# roku-framework
Roku app framework to make app creation easier and structured. Under construction

Example app that uses this framework https://github.com/kaayr1m/roku-framework-example

Async Http network request can be performed this way : 
        
    ahttp("GET",{
        url : "http://google.com"
        done : function(response as Object)
            headers = response.headers
            body = response.body
            
        end function
    }).fire()
        
Animating Example: 

    m.view.children.childWithId("movies").animate({x : 1000}, outBounce, 4, 0, function(completed)
        
    end function)

Setting Focus :
	  
	 m.view.focusControl.focusOn("view-id")
	
I will make a better ReadMe and Documentation File :) 
