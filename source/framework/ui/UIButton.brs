
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

function UIButton(options)
    this = UIView(options, {
        label : UIlabel({
            center : true
            text : options.title
        })
        
        focused : {
            color : ColorWithName(options["focused:title:color"])
            backgroundColor : ColorWithName(options["focused:bg:color"])
            backgroundImage : BitmapImageWithName(options["focused:bg:image"])
        }
        
        highlight : {
            color : ColorWithName(options["highlight:title:color"])
            backgroundColor : ColorWithName(options["highlight:bg:color"])
            backgroundImage : BitmapImageWithName(options["highlight:bg:image"])
        }
        
        selected : {
            color : ColorWithName(options["selected:title:color"])
            backgroundColor : ColorWithName(options["selected:bg:color"])
            backgroundImage : BitmapImageWithName(options["selected:bg:image"])
        }
    })
    
    this.children.addChild(this.label)
    
    return this
end function