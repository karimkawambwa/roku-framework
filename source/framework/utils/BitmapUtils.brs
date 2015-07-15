
' The MIT License (MIT)

' Copyright (c) 2015 Karim Kawambwa

' Author Karim Kawambwa

' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:

' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Software.

' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
' THE SOFTWARE.

function BitmapImageWithName(name, options = {} as Object)

    if name = invalid then return invalid
    
    this = {
        bitmap : invalid
        syncCompleted : false
        defaultScaleMode : 1 'scaleMode = default 1 Bilinear scaling, slower but cleaner
    }
 
    this.getBitmap = function(path, options = invalid)
        app = GetApp()
        
        width = if_else(options <> invalid, options.width, invalid)
        height = if_else(options <> invalid, options.height, invalid)
 
        complete = invalid
        completeArg = invalid
        cache = true 'caching is true by default
        async = false 'async is false by defalut
        scaleMode = m.defaultScaleMode
 
        if options <> invalid
            if options.scaleMode <> invalid then scaleMode = options.scaleMode
            if options.async <> invalid then async = options.async
            if options.cache <> invalid then cache = options.cache
            if options.complete <> invalid then complete = options.complete
            if options.completeArg <> invalid then completeArg = options.completeArg
        end if
 
        request = CreateObject("roTextureRequest",path)
        request.setAsync(async)
        request.setScaleMode(scaleMode)
        
        if width <> invalid and height <> invalid then request.setSize(width, height)
        
        app.textureManager.RequestTexture(request)
 
        options = {
            id : request.GetId(), 
            async: async, 
            complete: complete, 
            completeArg: completeArg, 
            cache : cache
        }
 
        if not async 'will block UI (synchronous request)
            msgport = app.textureManager.GetMessagePort()
            while not m.syncCompleted 'synchronous request completed check
                msg = wait(0, msgport)
                m.eventReceiver(msg, options)
            end while
            m.syncCompleted = false 'reset
        else
            m.requests.Push(options)
            app.events.addHandler({
                msgId : toStr(request.GetId())
                handler : m.eventHandler
                arg: options 
            })
        end if
        
        return if_else(async, toStr(request.GetId()), m.bitmap)
    end function
    
    this.eventHandler = function(msg, request) as Object
        if msg <> invalid and type(msg) = "roTextureRequestEvent"
            state = msg.GetState()
            
            if state = 3
                if request.async and request.complete <> invalid then 
                    request.complete(msg.GetId(), msg.GetBitmap(), request.completeArg)
                else if not request.async
                    m.bitmap = msg.GetBitmap()
                else if request.complete = invalid
                    print "BitmapManager: Image Lost, no complete callback for image with id : " + msg.GetId()
                end if
 
                if not request.async then m.syncCompleted = true
                
                app = GetApp()
                if not request.cache then app.textureManager.UnloadBitmap(msg.GetURI())
                    
            else if state = 4
                'TODO : retry
            end if
        end if
        
        ' This means remove this handler
        return true
    end function
    
    app = GetApp()
 
    return this.getBitmap(app.imagePaths[name], options)
end function