; Kee4 functions
;	v1.3
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
#SingleInstance, force
;disable hotkeys until setup is complete
Suspend, On
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;Menu, tray, Icon, %A_ScriptDir%\Kee4_2.ico, ,1
StringCaseSense, On
;#InstallMouseHook
;KeyHistory
DllCall("AllocConsole")
FileAppend Presage next word prediction and word completion..., CONOUT$
Sleep 500
WinHide % "ahk_id " DllCall("GetConsoleWindow", "ptr")
;shell := ComObjCreate("WScript.Shell")
;cmdStr := "cmd.exe /c presagePredict.py"
;exec := ComObjCreate("WScript.Shell").Exec("cmd.exe /c presage_python_demo.py")
;strStdOut := exec.StdOut.ReadAll()WinHide % "ahk_id " DllCall("GetConsoleWindow", "ptr")

{ ; Variables
	firstKeyDown :=
	secondKeyDown :=
	thirdKeyDown :=
	fourthKeyDown :=
	opositeKeyDown :=
	firstKeyUp :=
	secondKeyUp :=
	thirdKeyUp :=
	fourthKeyUp :=
	opositeKeyUp :=
	lastSent :=
	SentensBuffer :=
	WordBuffer :=
	ShiftDown :=
	ControlDown :=
	AltDown :=
	WinDown :=
	MouseMDown :=
	MouseGetPos, MouseLastPosX, MouseLastPosY
	keysAreActive := 0
	keysWereActive := 0
	HIDmode := 0
	HIDopacity := 0
	if MouseMoveMin =
		MouseMoveMin := 5 ; 1 ;
	if MouseMoveX =
		MouseMoveX := 2 ; 1 ;
	if MouseMoveY =
		MouseMoveY := 2 ; 1 ;
	if MouseWheelX =
		MouseWheelX := 1
	if MouseWheelY =
		MouseWheelY := 1
	if MouseAutoDetect =
		MouseAutoDetect := 1 ; 0 ;
	if lastKeyRepeat =
		lastKeyRepeat := 0 ; 1
	if daynight =
		daynight := 1 ; 0 ;
	if CableUp =
		CableUp := 0 ; 1 ;
	if UseGamepad =
		UseGamepad := 0 ; 1 ;
	if UsePresage =
		UsePresage := 0 ; 1 ;
	if modeDEFAULT =
		modeDEFAULT := 1
	mode := modeDEFAULT
	ch_mode := modeDEFAULT
	modePRE := modeDEFAULT
}

