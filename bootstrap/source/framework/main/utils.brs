function GetApp()
    aa = GetGlobalAA()
    return aa.app
end function

function AppScreen(command)
    app = GetApp()
    if command = "width"
        return app.screen.GetWidth()
    else if command = "height"
        return app.screen.GetWidth()
    end if
    return invalid
end function

function AppNavigation()
    return GetApp().navigationManager
end function

function NavigateTo(controller)
    AppNavigation().navigateTo(controller)
end function

function NavigateWithoutHistoryTo(controller)  
    AppNavigation().navigateTo(controller, true)
end function

function ScheduleTask(task)
    return GetApp().async.scheduleTask(task)
end function

function random(num_min As Integer, num_max As Integer) As Integer
    return (RND(0) * (num_max - num_min)) + num_min
end function

function copy(obj as Object) as Object
    return ParseJson(FormatJson(obj))
end function

function uniqueid(append = "id" as String)
    return append +"_"+random(1000000000, 9999999999).toStr()
end function