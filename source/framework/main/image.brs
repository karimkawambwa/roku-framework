
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

' This will load up all the image paths in the image folder pkg://locale/images
' It will perform a recursive loading of images in that folder
' You will be able to load images with name using the function :
' 
' 		ImageWithName(name, options)
'
' Localization will be respected if specific
' HD, SD and Wide Screens assets will be respected if specific
function initImages(app)
    app.imagePaths = {}
    
    getImagesInPath = function(path, app, getImagesInPath)
        images = app.fileSystem.Find(path, "(.jpg|.png)")
        images.ResetIndex()
        image = images.GetIndex()
        while image <> invalid
            app.imagePaths[image.tokenize(".")[0]] = path+"/"+image
            image = images.GetIndex()
        end while
        
        paths = app.fileSystem.GetDirectoryListing(path)
        paths.ResetIndex()
        subpath = paths.GetIndex()
        while subpath <> invalid
            getImagesInPath(path+"/"+subpath, app, getImagesInPath)
            subpath = paths.GetIndex()
        end while
    end function
    
    getImagesInPath("pkg://locale/images", app, getImagesInPath)
end function