{ ; Kee4 definitions
	all_characters := Object()
	all_characters_long := Object()
	ArrayIndex := 1
	character_mode_lists = Lowercase,Capitals,Numbers,Mode Select,Navigation,Functions,Mouse
	StringSplit, character_mode_list, character_mode_lists, `,

	{ ; abc
		mode_characters =  %A_Space%,,,,,,,,,
		mode_characters =  %mode_characters%Spc,Spc, l , i , w ,   ,Spc, n , p , j ,
		mode_characters =  %mode_characters% a , o , a , h , c ,   , m , a , f , g ,
		mode_characters =  %mode_characters% e , y , t , e , v ,   , r , s , e , x ,
		mode_characters =  %mode_characters%Mod, u , d , q ,Mod,   , b , k , z ,Mod,
		StringSplit, all_characters%ArrayIndex%, mode_characters, `,
	}
	{ ; ABC
		mode_characters =   %A_Space%,,,,,,,,,
		mode_characters =  %mode_characters%Spc,Spc, L , I , W ,   ,Spc, N , P , J ,
		mode_characters =  %mode_characters% A , O , A , H , C ,   , M , A , F , G ,
		mode_characters =  %mode_characters% E , Y , T , E , V ,   , R , S , E , X ,
		mode_characters =  %mode_characters%Mod, U , D , Q ,Mod,   , B , K , Z ,Mod,
		ArrayIndex++
		StringSplit, all_characters%ArrayIndex%, mode_characters, `,
	}
	{ ; Numbers
		mode_characters =   %A_Space%,,,,,,,,,
		mode_characters =  %mode_characters%Spc,Spc, 1 , 3 , 9 ,   ,Spc, * , \ , - ,
		mode_characters =  %mode_characters% = , 2 , = , 5 , 7 ,   , + , = , `` , & ,
		mode_characters =  %mode_characters% @ , 4 , 6 , @ , ^ ,   , / , ~ , @ , # ,
		mode_characters =  %mode_characters%Mod, 0 , 8 , _ ,Mod,   , `% , | , $ ,Mod,
		ArrayIndex++
		StringSplit, all_characters%ArrayIndex%, mode_characters, `,
	}
	{ ; Symbols / Mode Select
		mode_characters =   %A_Space%,,,,,,,,,
		mode_characters =  %mode_characters%Cap,Cap, . ,SHF,scl,   ,Cap,cma,CTR,ALT,
		mode_characters =  %mode_characters%Num,Ent,Num,Del, [ ,   ,Tab,Num,ReD, < ,
		mode_characters =  %mode_characters%Fnc, ! ,BkS,Fnc, ( ,   , : ,UnD,Fnc, { ,
		mode_characters =  %mode_characters%Nav, ' , ] , ) ,Nav,   , " , > , } ,Nav,
		ArrayIndex++
		StringSplit, all_characters%ArrayIndex%, mode_characters, `,
		all_characters%ArrayIndex%17 := " , "
		all_characters%ArrayIndex%14 := " `; "
		if (MouseMoveControl) {
			all_characters%ArrayIndex%40 := "Mou"
			all_characters%ArrayIndex%44 := "Mou"
			all_characters%ArrayIndex%49 := "Mou"
		}
	}
	{ ; Navigation
		mode_characters =  %A_Space%,,,,,,,,,
		mode_characters =  %mode_characters% Up, Up,Mod,SHF,End,   , Up,PRE,CTR,ALT,
		mode_characters =  %mode_characters%Lft,Ent,Lft,Del,Cpy,   ,Tab,Lft,ClT,Pst,
		mode_characters =  %mode_characters%Rit, F5,BkS,Rit,SAl,   , F6,ClW,Rit,WIN,
		mode_characters =  %mode_characters%Dwn,Hom,MOU,Ins,Dwn,   ,   ,   ,ScL,Dwn,
		ArrayIndex++
		StringSplit, all_characters%ArrayIndex%, mode_characters, `,
	}
	{ ; Functions
		mode_characters =  %A_Space%,,,,,,,,,
		mode_characters =  %mode_characters%Pau,Pau,Nxt,Fnd,Mnu,   ,Pau,Esc,Rpl,Sav,
		mode_characters =  %mode_characters%VUp,Prv,VUp,ScS,Hga,   , F2,VUp,ClW,Kka,
		mode_characters =  %mode_characters%VDn, F3,ARe,VDn,TAS,   ,F11,TUD,VDn,TAC,
		mode_characters =  %mode_characters%Mod,PrS,Jap,TAP,Mod,   ,ALT,SHF,CTR,Mod,
		ArrayIndex++
		StringSplit, all_characters%ArrayIndex%, mode_characters, `,
	}
	{ ; Mouse
		mode_characters =  %A_Space%,,,,,,,,,
		mode_characters =  %mode_characters%MLC,MLC,MLD,MX1,End,   ,MLC,MLU,MX2,PRE,
		mode_characters =  %mode_characters%MMC,MMD,MMC,WDn,Cpy,   ,MMU,MMC,PDn,Pst,
		mode_characters =  %mode_characters%MRC,MRD,WUp,MRC,WRi,   ,MRU,PUp,MRC,Mg!,
		mode_characters =  %mode_characters%Mod,Hom,NAV,WLf,Mod,   ,ALT,SHF,CTR,Mod,
		ArrayIndex++
		StringSplit, all_characters%ArrayIndex%, mode_characters, `,
		if (MouseMoveControl) {
			all_characters%ArrayIndex%10 := "MPU"
			all_characters%ArrayIndex%11 := "MPU"
			all_characters%ArrayIndex%16 := "MPU"
			all_characters%ArrayIndex%20 := "MPL"
			all_characters%ArrayIndex%22 := "MPL"
			all_characters%ArrayIndex%27 := "MPL"
			all_characters%ArrayIndex%30 := "MPR"
			all_characters%ArrayIndex%33 := "MPR"
			all_characters%ArrayIndex%38 := "MPR"
			all_characters%ArrayIndex%40 := "MPD"
			all_characters%ArrayIndex%44 := "MPD"
			all_characters%ArrayIndex%49 := "MPD"
		}
	}
}

{ ; Menu
	Menu, Tray, NoStandard
	;Menu, Tray, Add , Pause, Pau
	;Menu, Tray, Add , Suspend, Sus
	Menu, Tray, Add , Freeze, Fre
	Menu, Tray, Add ,,
	Menu, Tray, Add , Reload, Rel
	Menu, Tray, Add ,,
	Menu, Tray, Add , Exit, Exi
	Menu, Tray, Default, Freeze
	if IconOn <>
	{
		Menu, Tray, Icon, %IconOn%,, 1
		Menu, Tray, Icon, Reload, %IconOn%,, 0
	} else {
		Menu, Tray, Icon , %A_AhkPath%, 1, 1
	} if IconOff <>
	{
		Menu, Tray, Icon, Freeze, %IconOff%,, 0
	}
}

RELEASEKEYS()
; Register a function to be called on exit:
OnExit("RELEASEKEYS")

;#Include ListBox.ahk
CoordMode, Mouse , Screen
CoordMode, Menu , Screen
CoordMode, Caret , Screen

Menu, Tray, Icon
Suspend, OFF

Return

Sus:
	Menu, Tray, ToggleCheck, Suspend
	RELEASEKEYS()
	Suspend, Toggle
	if (A_IsSuspended) {
		if (A_IsPaused) {
			if IconOff <>
			{
				Menu, Tray, Icon, %IconOff%,, 1
			} else {
				Menu, Tray, Icon , %A_AhkPath%, 5, 1
			}
		} else {
			Menu, Tray, Icon , %A_AhkPath%, 3, 1
		}
	} else {
		if (A_IsPaused) {
			Menu, Tray, Icon , %A_AhkPath%, 4, 1
		} else {
			if IconOn <>
			{
				Menu, Tray, Icon, %IconOn%,, 1
			} else {
				Menu, Tray, Icon , %A_AhkPath%, 1, 1
			}
		}
	}
Return
Pau:
	Menu, Tray, ToggleCheck, Pause
	RELEASEKEYS()
	Pause ,Toggle,1
	if (A_IsPaused) {
		if (A_IsSuspended) {
			if IconOff <>
			{
				Menu, Tray, Icon, %IconOff%,, 1
			} else {
				Menu, Tray, Icon , %A_AhkPath%, 5, 1
			}
		} else {
			Menu, Tray, Icon , %A_AhkPath%, 4, 1
		}
	} else {
		if (A_IsSuspended) {
			Menu, Tray, Icon , %A_AhkPath%, 3, 1
		} else {
			if IconOn <>
			{
				Menu, Tray, Icon, %IconOn%,, 1
			} else {
				Menu, Tray, Icon , %A_AhkPath%, 1, 1
			}
		}
	}
Return
Fre:
	Menu, Tray, ToggleCheck, Freeze
	RELEASEKEYS()
	Progress, 1:Off
	if (A_IsPaused || A_IsSuspended) {
		Pause, OFF
		Suspend, OFF
		if IconOn <>
		{
			Menu, Tray, Icon, %IconOn%,, 1
		} else {
			Menu, Tray, Icon , %A_AhkPath%, 1, 1
		}
	} else {
		Suspend, ON
		if IconOff <>
		{
			Menu, Tray, Icon, %IconOff%,, 1
		} else {
			Menu, Tray, Icon , %A_AhkPath%, 5, 1
		}
		Pause, ON
	}
Return
Exi:
	ExitApp
Return
Rel:
	Reload
Return

ExitFunc(ExitReason, ExitCode)
{
    if ExitReason not in Logoff,Shutdown
    {
        MsgBox, 4, , Are you sure you want to exit?
        IfMsgBox, No
            return 1  ; OnExit functions must return non-zero to prevent exit.
    }
    ; Do not call ExitApp -- that would prevent other OnExit functions from being called.
}

SENDCOMMAND(ThisCommand := "", predict := 0)
{
	{ ; Global Variables
		global modeDEFAULT
		global mode
		global ch_mode
		global modePRE
		global LeftHanded
		global CableUp
		global UsePresage
		global WordList
		global WordBuffer
		global lastKeyRepeat
		global MouseMDown
		global ShiftDown
		global ControlDown
		global AltDown
		global WinDown
		global MouseMoveX
		global MouseMoveY
		global MouseMoveMin
		global MouseWheelX
		global MouseWheelY
		global keysWereActive
		global MouseMoveControl
	}
	;ToolTip, %ThisCommand%
	if (ThisCommand = "Mod") {
		if (mode = 4) {
			mode := modeDEFAULT
			modePRE := mode
		}
		else if (mode = 44) {
			mode := 4
			modePRE := mode
		}
		else {
			mode := 44
		}
	} else if (ThisCommand = "Cap") {
		if (mode = 2 || modePRE = 2) {
			mode := modeDEFAULT
			modePRE := mode
		}
		else if (mode = 22) {
			mode := 2
			modePRE := mode
		}
		else {
			mode := 22
		}
	} else if (ThisCommand = "Num") {
		if (mode = 3 || modePRE = 3) {
			mode := modeDEFAULT
			modePRE := mode
		}
		else if (mode = 33) {
			mode := 3
			modePRE := mode
		}
		else {
			mode := 33
		}
	} else if InStr(ThisCommand, "Nav", true) {
		if (true) { ;MouseMoveControl
			if (keysWereActive < 0) {
				if (mode = 4) {
					mode := modeDEFAULT
					modePRE := mode
				} else if (mode = 44) {
					mode := 4
					modePRE := mode
				} else if (mode = 7) {
					mode := 44
					modePRE := 5
				} else if (mode = 5) {
					mode := 7
				} else {
					mode := 5
				}
			} else {
				mode := 5
			}
		} else {
			if (mode = 77) {
				mode := modeDEFAULT
				modePRE := mode
			} else if (mode = 5) {
				mode := 7
				modePRE := mode
			} else if (mode = 7) {
				mode := 55
			} else if (mode = 55) {
				mode := 77
			} else {
				mode := 5
			}
		}
	} else if InStr(ThisCommand, "Mou", true) {
		if (true) { ;MouseMoveControl
			if (keysWereActive < 0) {
				if (mode = 4) {
					mode := modeDEFAULT
					modePRE := mode
				} else if (mode = 44) {
					mode := 4
					modePRE := mode
				} else if (mode = 5) {
					mode := 44
					modePRE := 7
				} else if (mode = 7) {
					mode := 5
				} else {
					mode := 7
				}
			} else {
				mode := 7
			}
		} else {
			if (mode = 77) {
				mode := modeDEFAULT
				modePRE := mode
			} else if (mode = 5) {
				mode := 7
				modePRE := mode
			} else if (mode = 7) {
				mode := 55
			} else if (mode = 55) {
				mode := 77
			} else {
				mode := 5
			}
		}
	} else if (InStr(ThisCommand, "NAV", true) || InStr(ThisCommand, "MOU", true)) {
		if (true) { ;MouseMoveControl
			if (keysWereActive < 0) {
				if (mode = 44) {
					mode := 4
					modePRE := mode
				} else if (mode = 7) {
					mode := 44
					modePRE := 5
				} else if (mode = 5) {
					mode := 44
					modePRE := 7
				} else {
					mode := modeDEFAULT
					modePRE := mode
				}
			} else {
				if (mode = 5) {
					mode := 7
				} else {
					mode := 5
				}
			}
		} else {
			if (mode = 77) {
				mode := modeDEFAULT
				modePRE := mode
			} else if (mode = 5) {
				mode := 7
				modePRE := mode
			} else if (mode = 7) {
				mode := 55
			} else if (mode = 55) {
				mode := 77
			} else {
				mode := 5
			}
		}
	} else if (ThisCommand = "Fnc") {
		if (mode = 6 || modePRE = 6) {
			mode := modeDEFAULT
			modePRE := mode
		}
		else if (mode = 66) {
			mode := 6
			modePRE := mode
		}
		else {
			mode := 66
		}
	} else if (ThisCommand = "PRE") {
		if (modePRE = 7) || (modePRE = 5) {
			mode := modeDEFAULT
			modePRE := mode
		} else {
			mode := modePRE
		}
	} else
	{
		ForceNewWord := 1
		if (ThisCommand = "SHa") {
			LeftHanded := !LeftHanded
		} else if (ThisCommand = "TUD") {
			CableUp := !CableUp
		} else if (ThisCommand = "ARe") {
			lastKeyRepeat := !lastKeyRepeat
		} else if (ThisCommand = "Spc") {
			SendInput, {Space}
			ADDCHARACTERS(A_Space, predict)
			ForceNewWord := 0
		} else if (ThisCommand = "BkS") {
			SendInput, {BackSpace}
			ADDCHARACTERS(-1, predict)
			ForceNewWord := 0
		} else if (ThisCommand = "Del") {
			SendInput, {Delete}
		} else if (ThisCommand = "Ent") {
			SendInput, {Enter}
		} else if (ThisCommand = "Tab") {
			SendInput, {Tab}
		} else if (ThisCommand = "Rit") {
			SendInput, {Right}
		} else if (ThisCommand = "Lft") {
			SendInput, {Left}
		} else if (ThisCommand = "Up") {
			SendInput, {Up}
		} else if (ThisCommand = "Dwn") {
			SendInput, {Down}
		} else if (ThisCommand = "Hom") {
			SendInput, {Home}
		} else if (ThisCommand = "End") {
			SendInput, {End}
		} else if (ThisCommand = "Esc") {
			SendInput, {Escape}
		} else if (ThisCommand = "Ins") {
			SendInput, {Insert}
		} else if (ThisCommand = "ScL") {
			SendInput, {ScrolLock}
		} else if (ThisCommand = "UnD") {
			SendInput, ^{z}
		} else if (ThisCommand = "ReD") {
			SendInput, ^{y}
		} else if (ThisCommand = "SAl") {
			SendInput, ^{a}
		} else if (ThisCommand = "Cpy") {
			SendInput, ^{c}
		} else if (ThisCommand = "Cut") {
			SendInput, ^{x}
		} else if (ThisCommand = "Pst") {
			SendInput, ^{v}
		} else if (ThisCommand = "sCp") {
			SendInput, ^+{c}
		} else if (ThisCommand = "sPs") {
			SendInput, ^+{v}
		} else if (ThisCommand = "Fnd") {
			SendInput, ^{f}
		} else if (ThisCommand = "Rpl") {
			SendInput, ^{h}
		} else if (ThisCommand = "Sav") {
			SendInput, ^{s}
		} else if (ThisCommand = "Mnu") {
			SendInput, {AppsKey}
		} else if (ThisCommand = "Zm+") {
			SendInput, ^{=}
		} else if (ThisCommand = "Zm-") {
			SendInput, ^{-}
		} else if (ThisCommand = "Mg+") {
			SendInput, #{=}
		} else if (ThisCommand = "Mg-") {
			SendInput, #{-}
		} else if (ThisCommand = "Mg!") {
			SendInput, #{Escape}
		} else if (ThisCommand = "ChT") {
			SendInput, {Control DownTemp}{Tab}
		} else if (ThisCommand = "ChW") {
			SendInput, {Alt DownTemp}{Tab}
		} else if (ThisCommand = "ClT") {
			SendInput, ^{w}
		} else if (ThisCommand = "ClW") {
			SendInput, !{F4}
		} else if (ThisCommand = "#X") {
			SendInput, #{x}
		} else if (ThisCommand = "FuS") {
			SendInput, {F11}
		} else if (ThisCommand = "gFS") {
			SendInput, !{Enter}
		} else if (ThisCommand = "PrS") {
			SendInput, {PrintScreen}
		} else if (ThisCommand = "aPS") {
			SendInput, !{PrintScreen}
		} else if (ThisCommand = "Jap") {
			SendInput, {Alt Down}{``}{Alt Up}
		} else if (ThisCommand = "Hga") {
			SendInput, {Control Down}{CapsLock}{Control Up}
		} else if (ThisCommand = "Kka") {
			SendInput, {Alt Down}{CapsLock}{Alt Up}
		} else if (ThisCommand = "ScS") {
			Run, C:\Windows\System32\scrnsave.scr /s
		} else if (ThisCommand = "Pau") {
			SendInput, {Media_Play_Pause}
		} else if (ThisCommand = "Prv") {
			SendInput, {Media_Prev}
		} else if (ThisCommand = "Nxt") {
			SendInput, {Media_Next}
		} else if (ThisCommand = "VUp") {
			SendInput, {Volume_Up}
		} else if (ThisCommand = "VDn") {
			SendInput, {Volume_Down}
		} else if (ThisCommand = "TAS") {
			SendInput, !{c}
		} else if (ThisCommand = "TAP") {
			SendInput, !{z}
		} else if (ThisCommand = "TAC") {
			SendInput, !{x}
		} else if (ThisCommand = "MLC") {
			MouseClick, Left,,, 1, 0
		} else if (ThisCommand = "MLU") {
			MouseClick, Left,,, 1, 0, U
		} else if (ThisCommand = "MLD") {
			MouseClick, Left,,, 1, 0, D
		} else if (ThisCommand = "MRC") {
			MouseClick, Right,,, 1, 0 ;, U
		} else if (ThisCommand = "MRU") {
			MouseClick, Right,,, 1, 0, U
		} else if (ThisCommand = "MRD") {
			MouseClick, Right,,, 1, 0, D
		} else if (ThisCommand = "MMC") {
			MouseClick, Middle,,, 1, 0
		} else if (ThisCommand = "MMU") {
			MouseClick, Middle,,, 1, 0, U
			MouseMDown := 0
		} else if (ThisCommand = "MMD") {
			MouseClick, Middle,,, 1, 0, D
			MouseMDown := 1
		} else if (ThisCommand = "MX1") {
			MouseClick, X1,,, 1, 0
		} else if (ThisCommand = "MX2") {
			MouseClick, X2,,, 1, 0
		} else if (ThisCommand = "MPU") {
			if (keysWereActive >= 0)
				MouseMoveY := MouseMoveMin
			MouseMove, 0, -MouseMoveY, 0, R
		} else if (ThisCommand = "MPD") {
			if (keysWereActive >= 0)
				MouseMoveY := MouseMoveMin
			MouseMove, 0, MouseMoveY, 0, R
		} else if (ThisCommand = "MPL") {
			if (keysWereActive >= 0)
				MouseMoveX := MouseMoveMin
			MouseMove, -MouseMoveX, 0, 0, R
		} else if (ThisCommand = "MPR") {
			if (keysWereActive >= 0)
				MouseMoveX := MouseMoveMin
			MouseMove, MouseMoveX, 0, 0, R
		} else if (ThisCommand = "WUp") {
			if (keysWereActive >= 0)
				MouseWheelY := 1
			SendInput, {WheelUp %MouseWheelY%}
			if (keysWereActive >= 0)
				MouseWheelY--
		} else if (ThisCommand = "WDn") {
			if (keysWereActive >= 0)
				MouseWheelY := 1
			SendInput, {WheelDown %MouseWheelY%}
			if (keysWereActive >= 0)
				MouseWheelY--
		} else if (ThisCommand = "WLf") {
			if (keysWereActive >= 0)
				MouseWheelX := 1
			SendInput, {WheelLeft %MouseWheelX%}
			if (keysWereActive >= 0)
				MouseWheelX--
		} else if (ThisCommand = "WRi") {
			if (keysWereActive >= 0)
				MouseWheelX := 1
			SendInput, {WheelRight %MouseWheelX%}
			if (keysWereActive >= 0)
				MouseWheelX--
		} else if (ThisCommand = "SHF") {
			TOGGLEMODKEY("Shift")
		} else if (ThisCommand = "CTR") {
			TOGGLEMODKEY("Control")
		} else if (ThisCommand = "ALT") {
			TOGGLEMODKEY("Alt")
		} else if (ThisCommand = "WIN") {
			TOGGLEMODKEY("LWin")
		} else if InStr(ThisCommand, "}") {
			ThisCommand := StrReplace(ThisCommand, A_Space)
			Send, {%ThisCommand%}
		} else if (ThisCommand <> "") {
			ThisCommand := StrReplace(ThisCommand, A_Space)
			if (InStr("0123456789", ThisCommand) && WordList && UsePresage) {
				if (ThisCommand = 0)
					ThisCommand := 10
				SelectedWord := SubStr(StrSplit(WordList, ",", "() '`n`r")[ThisCommand], StrLen(WordBuffer) + 1) . A_Space
				;ToolTip, SelectedWord: `"%SelectedWord%`" was selected.
				SendInput, %SelectedWord%
				ADDCHARACTERS(SelectedWord, true)
			} else {
				SendInput, {%ThisCommand%}
				ADDCHARACTERS(ThisCommand, predict)
			}
			ForceNewWord := 0
		} else {
			mode := modeDEFAULT
		}
		if (mode > 10) {
			if (modePRE = 7) || (modePRE = 5) {
				modeTMP := mode
				mode := modePRE
				modePRE := modeTMP
			} else {
				mode := modePRE
			}
		}
		if (ForceNewWord) {
			CLEARCHARACTERS()
		}
		if !InStr("SHF CTR ALT WIN", ThisCommand) {
			if (ShiftDown = 1) {
				RELEASEKEYS("Shift")
				;ShiftDown := 0
				;SoundBeep, 700, 100
				;SoundBeep, 500, 100
			}
			if (ControlDown = 1) {
				RELEASEKEYS("Control")
			}
			if (AltDown = 1) {
				RELEASEKEYS("Alt")
			}
			if (WinDown = 1) {
				RELEASEKEYS("Win")
			}
		}
	}
	ch_mode := mod(mode, 10)
}

