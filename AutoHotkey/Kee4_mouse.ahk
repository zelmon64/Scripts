; Kee4 modeled input with a mouse
;	v1.3
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;Menu, tray, Icon, %A_ScriptDir%\Kee4_2.ico, ,1

{ ; Variables
	modeDEFAULT := 1
	mode := modeDEFAULT
	ch_mode := modeDEFAULT
	modePRE := modeDEFAULT
	lastKeyRepeat := 1 ; 0 ;
	UsePresage := 0 ; 1 ;
}

IconOn := A_ScriptDir . "\Kee4_2b.ico"
IconOff := A_ScriptDir . "\Kee4_2y.ico"
#Include %A_ScriptDir%\Kee4.ahk

*LButton::
*RButton::
*MButton::
*XButton1::
*Escape::
	if (!InStr("MLC", lastSent) && lastKeyRepeat && keysAreActive = 0 && InStr(A_PriorHotkey, A_ThisHotkey) && A_TimeSincePriorHotkey > 0 && (A_TimeSincePriorHotkey < 130 || keysWereActive = -1) && keysWereActive <> -2) {
		REPEATKEY(lastSent)
	} else if (keysWereActive >= 0) {
		B_ThisHotkey := REBINDKEY(A_ThisHotkey)
		if B_ThisHotkey <>
			KEYDOWN(B_ThisHotkey, isLeftHand)
	}
Return

*XButton2::
	Gosub, Fre
Return

*LButton Up::
*RButton Up::
*MButton Up::
*XButton1 Up::
*Escape Up::
	B_ThisHotkey := REBINDKEY(A_ThisHotkey)
	if B_ThisHotkey <>
		KEYUP(B_ThisHotkey)
Return