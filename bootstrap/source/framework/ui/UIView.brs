function UIView(options, appendOptions = invalid as Object)
    this = UILayout(options) 'Add Layout Tools
    this.Append({
        region      : invalid
        sprite      : invalid
        bitmap      : invalid
        backgroundColor  : UIColorWithName(options["background-color"])
    })
    
    if appendOptions <> invalid then this.Append(appendOptions) 'Other Views options
    
    'Called by RefreshScreen
    this.draw = function(component as Object) as Boolean
        if m.sprite <> invalid then m.sprite.setDrawableFlag(m.isOpaque())
        return true
    end function
    
    this.prepareForLayout = function()
    end function
    
    this.initBackground = function()
        m.bitmap = CreateBitmap(m.width, m.height)
        m.region = CreateRegion(0, 0, m.width, m.height, m.bitmap)
        m.sprite = CreateSprite(m.x, m.y, m.region)
        
        m.sprite.SetDrawableFlag(m.isOpaque())
    end function
    
    this.setBackgroundColor = function(color as Integer)
        m.backgroundColor = color
        if m.bitmap = invalid then m.initBackground()
        m.bitmap.Clear(m.backgroundColor)
    end function
    
    this.init = function()
        if m.backgroundColor <> invalid then m.initBackground()
        m.bitmap.Clear(m.backgroundColor)
    end function
    
    this.init()
    
    return this
end function