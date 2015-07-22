
' The MIT License (MIT)

' Copyright (c) 2015 Karim Kawambwa

' Author Karim Kawambwa

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

function BeginScreenUpdate(app)
    app.screen.Clear(ColorWithName("black"))
    app.screen.SetAlphaEnable(true)
end function

function RefreshScreen()
    print "___________BEGIN__RefreshScreen___________________"
    
    app = GetApp()
    
    BeginScreenUpdate(app)
    
    currentController = AppNavigation().currentController()
    
    if currentController.View <> invalid then
        currentController.View.Draw(app.screen)
    else
        print "Invalid View Error Controller [ ",currCtrlr," ]"
    end if
    
    ' Draw the app compositor sprites
    ' Holds to level Views
    app.compositor.DrawAll()
    
    'AddBorderToBitmap(app.screen, ColorWithName("red"))
    
    UpdateRoScreen(app)
    
    print "___________END__RefreshScreen___________________"
end function

function UpdateRoScreen(app)
    scaleX = app.roScreen.GetWidth() / app.screen.GetWidth()
    scaleY = app.roScreen.GetHeight() / app.screen.GetHeight()
    
    'print "roScreen : w = ", app.roScreen.GetWidth(), " h = ",app.roScreen.GetHeight()
    'print "screen : w = ", app.screen.GetWidth(), " h = ",app.screen.GetHeight()
    'print "scaleX : ", scaleX, " scaleY : ",scaleY
    
    region = CreateObject("roRegion", app.screen, 0, 0, app.screen.GetWidth(), app.screen.GetHeight())
    region.SetScaleMode(1)
    app.roScreen.DrawScaledObject(0, 0, scaleX, scaleY, region)
    app.roScreen.SwapBuffers()
end function