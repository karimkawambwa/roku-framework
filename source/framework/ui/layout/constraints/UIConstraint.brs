
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

function UIContraint(ref, side, value, priority, flexibility = "==" as String)
    this = {  
        x___pr : { 'don't access directly
            ref      : ref
            side     : side
            value    : value
            priority : priority
            flexibility : flexibility
        }
    }
    
    this.ref = function()
        return m.x___pr.ref
    end function
    
    this.side = function()
        return m.x___pr.side
    end function
    
    this.value = function()
        return m.x___pr.value
    end function
    
    this.priority = function()
        return m.x___pr.priority
    end function
    
    this.flexibility = function()
        return m.x___pr.flexibility
    end function
    
    this.setValue = function(value, refresh = true as Boolean, easing = linear as Function)
        m.x___pr.value = value
        'TODO: Easing
        if refresh then RefreshScreen()
    end function
    
    this.setPriority = function(value, refresh = true as Boolean, easing = linear as Function)
        m.x___pr.value = value
        'TODO: Easing
        if refresh then RefreshScreen()
    end function
    
    this.setFlexibility = function(value, refresh = true as Boolean, easing = linear as Function)
        m.x___pr.value = value
        'TODO: Easing
        if refresh then RefreshScreen()
    end function
    
    return this
end function

function UIConstraintFlexibility()
    return {
        GREATER_THAN_OR_EQUAL : ">="
        LESS_THAN_OR_EQUAL : "<="
        EXACT : "=="
    }
end function