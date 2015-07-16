
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


function PerformLayout(args) as Boolean
    m = args.context

    m.prepareForLayout()

    if args.index = invalid then options.index = 0
    
    view = m.children.childAtIndex(args.index)
    args.index = args.index + 1

    if view = invalid then 
        return true
    end if
    
    'Desired positions
    if view.relative_position = invalid then
        view.relative_position = {
            x : if_else(view.x() <> invalid, view.x(), 0)
            y : if_else(view.y() <> invalid, view.y(), 0)
        } 
    end if
    
    'default x and y if provide
    view.setX(m.x() + view.relative_position.x)
    view.setY(m.y() + view.relative_position.y)
    
    offset = view.x() - m.x() 'x that would place view outside layout area
    view.setMaxWidth(m.width() - offset)
    
    view.prepareForLayout()
    
    if view.constraints <> invalid and view.constraints.Count() > 0

        view.constraints.prepareForLayout()

        top    = view.constraints.T 'top contraint
        bottom = view.constraints.B 'bottom contraint
        left   = view.constraints.L 'left contraint
        right  = view.constraints.R 'right contraint
        
        if top <> invalid
            if top.side() = "T"
                view.setY(top.view.y() + top.value())
            else if top.side() = "B"
                view.setY(top.view.y() + top.view.height() + top.value())
            end if
        end if

        if bottom <> invalid
            if bottom.side() = "T"
                view.setY(bottom.view.y() + bottom.value() + view.height())
            else if bottom.side() = "B"
                view.setY(bottom.view.y() + bottom.view.height() - bottom.value() - view.height())
            end if
        end if
        
        if left <> invalid
            if left.side() = "L"
                view.setX(left.view.x() + left.value())
            else if left.side() = "R"
                view.setX(left.view.x() + left.view.width() + left.value())
            end if
        end if
        
        if right <> invalid
            if right.side() = "L"
                view.setX(right.view.x() + right.view.width() + right.value())
            else if right.side() = "R"
                view.setX(right.view.x() + right.view.width() - view.width() - right.value())
            end if
        end if
    end if
    
    if m.z() >= view.z() then view.setZ(m.z()+1)
    
    if view.align.vertical or view.align.center
        view.setX(m.x() + ((m.width()/2) - (view.width()/2)))
    end if
    
    if view.align.horizontal or view.align.center
        view.setY(m.y() + ((m.height()/2) - (view.height()/2)))
    end if
    
    if view.children.Count() <> 0
        args.workStack.Push({context : m, index : args.index})
        args.context = view
        args.index   = 0
    else if m.children.Count() <= args.index and args.workStack.Count() > 0 then
        obj = args.workStack.Pop()
        
        args.context = obj.context
        args.index   = obj.index
        
        m = args.context
    end if
    
    if view.didLayout <> invalid then view.didLayout()
    
    return args.workStack.Count() = 0 and m.children.Count() <= args.index
end function