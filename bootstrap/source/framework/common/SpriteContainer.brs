function AddSpriteContainerTo(this)
    this.sprites = {
        x___ : {
            sprites : []
        }
    }
    
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