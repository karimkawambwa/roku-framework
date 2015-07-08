function UIView(options, appendOptions = invalid as Object)
    this = UILayout(options)
    this.Append({
        screen      : GetApp().screen
        compositor  : GetApp().compositor
        region      : invalid
        bitmap      : invalid 'Created When Needed
    })
    
    if appendOptions <> invalid then this.Append(appendOptions)
    
    'Called by RefreshScreen
    this.draw = function()
        if m.bitmap <> invalid then m.screen.DrawObject(m.x, m.y, m.bitmap)
    end function
    
    this.initBackGroundBitmap = function()
        m.bitmap = CreateBitmap(m.width, m.height)
        m.screen.DrawObject(m.x, m.y, m.bitmap)
    end function
    
    this.setBackGroundColor = function(color as String)
        if m.bitmap = invalid then m.initBackGroundBitmap()
        
        m.bitmap.Clear(HexToInteger("FFFFFFFF"))
    end function
    
    'image as uiimage
    this.setBackGroundImage = function(image)
        if m.bitmap = invalid then m.initBackGroundBitmap()
        
    end function
    
    return this
end function