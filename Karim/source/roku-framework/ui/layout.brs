function layout(opts)
    this = {
        id : not_invalid(opts.id, "random-id")
        x : not_invalid(opts.x, 0)
        y : not_invalid(opts.y, 0)
        width : not_invalid(opts.width, 0)
        height : not_invalid(opts.height, 0)
    }
    
    return this
end function