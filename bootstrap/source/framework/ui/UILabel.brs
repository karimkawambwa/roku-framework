function UILabel(options)
    
    if options["background-opacity"] = invalid then options["background-opacity"] = "0"
    if options["background-color"] = invalid then options["background-color"] = "white"
    
    this = UIView(options, {
        type  : "UILabel"
        text  : if_else(options.text <> invalid, options.text, "")
        size  : if_else(options.size <> invalid, toInt(options.size), 10)
        font  : invalid 'Will be loaded
        color : ColorWithName(options.color)
        colorname : options.color
        fontname : options.font
    })
    
    this.base_view_Init = this.init
    this.init = function()
        m.font = FontWithNameAndSize(m.fontname, m.size)
        
        m.sizeToFit()
        
        'FIX : ROKU BUG FOR TEXT DRAWING ON BITMAP
        m.backgroundColor = ColorWithName(m.colorname, ColorOpacity()["0"])
        
        m.base_view_Init()
        
        bitmap =  m.sprites.sprite(0).GetRegion().GetBitmap()
        if m.font <> invalid then
            drewText = bitmap.DrawText(m.text, 0, 0, m.color, m.font)
            if not drewText then print "Error : Failed to draw text '"+m.text+"' in label ["+m.id+"]"
        end if
    end function
    
    this.base_view_prepareForLayout = this.prepareForLayout
    this.prepareForLayout = function()
        m.sizeToFit()
        
        m.base_view_prepareForLayout()
    end function
    
    this.base_view_didLayout = this.didLayout
    this.didLayout = function()
        m.base_view_didLayout()
    end function
    
    this.sizeToFit = function() as Void
        if m.font = invalid then return
        
        m.setWidth(GetFontWidth(m.font, m.text))
        m.setHeight(GetFontHeight(m.font))
    end function
    
    this.draw = function(component as Object) as Boolean
        stop
        return true
    end function
    
    return this
end function