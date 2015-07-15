
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

function UIView(options, appendOptions = invalid as Object)
    this = UILayout(options) 'Add Layout Tools
    this.Append({
        backgroundOpacity : if_else(options["background-opacity"] <> invalid, options["background-opacity"], "100")
        backgroundColor  : 255 'black
    })

    'Other Views options subclassing
    if appendOptions <> invalid then this.Append(appendOptions) 

    this.backgroundColor = ColorWithName(options["background-color"], ColorOpacity()[this.backgroundOpacity])
    
    'Called by RefreshScreen
    this.draw = function(component as Object) as Boolean
        return true
    end function
    
    this.base_layout_prepareForLayout = this.prepareForLayout
    this.prepareForLayout = function()
        m.base_layout_prepareForLayout()
    end function
    
    this.base_layout_didLayout = this.didLayout
    this.didLayout = function()
        m.base_layout_didLayout()
    end function
    
    this.initBackground = function()
        bitmap = CreateBitmap(m.width(), m.height())
        bitmap.Clear(m.backgroundColor)
        
        region = CreateRegion(0, 0, m.width(), m.height(), bitmap)
        sprite = CreateSprite(m.x(), m.y(), region)
        
        m.sprites.Add(sprite)
        m.sprites.SetDrawableFlag(m.isOpaque())
    end function
    
    this.setBackgroundColor = function(color as Integer)
        m.backgroundColor = color
        if m.bitmap = invalid then m.initBackground()
    end function
    
    this.init = function()
        if m.backgroundColor <> invalid then m.initBackground()
        print "INIT [ "+ m.id+" ]"
    end function
    
    return this
end function