
' The MIT License (MIT)

' Copyright (c) 2015 Karim Kawambwa

' Author Karim Kawambwa

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

function UIImage(options)
    this = UIView(options, {
        name : options["name"]
        src : options["src"]
        async : options["load:sync"] = invalid
    })
    
    this.setup = function()
        options = {
            async : true
            args : [m]
            width : m.width()
            height : m.height()
            complete : m.imageLoaded
        }
        if m.name <> invalid
            ImageNamed(m.name, options)
        else if m.src <> invalid
            ImageFromPath(m.src, options)
        end if
    end function
    
    this.imageLoaded = function(id, bitmap, args)
        m = args[0]
        
        region = CreateRegion(0,0,m.width(), m.height(), bitmap)
        sprite = CreateSprite(0,0,region, m.compositor)
        RefreshScreen()
    end function
    
    this.setup()
    
    return this
end function