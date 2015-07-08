function AppDelegate()
    this = {}
    
    this.applicationLaunched = function()
        controller = ExampleController()
        navigateTo(controller)
    end function
    
    this.applicationTerminated = function()
        
    end function 
    
    return this
end function