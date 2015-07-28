
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

function GetApp()
    aa = GetGlobalAA()
    return aa.app
end function

function AppScreen(command)
    app = GetApp()
    if command = "width"
        return app.screen.GetWidth()
    else if command = "height"
        return app.screen.GetHeight()
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

function KillTask(taskId)
    return GetApp().async.cancelTask(taskId)
end function

function ParseXML(str As String) As Dynamic
    if str = invalid return invalid
    xml = CreateObject("roXMLElement")
    if not xml.Parse(str) return invalid
    return xml
end function

function random(num_min As Integer, num_max As Integer) As Integer
    return (RND(0) * (num_max - num_min)) + num_min
end function

' Object should not have functions
function copy(obj as Object) as Object
    return ParseJson(FormatJson(obj))
end function

function uniqueid(append = "id" as String)
    return append +"_"+random(1000000000, 9999999999).toStr()
end function