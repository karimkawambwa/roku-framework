function NavigationManager()
    this = {
        pr___   : { 'don't access directly
            navigationStackIds : []
            navigationStack    : []
        }
    }
    
    this.controllerAtIndex = function(index)
        navStack = m.pr___.navigationStack
        stackCount = navStack.Count()
        if stackCount = 0 then
            return invalid
        end if
        if index < 0 or index >= stackCount then
            print "Index [",index,"] Beyond Bounds of the navigationStack : ", m.pr___.navigationStack.Count()
            return invalid
        end if
        
        return navStack[index]
    end function
    
    this.previousController = function()
        navStack = m.pr___.navigationStack
        stackCount = navStack.Count()
        if stackCount = 0 or stackCount = 1 then return invalid
        
        return navStack[stackCount-2]
    end function
    
    this.currentController = function()
        navStack = m.pr___.navigationStack
        stackCount = navStack.Count()
        if stackCount = 0 then return invalid
        
        return navStack[stackCount-1]
    end function
    
    this.popBack = function()
    end function
    
    this.navigateTo = function(controller, preventHistory = false as Boolean)
        navStack = m.pr___.navigationStack
        navStackIds = m.pr___.navigationStackIds
        
        navStackIds.Push(controller.id)
        navStack.Push(controller)
        
        previousController  = m.previousController()
        currentController   = m.currentController()
        
        if previousController <> invalid then previousController.dispose()
        if currentController <> invalid then currentController.init()
    end function
    
    this.popToInitialController = function()
    end function
    
    return this
end function