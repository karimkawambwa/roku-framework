function DrawAll(array as Object, component as Object, duration = invalid as Dynamic) as Boolean
    if duration <> invalid then timer = CreateObject("roTimespan")
    max = array.Count() - 1
    success = true
    for i = 0 to max
        if duration <> invalid and timer.TotalMilliseconds() > duration
            return success
        end if
        item = array[i]
        if item <> invalid and (item.visible = invalid or item.visible) and not item.draw(component) then success = false
    end for
    return success
end function

function RefreshScreen()
    'print "___________BEGIN__RefreshScreen___________________"
    app = GetApp()
    app.screen.Clear(ColorWithName("white"))
    app.screen.SetAlphaEnable(true)
    
    currentController = AppNavigation().currentController()
    currentView = currentController.view
    
    if currentView <> invalid then
        currentView.draw(app.screen)
    else
        print "Controller [ "+currentController+" ] : has and invalid view"
    end if
    
    app.compositor.DrawAll()
    
    'AddBorderToBitmap(app.screen, ColorWithName("red"))
    
    scaleX = app.roScreen.GetWidth() / app.screen.GetWidth()
    scaleY = app.roScreen.GetHeight() / app.screen.GetHeight()
    
    'print "roScreen : w = ", app.roScreen.GetWidth(), " h = ",app.roScreen.GetHeight()
    'print "screen : w = ", app.screen.GetWidth(), " h = ",app.screen.GetHeight()
    'print "scaleX : ", scaleX, " scaleY : ",scaleY
    
    region = CreateObject("roRegion", app.screen, 0, 0, app.screen.GetWidth(), app.screen.GetHeight())
    region.SetScaleMode(1)
    app.roScreen.DrawScaledObject(0, 0, scaleX, scaleY, region)
    app.roScreen.SwapBuffers()
    
    'print "___________END__RefreshScreen___________________"
end function