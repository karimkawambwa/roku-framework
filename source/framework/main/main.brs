
' The MIT License (MIT)

' Copyright (c) 2015 Karim Kawambwa

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

Library "v30/bslDefender.brs"

function main()
    initApp()
    
    app     = GetApp()
    mainNav = AppNavigation()
    codes   = bslUniversalControlEventCodes()
    
    app.delegate.applicationLaunched()
    
    while 1
        msg = app.msgPort.GetMessage()
        handled = false
        
        currentController = mainNav.currentController()
        currentView = currentController.view
        
        if type(msg) = "roUniversalControlEvent"
            if currentView.focusControl <> invalid then handled = currentView.focusControl.handleUserInput(msg.GetInt())
            
            if not handled and currentView <> invalid and currentView.handleUserInput <> invalid
                handled = currentView.handleUserInput(msg.GetInt(), codes)
            end if
        end if

        if type(msg) = "roUrlEvent"
            idx = 0
            for each listener in app.urlEventListeners
                if listener.id = msg.GetSourceIdentity()
                    done = listener.handleUrlEvent(msg)
                    if done then
                        app.urlEventListeners.Delete(idx)
                    end if
                    
                    exit for
                end if
                
                idx = idx + 1
            end for
        end if
        
        if type(msg) = "roTextureRequestEvent"
            idx = 0
            for each listener in app.textureEventListeners
                if listener.id = msg.GetSourceIdentity()
                    done = listener.handleUrlEvent(msg)
                    if done then
                        app.textureEventListeners.Delete(idx)
                    end if
                    
                    exit for
                end if
                
                idx = idx + 1
            end for
        end if
        
        app.async.performTasks() 'perfortasks to simulate asynchronous behaviour
    end while
    
    app.delegate.applicationTerminated()
    
end function