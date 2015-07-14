function UIContraint(ref, side, value, priority, flexibility = "==" as String)
    this = {  
        constraint___pr : { 'don't access directly
            ref      : ref
            side     : side
            value    : value
            priority : priority
            flexibility : flexibility
        }
        
        pre_layout : {
            ref      : ref
            value    : value
            priority : priority
            flexibility : flexibility
        }
    }
    
    this.ref = function()
        return m.constraint___pr.ref
    end function
    
    this.side = function()
        return m.constraint___pr.side
    end function
    
    this.value = function()
        return m.constraint___pr.value
    end function
    
    this.priority = function()
        return m.constraint___pr.priority
    end function
    
    this.flexibility = function()
        return m.constraint___pr.flexibility
    end function
    
    this.setValue = function(value)
        m.pre_layout.value = value
        'Update Layout
    end function
    
    this.setPriority = function(value)
        m.pre_layout.value = value
        'Update Layout
    end function
    
    this.setFlexibility = function(value)
        m.pre_layout.value = value
        'Update Layout After this call or it will update on another update cycle
    end function
    
    return this
end function

function UIConstraintFlexibility()
    return {
        GREATER_THAN_OR_EQUAL : ">="
        LESS_THAN_OR_EQUAL : "<="
        EXACT : "=="
    }
end function