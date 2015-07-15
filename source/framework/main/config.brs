
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

function Config(app)
    app.frameworkFolder = "pkg://source/framework/"
    
    app.viewFolder = { 
        SD          : "pkg://source/views/SD/"
        HD          : "pkg://source/views/HD/"
        WideScreen  : "pkg://source/views/HD/"
        Default     : "pkg://source/views/"
    }
    
    app.imageFolder = {
        en_GB       : "pkg://locale/en_GB/images/"
        de_DE       : "pkg://locale/de_DE/images/"
        en_US       : "pkg://locale/en_US/images/"
        es_ES       : "pkg://locale/es_ES/images/"
        fr_CA       : "pkg://locale/fr_CA/images/"
        Default     : "pkg://locale/default/images/"
    }
    
    app.colorNames = ParseJson(ReadAsciiFile(app.frameworkFolder+"ui/colors/colors.json"))
end function