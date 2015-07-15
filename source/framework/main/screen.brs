
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

function DisplayType()
    return {
        HDTV          : "HDTV"
        SD            : "4:3 standard"
        WIDESCREEN    : "16:9 anamorphic"
    }
end function

function initScreen(app)
    DisplaySize = app.deviceInfo.GetDisplaySize()
    
    app.roScreen   = CreateObject("roScreen", true)
    app.roScreen.SetMessagePort(app.msgPort)
    
    dt  = app.deviceInfo.GetDisplayType()
    
    app.isHD           = DisplaySize.h >= 720 or dt = DisplayType().HDTV
    app.isWideScreen   = DisplaySize.h >= 720 or dt = DisplayType().WIDESCREEN
    app.isSD           = DisplaySize.h < 720 and dt = DisplayType().SD
    
    app.screenSafeZone.x  = if_else(app.isWideScreen, 64, 36)
    app.screenSafeZone.y  = if_else(app.isWideScreen, 35, 24)
    
    if app.isWideScreen
        app.screenSize = {
            x       : 0
            y       : 0
            width   : 1280
            height  : 720
        }
    else
        app.screenSize = {
            x       : 0
            y       : 0
            width   : 640
            height  : 480
        }
    end if
    
    app.screen     = CreateBitmap(app.screenSize.width, app.screenSize.height)
end function