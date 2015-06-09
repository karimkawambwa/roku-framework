function main()
    
    splash = splash()
    
    'Create app manager
    app = CreateObject("roAppManager")
    
    'App configurations
    config = config_()
    config.init_theme(app)
    
    appDelegate = AppDelegate(app)
    
    appDelegate.applicationDidLaunch()
    
    'Event Looooop
    while true:
        
    end while
    
end function