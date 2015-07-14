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