function AddChildrenContainerTo(this)
    this.Append({
        pr___ : { 'don't access directly
            childrenIds  : []
            children     : {}
        }
    })
    
    'Child must be an object with a unique ID
    this.addChild = function(child)
    end function
    
    'Each child must be an object with a unique ID
    this.addChildren = function(children)
    end function
    
    this.childWithId  = function(id as String)
    end function
    
    this.firstChild  = function()
    end function
    
    this.lastChild  = function()
    end function
    
    this.childAtIndex  = function(index as Integer)
    end function
end function