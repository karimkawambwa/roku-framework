
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


function UIBase(options)
    this = {
        uibase___pr : { 'don't access directly
            hidden : false
            opaque : false
        }
    }
    
    this.Append(options)
    
    this.isOpaque = function()
        return m.uibase___pr.opaque
    end function
    
    this.isHidden = function()
        return m.uibase___pr.hidden
    end function
    
    this.setOpaque = function(opaque = true as Boolean)
        m.uibase___pr.opaque = opaque
        
        m.sprites.SetDrawableFlag(opaque)

        m.children.perform("setOpaque", opaque)
        
        'This will mostly be a visual change no need to update the layout
        'Just refresh the screen automatically
        RefreshScreen()
    end function
    
    this.setHidden = function(hidden = true as Boolean)
        m.uibase___pr.hidden = hidden
        m.setOpaque(true)
        'Update Layout
        'Hidden will make the view be treated as 0 width and 0 height
        '
    end function
    
    return this
end function