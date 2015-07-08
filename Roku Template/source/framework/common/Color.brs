function ColorToHex(color as String)
    
end function

function ColorToRGBA(color as String)
    
end function

function HexToRGBA(hexColorValue as String, opacity as String) as Integer
    'convert #FFFFFF to FFFFFF
    if left(hexColorValue, 1) = "#"
        hexColorValue = strReplace(hexColorValue, "#", "")
    end if 
   
    return HexToInteger(hexColorValue + opacity)
end function

function DecimalToHex(decimal as Float) as String
    reg = CreateObject("roRegex", "(\t|.)+", "")
    hex = ""
    
    result = decimal
    while 1
        result = result / 16.0
        
        results = reg.Split(result.toStr())
        result = results[0].toInt()
        
        if results.Count() > 0 then 
            remainder = results[1].toInt()
        else
            remainder = 0
        end if
        
        if remainder = 0 then exit while
        
        value = Fix(100/remainder)
    end while
end function