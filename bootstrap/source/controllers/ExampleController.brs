function ExampleController()
    this = BaseController({
        id : "ExampleController" 'Custom ID, comment for random Id
        viewName : "example"
    })
    
    this.baseInit = this.init
    this.init = function()
        
        m.baseInit()
    end function
    
    this.viewLoaded = function()
        'm.view is not invalid but not visible
    end function
    
    this.viewAppeared = function()
        'm.view is not invalid and is visible
    end function
    
    this.baseDispose = this.dispose
    this.dispose = function()
        
        m.baseDispose()
    end function
    
    return this
end function