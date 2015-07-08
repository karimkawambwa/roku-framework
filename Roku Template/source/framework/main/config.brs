function Config(app)
    app.viewFolder = { 
        SD          : "pkg://source/views/SD/"
        HD          : "pkg://source/views/HD/"
        WideScreen  : "pkg://source/views/HD/"
        Default     : "pkg://source/views/"
    }
    
    app.imageFolder = {
        en_GB       : "pkg://locale/en_GB/images/"
        de_DE       : "pkg://locale/de_DE/images/"
        en_US       : "pkg://locale/en_US/images/"
        es_ES       : "pkg://locale/es_ES/images/"
        fr_CA       : "pkg://locale/fr_CA/images/"
        Default     : "pkg://locale/default/images/"
    }
end function