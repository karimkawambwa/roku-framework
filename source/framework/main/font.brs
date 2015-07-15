
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

function initFont(app)
    app.fontRegistry = CreateObject("roFontRegistry")
    fonts = app.fileSystem.GetDirectoryListing("pkg://fonts/")
    fonts.ResetIndex()
    font = fonts.GetIndex()
    while font <> invalid
        family = app.fileSystem.Find("pkg://fonts/"+font, "(.ttf|.otf)")
        family.ResetIndex()
        fam = family.GetIndex()
        while fam <> invalid
            registered = app.fontRegistry.Register("pkg://fonts/"+font+"/"+fam)
            if not registered then print "Font Register [FAILED] : "+ font + " path [ pkg://fonts/"+font+"/"+fam+" ]"
            fam = family.GetIndex()
        end while
        font = fonts.GetIndex()
    end while
end function