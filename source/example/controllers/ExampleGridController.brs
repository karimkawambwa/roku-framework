
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

function ExampleGridController()
    this = BaseController({
        id : "ExampleController" 'Custom ID, comment for random Id
        viewName : "example-grid"
    })
    
    this.baseInit = this.init
    this.init = function()
        
        m.baseInit()
    end function
    
    this.viewLoaded = function()
        'm.view is not invalid but not visible
        'm.sideMenu = m.view.children.childWithId("side-menu")
        'm.exampleListView = m.sideMenu.children.childWithId("example-list")
        'm.exampleListView.dataSource = m
    end function
    
    this.viewAppeared = function()
        'm.view is not invalid and is visible
        m.view.focusControl.focusOn("movies")
        
        m.view.children.childWithId("movies").animate({x : 1000}, outBounce, 4, 0, function(completed)
            
        end function)
    end function
    
    ' @required ListView Datasource Call
    ' ExampleListView Datasource Calls
    ' These Must be implimented for none static ListView
    this.numberOfItemsForList = function(listView)
        return 1
    end function
    
    ' @required ListView Datasource Call
    ' Return a view
    this.itemForListAtIndex = function(listView, index)
        return listView.itemFromPrototypeWithId("prototype-example-item-0")
    end function
    
    this.baseDispose = this.dispose
    this.dispose = function()
        
        m.baseDispose()
    end function
    
    return this
end function