
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


'@param opacity see color opacity below
function ColorWithName(name, opacity = "FF" as String) as Integer
    app = GetApp()
    if app = invalid then return 255
    
    if app.colorNames <> invalid and name <> invalid and app.colorNames[name] <> invalid
        hex = app.colorNames[name]
        return HexToInteger(hex + opacity)
    end if
    
    return ColorWithName("black", opacity)
end function

' Opacity percentages and the hex value
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