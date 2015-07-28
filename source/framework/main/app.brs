
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
        
        urlEventListeners : []
        
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
    initImages(gg.app)
    initStrings(gg.app)
    initCompositor(gg.app)
    initEventReceiver(gg.app)
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