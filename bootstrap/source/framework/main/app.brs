function initApp()
    gg = GetGlobalAA()
    gg.app = {
        screen          : invalid   'will be initialized
        roScreen        : invalid   'will be initialized
        compositor      : invalid   'will be initialized
        textureManager  : invalid   'will be initialized
        
        msgPort         : CreateObject("roMessagePort")
        deviceInfo      : CreateObject("roDeviceInfo")
        fileSystem      : CreateObject("roFileSystem")
        
        'Action Safe Zone From Roku Docs
        'Will be set in initScreen
        screenSafeZone  : {
            x       : 0
            y       : 0
        }
        
        'Will be set in initScreen
        'Will be corrected for SafeZones
        screenSize  : {
            x       : 0
            y       : 0
            width   : 0
            height  : 0
        }
        
        'Will be set in initScreen
        isHD          : false
        isSD          : false
        isWideScreen  : false
    }
    
    initFont(gg.app)
    initScreen(gg.app)
    initCompositor(gg.app)
    initTextureManager(gg.app)
    initAsyncTaskManager(gg.app)
    
    gg.app.navigationManager = NavigationManager()
    gg.app.delegate = AppDelegate()
    
    'Configure the Application
    Config(gg.app)
end function

function initCompositor(app)
    app.compositor  = CreateObject("roCompositor")
    app.compositor.SetDrawTo(app.screen, 0)
end function

function initTextureManager(app)
    app.textureManager  = CreateObject("roTextureManager")
    app.textureManager.SetMessagePort(app.msgPort)
end function