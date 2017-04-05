^!v:: 
	v := ComObjCreate("SAPI.SpVoice")
	v.Voice := v.GetVoices().Item(0)
	SplashTextOn,,, Voice On
	v.Speak("Voice on") 
	SplashTextOff
return

^!u::
	v := ComObjCreate("SAPI.SpVoice")
	v.Voice := v.GetVoices().Item(1)
	SplashTextOn,,, Voice On
	v.Speak("Voice on") 
	SplashTextOff
return

^!o:: 
	SplashTextOn,,, Voice Off
	v.Speak("Voice off") 
	SplashTextOff
	v := []
	v.Voice := []
return

^!1::
	SplashTextOn,,, Mouse Mode
	v.Speak("mouse mode") 
	SplashTextOff
Return

^!8::
	SplashTextOn,,, Select Mode
	v.Speak("select mode") 
	SplashTextOff
Return

^!2::
	SplashTextOn,,, VLC Mode
	v.Speak("v l c mode") 
	SplashTextOff
Return

^!3::
	SplashTextOn,,, Media Mode
	v.Speak("media mode") 
	SplashTextOff
Return

^!4::
	SplashTextOn,,, T9 Mode
	v.Speak("T 9 mode") 
	SplashTextOff
Return

^!5::
	SplashTextOn,,, Keyboard Mode
	v.Speak("keyboard mode") 
	SplashTextOff
Return

^!9::
	SplashTextOn,,, Scroll Mode
	v.Speak("scroll mode") 
	SplashTextOff
Return

^!6::
	SplashTextOn,,, Window Mode
	v.Speak("window mode") 
	SplashTextOff
Return

^!7::
	SplashTextOn,,, Blank Mode
	v.Speak("Blank mode") 
	SplashTextOff
Return


