
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


function AddDimmensionControlsTo(this)
	this.Append({
		dim___pr : { 'don't access directly
            x               :   if_else(options.x <> invalid, toInt(options.x), 0)
            y               :   if_else(options.y <> invalid, toInt(options.y), 0)
            z               :   if_else(options.z <> invalid, toInt(options.z), 0)
            width           :   invalid 'will be set
            height          :   invalid 'will be set

            widthPercent    :   -1
            heightPercent   :   -1
            
            ' if width is provided then autoWidth will be set to false
            autoWidth : (options.width = invalid or (options.autoWidth <> invalid and options.width = invalid))
            ' if height is provided then autoHeight will be set to false
            autoWidth : (options.height = invalid or (options.autoHeight <> invalid and options.height = invalid))
            
            ' This is the cuttoff width and height
           	' The view cannot/should not exceed this
           	' Otherwise we might for example go off screen
           	' This is set after layout is called
            maxWidth : 0
            maxHeight : 0
		}
	})

	this.dim___pr.width = if_else(options.width <> invalid, options.width, 0)
    this.dim___pr.height = if_else(options.height <> invalid, options.height, 0)
    
    if type(this.dim___pr.width) = "roString"
        if this.dim___pr.width.right(1) = "%"
           this.dim___pr.widthPercent = toInt(this.dim___pr.width.left(this.dim___pr.width.len()-1))/100
        else
            this.dim___pr.width = toInt(this.dim___pr.width)
        end if
    end if
    
    if type(this.dim___pr.height) = "roString"
        if this.dim___pr.height.right(1) = "%"
           this.dim___pr.heightPercent = toInt(this.dim___pr.height.left(this.dim___pr.height.len()-1))/100
        else
            this.dim___pr.height = toInt(this.dim___pr.height)
        end if
    end if
    
    this.z = function()
        return m.dim___pr.z
    end function
    
    this.x = function()
        return m.dim___pr.x
    end function
    
    this.y = function()
        return m.dim___pr.y
    end function
    
    this.width = function()
        return if_else(m.hidden(), 0, m.dim___pr.width)
    end function
    
    this.height = function()
        return if_else(m.hidden(), 0, m.dim___pr.height)
    end function

    'Call Render Screen After This
    this.setZ = function(z)
        m.dim___pr.z = z
        m.sprites.SetZ(z)
    end function
    
    'Call Render Screen After This
    this.addZ = function(z)
        m.dim___pr.z = m.dim___pr.z + z
        m.sprites.AddZ(z)
    end function
    
    'Call Render Screen After This
    this.setX = function(x)
        offset = x - m.x()
        
        m.dim___pr.x = x
        
        m.sprites.MoveOffset(offset, 0)
    end function
    
    'Call Render Screen After This
    this.setY = function(y)
        offset = y - m.y()
        
        m.dim___pr.y = y
        
        m.sprites.MoveOffset(0, offset)
    end function
    
    'Call Render Screen After This
    this.setHeight = function(height)
        m.dim___pr.height = height
    end function
    
    'Call Render Screen After This
    this.setWidth = function(width)
        m.dim___pr.width = width
    end function

    'Center point of view
    this.center = function()
    'TODO : Distiguish between real position and the relative
        return {
            x : m.x() + Fix(m.width()/2)
            y : m.y() + Fix(m.height()/2)
        }
    end function

    'This is to bound within layout
    this.setMaxWidth = function(maxWidth)
        m.dim___pr.maxWidth = maxWidth
    end function
    
    'This is to bound within layout
    this.setMaxHeight = function(maxHeight)
        m.dim___pr.maxHeight = maxHeight
    end function

    'Call Render Screen After This
    this.MoveTo = function(x, y)
        offset_x = x - m.x()
        offset_y = y - m.y()
        
        m.dim___pr.x = x
        m.dim___pr.y = y
        
        m.sprites.MoveOffset(offset_x, offset_y)
    end function
    
    'Call Render Screen After This
    this.MoveOffset = function(x, y)
        
        m.dim___pr.x = m.dim___pr.x + x
        m.dim___pr.y = m.dim___pr.y + y
        
        m.sprites.MoveOffset(x, y)
    end function

    this.setupDimensions = function()
    	' If the parent is invalid for this view
    	' Any percentage dimmensions used will fail
    	if m.parent <> invalid
	    	if m.dim___pr.widthPercent > -1
	            m.setWidth(Fix(m.dim___pr.widthPercent * m.parent.width()))
	        end if
	        if m.dim___pr.heightPercent > -1
	            m.setHeight(Fix(m.dim___pr.heightPercent * m.parent.height()))
	        end if
        end if
    end function

end function