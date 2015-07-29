
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

function UIButton(options)
    
    if options["bg:opacity"] = invalid then options["bg:opacity"] = "0"
    
    this = UIView(options, {
        type  : "UIButton"
        isSelectable : true
        hasFocus     : false
        padding      : if_else(options.padding <> invalid, options.padding, 5)
        
        label : UIlabel({
            id : "title_label"
            font : if_else(options.font <> invalid, options.font, "Open Sans")
            size : if_else(options.size <> invalid, options.size, "10")
            center : true
            text   : options["title:text"]
            color  : options["title:color"]
        })
        
        blurred : {
            titleColor : ColorWithName(options["title:color"])
            backgroundImage : ImageNamed(options["bg:image"])
            backgroundColor : ColorWithName(options["bg:color"], ColorOpacity(options["bg:opacity"]))
        }
        
        focused : {
            titleColor : ColorWithName(options["title:focused:color"])
            backgroundImage : ImageNamed(options["bg:focused:image"])
            backgroundColor : ColorWithName(options["bg:focused:color"], ColorOpacity(options["bg:opacity"]))
        }
        
        highlight : {
            titleColor : ColorWithName(options["title:highlight:color"])
            backgroundImage : ImageNamed(options["bg:highlight:image"])
            backgroundColor : ColorWithName(options["bg:highlight:color"], ColorOpacity(options["bg:opacity"]))
        }
        
        selected : {
            titleColor : ColorWithName(options["title:selected:color"])
            backgroundImage : ImageNamed(options["bg:selected:image"])
            backgroundColor : ColorWithName(options["bg:selected:color"], ColorOpacity(options["bg:opacity"]))
        }
    })
    
    if options.textColor <> invalid and options["bg:color"] = invalid then options["bg:color"] = options.textColor
    
    this.label.sizeToFit()
    
    this.setWidth(if_else(options.width <> invalid, options.width, this.label.width() + (2*this.padding)))
    this.setHeight(if_else(options.height <> invalid, options.height, this.label.height() + (2*this.padding)))
    
    this.base_view_movedToParent = this.movedToParent
    this.movedToParent = function(parent)
        m.base_view_movedToParent(parent)
    
        m.children.addChild(m.label)
    end function
    
    this.base_view_draw = this.draw
    this.draw = function(component as Object) as Boolean
        bitmap = m.sprites.sprite(0).GetRegion().GetBitmap()
        
        m.label.color = m.titleColor()
        
        m.base_view_draw(component)
        
        if m.hasFocus
            AddBorderToBitmap(bitmap, m.titleColor(), 1)
        end if
        return true
    end function
    
    this.bgColor = function()
        if m.hasFocus
            if m.focused.backgroundColor < 0 then return m.titleColor()
            return m.focused.backgroundColor
        else
            if m.blurred.backgroundColor < 0 then return m.titleColor()
            return m.blurred.backgroundColor
        end if
    end function
    
    this.titleColor = function()
        if m.hasFocus
            return m.focused.titleColor
        else
            return m.blurred.titleColor
        end if
    end function
    
    this.base_view_focus = this.focus
    this.focus = function(refresh = true)
        m.hasFocus = true
        m.base_view_focus(refresh)
    end function
    
    this.base_view_blur = this.blur
    this.blur = function(refresh = true)
        m.hasFocus = false
        m.base_view_blur(refresh)
    end function
    
    return this
end function