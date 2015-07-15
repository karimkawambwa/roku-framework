
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

'A constraint consists of  side|to_side|value|flexibility|priority|ref_id
'Eg: t|b|0|==|100|ExampleView  
'It means (t) top of current view to (b) bottom of view (ref_id) ExampleView
'(==) with no flexibility i.e exact value at (100) % priority
'
'Maximum of 4 constraints per view i.e top, bottom, left, right
function CreateConstraintsContainerFor(view, constraintsString)
    
    ' Setup the constraints container
    constraints = {
        view : view
        'T    : invalid   'top
        'B    : invalid   'bottom
        'L    : invalid   'left
        'R    : invalid   'right
    }
    
    constraints.SetModeCaseSensitive()

    constraints.prepareForLayout = function()
        getViewConstrainedToSide = function(constraint, view) as Void
            if constraint = invalid then return
            
            constraint.view = view.parent.children.childWithId(constraint.ref())
            if constraint.view = invalid then 
                print "Constraint Error : Cannot constrain "+side+" [ "+child.id+" ] in [ "+parent.id+" ] to invalid view"
                print "Constraint Errored : "
                print constraint
            end if
        end function
            
        getViewConstrainedToSide(m.T, m.view)
        getViewConstrainedToSide(m.B, m.view)
        getViewConstrainedToSide(m.L, m.view)
        getViewConstrainedToSide(m.R, m.view)
    end function
    
    contraints.add = function(constraint)
        reg = CreateObject("roRegex", "(\t|\|)+", "")
        params = reg.Split(constraint)
        
        mySide      = params[0]
        toSide      = params[1]
        value       = params[2]
        flexibility = params[3]
        priority    = params[4]
        ref         = params[5]
        
        m[mySide] = UIContraint(ref, toSide, toInt(value), toInt(priority), flexibility)
    end function
    
    'Begin parsing if string is valid
    if constraintsString = invalid then return constraints
    
    reg1 = CreateObject("roRegex", "(\t|,)+", "")
    
    tokens = reg1.Split(constraintsString)
    for each token in tokens
        constraints.add(token)
    end for
    
    return constraints
end function