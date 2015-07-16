
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

function BaseController(appendParams as Object)
    id = random(1000000000, 9999999999).toStr()
    this = {
        id                  : id
        viewName            : invalid
        displayTypeSpecific : false
        view                : invalid 'view willbe loaded
    }
    
    this.Append(appendParams)
    
    AddChildrenContainerTo(this)
    
    'Careful when overiding this function
    this.init = function()
        if m.viewName <> invalid 
            m.view = LoadViewNamed(m.viewName, m.displayTypeSpecific, 0, 0, AppScreen("width"), AppScreen("height"))
        else
            m.view = UIView()
            ' This means that its the main window
            m.view.movedToParent(invalid)
        end if
        
        m.viewLoaded()
        
        onLayoutComplete = function(context)
            context.viewAppeared()
        end function
        
        m.view.layout(onLayoutComplete, m)
    end function
    
    'called right after init, when view is loaded but not rendered
    this.viewLoaded     = function()
        'Should override in your controller
    end function
    
    'called right after the view is render and everything is visible
    this.viewAppeared   = function()
        'Should override in your controller
    end function
    
    this.userPressed = function(msg as Integer)
    end function
    
    this.clicked = function(view)
        return true
    end function
    
    this.focused = function(view)
    end function
    
    this.unFocused = function(view)
    end function
    
    'Careful when overiding this function
    this.dispose    = function()
    end function
    
    return this
end function