function ahttp(method, args)
    this = {
        id : invalid
        
        method : method
        params : args["params"]
        url : args["url"]
        
        before : args["before"]
        done : args["done"]
        fail : args["fail"]
        cancelled : args["cancelled"]
        
        timeout : args["timeout"]
        
        request : CreateObject("roUrlTransfer")
    }
    
    this.setup = function()
        app = GetApp()
        m.id = m.request.GetIdentity()
        m.request.SetUrl(m.absoluteUrl())
        m.request.SetRequest(m.method)
        m.request.RetainBodyOnError(true)
        m.request.SetMessagePort(app.msgport)
    end function
    
    this.absoluteUrl = function()
        ' TODO : add params to url if its a get request
        return m.url
    end function
    
    this.urlQuery = function()
    end function
    
    this.baseUrl = function()
    end function
    
    this.fire = function(delay = 0 as Integer)
        requested = false
        if m.method = "GET"
            requested = m.request.AsyncGetToString()
        else if m.method = "POST"
            requested = m.request.AsyncPostFromString("")
        else if m.method = "DELETE"
            requested = m.request.AsyncGetToString()
        else if m.method = "PUT"
            requested = m.request.AsyncGetToString()
        else if m.method = "HEAD"
            requested = m.request.AsyncHead()
        else
            ' Unsupported
            return false
        end if
        
        if requested then
            app = GetApp()
            app.urlEventListeners.Push(m)
        end if
        
        return requested
    end function
    
    this.cancel = function()
        m.request.AsyncCancel()
    end function
    
    if this.before = invalid then
        this.before = function(request)
        end function
    end if
    
    this.handleUrlEvent = function(msg)
        state = msg.GetInt()
        if state = 2 ' started
            
            return false
        else if state = 1 ' complete
            status = msg.GetResponseCode()
            
            if status = 200
                m.done({ headers: msg.GetResponseHeaders(), body : msg.GetString()})
            else
                m.fail("TO DO : error message and code")
            end if
            
            return true
        end if
    end function
    
    ' Overide this 
    ' eg : request.done(function(data)
    ' 
    ' end function)
    if this.done = invalid then
        this.done = function(response as Object)
        end function
    end if
    
    ' Overide this 
    ' eg : request.fail(function(error)
    ' 
    ' end function)
    if this.fail = invalid then
        this.fail = function(error)
        end function
    end if
    
    ' Overide this 
    ' eg : request.cancelled(function()
    ' 
    ' end function)
    if this.cancelled = invalid then
        this.cancelled = function()
        end function
    end if
    
    this.setup()
    
    return this
end function