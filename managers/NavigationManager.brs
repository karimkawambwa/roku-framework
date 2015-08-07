
' The MIT License (MIT)

' Copyright (c) 2015 Karim Kawambwa

' Permission is hereby granted, free of charge, to any person obtaining a copy
' of this software and associated documentation files (the "Software"), to deal
' in the Software without restriction, including without limitation the rights
' to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
' copies of the Software, and to permit persons to whom the Software is
' furnished to do so, subject to the following conditions:

' The above copyright notice and this permission notice shall be included in
' all copies or substantial portions of the Software.

' THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
' IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
' FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
' AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
' LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
' OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
' THE SOFTWARE.

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