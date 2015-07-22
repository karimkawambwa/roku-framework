function SetupFocusControl(view)
    this = {
        focusableViewCount : 0
        focused : invalid
        view : view
        map : {}
    }
    
    this.init = function()
        m.createFocusMap()
        if m.focusableViewCount > 0 then 
            m.view.focusControl = m
        end if
    end function
    
    this.focusOn = function(viewId) as Boolean
        if viewId = invalid or m.map[viewId] = invalid then return false
        
        curr = invalid
        if m.focused <> invalid then
            curr = m.map[m.focused].view
        end if
        
        nxt = m.map[viewId].view
        nxt.focus(curr = invalid)
        m.focused = nxt.id
        
        if curr <> invalid then curr.blur()
        
        return true
    end function
    
    this.createFocusMap = function()
        m.view.children["each"](m, function(index, currView, m) as Boolean
            
            if not currView.isFocusable() then return true 'continue
            
            map = { T: invalid, B : invalid, L: invalid, R: invalid, tPos: invalid, bPos: invalid, lPos: invalid, rPos: invalid, view : currView }
            
            currView.parent.children["each"]([m, currView, map], function(index, nextView, args) as Boolean
                m = args[0]
                currView = args[1]
                map = args[2]
                
                if currView.id = nextView.id then return true 'continue
                
                if not nextView.isFocusable() then return true 'continue
               
                if nextView.isOpaque()
                    ' bottom selection
                    score = m.calculateScore(currView, nextView, "bottom")
                    if score <> invalid and (map.bPos = invalid or map.bPos > score)
                        map.bPos = score
                        map.B = nextView.id
                    end if 
                    
                    ' top selection
                    if score = invalid then
                        score = m.calculateScore(currView, nextView, "top")
                        if score <> invalid and (map.tPos = invalid or map.tPos > score)
                            map.tPos = score
                            map.T = nextView.id
                        end if
                    end if
                                            
                    ' right selection
                    score = m.calculateScore(currView, nextView, "right")
                    if score <> invalid and (map.rPos = invalid or map.rPos > score)
                        map.rPos = score
                        map.R = nextView.id
                    end if
                    
                    ' Left selection
                    if score = invalid then
                        score = m.calculateScore(currView, nextView, "left")
                        if score <> invalid and (map.lPos = invalid or map.lPos > score)
                            map.lPos = score
                            map.L = nextView.id
                        end if
                    end if
                end if
                
                return true
            end function)
            
            m.focusableViewCount = m.focusableViewCount+ 1
            
            m.map[currView.id] = map
            
            if currView.type = "UIView" and currView.children.Count() > 0 then SetupFocusControl(currView)
            
            return true
        end function)
    end function

    this.calculateScore = function(curr, nxt, side)
    
        score = invalid
        if side = "left" then
            compX1 = curr.x()
            compY1 = curr.center().y
            compX2 = nxt.x() + nxt.width()
            compY2 = nxt.center().y
            if compX2 <= compX1 then
                if curr.center().y >= nxt.y() and curr.center().y <= nxt.y() + nxt.height() then
                    score = compX1 - compX2
                else
                    score = compX1 - compX2 + 1280 * abs(compY1-compY2)
                end if
            end if
        else if side = "right" then
            compX1 = curr.x() + curr.width()
            compY1 = curr.center().y
            compX2 = nxt.x()
            compY2 = nxt.center().y
            if compX2 >= compX1 then
                if curr.center().y >= nxt.y() and curr.center().y <= nxt.y() + nxt.height() then
                    score = compX2 - compX1
                else
                    score = compX2 - compX1 + 1280 * abs(compY1-compY2)
                end if
            end if
        else if side = "top" then
            compX1 = curr.center().y
            compY1 = curr.y()
            compX2 = nxt.center().x
            compY2 = nxt.y() + nxt.height()
            if compY2 <= compY1 then
                if curr.center().y >= nxt.x() and curr.center().y <= nxt.x() + nxt.width() then
                    score = compY1 - compY2
                else
                    score = compY1 - compY2 + 720 * abs(compX1-compX2)
                end if
            end if
        else if side = "bottom" then
            compX1 = curr.center().y
            compY1 = curr.y() + curr.height()
            compX2 = nxt.center().x
            compY2 = nxt.y()
            if compY2 >= compY1 then
                if curr.center().y >= nxt.x() and curr.center().y <= nxt.x() + nxt.width() then
                    score = compY2 - compY1
                else
                    score = compY2 - compY1 + 720 * abs(compX1-compX2)
                end if
            end if
        end if
    
        return score                
    end function

    this.handleUserInput = function(msg) as Boolean
        print "handleUserInput : ", msg
        if msg = 2
            return m.buttonUp()
        else if msg = 3
            return m.buttonDown()
        else if msg = 4
            return m.buttonLeft()
        else if msg = 5
            return m.buttonRight()
        end if
        return false
    end function
    
    this.buttonUp = function() as Boolean
        map = m.map[m.focused]
        m.focusOn(map.U)
        return true
    end function
    
    this.buttonDown = function() as Boolean
        map = m.map[m.focused]
        m.focusOn(map.D)
        return true
    end function
    
    this.buttonLeft = function() as Boolean
        map = m.map[m.focused]
        m.focusOn(map.L)
        return true
    end function
    
    this.buttonRight = function() as Boolean
        map = m.map[m.focused]
        m.focusOn(map.R)
        return true
    end function
    
    this.init()
end function