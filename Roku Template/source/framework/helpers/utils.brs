function GetApp()
    aa = GetGlobalAA()
    return aa.app
end function

function AppNavigation()
    return GetApp().navigationManager
end function

function NavigateTo(controller)
    AppNavigation().navigateTo(controller)
end function

function NavigateWithoutHistoryTo(controller)  
    AppNavigation().navigateTo(controller, true)
end function

function CreateBitmap(width, height)
    return CreateObject("roBitmap", {width: width, height: height, alpahEnabled: true})
end function

function RefreshScreen()
    app = GetApp()
    app.screen.Clear(HexToInteger("000000FF"))
    
    currentController = AppNavigation().currentController()
    currentView = try_get(currentController, "view")
    
    if currentView <> invalid then
        currentView.draw()
    end if
    
    '1:1 scaling
    scaleX = app.roScreen.GetWidth() / app.screen.GetWidth()
    scaleY = scaleX
    
    region = CreateObject("roRegion", app.screen, 0, 0, app.screen.GetWidth(), app.screen.GetHeight())
    region.SetScaleMode(1)
    app.roScreen.DrawScaledObject(0, 0, scaleX, scaleY, region)
    app.roScreen.SwapBuffers()
end function

function random(num_min As Integer, num_max As Integer) As Integer
    return (RND(0) * (num_max - num_min)) + num_min
end function