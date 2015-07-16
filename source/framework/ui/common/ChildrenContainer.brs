
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
    
    this.children["each"] = function(ctxt, callback)
        index = 0
        for each id in m.x___.childrenIds
            child = m.x___.children[id]
            callback(index, child, ctxt)
            index = index + 1
        end for
    end function
    
    'Child must be an object with a unique ID
    this.children.addChild = function(child)
        m.x___.childrenIds.Push(child.id)
        m.x___.children[child.id]= child
        
        child.parent = m.parent
        if child.movedToParent <> invalid then child.movedToParent(m.parent)
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
            print "Error : Trying to access child at index [",index,"] out of bounds"
            return invalid
        end if
        
        id = m.x___.childrenIds[index]
        return  m.x___.children[id]
    end function
end function