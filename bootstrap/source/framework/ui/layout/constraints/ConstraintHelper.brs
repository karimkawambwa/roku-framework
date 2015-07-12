'A constraint consists of  side|to_side|value|flexibility|priority|ref_id
'Eg: t|b|0|==|100|ExampleView  
'It means (t) top of current view to (b) bottom of view (ref_id) ExampleView
'(==) with no flexibility i.e exact value at (100) % priority
'
'Maximum of 4 constraints per view i.e top, bottom, left, right
function CreateConstraintsContainerFor(view, constraintsString)
    
    ' Setup the constraints container
    constraints = {
        view : view
        T    : invalid   'top
        B    : invalid   'bottom
        L    : invalid   'left
        R    : invalid   'right
    }

    constraints.prepareForLayout = function()
        getViewConstrainedToSide = function(constraint, view) as Void
            if constraint = invalid then return

            constraint.view = view.parent.childWithId(constraint.ref)
            if constraint.view = invalid then 
                print "Constraint Error : Cannot constrain "+side+" [ "+child.id+" ] in [ "+parent.id+" ] to invalid view"
                print "Constraint Errored : "
                print constraint
            end if
        end function
            
        getViewConstrainedToSide(m.T, m.view)
        getViewConstrainedToSide(m.B, m.view)
        getViewConstrainedToSide(m.L, m.view)
        getViewConstrainedToSide(m.R, m.view)
    end function
    
    'Begin parsing if string is valid
    if constraintsString = invalid then return constraints
    
    reg1 = CreateObject("roRegex", "(\t|,)+", "")
    reg2 = CreateObject("roRegex", "(\t|\|)+", "")
    
    tokens = reg1.Split(constraintsString)
    
    for each token in tokens
        params = reg2.Split(token)
        
        mySide      = params[0]
        toSide      = params[1]
        flexibility = params[2]
        value       = params[3]
        priority    = params[4]
        ref         = params[5]
        
        constraint = UIContraint(ref, toSide, value, priority, flexibility)
        constraints[mySide] = constraint
    end for
    
    return constraints
end function