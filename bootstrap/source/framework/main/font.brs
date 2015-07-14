function initFont(app)
    app.fontRegistry = CreateObject("roFontRegistry")
    fonts = app.fileSystem.GetDirectoryListing("pkg://fonts/")
    fonts.ResetIndex()
    font = fonts.GetIndex()
    while font <> invalid
        family = app.fileSystem.Find("pkg://fonts/"+font, "(.ttf|.otf)")
        family.ResetIndex()
        fam = family.GetIndex()
        while fam <> invalid
            registered = app.fontRegistry.Register("pkg://fonts/"+font+"/"+fam)
            if not registered then print "Font Register [FAILED] : "+ font + " path [ pkg://fonts/"+font+"/"+fam+" ]"
            fam = family.GetIndex()
        end while
        font = fonts.GetIndex()
    end while
end function