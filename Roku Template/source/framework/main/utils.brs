function GetApp()
    aa = GetGlobalAA()
    return aa.app
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

function CreateBitmap(width, height)
    return CreateObject("roBitmap", {width: width, height: height, alpahEnabled: true})
end function

function CreateRegion(x, y, width, height, component)
    return CreateObject("roRegion", component, x, y, width, height)
end function

function CreateSprite(x, y, region)
    return GetApp().compositor.NewSprite(x, y, region)
end function

function random(num_min As Integer, num_max As Integer) As Integer
    return (RND(0) * (num_max - num_min)) + num_min
end function