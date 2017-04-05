#Persistent 
#Include WatchDirectory.ahk

;SplashImage, C:\Users\William\AppData\Roaming\iSpy\WebServerRoot\Media\Video\EGGWG\thumbs\1_2016-03-22_17-56-17_large.jpg, B X640 Y360
;Sleep 5000
;SplashImage, off


WatchDirectory("C:\Users\William\AppData*","Report")  
Report(from, to)
{ 
msgbox % to  
}
