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
	MouseMoveControl := 0 ; 1 ;
	Repeating := Object()
}

IconOn := A_ScriptDir . "\Kee4_2pi.ico"
IconOff := A_ScriptDir . "\Kee4_2o.ico"
#Include %A_ScriptDir%\Kee4.ahk

*U::
*D::
*L::
*R::
if firstKeyDown =
{
		Key := SubStr(A_ThisHotkey, 2)
		;ToolTip, % "MP" Key
		Repeating[Key] := 1
		{
			if (InStr(A_PriorHotkey, A_ThisHotkey) && keysAreActive = 0 && A_TimeSincePriorHotkey > 0 && (A_TimeSincePriorHotkey < 130)) {
				REPEATKEY("MP" . Key)
			} else if (keysWereActive >= 0) {
				SENDCOMMAND("MP" . Key)
			}
		}
		while Repeating[Key]
		{
			if (A_TimeSinceThisHotkey > 200) {
				{
					keysWereActive := -1
					SENDCOMMAND("MP" . Key)
				}
			}
			Sleep, 36
		}
		;ToolTip
	Return
}
*a::
*b::
*h::
*g::
	Key := SubStr(A_ThisHotkey, 2)
	Repeating[Key] := 1
	{
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
	}
	while Repeating[Key]
	{
		if (Repeating[Key] && A_TimeSinceThisHotkey > 200) {
			{
				if (lastKeyRepeat && keysAreActive = 0 && A_TimeSincePriorHotkey > 0 && (A_TimeSincePriorHotkey < 130 || keysWereActive = -1) && keysWereActive <> -2 && lastSent) {
					if InStr(B_PriorHotkey, B_ThisHotkey)
						REPEATKEY(lastSent, B_ThisHotkey)
				} else if (keysWereActive >= 0) {
					if B_ThisHotkey <>
						KEYDOWN(B_ThisHotkey, isLeftHand)
				}
			}
		}
		Sleep, 36
	}
Return

*NumpadSub::
	Gosub, Fre
Return

*U Up::
*D Up::
*L Up::
*R Up::
if firstKeyDown =
{
		Key := SubStr(A_ThisHotkey, 2, -3)
		Repeating[Key] := 0
		keysAreActive := 0
		keysWereActive := 0
		mode := 7
		ch_mode := mode
		modePRE := mode
	Return
}
*a Up::
*b Up::
*h Up::
*g Up::
	Key := SubStr(A_ThisHotkey, 2, -3)
	Repeating[Key] := 0
	B_ThisHotkey := REBINDKEY(A_ThisHotkey)
	if B_ThisHotkey <>
		KEYUP(B_ThisHotkey)
	;MouseMoveControl := 0 ; 1 ;
	;MouseAutoDetect := 0 ; 1 ;
Return
/*
*U::
*D::
*L::
*R::
	Key := SubStr(A_ThisHotkey, 2)
	;ToolTip, % "MP" Key
	Repeating[Key] := 1
	{
		if (InStr(A_PriorHotkey, A_ThisHotkey) && keysAreActive = 0 && A_TimeSincePriorHotkey > 0 && (A_TimeSincePriorHotkey < 130)) {
			REPEATKEY("MP" . Key)
		} else if (keysWereActive >= 0) {
			SENDCOMMAND("MP" . Key)
			keysAreActive := 0
		}
	}
	while Repeating[Key]
	{
		if (A_TimeSinceThisHotkey > 200) {
			{
				keysWereActive := -1
				SENDCOMMAND("MP" . Key)
			}
		}
		Sleep, 36
	}
	ToolTip
Return

*U Up::
*D Up::
*L Up::
*R Up::
	Key := SubStr(A_ThisHotkey, 2, -3)
	Repeating[Key] := 0
	keysAreActive := 0
	keysWereActive := 0
Return
*/