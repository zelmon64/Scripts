#Persistent 
#Include WatchDirectory.ahk

;SplashImage, C:\Users\William\AppData\Roaming\iSpy\WebServerRoot\Media\Video\EGGWG\thumbs\1_2016-03-22_17-56-17_large.jpg, B X640 Y360
;Sleep 5000
;SplashImage, off


;WatchDirectory("C:\Users\William\AppData\Roaming\iSpy\WebServerRoot\Media\Video\EGGWG\thumbs*","Report")  
Report(from, to)
{ 
msgbox % to
}

WatchDirectory("C:\Users\William\AppData\Roaming\iSpy\WebServerRoot\Media\Video\EGGWG\thumbs*|*large.jpg\","ReportImage",0x10)  
ReportImage(from, to)
{ 
	static last
	If (last=from to)
		Return

	SplashImage, % to, B X640 Y360
	Sleep 2000
	SplashImage, off

	last:=from to
}
