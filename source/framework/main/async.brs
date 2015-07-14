function initAsyncTaskManager(app)
    app.async = {
        timer : CreateObject("roTimespan")
        x___ : { 'don't access directly)
            tasks : []
        }
    }

    ' @param task
    ' {
    '   callback    : @require (function(arg) {})
    '   arg         : @optional (callback function argument)
    '   delay       : @optional (seconds)
    '   onStateChange  : @optional (function(state ("willstart", "cancelled", "done" ), onStateChangeArg) {})
    '   onStateChangeArg : @optional (onStateChange function argument)
    ' }
    app.async.scheduleTask = function(task as Object)
        if task = invalid then return invalid
        if task.callback = invalid then
            print "Error : Schedule task must have callback"
            return invalid
        end if
        
        id = uniqueid("async_task")
        
        task.id = id
        task.scheduled = m.timer.TotalMilliseconds()
        task.delay = if_else(task.delay <> invalid, task.delay, 0)
        task.state = "scheduled"
        
        m.x___.tasks.Push(task)
                
        return id
    end function
    
    app.async.setupTasksToPerform = function()
        tasks = []
        for each task in m.x___.tasks
            if task.state <> "performing"
                now = m.timer.TotalMilliseconds()
                if ((now - task.scheduled)/1000) >= task.delay
                    task.state = "performing"
    
                    if task.onStateChange <> invalid
                        task.onStateChange("willstart", task.onStateChangeArg)
                    end if
                end if
            end if
        end for
    end function
    
    app.async.performTasks = function()
        m.setupTasksToPerform()
        endTasks = []
        start = m.timer.TotalMilliseconds()
        for each task in m.x___.tasks
            if task.state = "performing"
                done = task.callback(task.arg)
                if done then
                    endTasks.Push(task.id)
                end if
                
                now = m.timer.TotalMilliseconds()
                if now - start >= 2000 'don't stay in here more than 2 seconds
                    exit for
                end if
            end if
        end for

        for each id in endTasks
            m.endTask(id)
        end for
    end function
    
    app.async.cancelTask = function(id)
        return m.endTask(id, "cancelled")
    end function
    
    app.async.taskWithId = function(id)
        for each task in m.x___.tasks
            if task.id = id then return task
        end for
        return invalid
    end function
    
    app.async.indexOfTaskWithId = function(id)
        index = -1
        for each task in m.x___.tasks
            index = index + 1
            if task.id = id then exit for
        end for
        return index
    end function
    
    app.async.endTask = function(id, state = "done" as String)
        if id = invalid then return true
        
        task = m.taskWithId(id)

        if task.onStateChange <> invalid
            task.onStateChange(state, task.onStateChangeArg)
        end if
        
        index = m.indexOfTaskWithId(id)
        if index >= 0 then m.x___.tasks.Delete(index)
        return true
    end function
end function