function LayoutType()
    return {
        NONE        : "NONE"
        VERTICAL    : "VERTICAL"
        HORIZONTAL  : "HORIZONTAL"
    }
end function

function UILayout(options)
    id = random(1000000000, 9999999999).toStr()
    app = GetApp()
    this = {
        id      :   if_else(options.id <> invalid, options.id, id)
        x       :   if_else(options.x <> invalid, options.x, 0)
        y       :   if_else(options.y <> invalid, options.y, 0)
        z       :   if_else(options.z <> invalid, options.z, 0)
        width   :   if_else(options.width <> invalid, options.width, 0)
        height  :   if_else(options.height <> invalid, options.height, 0)
        hidden  :   false
        opaque  :   true
    }
    
    this.preLayout = {
        x       :   this.x
        y       :   this.y
        z       :   this.z
        width   :   this.width
        height  :   this.height
        hidden  :   false
        opaque  :   true
    }
    
    AddChildrenContainerTo(this)
    
    this.layout = function(onComplete = invalid, onCompleteContext = invalid)
        app = GetApp()
        
        RefreshScreen()
    end function
    
    return this
end function