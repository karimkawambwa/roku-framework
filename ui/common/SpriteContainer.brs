
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

function IncludeSpriteContainerTo(this)
    this.sprites = {
        x___ : {
            sprites : []
        }
    }
    
    this.sprites.sprite = function(index)
        if index < 0 or index >= m.Count() then return invalid
        return m.x___.sprites[index]
    end function
    
    this.sprites.Count = function()
        return m.x___.sprites.Count()
    end function
    
    this.sprites.Add = function(sprite)
        if sprite <> invalid then m.x___.sprites.Push(sprite)
    end function
    
    this.sprites.SetZ = function(z)
        for each sprite in m.x___.sprites
            sprite.SetZ(z)
        end for
    end function
    
    this.sprites.AddZ = function(z)
        for each sprite in m.x___.sprites
            sprite.SetZ(sprite.GetZ()+z)
        end for
    end function
    
    this.sprites.MoveOffset = function(x, y)
        for each sprite in m.x___.sprites
            sprite.MoveOffset(x, y)
        end for
    end function
    
    this.sprites.SetDrawableFlag = function(drawable)
        for each sprite in m.x___.sprites
            sprite.SetDrawableFlag(drawable)
        end for
    end function
    
end function