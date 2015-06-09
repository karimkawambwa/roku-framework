function AppDelegate(app)
    self = ApplicationDelegate(app)
    
    self.applicationDidLaunch = function()
        
        mainViewController = MainViewController(m.app)
        m.setRootController(mainViewController, true)
        
    end function
    
    return self
end function