
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

function UIListView(options)
    this = UIScrollView(options, {
        
        numberOfItems : 0
        index : -1
        
        isStatic : if_else(options.static = "true", true, false)
        layout : if_else(options.layout = "horizontal", "horizontal", "vertical")
        spacing : if_else(options.spacing <> invalid, toInt(options.spacing), 0)
        
        prototypeItem : options.prototypeItem
        dataSource : invalid
    })
    
    this.items = {
        each : this.children["each"]
        count : this.children.count
        item : this.children.childAtIndex
        add : this.children.add
    }
    
    this.itemFromPrototype = function(id)
        if m.prototypeItem <> invalid
            
        end if
    end function
    
    this.prepareForLayout = function() as Void
        if m.dataSource <> invalid then
            availableSpace = if_else(m.layout = "horizontal", m.width(), m.height())
            m.numberOfItems = m.dataSource.numberOfItemsForList(m)
            
            for index = 0 to m.numberOfItems
                item = m.dataSource.itemForListAtIndex(m, index)
                
                if item = invalid then 'Bail, Don't want to deal with this
                    print "Error : Invalid item for list [ "+m.id+" ] and index ", index
                    exit for
                end if
                
                takenSpace = m.spacing
                m.items.add(item)
                if layout = "horizontal"
                    item.setHeight(m.height())'fix to list height
                    takenSpace = takenSpace + item.width
                    
                    if index <> 0
                        m.items.item(index).constraints.add("T|T|"+toStr(spacing)+"|==|100|"+m.items.item(index-1).id)
                        m.items.item(index).constraints.add("L|R|"+toStr(spacing)+"|==|100|"+m.items.item(index-1).id)
                    end if
                else
                    item.setWidth(m.width()) 'fix to list width
                    takenSpace = takenSpace + item.height
                    
                    if index <> 0
                        m.items.item(index).constraints.add("T|B|"+toStr(spacing)+"|==|100|"+m.items.item(index-1).id)
                        m.items.item(index).constraints.add("L|L|"+toStr(spacing)+"|==|100|"+m.items.item(index-1).id)
                    end if
                end if
                
                availableSpace = availableSpace - takenSpace
                
                if availableSpace <= 0 then exit for
            end for
            
            if m.items.count > 0 then m.index = 0
        end if
    end function
    
    return this
end function