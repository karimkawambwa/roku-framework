'Author : Karim Kawambwa
'Date : 2015-06-19
'
function PerformLayout(args) as Boolean
    m = args.context

    m.prepareForLayout()

    if args.index = invalid then options.index = 0
    
    view = m.children.childAtIndex(args.index)
    args.index = args.index + 1

    if view <> invalid then 
        'Desired positions
        if view.relative_position = invalid then
            view.relative_position = {
                x : if_else(view.x <> invalid, view.x, 0)
                y : if_else(view.y <> invalid, view.y, 0)
            } 
        end if
            
        'default x and y if provide
        view.x = m.x + view.relative_position.x
        view.y = m.y + view.relative_position.y
        
        offset = view.x - m.x 'x that would place view outside layout area
        view.maxWidth = m.width - offset
        
        view.prepareForLayout()
        
        if view.constraints <> invalid and view.constraints.Count() > 0

            view.constraints.prepareForLayout()

            top    = view.constraints.T 'top contraint
            bottom = view.constraints.B 'bottom contraint
            left   = view.constraints.L 'left contraint
            right  = view.constraints.R 'right contraint

            if top <> invalid
                if top.side = "T"
                    view.y = top.view.y + top.value
                else if top.side = "B"
                    view.y = top.view.y + top.view.height() + top.view.value
                end if
            end if

            if bottom <> invalid
                if bottom.side = "T"
                    view.y = bottom.view.y + bottom.value + view.height()
                else if bottom.side = "B"
                    view.y = bottom.view.y + bottom.view.height() - bottom.value - view.height()
                end if
            end if
            
            if left <> invalid
                if left.side = "L"
                    view.x = left.view.x + left.value()
                else if left.side = "R"
                    view.x = left.view.x + left.view.width() + left.value()
                end if
            end if
            
            if right <> invalid
                if right.side = "L"
                    view.x = right.view.x + right.view.width() + right.value()
                else if right.side = "R"
                    view.x = right.view.x + right.view.width() - view.width() - right.value()
                end if
            end if
        end if
        
        if view.children.childrenCount() <> 0
            args.workStack.Push({context : m, index : options.index})
            args.context = view
            args.index   = 0
        end if
    end if

    if view.children.Count() <= args.index and args.workStack.Count() > 0 then
        obj = args.workStack.Pop()

        args.context = obj.context
        args.index   = obj.index
    end if
    
    return args.workStack.Count() = 0 and args.children.Count() <= args.index
end function