
Library "v30/bslDefender.brs"

function main()
    initApp()
    
    app     = GetApp()
    codes   = bslUniversalControlEventCodes()
    
    app.delegate.applicationLaunched()
    while 1
        
    end while
    app.delegate.applicationTerminated()
end function