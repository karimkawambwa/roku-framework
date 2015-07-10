function UIBase(options)
    this = {
        uibase___pr : { 'don't access directly
            hidden : false
            opaque : false
        }
    }
    
    this.Append(options)
    
    this.isOpaque = function()
        return m.uibase___pr.opaque
    end function
    
    this.isHidden = function()
        return m.uibase___pr.hidden
    end function
    
    this.setOpaque = function(opaque = true as Boolean)
        m.uibase___pr.opaque = opaque
        if m.sprite <> invalid then m.sprite.setDrawableFlag(opaque)

        m.children.perform("setOpaque", true)
        
        'This will mostly be a visual change no need to update the layout
        'Just refresh the screen automatically
        RefreshScreen()
    end function
    
    this.setHidden = function(hidden = true as Boolean)
        m.uibase___pr.hidden = hidden
        m.setOpaque(true)
        'Update Layout
        'Hidden will make the view be treated as 0 width and 0 height
        '
    end function
    
    return this
end function