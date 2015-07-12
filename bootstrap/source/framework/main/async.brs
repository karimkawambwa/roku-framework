function initAsyncTaskManager(app)
    app.async = {
        timer : CreateObject("roTimespan")
        x___ : { 'don't access directly)
            tasks : []
            scheduledTasks : {}
            performingTasks : []
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
        
        m.x___.tasks.Push(id)
        m.x___.scheduledTasks[id] = task
                
        return id
    end function
    
    app.async.setupTasksToPerform = function()
        tasks = []
        for each key in m.x___.tasks
            task = m.x___.scheduledTasks[key]
            now = m.timer.TotalMilliseconds()
            if ((now - task.scheduled)/1000) >= task.delay
                task.state = "performing"

                if task.onStateChange <> invalid
                    task.onStateChange("willstart", task.onStateChangeArg)
                end if

                tasks.Push(task)
            end if
        end for
        
        for each task in tasks 'remove from scheduled
            m.x___.scheduledTasks.Delete(task.id)
            m.x___.performingTasks.Push(task)
        end for
    end function
    
    app.async.performTasks = function()
        m.setupTasksToPerform()
        endTasks = []
        start = m.timer.TotalMilliseconds()
        for each task in m.x___.performingTasks
            done = task.callback(task.arg)
            if done then
                endTasks.Push(task.id)
            end if
            
            now = m.timer.TotalMilliseconds()
            if now - start >= 2000 'don't stay in here more than 2 seconds
                exit for
            end if
        end for

        for each id in endTasks
            m.endTask(id)
        end for
    end function
    
    app.async.performTask = function(id as String)
    end function
    
    app.async.cancelTask = function(id)
        return m.endTask(id, "cancelled")
    end function
    
    app.async.indexOfId = function(id)
        for index = 0 to m.x___.tasks.Count()
            if m.x___.tasks[index] = id then return index
        end for
        return -1
    end function
    
    app.async.endTask = function(id, state = "done" as String)
        if id = invalid then return true
        
        task = m.x___.performingTasks[id]

        if task.onStateChange <> invalid
            task.onStateChange(state, task.onStateChangeArg)
        end if

        m.x___.performingTasks.Delete(id)

        index = m.indexOfId(id)
        if index >= 0 then m.x___.tasks.Delete(index)
        return true
    end function
end function