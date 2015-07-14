'@param opacity
' 100 	: FF
' 95 	: F2
' 90 	: E6
' 85 	: D9
' 80 	: CC
' 75 	: BF
' 70 	: B3
' 65 	: A6
' 60 	: 99
' 55 	: 8C
' 50 	: 80
' 45 	: 73
' 40 	: 66
' 35 	: 59
' 30 	: 4D
' 25 	: 40
' 20 	: 33
' 15 	: 26
' 10 	: 1A
' 5 	: 0D
' 0 	: 00
function ColorWithName(name, opacity = "FF" as String) as Integer
    app = GetApp()
    if app = invalid then return 255
    
    if app.colorNames <> invalid and name <> invalid and app.colorNames[name] <> invalid
        hex = app.colorNames[name]
        return HexToInteger(hex + opacity)
    end if
    
    return ColorWithName("black", opacity)
end function

function ColorOpacity()
	colorop = {}
	colorop["100"] = "FF"
	colorop["95"] = "F2"
	colorop["90"] =  "E6"
	colorop["85"] = "D9"
	colorop["80"] = "CC"
	colorop["75"] = "BF"
	colorop["70"] = "B3"
	colorop["65"] = "A6"
	colorop["60"] = "99"
	colorop["55"] = "8C"
	colorop["50"] = "80"
	colorop["45"] = "73"
	colorop["40"] = "66"
	colorop["35"] = "59"
	colorop["30"] = "4D"
	colorop["25"] = "40"
	colorop["20"] = "33"
	colorop["15"] = "26"
	colorop["10"] = "1A"
	colorop["5"] = "0D"
	colorop["0"] = "00"
	
	return colorop
end function