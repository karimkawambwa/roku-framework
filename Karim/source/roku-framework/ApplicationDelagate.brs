function ApplicationDelegate(app)
    self = {
         app : app
         rootController : invalid
    }
    
    self.setRootController = function(controller, animated = false)
        prevController = m.rootController
        if prevController <> invalid 
            
        else
            rootController = controller
        end if
    end function
    
    return self
end function