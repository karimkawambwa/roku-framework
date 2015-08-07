
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

function UIView(options, appendOptions = {} as Object)
    this = UILayout(options, {
        type : "view"
        animating : false
        compositor : invalid
        parentCompositor : invalid
        
        backgroundOpacity : if_else(options["bg:opacity"] <> invalid, options["bg:opacity"], 1)
        backgroundColor   : invalid
    })
    
    IncludeSpriteContainerTo(this)
    IncludeAnimateTo(this)
    IncludeUIInteractionTo(this)
    
    'Other Views options subclassing
    if appendOptions <> invalid then this.Append(appendOptions) 

    this.backgroundColor = ColorWithName(options["bg:color"], ColorOpacity(this.backgroundOpacity))
    
    ' Called by RefreshScreen
    ' Carefull Overriding this method
    this.draw = function(component as Object) as Boolean
        
        sprite = m.sprites.sprite(0)
        bitmap = sprite.GetRegion().GetBitmap()
        bitmap.Clear(m.bgColor())
        
        m.children.perform("draw", [bitmap])
        
        'print m.id+" drawable : ", sprite.GetDrawableFlag() 
        'AddBorderToBitmap(bitmap, ColorWithName("red"), 1)
        
        'Draw the view compositor sprites
        if m.compositor <> invalid then
            m.compositor.DrawAll()
        end if
        
        return true
    end function
    
    this.base_layout_prepareForLayout = this.prepareForLayout
    this.prepareForLayout = function()
        m.base_layout_prepareForLayout()
    end function
    
    this.base_layout_didLayout = this.didLayout
    this.didLayout = function()
        m.base_layout_didLayout()
    end function
    
    this.setBackgroundColor = function(color as Integer)
        m.backgroundColor = color
        
        RefreshScreen()
    end function
    
    this.bgColor = function()
        return m.backgroundColor
    end function
    
    ' Should be invoked once
    this.init = function()
        m.initBackground()
        m.initViewCompositor()
    end function
    
    ' Should be invoked once
    this.initViewCompositor = function() as Void
        if m.compositor <> invalid then return
        
        m.compositor = CreateObject("roCompositor")
        
        sprite = m.sprites.sprite(0)
        bitmap = sprite.GetRegion().GetBitmap()
        bitmap.SetAlphaEnable(true)
        
        m.compositor.SetDrawTo(bitmap, 0)
    end function
    
    ' Should be invoked once
    this.initBackground = function() as Void
        if m.sprites.count() > 0 then return
        
        bitmap = CreateBitmap(m.width(), m.height())
        bitmap.Clear(m.bgColor())
        
        region = CreateRegion(0, 0, m.width(), m.height(), bitmap)
        
        ' If the viewCompositor is invalid then the app compositor will be used
        ' Only the first view in the hirerchy should use the app compositor
        ' See Drawing.md for more information
        sprite = CreateSprite(m.x(), m.y(), region, m.parentCompositor)
        
        ' This Sprite 0 is the main view bitmap
        ' Everything belonging to this view will be draw on this
        m.sprites.Add(sprite)
        m.sprites.SetDrawableFlag(m.isOpaque())
    end function
    
    return this
end function