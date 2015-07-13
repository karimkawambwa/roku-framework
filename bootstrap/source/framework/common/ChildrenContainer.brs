function AddChildrenContainerTo(this)
    this.Append({
        children : {
            parent : this
            x___ : { 'don't access directly unless debugging
                childrenIds  : []
                children     : {}
            }
        }
    })

    this.children.perform = function(funcName, arg)
        for each id in m.x___.childrenIds
            child = m.x___.children[id]
            if child[funcName] <> invalid then child[funcName](arg)
        end for
    end function

    this.children.Count = function()
        return m.x___.childrenIds.Count()
    end function
    
    'Child must be an object with a unique ID
    this.children.addChild = function(child)
        m.x___.childrenIds.Push(child.id)
        m.x___.children[child.id]= child
        
        child.parent = m
    end function
    
    'Each child must be an object with a unique ID
    this.children.addChildren = function(children)
        for each child in children
            m.x___.childrenIds.Push(child.id)
            m.x___.children[child.id]= child
            
            child.parent = m.parent
        end for
    end function
    
    this.children.childWithId  = function(id as String)
        return m.x___.children[id]
    end function
    
    this.children.firstChild  = function()
        if m.x___.childrenIds.Count() = 0 then return invalid
        
        id = m.x___.childrenIds[0]
        return  m.x___.children[id]
    end function
    
    this.children.lastChild  = function()
        if m.x___.childrenIds.Count() = 0 then return invalid
        
        count = m.x___.childrenIds.Count()
        id = m.x___.childrenIds[count-1]
        return  m.x___.children[id]
    end function
    
    this.children.childAtIndex  = function(index as Integer)
        count = m.x___.childrenIds.Count()
        if count = 0 then return invalid
        if index >= count or index < 0 then
            print "Error View [ "+m.id+" ] : Trying to access child at index ["+index+"] out of bounds"
            return invalid
        end if
        
        id = m.x___.childrenIds[index]
        return  m.x___.children[id]
    end function
end function