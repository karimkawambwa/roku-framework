'Get font width / height
function GetFontWidth(font, text as String) As Integer
    return font.GetOneLineWidth(text, 9999)
end function

function GetFontHeight(font) as Integer
    return font.GetOneLineHeight()
end function

function CreateBitmap(width, height)
    bitmap = CreateObject("roBitmap", {width: width, height: height, alpahEnabled: false})
    return bitmap
end function

function CreateRegion(x, y, width, height, component)
    return CreateObject("roRegion", component, x, y, width, height)
end function

function CreateSprite(x, y, region)
    return GetApp().compositor.NewSprite(x, y, region)
end function

function FontWithNameAndSize(fontName, size)
    app = GetApp()
    return app.fontRegistry.GetFont(fontName, size, false, false)
end function