function if_else(condition, trueValue, falseValue)
    if condition then return trueValue
    return falseValue
end function

function not_invalid(property, valid_property)
    return if_else(property <> invalid, property, valid_property)
end function