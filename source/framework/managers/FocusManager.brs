function SetupFocusControl(view)
    this = {
        focusableViewCount : 0
        focused : invalid
        view : view
        map : {}
    }
    
    this.init = function()
        m.createFocusMap()
        if m.focusableViewCount > 0 then view.focusControl = m
    end function
    
    this.createFocusMap = function()
        m.view.children["each"](m, function(index, currView, m) as Void
            
            if not currView.isFocusable() then return
            
            map = { T: invalid, B : invalid, L: invalid, R: invalid, tPos: invalid, bPos: invalid, lPos: invalid, rPos: invalid }
            
            currView.parent.children["each"]([m, currView, map], function(index, nextView, args) as Void
                m = args[0]
                currView = args[1]
                map = args[2]
                
                if currView.id = nextView.id then return
                
                if not nextView.isFocusable() then return
               
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
            end function)
            
            m.focusableViewCount = m.focusableViewCount+ 1
            
            m.map[currView.id] = map
            
            if currView.children.Count() > 0 then SetupFocusControl(currView)
            
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
            compX2 = nextCenterX
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
            compY1 = curr.y() + curCtrl.height
            compX2 = nextCenterX
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

    this.userInput = function(msg, codes)
        if msg = 2
            m.buttonUp()
        else if msg = 3
            m.buttonDown()
        else if msg = 4
            m.buttonLeft()
        else if msg = 5
            m.buttonRight()
        end if
    end function
    
    this.buttonUp = function()
        
    end function
    
    this.buttonDown = function()
        
    end function
    
    this.buttonLeft = function()
        
    end function
    
    this.buttonRight = function()
        
    end function
    
    this.init()
end function