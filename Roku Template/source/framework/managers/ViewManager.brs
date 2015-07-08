function CreateUI(type_, options) as Object
    ui = {
        button      : UIButton
        label       : UILabel
        image       : UIImage
        textArea    : UITextArea
        view        : UIView
        gridView    : UIGridView
        listView    : UIListView
        scrollView  : UIScrollView
    }
    
    return ui[type_](options)
end function

function LoadViewNamed(viewName, displaySpecific = false as Boolean)
    app = GetApp()
    
    xmlString = ReadAsciiFile(app.viewFolder.Default+viewName+".xml")
    xml = ParseXML(xmlString)
    
    body = xml.getbody()
    
    if body <> invalid
        for each e in body
        end for
    end if
    
    return CreateUI(xml.GetName(), xml.GetAttributes())
end function

function ParseXML(str As String) As Dynamic
    if str = invalid return invalid
    xml = CreateObject("roXMLElement")
    if not xml.Parse(str) return invalid
    return xml
end function