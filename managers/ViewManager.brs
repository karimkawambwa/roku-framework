
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

function CreateUI(type_, options) as Object
    app = GetApp()
    ui = {
        button      : UIButton
        label       : UILabel
        image       : UIImage
        textArea    : UITextArea
        view        : UIView
    }
    
    ui["list:view"] = UIListView
    ui["grid:view"] = UIGridView
    ui["scroll:view"] = UIScrollView
    
    ui.Append(app.customUI)
    
    return ui[type_](options)
end function

function LoadViewNamed(viewName, displaySpecific = false as Boolean, x = invalid, y = invalid, w = invalid, h = invalid)
    app = GetApp()
    
    'TODO Display Specific
    xmlString = ReadAsciiFile(app.viewFolder+viewName+".xml")

    'TODO :
    'LocalizeViewXmlString(xmlString)

    xml = ParseXML(xmlString)
    
    loadedView = CreateUI(xml.GetName(), xml.GetAttributes())
    
    if x <> invalid then loadedView.setX(x)
    if y <> invalid then loadedView.setY(y)
    if w <> invalid then loadedView.setWidth(w)
    if h <> invalid then loadedView.setHeight(h)
    
    loadedView.parentCompositor = GetApp().compositor
    ' This means that its the main window
    loadedView.movedToParent(invalid)
    
    LoadChildrenForView(loadedView, xml)
    
    return loadedView
end function

function ViewFromXml(xml)
    if xml = invalid then return invalid
    
    view = CreateUI(xml.GetName(), xml.GetAttributes())
    LoadChildrenForView(view, xml)
    return view
end function

function LoadChildrenForView(parentView, parentXml)
    childrenXml = parentXml.getbody()
    if childrenXml <> invalid
        for each childXml in childrenXml
            view = CreateUI(childXml.GetName(), childXml.GetAttributes())
            
            if view = invalid then return false
            
            parentView.children.addChild(view)
            
            if childXml.GetName() = "list:view" and childXml.GetAttributes()["static"] = "false"
                view.prototypeItems = childXml.getbody()
            else if childXml.GetName() = "grid:view" and childXml.GetAttributes()["static"] = "false"
                view.prototypeItems = childXml.getbody()
            else
                LoadChildrenForView(view, childXml)
            end if
        end for
    end if
    
    return true
end function
