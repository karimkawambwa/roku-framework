# Roku Framework 
###(UNDER CONSTRUCTION)

I just started working on the Roku and I thhought i would challenge myself and make a framework for it and this is what i got so far. Still under work btw :)

Current working view example : 

<view id="main-layout" background-color="white">

	<view id="side-menu" background-color="black" width="25%" height="100%">
		<label id="hurray-label" text="Menu" color="darkorange" font="Open Sans" size="30" />
		<view id="separator" background-color="darkorange" width="100%" height="2" constraints="T|B|10|==|100|hurray-label">
		</view>
	</view>
	
	<view id="main-content" background-color="slategrey" width="75%" height="25%" constraints="L|R|0|==|100|side-menu">
		<label id="hurray-label" text="Content Goes Here" color="darkorange" font="Open Sans" size="40" center="true" />
	</view>
	
</view>

Async Http network request can be performed this way : 
        
        ahttp("GET",{
            url : "http://google.com"
            done : function(response as Object)
                headers = response.headers
                body = response.body
                
            end function
        }).fire()

Image Loading can be performed by calling , ImageFromPath or ImageNamed
ImageNamed uses the name of the image u dragged into the the images folder
ImageFromPath takes in the full path of the image location, even a url path

Async Loading returns the object and you can call cancel or reload
Sync Loading will return Bitmap but block UI

            ImageNamed(name, {
            	async : true 'Mustbe Specified
            	args : [ ] or { }
            	height : optional
            	width : optional
            	scaleMode : optional default is 1
            	cache : default is true
            	complete : function(id, bitmap, args)
            		
            	end function
            })
            
            ImageFromPath(path, {
            	async : true 'Mustbe Specified
            	args : [ ] or { }
            	height : optional
            	width : optional
            	scaleMode : default is 1
            	cache : default is true
            	complete : function(id, bitmap, args)
            		
            	end function
            })
            

Animating Example: 

        m.view.children.childWithId("movies").animate({x : 1000}, outBounce, 4, 0, function(completed)
            
        end function)
        
Setting Focus :
	
	m.view.focusControl.focusOn("movies")
            
I will make a better ReadMe and Documentation File :) 
