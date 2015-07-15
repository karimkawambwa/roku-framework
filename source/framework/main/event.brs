
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

function initEventReceiver(app)
    app.events = {'eclipse gives me weird errors when i type event :/
        handlers : {}
    }
    
    app.events.addHandler = function(id as String, handler as Function, arg = invalid)
        m.handlers[id] = {handler : handler , arg : arg}
        return handleId
    end function
    
    app.events.removeHanlderWithId = function(id)
        m.hadlers.Delete(id)
    end function
    
    app.events.dispatch = function(msg)
        handle = m.handlers[msg.GetId()]
        
        if handle <> invalid then 
            remove = handle.handler(msg, handle.arg)
            if remove then m.removeHanlderWithId(msg.GetId())
        end if
    end function
    
end function