function DisplayType()
    return {
        HDTV          : "HDTV"
        SD            : "4:3 standard"
        WIDESCREEN    : "16:9 anamorphic"
    }
end function

function initScreen(app)
    DisplaySize = app.deviceInfo.GetDisplaySize()
    
    app.screen     = CreateBitmap(DisplaySize.w, DisplaySize.h) 
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
            x       : app.screenSafeZone.x
            y       : app.screenSafeZone.y
            width   : 1280  - app.screenSafeZone.x
            height  : 720   - app.screenSafeZone.y
        }
    else
        app.screenSize = {
            x       : app.screenSafeZone.x
            y       : app.screenSafeZone.y
            width   : 640  - app.screenSafeZone.x
            height  : 480  - app.screenSafeZone.y
        }
    end if
end function