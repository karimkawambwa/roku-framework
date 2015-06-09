function ViewManager()
    this = {
        view_folder : "pkg:/source/views/"
    }
    
    this.loadViewNamed = function(name)
        viewXML = ParseXML(ReadAsciiFile(m.view_folder+name+".xml"))
        view = invalid
        return view
    end function
    
    return this
end function