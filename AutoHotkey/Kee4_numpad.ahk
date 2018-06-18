; Kee4 modeled input with a numpad
;	v1.3
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;Menu, tray, Icon, %A_ScriptDir%\Kee4_2.ico, ,1

{ ; Variables
	modeDEFAULT := 1
	mode := modeDEFAULT
	ch_mode := mode
	modePRE := mode
	lastKeyRepeat := 1
	MouseAutoDetect := 1 ; 0 ;
	MouseMoveControl := !MouseAutoDetect ; 1 ; 0 ;
	daynight := 1 ; 0 ;
	CableUp := 0 ; 1 ;
	UseGamepad := 0 ; 1 ;
	UsePresage := 0 ; 1 ;
	LeftOnly := 1 ; 0 ;
}

IconOn := A_ScriptDir . "\Kee4_2.ico"
IconOff := A_ScriptDir . "\Kee4_2r.ico"
#Include %A_ScriptDir%\Kee4.ahk

#If LeftOnly
*Numpad1::
*Numpad4::
*Numpad7::
*NumpadEnd::
*NumpadLeft::
*NumpadHome::
#If
*Numpad2::
*Numpad5::
*Numpad8::
*NumpadDiv::
*Numpad3::
*Numpad6::
*Numpad9::
*NumpadMult::
*NumpadDown::
*NumpadPgDn::
*NumpadClear::
*NumpadRight::
*NumpadUp::
*NumpadPgUp::
	if (lastKeyRepeat && keysAreActive = 0 && A_TimeSincePriorHotkey > 0 && (A_TimeSincePriorHotkey < 130 || keysWereActive = -1) && keysWereActive <> -2 && lastSent) {
		B_PriorHotkey := REBINDKEY(A_PriorHotkey)
		B_ThisHotkey := REBINDKEY(A_ThisHotkey)
		if InStr(B_PriorHotkey, B_ThisHotkey)
			REPEATKEY(lastSent, B_ThisHotkey)
	} else if (keysWereActive >= 0) {
		B_ThisHotkey := REBINDKEY(A_ThisHotkey)
		if B_ThisHotkey <>
			KEYDOWN(B_ThisHotkey, isLeftHand)
	}
Return

#If !LeftOnly
*NumpadAdd::
	Gosub, Fre
Return

#If LeftOnly
*Numpad1 Up::
*Numpad4 Up::
*Numpad7 Up::
*NumpadEnd Up::
*NumpadLeft Up::
*NumpadHome Up::
#If
*Numpad2 Up::
*Numpad3 Up::
*Numpad5 Up::
*Numpad6 Up::
*Numpad8 Up::
*Numpad9 Up::
*NumpadMult Up::
*NumpadDiv Up::
*NumpadDown Up::
*NumpadPgDn Up::
*NumpadClear Up::
*NumpadRight Up::
*NumpadUp Up::
*NumpadPgUp Up::
	B_ThisHotkey := REBINDKEY(A_ThisHotkey)
	if B_ThisHotkey <>
		KEYUP(B_ThisHotkey)
Return
