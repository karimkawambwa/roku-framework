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


I will make a better ReadMe and Documentation File :) 
