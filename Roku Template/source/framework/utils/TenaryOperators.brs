function if_else(condition, trueValue, falseValue)
    if condition then 
        return trueValue
    else
        return falseValue
    end if
end function

function try_get(obj as Object, getVarible as String)
    reg = CreateObject("roRegex", "(\t|.)+", "")
    variableNames = reg.Split(getVarible)
    
    variable = invalid
    for each variableName in variableNames
        variable = obj[variableName]
        if variable = invalid then return invalid
    end for
    
    return variable
end function