CLEARCHARACTERS()
{
	global SentensBuffer
	global WordBuffer
	global WordList
	SentensBuffer :=
	WordBuffer :=
	WordList :=
	; ToolTip,
	Gui, ListBoxGui: Destroy
}

RELEASEKEYS(KeyList := "")
{ ; Release any held keys
	{ ; global
		global ShiftDown
		global ControlDown
		global AltDown
		global WinDown
		global MouseMDown
	}

	SomeWhereDown := 0
	if (KeyList = "") {
		KeyList := "Shift|Control|Alt|LWin|RWin|LControl|RControl|LShift|RShift|LAlt|RAlt|CapsLock|LButton|RButton|MButton|XButton1|XButton2"
		if MouseMDown {
			MouseClick, Middle,,, 1, 0, U
			MouseMDown := 0
		}
	} else if InStr(KeyList, "Shift") {
		if ShiftDown {
			Send, {Shift Up}
			ShiftDown := 0
			SomeWhereDown := 1
		}
		KeyList := KeyList . "|LShift|RShift"
	} else if InStr(KeyList, "Control") {
		if ControlDown {
			Send, {Control Up}
			ControlDown := 0
			SomeWhereDown := 1
		}
		KeyList := KeyList . "|LControl|RControl"
	} else if InStr(KeyList, "Alt") {
		if AltDown {
			Send, {Alt Up}
			AltDown := 0
			SomeWhereDown := 1
		}
		KeyList := KeyList . "|LAlt|RAlt"
	} else if InStr(KeyList, "Win") {
		if WinDown {
			Send, {LWin Up}
			WinDown := 0
			SomeWhereDown := 1
		}
		KeyList := "LWin|RWin"
	}
	Loop, Parse, KeyList, |
	{
		if GetKeystate(A_Loopfield) {
			/*
			If InStr(A_Loopfield, "Button") {
				If InStr(A_Loopfield, "L") {
					MouseClick, Left,,, 1, 0, U
				} Else If InStr(A_Loopfield, "R") {
					MouseClick, Right,,, 1, 0, U
				} Else If InStr(A_Loopfield, "M") {
					MouseClick, Middle,,, 1, 0, U
				} Else If InStr(A_Loopfield, "1") {
					MouseClick, X1,,, 1, 0, U
				} Else If InStr(A_Loopfield, "2") {
					MouseClick, X2,,, 1, 0, U
				}
			} Else {
			*/
				Send % "{" A_Loopfield " Up}"
				SomeWhereDown := 1
			;}
		}
	}
	Return SomeWhereDown
}

