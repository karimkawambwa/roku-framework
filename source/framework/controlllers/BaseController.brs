function BaseController(appendParams as Object)
    id = random(1000000000, 9999999999).toStr()
    this = {
        id                  : id
        viewName            : invalid
        displayTypeSpecific : false
        view                : invalid 'view willbe loaded
    }
    
    this.Append(appendParams)
    
    AddChildrenContainerTo(this)
    
    'Careful when overiding this function
    this.init = function()
        if m.viewName <> invalid 
            m.view = LoadViewNamed(m.viewName, m.displayTypeSpecific, 0, 0, AppScreen("width"), AppScreen("height"))
        else
            m.view = UIView()
        end if
        
        m.viewLoaded()
        
        onLayoutComplete = function(context)
            context.viewAppeared()
        end function
        
        m.view.layout(onLayoutComplete, m)
    end function
    
    'called right after init, when view is loaded but not rendered
    this.viewLoaded     = function()
        'Should override in your controller
    end function
    
    'called right after the view is render and everything is visible
    this.viewAppeared   = function()
        'Should override in your controller
    end function
    
    this.userPressed = function(msg as Integer)
    end function
    
    this.clicked = function(view)
        return true
    end function
    
    this.focused = function(view)
    end function
    
    this.unFocused = function(view)
    end function
    
    'Careful when overiding this function
    this.dispose    = function()
    end function
    
    return this
end function