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
	daynight := 1 ; 0 ;
	CableUp := 0 ; 1 ;
	UseGamepad := 0 ; 1 ;
	UsePresage := 0 ; 1 ;
	MouseMoveControl := 0 ; 1 ;
}

IconOn := A_ScriptDir . "\Kee4_2g.ico"
IconOff := A_ScriptDir . "\Kee4_2p.ico"
#Include %A_ScriptDir%\Kee4.ahk

*Numpad0::
*Numpad1::
*Numpad4::
*Numpad7::
*NumpadDot::
*NumpadIns::
*NumpadEnd::
*NumpadLeft::
*NumpadHome::
*NumpadDel::
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

*NumpadSub::
	Gosub, Fre
Return

*Numpad0 Up::
*Numpad1 Up::
*Numpad4 Up::
*Numpad7 Up::
*NumpadDot Up::
*NumpadIns Up::
*NumpadEnd Up::
*NumpadLeft Up::
*NumpadHome Up::
*NumpadDel Up::
	B_ThisHotkey := REBINDKEY(A_ThisHotkey)
	if B_ThisHotkey <>
		KEYUP(B_ThisHotkey)
Return