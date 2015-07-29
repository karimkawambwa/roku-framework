
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

function ImageNamed(name, options = {} as Object)
    if name = invalid then return invalid
    
    app = GetApp()
    return ImageFromPath(app.imagePaths[name], options)
end function

function ImageFromPath(path, options = {} as Object)

    if name = invalid then return invalid
    
    this = {
        id : invalid
        request : invalid
        args : invalid
        cache : true 'caching is true by default
        async : false 'async is false by defalut
        syncCompleted : false
        scaleMode : 1 'scaleMode = default 1 Bilinear scaling, slower but cleaner
    }
 
    this.getBitmap = function(path, options = invalid)
        app = GetApp()
        
        width = if_else(options <> invalid, options.width, invalid)
        height = if_else(options <> invalid, options.height, invalid)
 
        if options <> invalid
            if options.scaleMode <> invalid then m.scaleMode = options.scaleMode
            if options.async <> invalid then m.async = options.async
            if options.cache <> invalid then m.cache = options.cache
            if options.complete <> invalid then m.complete = options.complete
            if options.args <> invalid then m.args = options.args
        end if
 
        m.request = CreateObject("roTextureRequest",path)
        m.request.setAsync(m.async)
        m.request.setScaleMode(m.scaleMode)
        
        if width <> invalid and height <> invalid then m.request.setSize(width, height)
        
        app.textureManager.RequestTexture(request)
        
        m.id = request.GetId()
        
        bitmap = invalid
        if not async 'will block UI (synchronous request)
            msgport = app.textureManager.GetMessagePort()
            while not m.syncCompleted 'synchronous request completed check
                msg = wait(0, msgport)
                if type(msg) = "roTextureRequestEvent" and msg.GetId() = m.id then 
                    bitmap = m.handleTextureEvent(msg)
                end if
            end while
            m.syncCompleted = false 'reset
        else
            m.requests.Push(options)
            app.textureEventListeners.Push(m)
        end if
        
        return if_else(async, m, bitmap)
    end function
    
    this.handleTextureEvent = function(msg)
        state = msg.GetState()
        app = GetApp()
        
        ' 0 Requested
        ' 1 Downloading
        ' 2 Downloaded
        ' 3 Ready
        ' 4 Failed
        ' 5 Cancelled
        if state = 3
            if m.async and m.completed <> invalid then 
                m.complete(msg.GetId(), msg.GetBitmap(), m.args)
            else if not m.async
                m.syncCompleted = true
                return msg.GetBitmap()
            else if m.async and request.complete = invalid
                print "BitmapManager: Image Lost, no complete callback for image with id : " + msg.GetId()app = GetApp()
                app.textureManager.UnloadBitmap(msg.GetURI())
            end if
            
            if not m.cache then app.textureManager.UnloadBitmap(msg.GetURI())
        else if state = 4
             'TODO : retry
            if not m.async then m.syncCompleted = true
            if not m.async then return invalid
        end if
        
        ' This means remove this handler
        return (not state = 0 or not state = 1)
    end function
    
    app = GetApp()
    return m.getBitmap(app.imagePaths[name], options)
end function