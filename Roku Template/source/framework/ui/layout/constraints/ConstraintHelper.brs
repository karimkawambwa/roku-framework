'A constraint consists of  side|to_side|value|flexibility|priority|ref_id
'Eg: t|b|0|==|100|ExampleView  
'It means (t) top of current view to (b) bottom of view (ref_id) ExampleView
'(==) with no flexibility i.e exact value at (100) % priority
'
'Maximum of 4 constraints per view i.e top, bottom, left, right
function ParseConstraintString(constraintsString)
    
    constraints = {
        T  : invalid   'top
        B  : invalid   'bottom
        L  : invalid   'left
        R  : invalid   'right
    }
    
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