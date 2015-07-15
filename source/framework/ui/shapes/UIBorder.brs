
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


function UIBorder(x as Integer, y as Integer, width as Integer, height as Integer, thickness as Integer, rgba as Integer) as Object
    this = {
        type : "UIBorder"
        x: x
        y: y
        width: width
        height: height
        thickness: thickness
        rgba: rgba
    }
    
    this.draw = function(component as Object) as Boolean
        if m.top.x <> m.x then m.Init()
        
        items = [m.top, m.bottom, m.left, m.right]
        return DrawAll(items, component)
    end function
    
    this.init = function() as Void
        m.top       = UIRect(m.x, m.y, m.width, m.thickness, m.rgba)
        m.bottom    = UIRect(m.x, m.y + m.height - m.thickness, m.width, m.thickness, m.rgba)
        m.left      = UIRect(m.x, m.y, m.thickness, m.height, m.rgba)
        m.right     = UIRect(m.x + m.width - m.thickness, m.y, m.thickness, m.height, m.rgba)
    end function
    
    this.init()
    
    return this
end function

function AddBorderToBitmap(bitmap as Object, color as integer)
    border = UIBorder(0, 0, bitmap.getWidth(), bitmap.getHeight(), 4, color)
    border.draw(bitmap)
    return border 
end function