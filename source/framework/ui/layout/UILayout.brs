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

        layout___pr : { 'don't access directly
            x               :   if_else(options.x <> invalid, toInt(options.x), 0)
            y               :   if_else(options.y <> invalid, toInt(options.y), 0)
            z               :   if_else(options.z <> invalid, toInt(options.z), 0)
            width           :   invalid 'will be set
            height          :   invalid 'will be set
            
            widthPercent    :   -1
            heightPercent   :   -1
            
            ' if width is provided then autoWidth will be set to false
            autoWidth : (options.width = invalid or (options.autoWidth <> invalid and options.width = invalid))
            ' if height is provided then autoHeight will be set to false
            autoWidth : (options.height = invalid or (options.autoHeight <> invalid and options.height = invalid))
            
            maxWidth : 0
            maxHeight : 0
        }
    })
    
    this.layout___pr.width = if_else(options.width <> invalid, options.width, 0)
    this.layout___pr.height = if_else(options.height <> invalid, options.height, 0)
    
    if type(this.layout___pr.width) = "roString"
        if this.layout___pr.width.right(1) = "%"
           this.layout___pr.widthPercent = toInt(this.layout___pr.width.left(this.layout___pr.width.len()-1))/100
        else
            this.layout___pr.width = toInt(this.layout___pr.width)
        end if
    end if
    
    if type(this.layout___pr.height) = "roString"
        if this.layout___pr.height.right(1) = "%"
           this.layout___pr.heightPercent = toInt(this.layout___pr.height.left(this.layout___pr.height.len()-1))/100
        else
            this.layout___pr.height = toInt(this.layout___pr.height)
        end if
    end if
    
    this.movedToParent = function(parent)
        if m.layout___pr.widthPercent > -1
            m.setWidth(Fix(m.layout___pr.widthPercent * parent.width()))
        end if
        if m.layout___pr.heightPercent > -1
            m.setHeight(Fix(m.layout___pr.heightPercent * parent.height()))
        end if
        
        m.init()
    end function
    
    this.constraints = CreateConstraintsContainerFor(this, options.constraints)
    
    'Center point of layout
    this.center = function()
        'TODO Calculate the center
        return {
            x : 0
            y : 0
        }
    end function
    
    ' Container
    AddChildrenContainerTo(this)
    
    this.z = function()
        return m.layout___pr.z
    end function
    
    this.x = function()
        return m.layout___pr.x
    end function
    
    this.y = function()
        return m.layout___pr.y
    end function
    
    this.width = function()
        return m.layout___pr.width
    end function
    
    this.height = function()
        return m.layout___pr.height
    end function
    
    'This is to bound within layout
    this.setMaxWidth = function(maxWidth)
        m.layout___pr.maxWidth = maxWidth
    end function
    
    'This is to bound within layout
    this.setMaxHeight = function(maxHeight)
        m.layout___pr.maxHeight = maxHeight
    end function
    
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
                print "UILAYOUT LAYOUT_STATE("+state+")"
                if state = "willstart"
                    '
                else if state = "cancelled"
                    '
                else if state = "done"
                    m.setOpaque(true) 'End Layout
                    if m.onComplete <> invalid
                        m.onComplete(m.onCompleteContext)
                    end if
            
                    RefreshScreen()
                end if
            end function
        })
    end function
    
    this.prepareForLayout = function()
        
    end function
    
    this.didLayout = function()
        
    end function
    
    return this
end function