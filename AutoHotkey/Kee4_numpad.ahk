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
	MouseAutoDetect := 0 ; 1 ;
	daynight := 1 ; 0 ;
	CableUp := 0 ; 1 ;
	UseGamepad := 0 ; 1 ;
	UsePresage := 0 ; 1 ;
}

IconOn := A_ScriptDir . "\Kee4_2.ico"
IconOff := A_ScriptDir . "\Kee4_2r.ico"
#Include %A_ScriptDir%\Kee4.ahk

*Numpad2::
*Numpad5::
*Numpad8::
*NumpadDiv::
*Numpad3::
*Numpad6::
*Numpad9::
*NumpadMult::
*Numpad0::
*Numpad1::
*Numpad4::
*Numpad7::
*NumpadDot::
	if (lastKeyRepeat && keysAreActive = 0 && InStr(A_PriorHotkey, A_ThisHotkey) <> 0 && A_TimeSincePriorHotkey > 0 && (A_TimeSincePriorHotkey < 130 || keysWereActive = -1) && keysWereActive <> -2) {
		REPEATKEY(lastSent)
	} else if (keysWereActive >= 0) {
		B_ThisHotkey := REBINDKEY(A_ThisHotkey)
		if B_ThisHotkey <>
			KEYDOWN(B_ThisHotkey, isLeftHand)
	}
Return

*NumpadAdd::
	Gosub, Fre
Return

*Numpad2 Up::
*Numpad3 Up::
*Numpad5 Up::
*Numpad6 Up::
*Numpad8 Up::
*Numpad9 Up::
*NumpadMult Up::
*NumpadDiv Up::
*Numpad0 Up::
*Numpad1 Up::
*Numpad4 Up::
*Numpad7 Up::
*NumpadDot Up::
	B_ThisHotkey := REBINDKEY(A_ThisHotkey)
	if B_ThisHotkey <>
		KEYUP(B_ThisHotkey)
Return