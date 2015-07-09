function AddChildrenContainerTo(this)
    this.Append({
        children___pr : { 'don't access directly unless debugging
            childrenIds  : []
            children     : {}
        }
    })
    
    'Child must be an object with a unique ID
    this.addChild = function(child)
        m.children___pr.childrenIds.Push(child.id)
        m.children___pr.children[child.id]= child
        
        child.parent = m
    end function
    
    'Each child must be an object with a unique ID
    this.addChildren = function(children)
        for each child in children
            m.children___pr.childrenIds.Push(child.id)
            m.children___pr.children[child.id]= child
            
            child.parent = m
        end for
    end function
    
    this.childWithId  = function(id as String)
        return m.children___pr.children[id]
    end function
    
    this.firstChild  = function()
        if m.children___pr.childrenIds.Count() = 0 then return invalid
        
        id = m.children___pr.childrenIds[0]
        return  m.children___pr.children[id]
    end function
    
    this.lastChild  = function()
        if m.children___pr.childrenIds.Count() = 0 then return invalid
        
        count = m.children___pr.childrenIds.Count()
        id = m.children___pr.childrenIds[count-1]
        return  m.children___pr.children[id]
    end function
    
    this.childAtIndex  = function(index as Integer)
        count = m.children___pr.childrenIds.Count()
        if count = 0 then return invalid
        if index >= count or index < 0 then
            print "Error View [ "+m.id+" ] : Trying to access child at index ["+index+"] out of bounds"
            return invalid
        end if
        
        id = m.children___pr.childrenIds[0]
        return  m.children___pr.children[id]
    end function
end function