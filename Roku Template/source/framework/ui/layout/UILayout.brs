function LayoutType()
    return {
        NONE        : "NONE"
        VERTICAL    : "VERTICAL"
        HORIZONTAL  : "HORIZONTAL"
    }
end function

function UILayout(options)
    app = GetApp()
    this = UIBase({
        id              :   if_else(options.id <> invalid, options.id, uniqueid())
        x               :   if_else(options.x <> invalid, toInt(options.x), 0)
        y               :   if_else(options.y <> invalid, toInt(options.y), 0)
        z               :   if_else(options.z <> invalid, toInt(options.z), 0)
        width           :   if_else(options.width <> invalid, toInt(options.width), 0)
        height          :   if_else(options.height <> invalid, toInt(options.height), 0)

        '              top (T)
        '            _____________
        '           |             |
        '  left (L) |             | right (R)
        '           |             |
        '           |_____________|
        '
        '              bottom (B)
        constraints     :   CreateConstraintsContainerFor(m, options.constraints)

        '       align_v |
        '               |
        ' align_h -------------
        '               |
        '               |
        align   : {
            vertical    : options.aling_v <> invalid
            horizontal  : options.align_h <> invalid
            center      : options.center <> invalid
        }

        layout___pr : { 'don't access directly
            ' if width is provided then autoWidth will be set to false
            autoWidth : (options.width = invalid or (options.autoWidth <> invalid and options.width = invalid))
            ' if height is provided then autoHeight will be set to false
            autoWidth : (options.height = invalid or (options.autoHeight <> invalid and options.height = invalid))
        }
    })
    
    'Center point of layout
    this.center = function()
        return {
            x : 0
            y : 0
        }
    end function
    
    this.preLayout = {
        x           :   this.x
        y           :   this.y
        z           :   this.z
        width       :   this.width
        height      :   this.height
        align       :   copy(this.align) 'hold a copy
    }
    
    ' Container
    AddChildrenContainerTo(this)
    
    this.prepareForLayout = function()
    end function
    
    this.layout = function(onComplete = invalid, onCompleteContext = invalid)
        app = GetApp()
        
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
            onStateChangedArg : m
            onStateChanged : function(state, onStateChangedArg)
                m = onCompleteContext
                
                if state = "willstart"
                    '
                else if state = "cancelled"
                    '
                else if state = "done"
                    m.setOpaque(true) 'End Layout
            
                    if onComplete <> invalid
                        onComplete(onCompleteContext)
                    end if
            
                    RefreshScreen()
                end if
            end function
        })
    end function
    return this
end function