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