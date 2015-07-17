
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

function UILayout(options, appendOptions = {} as Object)
    app = GetApp()
    this = {
        id  :  if_else(options.id <> invalid, options.id, uniqueid())
        '              top (T)
        '            _____________
        '           |             |
        '  left (L) |             | right (R)
        '           |             |
        '           |_____________|
        '
        '              bottom (B)
        constraints     :   invalid 'Will be set 

        '       align_v |
        '               |
        ' align_h -------------
        '               |
        '               |
        align   : {
            vertical    : options["align_v"] <> invalid
            horizontal  : options["align_h"] <> invalid
            center      : options["center"] <> invalid
        }
    }
    
    'Other Views options subclassing
    if appendOptions <> invalid then this.Append(appendOptions) 

    AddChildrenContainerTo(this)
    AddVisibilityControlsTo(this)
    AddDimensionControlsTo(this, options)
    
    'Careful not to Override this method!
    this.movedToParent = function(parent)
        if parent <> invalid then m.setupDimensions()
        
        m.init()
    end function
    
    this.constraints = CreateConstraintsContainerFor(this, options.constraints)
    
    this.layout = function(onComplete = invalid, onCompleteContext = invalid)
        app = GetApp()
        
        m.onComplete = onComplete
        m.onCompleteContext = onCompleteContext
        
        m.setOpaque(false) 'Begin Layout
        
        'Perform layout asyncronously
        ScheduleTask({
            delay : 0 'perform immediately
            callback : PerformLayout
            arg : {
                context : m
                index   : 0
                workStack : []
            }
            onStateChangeArg : m
            onStateChange : function(state, onStateChangeArg)
                m = onStateChangeArg
                
                print "Layout State : "+state

                if state = "willstart"
                    '
                else if state = "cancelled"
                    '
                else if state = "done"
                    m.setOpaque(true) 'End Layout
                    if m.onComplete <> invalid
                        m.onComplete(m.onCompleteContext)
                    end if
                end if
            end function
        })
    end function
    
    this.prepareForLayout = function()
        '
    end function
    
    this.didLayout = function()
        '
    end function
    
    return this
end function