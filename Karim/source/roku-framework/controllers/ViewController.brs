function ViewController(app,view_name = invalid)
    self = {
        app : app
        super : {
            
        }
    }
    
    self.initializeController_ = function()
        m.view = m.app.viewManager.loadViewNamed(view_name)
        if m.viewDidLoad <> invalid then m.viewDidLoad()
    end function
    
    return self
end function