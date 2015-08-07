function IncludeAnimateTo(this)
    ' @param options : opacity, width, height, x, y
    this.animate = function(options as Object, easing as Function, duration as Integer, delay = 0 as Integer, complete = invalid as Function) as Object
        if options = invalid then
            if complete <> invalid then complete(false)
            return invalid
        end if
        
        x = options.x
        y = options.y
        w = options.w ' width
        h = options.h ' height
        o = options.o ' opacity
        
        if x = invalid and y = invalid and w = invalid and h = invalid and 0 = invalid then
            if complete <> invalid then complete(false)
            return invalid
        end if
        
        'Temporarily variable during animation
        m.onAnimationComplete = complete
        
        change = {}
        begin = {}
        
        if x <> invalid then
            change.x = x - m.x()
            begin.x = m.x()
        end if
        if y <> invalid then
            change.y = y - m.y()
            begin.y = m.y()
        end if
        if w <> invalid then
            change.w = w - m.width()
            begin.w = m.width()
        end if
        if h <> invalid then
            change.h = h - m.height()
            begin.h = m.height()
        end if
        
        animationTimer = CreateObject("roTimespan")
        
        'Perform animation asyncronously
        return ScheduleTask({
            delay : delay
            arg : [
                m
                animationTimer
                easing
                change
                begin
                duration
            ]
            callback : function(arg)
                m = arg[0]
                timer = arg[1]
                easing = arg[2]
                change = arg[3]
                begin = arg[4]
                duration = arg[5]*1000
                
                now = timer.TotalMilliSeconds()
                
                if change.x <> invalid then m.setX(easing(now,begin.x,change.x,duration))
                if change.y <> invalid then m.setY(easing(now,begin.y,change.y,duration))
                if change.w <> invalid then m.setWidth(easing(now,begin.w,change.w,duration))
                if change.h <> invalid then m.setHeight(easing(now,begin.h,change.h,duration))
                'if options.o <> invalid then m.setOpacity()
                
                m.updateConstraints()
                
                ' Layout the Views
                Layout(m)
                ' RefreshScreen
                RefreshScreen()
                
                return now >= duration
            end function
            onStateChangeArg : [ 
                m, 
                animationTimer
            ]
            onStateChange : function(state, onStateChangeArg)
                m = onStateChangeArg[0]
                timer = onStateChangeArg[1]
                
                print "Animation State : "+state

                if state = "willstart"
                    m.animating = true
                    timer.Mark()
                else if state = "cancelled"
                    m.animating = false
                    if m.onAnimationComplete <> invalid
                        m.onAnimationComplete(false)
                        m.onAnimationComplete = invalid
                    end if
                else if state = "done"
                    m.animating = false
                    if m.onAnimationComplete <> invalid
                        m.onAnimationComplete(true)
                        m.onAnimationComplete = invalid
                    end if
                end if
            end function
        })
        
    end function
end function
