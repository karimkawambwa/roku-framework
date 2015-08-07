
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

'@param x 
'@param y
'@param width
'@param height
'@param rgba a 32-bit value in the form &hXXXXXXXX specifying the rgb color and alpha
'@return an UIRect object
function UIRect(x as Integer, y as Integer, width as Integer, height as Integer, rgba as Integer) as Object
    this = {
        type: "UIRect"
        x: x
        y: y
        width: width
        height: height
        rgba: rgba
    }
    
    '@param component a roScreen/roBitmap/roRegion object
    this.draw = function(component as Object) as Boolean
        component.DrawRect(m.x, m.y, m.width, m.height, m.rgba)
        return true 'Bug in BrightScript, DrawRect always returns uninitialized
    end function
    
    return this
end function