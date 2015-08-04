
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

function IncludeUIInteractionTo(this)

    this.interaction = {
        view : this
        x___ : {
            hasFocus : false
        }
    }
    
    this.hasFocus = function()
        return m.interaction.x___.hasFocus
    end function
    
    this.interaction.canAcceptFocus = function(code = invalid) as Boolean
        if m.view.shouldAcceptFocus <> invalid then return m.view.shouldAcceptFocus(code)
        return false
    end function
    
    this.interaction.canReleaseFocus = function(code) as Boolean
        if m.view.shouldReleaseFocus <> invalid then return m.view.shouldReleaseFocus(code)
        return true
    end function
    
    this.interaction.willHandleUserInput = function(code) as Boolean
        if m.view.shouldHandleUserInput <> invalid then return m.view.shouldHandleUserInput(code)
        return false
    end function
    
    this.interaction.handleInteractionEvent = function(msg) as Boolean
        handled = false
        if m.view.onInteractionEvent <> invalid then handled = m.view.onInteractionEvent(msg)
        return handled
    end function
    
    this.interaction.focus = function(refresh = true)
        m.x___.hasFocus = true
        if m.view.onFocus <> invalid then m.view.onFocus()
        if refresh then RefreshScreen()
    end function
    
    this.interaction.blur = function(refresh = true)
        m.x___.hasFocus = false
        if m.view.onBlur <> invalid then m.view.onBlur()
        if refresh then RefreshScreen()
    end function
    
end function