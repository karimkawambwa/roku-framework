
Library "v30/bslDefender.brs"

function main()
    initApp()
    
    app     = GetApp()
    mainNav = AppNavigation()
    codes   = bslUniversalControlEventCodes()
    
    app.delegate.applicationLaunched()
    while 1
        msg = app.msgPort.GetMessage()
        
        currentController = mainNav.currentController()
        currentView = currentController.view
        
        if type(msg) = "roUniversalControlEvent"
            if currentView <> invalid and currentView.handleUserInput <> invalid
                currentView.handleUserInput(msg.GetInt(), codes)
            end if
            
            if currentView <> invalid and currentView.handleUserInput <> invalid
                currentView.handleUserInput(msg.GetInt(), codes)
            end if
        end if

        if type(msg) = "roUrlEvent"

        end if
        
        app.async.performTasks() 'perfortasks to simulate asynchronous behaviour
    end while
    app.delegate.applicationTerminated()
end function