
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


function PerformLayout(args) as Boolean
    m = args.context

    m.prepareForLayout()

    if args.index = invalid then options.index = 0
    
    view = m.children.childAtIndex(args.index)
    args.index = args.index + 1

    if view = invalid then
        print "Layout Bailed!!!"
        print "View ID : "+ m.id
        print "Layout Child Index : "+ (args.index -1).toStr()
        return true
    end if
    
    offset = view.x() - m.x() 'x that would place view outside layout area
    view.setMaxWidth(m.width() - offset)
    
    view.prepareForLayout()
    
    print "performing layout for view : "+ view.id
    
    if view.constraints <> invalid and view.constraints.Count() > 0

        view.constraints.prepareForLayout()
        
        view.updateDimmensions()
        
    end if
    
    if m.z() >= view.z() then view.setZ(m.z()+1)
    
    if view.align.vertical or view.align.center
        view.setX(((m.width()/2) - (view.width()/2)))
    end if
    
    if view.align.horizontal or view.align.center
        view.setY(((m.height()/2) - (view.height()/2)))
    end if
    
    print "dimmensions :"
    print view.dim___pr
    
    if view.children.Count() <> 0
        args.workStack.Push({context : m, index : args.index})
        args.context = view
        args.index   = 0
        
        m = view
    end if 
    
    if args.index >= m.children.Count() and args.workStack.Count() > 0 then
        
        ' From the work Stack get the obj that still needs layout work done
        ' This does a recursive search
        getWork = function(worKStack as Object, getWork as Function)
            obj = workStack.Pop()
            if obj.index >= obj.context.children.Count() and workStack.Count() > 0
                return getWork(worKStack, getWork) 
            end if
            return obj
        end function
        
        obj = getWork(args.worKStack, getWork)
        
        args.context = obj.context
        args.index   = obj.index
        
        m = args.context
    end if
    
    if view.didLayout <> invalid then view.didLayout()
    
    return args.workStack.Count() = 0 and args.index >= m.children.Count()
end function