TOGGLEMODKEY(ModKey := "")
{
	global ShiftDown
	global ControlDown
	global AltDown
	global WinDown
	if (ModKey = "")
		Return
	if !RELEASEKEYS(ModKey) {
			Send % "{" ModKey " Down}"
			if InStr(ModKey, "Shift") {
				ShiftDown := 1
			} else if InStr(ModKey, "Control") {
				ControlDown := 1
			} else if InStr(ModKey, "Alt") {
				AltDown := 1
			} else if InStr(ModKey, "Win") {
				WinDown := 1
			}
		}
}

ADDCHARACTERS(Character := "", predict := 0)
{
	{ ; Global Variables
		global SentensBuffer
		global WordBuffer
		global WordList
		global UsePresage
	}
	if (Character = -1) {
		if StrLen(SentensBuffer) > 1 {
			SentensBuffer := SubStr(SentensBuffer, 1, -1)
			if StrLen(WordBuffer) > 1 {
				WordBuffer := SubStr(WordBuffer, 1, -1)
			} else {
				WordBuffer :=
			}
			if (UsePresage && predict)
				strStdOut := PRESAGE(SentensBuffer)
		} else {
			CLEARCHARACTERS()
		}
	} else {
		if (InStr("abcdefghijklmnopqrstuvwxyz '-ABCDEFGHIJKLMNOPQRSTUVWXYZ", Character)
			|| StrLen(Character) > 1){ ; 0123456789
			SentensBuffer .= Character
			WordBuffer .= Character
			if (UsePresage && predict)
				WordList := PRESAGE(SentensBuffer)
		} else {
			CLEARCHARACTERS()
		}
		if WordBuffer <>
		{
			if InStr(SubStr(WordBuffer, -1), A_Space) {
				WordBuffer :=
			}
		}
	}
	;if WordList
	if (UsePresage && predict && StrLen(SentensBuffer))
	{
		ListOfWords := StrSplit(WordList, ",", "( ')`n`r")
		strigList := ;"strigList: "
		;if SentensBuffer <>
		;Gui, Name: ListOfWords,,
		;Gui, Destroy
		Gui, ListBoxGui: New
		Gui, ListBoxGui: -DPIScale -Caption +AlwaysOnTop +ToolWindow +Disabled -SysMenu +Owner
		Gui, ListBoxGui:Font, s18 bold, Courier New
		;GuiControl, -Redraw, ListBoxGui
		For Key , Value in ListOfWords {
			strigList .= A_Index . ": " . Value . "`n"
			;Gui, ListBoxGui: Add, Text,, %A_Index%: %Value%
			GuiControl, ListBoxGui:-Redraw, g_ListBox%A_Index%
			;can't use a g-label here as windows sometimes passes the click message when spamming the scrollbar arrows
			Gui, ListBoxGui: Add, ListBox, R1 T18 T32 hwndg_ListBoxHwnd%A_Index%, %A_Index%: %Value%
			;vg_ListBox%A_Index% R%A_Index% X0 Y0
			if (A_Index = ListOfWords.max()) {
				GuiControl, ListBoxGui: +AltSubmit +Redraw, g_ListBox%A_Index%
				GuiControl, ListBoxGui: Show, g_ListBox%A_Index%
				GuiControlGet, ListBoxActualSize, ListBoxGui: Pos, g_ListBox%A_Index%
			}
		}
		;GuiControl, +Redraw, ListBoxGui
		{
			PosX := HCaretX()
			PosY := HCaretY()
			Gui, ListBoxGui: Show, NoActivate AutoSize x%PosX% y%PosY%
			/*
			Local BorderWidthX
      Local ListBoxActualSize
      Local ListBoxActualSizeH
      Local ListBoxActualSizeW
      Local ListBoxPosY
      Local ListBoxSizeX
      Local ListBoxThread
      Local MatchEnd
      Local Rows
      Local ScrollBarWidth
      static ListBox_Old_Cursor
      ForceWithinMonitorBounds(g_ListBoxPosX,ListBoxPosY,ListBoxActualSizeW,ListBoxActualSizeH)

      g_ListBoxContentWidth := ListBoxActualSizeW - ScrollBarWidth - BorderWidthX
			WinSet, Transparent, %prefs_ListBoxOpacity%, ahk_id %g_ListBox_Id%
			*/
		}
	}
	if false { ; (UsePresage && predict && StrLen(SentensBuffer)) { ;&& WordBuffer <>
		if CheckIfCaretNotDetectable()
			ToolTip, %SentensBuffer%`n%strigList%
		else
			ToolTip, %SentensBuffer%`n%strigList%, HCaretX(), HCaretY()
		;ToolTip, %WordBuffer%`n%SentensBuffer%`n%strigList%`n%WordList%
	}
}

PRESAGE(SentensBuffer := "")
{
  shell := ComObjCreate("WScript.Shell")
	cmdStr := "cmd.exe /c presagePredict.py"
	global exec
	if SentensBuffer <>
	{
		cmdStr := cmdStr . " -c """ . SentensBuffer . """"
	}
  ;exec := shell.Exec(cmdStr)
	;exec.StdIn.WriteLine(SentensBuffer "`n")
  ;strStdOut := exec.StdOut.ReadAll()
  strStdOut := shell.Exec(cmdStr).StdOut.ReadAll()
	Return strStdOut
  MsgBox % strStdOut
}

HUD(ByRef SubTextT, ByRef SubTextB, index := 1, ch_mode := 1, ByRef SubTextI := "", ByRef SubTextO := "", isLeftHand := 1)
{
	global all_characters
	LeftHanded := isLeftHand = 1
	{
		option_index := index * 10
		option_index++
		option1 := % all_characters%ch_mode%%option_index%
		option_index++
		option2 := % all_characters%ch_mode%%option_index%
		option_index++
		option3 := % all_characters%ch_mode%%option_index%
		option_index++
		option4 := % all_characters%ch_mode%%option_index%
		option_index += 2
		option6 := % all_characters%ch_mode%%option_index%
		option_index++
		option7 := % all_characters%ch_mode%%option_index%
		option_index++
		option8 := % all_characters%ch_mode%%option_index%
		option_index++
		option9 := % all_characters%ch_mode%%option_index%
	}
	{
		if (index = 1) {
			if (LeftHanded) {
				SubTextT = %SubTextT%| %option4% %option3% %option2%/%option1%/|
				SubTextB = %SubTextB%| %option9% %option8% %option7%/%option6%/|
				SubTextI = %SubTextI%|            \   \|
				SubTextO = %SubTextO%+-----------------+
			} else {
				SubTextT = %SubTextT%|\%option1%\%option2% %option3% %option4% |
				SubTextB = %SubTextB%|\%option6%\%option7% %option8% %option9% |
				SubTextI = %SubTextI%|/   /            |
				SubTextO = %SubTextO%+-----------------+
			}
		} else if (index = 2) {
			if (LeftHanded) {
				SubTextT = %SubTextT%| %option4% %option3%/%option2%/%option1% |
				SubTextB = %SubTextB%| %option9% %option8%/%option7%/%option6% |
				SubTextI = %SubTextI%|        \   \    |
				SubTextO = %SubTextO%+-----------------+
			} else {
				SubTextT = %SubTextT%| %option1%\%option2%\%option3% %option4% |
				SubTextB = %SubTextB%| %option6%\%option7%\%option8% %option9% |
				SubTextI = %SubTextI%|    /   /        |
				SubTextO = %SubTextO%+-----------------+
			}
		} else if (index = 3) {
			if (LeftHanded) {
				SubTextT = %SubTextT%| %option4%\%option3%\%option2% %option1% |
				SubTextB = %SubTextB%| %option9%\%option8%\%option7% %option6% |
				SubTextI = %SubTextI%|    /   /        |
				SubTextO = %SubTextO%+-----------------+
			} else {
				SubTextT = %SubTextT%| %option1% %option2%/%option3%/%option4% |
				SubTextB = %SubTextB%| %option6% %option7%/%option8%/%option9% |
				SubTextI = %SubTextI%|        \   \    |
				SubTextO = %SubTextO%+-----------------+
			}
		} else if (index = 4) {
			if (LeftHanded) {
				SubTextT = %SubTextT%|\%option4%\%option3% %option2% %option1% |
				SubTextB = %SubTextB%|\%option9%\%option8% %option7% %option6% |
				SubTextI = %SubTextI%|/   /            |
				SubTextO = %SubTextO%+-----------------+
			} else {
				SubTextT = %SubTextT%| %option1% %option2% %option3%/%option4%/|
				SubTextB = %SubTextB%| %option6% %option7% %option8%/%option9%/|
				SubTextI = %SubTextI%|            \   \|
				SubTextO = %SubTextO%+-----------------+
			}
		} else {
			if (LeftHanded) {
				SubTextT = %SubTextT%| %option4% %option3% %option2% %option1% |
				SubTextB = %SubTextB%| %option9% %option8% %option7% %option6% |
				SubTextI = %SubTextI%|                 |
				SubTextO = %SubTextO%+-----------------+
			} else {
				SubTextT = %SubTextT%| %option1% %option2% %option3% %option4% |
				SubTextB = %SubTextB%| %option6% %option7% %option8% %option9% |
				SubTextI = %SubTextI%|                 |
				SubTextO = %SubTextO%+-----------------+
			}
		}
	}
}

KEYDOWN(thisKey, isLeftHand := 1)
{
	{ ; Global Variables
		global firstKeyDown
		global secondKeyDown
		global thirdKeyDown
		global fourthKeyDown
		global firstKeyUp
		global secondKeyUp
		global thirdKeyUp
		global fourthKeyUp
		global keysAreActive
		global keysWereActive
		global character_mode_list
		global modeDEFAULT
		global mode
		global modePRE
		global ch_mode
		global daynight
		global lastKeyRepeat
		global lastSent
		global CableUp
		global UseGamepad
		global HIDmode
		global HIDopacity
	}
	if (thisKey <> firstKeyDown && thisKey <> secondKeyDown && thisKey <> thirdKeyDown && thisKey <> fourthKeyDown)
	{
		if firstKeyDown =
		{
			firstKeyDown := thisKey
			keysAreActive++
			HIDmode := 1
			if (isLeftHand = 3)
				HIDopacity := -1
			else
				HIDopacity := -2
		} else if secondKeyDown =
		{
			secondKeyDown := thisKey
			keysAreActive++
		} else if thirdKeyDown =
		{
			thirdKeyDown := thisKey
			keysAreActive++
			HIDmode := 0
			Progress, 1:Off
			{ ; HUD
				SubTextT := ""
				SubTextB := ""
				SubTextI := ""
				SubTextO := ""
				Loop, 4
				{
					if (isLeftHand = 1) {
						HUD(SubTextT, SubTextB, 5-A_Index, ch_mode, SubTextI, SubTextO, isLeftHand)
					} else  {
						HUD(SubTextT, SubTextB, A_Index, ch_mode, SubTextI, SubTextO, 0)
					}
				}
				SubText = %A_Space%
										|%SubTextO%|`n
										|%SubTextT%|`n
										|%SubTextI%|`n
										|%SubTextB%|`n
										|%SubTextO%|`n
				mode_title := % character_mode_list%ch_mode%
				If (mode > 10)
				{
					mode_title = %mode_title% Latch
				}
				If (daynight)
					colour_text := "00FF00" ; Red FF0000 ; Green 008000 ; Lime 00FF00
				Else
					colour_text := "FF0000" ; Red FF0000 ; Green 008000 ; Lime 00FF00
				weight_text := 400
				Progress, 1:b zh0 fm32 fs28 w1800 ct%colour_text% cwBlack
					, %A_Space%%SubText% , % mode_title, HUD, Courier New
				WinSet, Transparent, 200, HUD
				;WinSet, TransColor, 000000, HUD
			}
			;ToolTip,
		} else if fourthKeyDown =
		{
			fourthKeyDown := thisKey
			keysAreActive++
			HIDmode := 0
			Progress, 1:Off
			{ ; HUD
				SubText := ""
				Loop, 5
				{
					if (A_Index + 1 < ch_mode)
						thisMode := A_Index + 1
					else
						thisMode := A_Index + 2
					SubTextT := ""
					SubTextB := ""
					SubTextI := ""
					SubTextO := ""
					Loop, 4
					{
						if (isLeftHand = 1) {
							HUD(SubTextT, SubTextB, 5-A_Index, thisMode, SubTextI, SubTextO, isLeftHand)
						} else  {
							HUD(SubTextT, SubTextB, A_Index, thisMode, SubTextI, SubTextO, isLeftHand)
						}
					}
					mode_title := % character_mode_list%thisMode%
					mode_title = %A_Space%%mode_title%`n
					SubText = %SubText% %mode_title%
											|%SubTextO%|`n
											|%SubTextT%|`n
											|%SubTextI%|`n
											|%SubTextB%|`n
											|%SubTextO%|`n
				}
				if (daynight)
					colour_text := "00FF00" ; Red FF0000 ; Green 008000 ; Lime 00FF00
				else
					colour_text := "FF0000" ; Red FF0000 ; Green 008000 ; Lime 00FF00
				Kee4Title := "Kee4"
				if (UseGamepad || isLeftHand = 2)
					Kee4Title = Gamepad %Kee4Title%
				else if (isLeftHand = 1)
					Kee4Title = Left-Hand %Kee4Title%
				else
					Kee4Title = Right-Hand %Kee4Title%
				if (lastKeyRepeat)
					Kee4Title = %Kee4Title%, last key repeat ON
				else
					Kee4Title = %Kee4Title%, last key repeat OFF
				if (isLeftHand < 2) {
					if (CableUp)
						Kee4Title = %Kee4Title%, cable UP
					else
						Kee4Title = %Kee4Title%, cable DOWN
				}
				weight_text := 400
				Progress, 1:b zh0 fm32 fs21 w1400 ct%colour_text% cwBlack
					, %A_Space%%SubText% , %Kee4Title%, HUD, Courier New
			}
			mode := modeDEFAULT
			ch_mode := mode
			modePRE := mode
		}
	}
	{ ; key was released
		if InStr(firstKeyUp, thisKey) {
			firstKeyUp :=
			keysAreActive++
			keysWereActive--
		} else if InStr(secondKeyUp, thisKey) {
			secondKeyUp :=
			keysAreActive++
			keysWereActive--
		} else if InStr(thirdKeyUp, thisKey) {
			thirdKeyUp :=
			keysAreActive++
			keysWereActive--
		}
	}
	{ ; HID
		if (HIDmode)
		{
			if (mod(HIDopacity, 20) = 0)
			{ ; HUD
					SubTextT := ""
					SubTextB := ""
					SubTextI := ""
					SubTextO := ""
					HUD(SubTextT, SubTextB, SubStr(firstKeyDown, 7, 1), ch_mode, SubTextI, SubTextO, isLeftHand)
					SubText = %A_Space%
											|%SubTextO%|`n
											|%SubTextT%|`n
											|%SubTextI%|`n
											|%SubTextB%|`n
											|%SubTextO%|

				mode_title := % character_mode_list%ch_mode%
				If (mode > 10)
				{
					mode_title = %mode_title% Latch
				}
				If (daynight)
					colour_text := "00FF00" ; Red FF0000 ; Green 008000 ; Lime 00FF00
				Else
					colour_text := "FF0000" ; Red FF0000 ; Green 008000 ; Lime 00FF00
				weight_text := 400
				Progress, 1:b zh0 fm32 fs28 w550 ct%colour_text% cwBlack
					, %A_Space%%SubText% , % mode_title, HUD, Courier New
				if (HIDopacity = 0)
					WinSet, TransColor, 000000, HUD
				else {
					opacity := HIDopacity * 4
					WinSet, Transparent, %opacity%, HUD
					if (opacity > 256)
						HIDmode := 0
				}
			}
			HIDopacity++
		}
	}
}

KEYUP(thisKey)
{
	{ ; Global Variables
		global firstKeyDown
		global secondKeyDown
		global thirdKeyDown
		global fourthKeyDown
		global firstKeyUp
		global secondKeyUp
		global thirdKeyUp
		global fourthKeyUp
		global opositeKeyDown
		global opositeKeyUp
		global keysAreActive
		global keysWereActive
		global character_mode_list
		global modeDEFAULT
		global mode
		global modePRE
		global ch_mode
		global lastSent
	}
	if (keysWereActive >= 0 && thisKey <> firstKeyUp && thisKey <> secondKeyUp && thisKey <> thirdKeyUp)
	{
		; ToolTip, %thisKey% %keysAreActive%`n%firstKeyUp% %secondKeyUp% %thirdKeyUp%
		if (keysAreActive = 1)
		{
			Progress, 1:Off
	    ;ToolTip,
			if (keysWereActive < 2){
				character_code := SubStr(firstKeyDown, 7, 1) * 10
		    if (keysWereActive = 1)
		    {
		      if (SubStr(firstKeyDown, 7, 1) <> SubStr(thisKey, 7, 1)) {
		        character_code += SubStr(secondKeyDown, 7, 1)
		      }
		      else {
		        character_code += SubStr(secondKeyDown, 7, 1) + 5
		      }
		    }
				lastSent := % all_characters%ch_mode%%character_code%
				SENDCOMMAND(lastSent, true)
			} else if (keysWereActive = 3) {
				CLEARCHARACTERS()
				RELEASEKEYS()
			}
			firstKeyDown :=
			secondKeyDown :=
	    thirdKeyDown :=
			fourthKeyDown :=
			firstKeyUp :=
			secondKeyUp :=
			thirdKeyUp :=
			fourthKeyUp :=
			opositeKeyDown :=
			opositeKeyUp :=
			keysAreActive := 0
			keysWereActive := 0
	  }
	  else if firstKeyUp =
	  {
	    firstKeyUp := thisKey
	    keysWereActive++
	    keysAreActive--
	  }
	  else if secondKeyUp =
	  {
	    secondKeyUp := thisKey
	    keysWereActive++
	    keysAreActive--
	  }
	  else if thirdKeyUp =
	  {
	    thirdKeyUp := thisKey
	    keysWereActive++
	    keysAreActive--
	  }
	}
	else if (keysWereActive < 0)
	{
		keysWereActive := 0
	}
}

REPEATKEY(ByRef lastSent := "", ThisHotkey := "")
{
	{ ; Global Variables
		global keysWereActive
		global modeDEFAULT
		global mode
		global modePRE
		global ch_mode
		global UsePresage
		global ShiftDown
		global ControlDown
		global AltDown
		global WinDown
		global MouseMoveX
		global MouseMoveY
		global MouseWheelX
		global MouseWheelY
	}
	if (lastSent = "Spc") {
		SENDCOMMAND("BkS")
		SENDCOMMAND(".")
		if (ch_mode <> 3) {
			SENDCOMMAND("Spc")
			mode := 22
			ch_mode := 2
		}
		lastSent :=
		keysWereActive := -2
	} else if InStr(lastSent, ";") {
		SENDCOMMAND("BkS")
		SENDCOMMAND(":")
		lastSent :=
		keysWereActive := -2
	} else if (lastSent = "!") {
		SENDCOMMAND("BkS")
		SENDCOMMAND("?")
		lastSent :=
		keysWereActive := -2
	} else if InStr(lastSent, "(") {
		SENDCOMMAND(")")
		keysWereActive := -2
	} else if InStr(lastSent, "{") {
		SENDCOMMAND("}")
		keysWereActive := -2
	} else if InStr(lastSent, "[") {
		SENDCOMMAND("]")
		keysWereActive := -2
	} else if InStr(lastSent, "<") {
		SENDCOMMAND(">")
		keysWereActive := -2
	} else if InStr(lastSent, "TUD") {
		SENDCOMMAND(lastSent)
		UsePresage := !UsePresage
		keysWereActive := -2
	} else if InStr(lastSent, "Pau") {
		SendInput, {Volume_Mute}
		keysWereActive := -2
	} else if InStr(lastSent, "Jap") {
		SendInput, {Alt Down}{Shift}{Alt Up}
		keysWereActive := -2
	} else if InStr(lastSent, "Mg!") {
		keysWereActive := -2
		lastSent := "Mg+"
		SENDCOMMAND(lastSent)
	} else if InStr(lastSent, "Cpy") {
		keysWereActive := -2
		lastSent :=
		SENDCOMMAND("Cut")
	} else if InStr(lastSent, "Pst") {
		keysWereActive := -2
		lastSent :=
		SENDCOMMAND("UnD")
		SENDCOMMAND("Cpy")
		SENDCOMMAND("ReD")
	} else if (InStr(lastSent, "Mod") || InStr(lastSent, "Cap") || InStr(lastSent, "Num") || InStr(lastSent, "Nav") || InStr(lastSent, "Fnc")) {
		keysWereActive := -2
		SENDCOMMAND(lastSent)
	} else if InStr(lastSent, "SHF") {
		if (ShiftDown = 1)
			ShiftDown := 2
		keysWereActive := -2
	} else if InStr(lastSent, "CTR") {
		if (ControlDown = 1)
			ControlDown := 2
		keysWereActive := -2
	} else if InStr(lastSent, "ALT") {
		if (AltDown = 1)
			AltDown := 2
		keysWereActive := -2
	} else if InStr(lastSent, "WIN") {
		if (WinDown = 1)
			WinDown := 2
		keysWereActive := -2
	} else if (SubStr(lastSent, 1, 1) . SubStr(lastSent, 3, 1) = "MD" && InStr("LRM", SubStr(lastSent, 2, 1))) {
		;lastSent := StrReplace(lastSent, "D", "U")
		lastSent := SubStr(lastSent, 1, 1) . SubStr(lastSent, 2, 1) . "U"
		;ToolTip, % lastSent
		SENDCOMMAND(lastSent)
		keysWereActive := -2
	} else if (SubStr(lastSent, 1, 1) . SubStr(lastSent, 3, 1) = "MU" && InStr("LRM", SubStr(lastSent, 2, 1))) {
		;ToolTip, % ThisHotkey
		if ((InStr("L", SubStr(lastSent, 2, 1)) && InStr(ThisHotkey, "1"))
			|| (InStr("M", SubStr(lastSent, 2, 1)) && InStr(ThisHotkey, "2"))
			|| (InStr("R", SubStr(lastSent, 2, 1)) && InStr(ThisHotkey, "3"))) {
			;lastSent := StrReplace(lastSent, "U", "C")
			lastSent := SubStr(lastSent, 1, 1) . SubStr(lastSent, 2, 1) . "C"
			SENDCOMMAND(lastSent)
		} else {
			;SENDCOMMAND(StrReplace(lastSent, "U", "D"))
			SENDCOMMAND(SubStr(lastSent, 1, 1) . SubStr(lastSent, 2, 1) . "D")
			lastSent :=
		}
		keysWereActive := -2
	} else if (SubStr(lastSent, 1, 1) . SubStr(lastSent, 3, 1) = "MC" && InStr("LRM", SubStr(lastSent, 2, 1))) {
		SENDCOMMAND(lastSent)
		keysWereActive := -2
	} else {
		if (keysWereActive = 0) {
			if ((lastSent = "MPU") || (lastSent = "MPD")) {
				MouseMoveY += MouseMoveY
			} else if ((lastSent = "MPL") || (lastSent = "MPR")) {
				MouseMoveX += MouseMoveX
			} else if ((lastSent = "WUp") || (lastSent = "WDn")) {
				MouseWheelY++
			} else if ((lastSent = "WLf") || (lastSent = "WRi")) {
				MouseWheelX++
			}
		}
		keysWereActive := -1
		SENDCOMMAND(lastSent)
	}
}

REBINDKEY(ThisHotkey := "")
{ ; Rebind
	{ ; Global Variables
		global UseGamepad
		global isLeftHand
		global MouseLastPosX
		global MouseLastPosY
		global MouseAutoDetect
		global mode
		global modePRE
		global ch_mode
		global CableUp
	}
	if (UseGamepad) {
		isLeftHand := 0
		if InStr(ThisHotkey, "Numpad5") {
			B_ThisHotkey := "Numpad1"
		} else if InStr(ThisHotkey, "Numpad6") {
			B_ThisHotkey := "Numpad2"
		} else if InStr(ThisHotkey, "Numpad8") {
			B_ThisHotkey := "Numpad3"
		} else if InStr(ThisHotkey, "Numpad9") {
			B_ThisHotkey := "Numpad4"
		} else {
			if firstKeyDown <>
			{
				if opositeKeyDown =
				{
					if InStr(firstKeyDown, "1") {
						opositeKeyDown := "Numpad4"
					} else if InStr(firstKeyDown, "2") {
						opositeKeyDown := "Numpad3"
					} else if InStr(firstKeyDown, "3") {
						opositeKeyDown := "Numpad2"
					} else if InStr(firstKeyDown, "4") {
						opositeKeyDown := "Numpad1"
					}
				}
				B_ThisHotkey = %opositeKeyDown%
			} else
				B_ThisHotkey :=
		}
	} else {
		MouseGetPos, MouseNewPosX, MouseNewPosY
		if (MouseAutoDetect && (MouseLastPosX <> MouseNewPosX || MouseLastPosY <> MouseNewPosY)) {
			MouseLastPosX := MouseNewPosX
			MouseLastPosY := MouseNewPosY
			mode := 7
			ch_mode := mode
			modePRE := mode
		}
		if (InStr(ThisHotkey, "Numpad0") || InStr(ThisHotkey, "NumpadIns")) {
			isLeftHand := 2
			B_ThisHotkey := "Numpad1"
		} else if (InStr(ThisHotkey, "Numpad1") || InStr(ThisHotkey, "NumpadEnd")) {
			isLeftHand := 2
			B_ThisHotkey := "Numpad2"
		} else if (InStr(ThisHotkey, "Numpad4") || InStr(ThisHotkey, "NumpadLeft")) {
			isLeftHand := 2
			B_ThisHotkey := "Numpad3"
		} else if (InStr(ThisHotkey, "Numpad7") || InStr(ThisHotkey, "NumpadHome")) {
			isLeftHand := 2
			B_ThisHotkey := "Numpad4"
		} else if (InStr(ThisHotkey, "NumpadDot") || InStr(ThisHotkey, "NumpadDel")) {
			isLeftHand := 2
			if firstKeyDown <>
			{
				if opositeKeyDown =
				{
					if InStr(firstKeyDown, "1") {
						opositeKeyDown := "Numpad4"
					} else if InStr(firstKeyDown, "2") {
						opositeKeyDown := "Numpad3"
					} else if InStr(firstKeyDown, "3") {
						opositeKeyDown := "Numpad2"
					} else if InStr(firstKeyDown, "4") {
						opositeKeyDown := "Numpad1"
					}
				}
				B_ThisHotkey = %opositeKeyDown%
			} else
				B_ThisHotkey :=
		} else if InStr(ThisHotkey, "LButton") {
			isLeftHand := 3
			B_ThisHotkey := "Numpad1"
		} else if InStr(ThisHotkey, "RButton") {
			isLeftHand := 3
			B_ThisHotkey := "Numpad3"
		} else if InStr(ThisHotkey, "MButton") {
			isLeftHand := 3
			B_ThisHotkey := "Numpad2"
		} else if (InStr(ThisHotkey, "XButton1") || InStr(ThisHotkey, "Escape")) {
			isLeftHand := 3
			B_ThisHotkey := "Numpad4"
		} else if (CableUp)
		{
			if (InStr(ThisHotkey, "Numpad2") || InStr(ThisHotkey, "NumpadDown")) {
				isLeftHand := 1
				B_ThisHotkey := "Numpad4"
			} else if (InStr(ThisHotkey, "Numpad5") || InStr(ThisHotkey, "NumpadClear")) {
				isLeftHand := 1
				B_ThisHotkey := "Numpad3"
			} else if (InStr(ThisHotkey, "Numpad8") || InStr(ThisHotkey, "NumpadUp")) {
				isLeftHand := 1
				B_ThisHotkey := "Numpad2"
			} else if InStr(ThisHotkey, "NumpadDiv") {
				isLeftHand := 1
				B_ThisHotkey := "Numpad1"
			} else if InStr(ThisHotkey, "NumpadMult") {
				isLeftHand := 0
				B_ThisHotkey := "Numpad1"
			} else if (InStr(ThisHotkey, "Numpad9") || InStr(ThisHotkey, "NumpadPgUp")) {
				isLeftHand := 0
				B_ThisHotkey := "Numpad2"
			} else if (InStr(ThisHotkey, "Numpad6") || InStr(ThisHotkey, "NumpadRight")) {
				isLeftHand := 0
				B_ThisHotkey := "Numpad3"
			} else if (InStr(ThisHotkey, "Numpad3") || InStr(ThisHotkey, "NumpadPgDn")) {
				isLeftHand := 0
				B_ThisHotkey := "Numpad4"
			}
		}
		else
		{
			if (InStr(ThisHotkey, "Numpad2") || InStr(ThisHotkey, "NumpadDown")) {
				isLeftHand := 0
				B_ThisHotkey := "Numpad1"
			} else if (InStr(ThisHotkey, "Numpad5") || InStr(ThisHotkey, "NumpadClear")) {
				isLeftHand := 0
				B_ThisHotkey := "Numpad2"
			} else if (InStr(ThisHotkey, "Numpad8") || InStr(ThisHotkey, "NumpadUp")) {
				isLeftHand := 0
				B_ThisHotkey := "Numpad3"
			} else if InStr(ThisHotkey, "NumpadDiv") {
				isLeftHand := 0
				B_ThisHotkey := "Numpad4"
			} else if InStr(ThisHotkey, "NumpadMult") {
				isLeftHand := 1
				B_ThisHotkey := "Numpad4"
			} else if (InStr(ThisHotkey, "Numpad9") || InStr(ThisHotkey, "NumpadPgUp")) {
				isLeftHand := 1
				B_ThisHotkey := "Numpad3"
			} else if (InStr(ThisHotkey, "Numpad6") || InStr(ThisHotkey, "NumpadRight")) {
				isLeftHand := 1
				B_ThisHotkey := "Numpad2"
			} else if (InStr(ThisHotkey, "Numpad3") || InStr(ThisHotkey, "NumpadPgDn")) {
				isLeftHand := 1
				B_ThisHotkey := "Numpad1"
			}
		}
	} if InStr(ThisHotkey, " Up") {
		B_ThisHotkey := B_ThisHotkey . " Up"
	}
	Return B_ThisHotkey
}
;------------------------------------------------------------------------

; function to grab the X position of the caret for the ListBox
HCaretX()
{
   /*
	 global g_DpiAware
   global g_DpiScalingFactor
   global g_Helper_Id
   global g_Process_DPI_Unaware

   WinGetPos, HelperX,,,, ahk_id %g_Helper_Id%
   if HelperX !=
   {
      return HelperX
   }
	 */
   if ( CheckIfCaretNotDetectable() )
   {
      MouseGetPos, MouseX
      return MouseX
   }
   ; non-DPI Aware
	 /*
   if (g_DpiAware == g_Process_DPI_Unaware) {
      return (A_CaretX * g_DpiScalingFactor)
   }
	 */
   return A_CaretX
}

;------------------------------------------------------------------------

; function to grab the Y position of the caret for the ListBox
HCaretY()
{
	/*
   global g_DpiAware
   global g_DpiScalingFactor
   global g_Helper_Id
   global g_Process_DPI_Unaware

   WinGetPos,,HelperY,,, ahk_id %g_Helper_Id%
   if HelperY !=
   {
      return HelperY
   }
	 */
   if ( CheckIfCaretNotDetectable() )
   {
      MouseGetPos, , MouseY
      return MouseY ;+ (20*g_DpiScalingFactor)
   }
	 /*
   if (g_DpiAware == g_Process_DPI_Unaware) {
      return (A_CaretY * g_DpiScalingFactor)
   }
	 */
   return A_CaretY
}

;------------------------------------------------------------------------

CheckIfCaretNotDetectable()
{
   ;Grab the number of non-dummy monitors
   SysGet, NumMonitors, 80

   IfLess, NumMonitors, 1
      NumMonitors = 1

   if !(A_CaretX)
   {
      Return, 1
   }

   ;if the X caret position is equal to the leftmost border of the monitor +1, we can't detect the caret position.
   Loop, %NumMonitors%
   {
      SysGet, Mon, Monitor, %A_Index%
      if ( A_CaretX = ( MonLeft ) )
      {
         Return, 1
      }

   }

   Return, 0
}