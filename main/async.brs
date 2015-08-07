
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
        if id = invalid then return false
        
        task = m.taskWithId(id)
        
        if task = invalid then return false

        if task.onStateChange <> invalid
            task.onStateChange(state, task.onStateChangeArg)
        end if
        
        index = m.indexOfTaskWithId(id)
        if index >= 0 then m.x___.tasks.Delete(index)
        return true
    end function
end function