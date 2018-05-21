; Kee4 modeled input with a numpad
;	v1.2
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Menu, tray, Icon, %A_ScriptDir%\Kee4_2.ico, ,1

{ ; Variables
	firstKeyDown :=
	secondKeyDown :=
	thirdKeyDown :=
	fourthKeyDown :=
	firstKeyUp :=
	secondKeyUp :=
	thirdKeyUp :=
	fourthKeyUp :=
	keysAreActive := 0
	keysWereActive := 0
	mode := 1
	ch_mode := mod(mode, 10)
	modePRE := mode
	lastSent :=
	lastKeyRepeat := 1
	Horizontal := 1
	daynight := 1 ; 0
	;LeftHanded := 1 ; 0 ;
	CableUp :=  0 ;1 ;
}

{ ; Kee4 definitions
	all_characters := Object()
	all_characters_long := Object()
	ArrayIndex := 1
	character_mode_lists = Lowercase,Capitals,Numbers,Mode Select,Navigation,Functions
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
		mode_characters =  %mode_characters% . , . , 1 , 3 , 9 ,   , . , * , \ , - ,
		mode_characters =  %mode_characters% = , 2 , = , 5 , 7 ,   , + , = , `` , & ,
		mode_characters =  %mode_characters% @ , 4 , 6 , @ , ^ ,   , / , ~ , @ , # ,
		mode_characters =  %mode_characters%Mod, 0 , 8 , _ ,Mod,   , `% , | , $ ,Mod,
		ArrayIndex++
		StringSplit, all_characters%ArrayIndex%, mode_characters, `,
	}
	{ ; Symbols / Mode Select
		mode_characters =   %A_Space%,,,,,,,,,
		mode_characters =  %mode_characters%Cap,Cap,Tab, . , Comma,   ,Cap,sTb, : ,%A_Space%; ,
		mode_characters =  %mode_characters%Num,Ent,Num,Del, [ ,   ,sEn,Num,ReD, < ,
		mode_characters =  %mode_characters%Fnc, ? ,BkS,Fnc, ( ,   , ! ,UnD,Fnc, { ,
		mode_characters =  %mode_characters%Nav, ' , ] , ) ,Nav,   , " , > , } ,Nav,
		ArrayIndex++
		StringSplit, all_characters%ArrayIndex%, mode_characters, `,
		all_characters%ArrayIndex%14 := " , "
	}
	{ ; Navigation
		mode_characters =  %A_Space%,,,,,,,,,
		mode_characters =  %mode_characters% Up, Up,Mod,cRi,End,   , Up,PRE,csR,cEd,
		mode_characters =  %mode_characters%Lft,Ent,Lft,Del,Cut,   ,sUD,Lft,cDe,SAl,
		mode_characters =  %mode_characters%Rit,Pst,BkS,Rit,Cpy,   ,sPs,cBS,Rit,sCp,
		mode_characters =  %mode_characters%Dwn,Hom,cLf,Ins,Dwn,   ,cHo,csL,Esc,Dwn,
		ArrayIndex++
		StringSplit, all_characters%ArrayIndex%, mode_characters, `,
	}
	{ ; Functions
		mode_characters =  %A_Space%,,,,,,,,,
		mode_characters =  %mode_characters%Pau,Pau,Nxt,Fnd,Mnu,   ,Pau,Esc,Rpl,Sav,
		mode_characters =  %mode_characters%VUp,Prv,VUp,ChW,Zm+,   ,gFS,VUp,ClW,TAp,
		mode_characters =  %mode_characters%VDn, F3,ChT,VDn,ARe,   ,sF3,ClT,VDn,FuS,
		mode_characters =  %mode_characters%Mod,PrS,Zm-,TAs,Mod,   ,aPS,TUD,TAc,Mod,
		ArrayIndex++
		StringSplit, all_characters%ArrayIndex%, mode_characters, `,
	}
}

SENDCOMMAND(ThisCommand := "")
{
	global mode
	global ch_mode
	global modePRE
	global LeftHanded
	global CableUp
	global lastKeyRepeat
	if (ThisCommand = "Mod") {
		if (mode = 4) {
			mode := 1
			mode := modePRE
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
			mode := 1
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
			mode := 1
			modePRE := mode
		}
		else if (mode = 33) {
			mode := 3
			modePRE := mode
		}
		else {
			mode := 33
		}
	} else if (ThisCommand = "Nav") {
		if (mode = 55 || modePRE = 5) {
			mode := 1
			modePRE := mode
		}
		else if (mode = 5) {
			mode := 55
		}
		else {
			mode := 5
		}
	} else if (ThisCommand = "Fnc") {
		if (mode = 6 || modePRE = 6) {
			mode := 1
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
		mode := modePRE
	} else
	{
		if (ThisCommand = "SHa") {
			LeftHanded := !LeftHanded
		} else if (ThisCommand = "TUD") {
			CableUp := !CableUp
		} else if (ThisCommand = "ARe") {
			lastKeyRepeat := !lastKeyRepeat
		} else if (ThisCommand = "Spc") {
			SendInput, {Space}
		} else if (ThisCommand = "BkS") {
			SendInput, {BackSpace}
		} else if (ThisCommand = "cBS") {
			SendInput, ^{BackSpace}
		} else if (ThisCommand = "Del") {
			SendInput, {Delete}
		} else if (ThisCommand = "cDe") {
			SendInput, ^{Delete}
		} else if (ThisCommand = "Ent") {
			SendInput, {Enter}
		} else if (ThisCommand = "Tab") {
			SendInput, {Tab}
		} else if (ThisCommand = "sEn") {
			SendInput, +{Enter}
		} else if (ThisCommand = "sTb") {
			SendInput, +{Tab}
		} else if (ThisCommand = "Rit") {
			SendInput, {Right}
		} else if (ThisCommand = "Lft") {
			SendInput, {Left}
		} else if (ThisCommand = "Up") {
			SendInput, {Up}
		} else if (ThisCommand = "Dwn") {
			SendInput, {Down}
		} else if (ThisCommand = "cRi") {
			SendInput, ^{Right}
		} else if (ThisCommand = "cLf") {
			SendInput, ^{Left}
		} else if (ThisCommand = "cUp") {
			SendInput, ^{Up}
		} else if (ThisCommand = "cDn") {
			SendInput, ^{Down}
		} else if (ThisCommand = "csR") {
			SendInput, ^+{Right}
		} else if (ThisCommand = "csL") {
			SendInput, ^+{Left}
		} else if (ThisCommand = "Hom") {
			SendInput, {Home}
		} else if (ThisCommand = "End") {
			SendInput, {End}
		} else if (ThisCommand = "cHo") {
			SendInput, ^{Home}
		} else if (ThisCommand = "cEd") {
			SendInput, ^{End}
		} else if (ThisCommand = "Esc") {
			SendInput, {Escape}
		} else if (ThisCommand = "Ins") {
			SendInput, {Insert}
		} else if (ThisCommand = "UnD") {
			SendInput, ^{z}
		} else if (ThisCommand = "sUD") {
			SendInput, ^+{z}
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
		} else if (ThisCommand = "F3") {
			SendInput, {F3}
		} else if (ThisCommand = "sF3") {
			SendInput, +{F3}
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
		} else if (ThisCommand = "FuS") {
			SendInput, {F11}
		} else if (ThisCommand = "gFS") {
			SendInput, !{Enter}
		} else if (ThisCommand = "PrS") {
			SendInput, {PrintScreen}
		} else if (ThisCommand = "aPS") {
			SendInput, !{PrintScreen}
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
		} else if (ThisCommand = "TAs") {
			SendInput, !{c}
		} else if (ThisCommand = "TAp") {
			SendInput, !{z}
		} else if (ThisCommand = "TAc") {
			SendInput, !{x}
		} else if (ThisCommand <> "") {
			;SendRaw, % SubStr(all_characters%ch_mode%%character_code%, 2, 1)
			;lastSent := SubStr(ThisCommand, 2, 1)
			Send, {%ThisCommand%}
		} else {
			mode := 1
		}
		if (mode > 10) {
			mode := modePRE
		}
	}
	ch_mode := mod(mode, 10)
}

HUD(ByRef SubTextT, ByRef SubTextB, index := 1, ch_mode := 1, ByRef SubTextI := "", ByRef SubTextO := "", isLeftHand := 1)
{
	global all_characters
	;global LeftHanded
	LeftHanded := isLeftHand
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
	global mode
	global ch_mode
	global daynight
	global lastKeyRepeat
	global lastSent
	global CableUp
	if (thisKey <> firstKeyDown && thisKey <> secondKeyDown && thisKey <> thirdKeyDown && thisKey <> fourthKeyDown)
	{
		if firstKeyDown =
		{
			firstKeyDown := thisKey
			keysAreActive++
			{ ; HUD
					SubTextT := ""
					SubTextB := ""
					SubTextI := ""
					SubTextO := ""
					HUD(SubTextT, SubTextB, SubStr(thisKey, 7, 1), ch_mode, SubTextI, SubTextO, isLeftHand)
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
				WinSet, Transparent, 100, HUD
				WinSet, TransColor, 000000, HUD
			}
		} else if secondKeyDown =
		{
			secondKeyDown := thisKey
			keysAreActive++
		} else if thirdKeyDown =
		{
			thirdKeyDown := thisKey
			keysAreActive++
			Progress, 1:Off
			{ ; HUD
				SubTextT := ""
				SubTextB := ""
				SubTextI := ""
				SubTextO := ""
				Loop, 4
				{
					if (isLeftHand) {
						HUD(SubTextT, SubTextB, 5-A_Index, ch_mode, SubTextI, SubTextO, isLeftHand)
					} else  {
						HUD(SubTextT, SubTextB, A_Index, ch_mode, SubTextI, SubTextO, isLeftHand)
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
			ToolTip,
		} else if fourthKeyDown =
		{
			mode := 1
			ch_mode := mod(mode, 10)
			modePRE := 1
			fourthKeyDown := thisKey
			keysAreActive++
			Progress, 1:Off
			{ ; HUD
				SubText := ""
				Loop, 5
				{
					thisMode := A_Index + 1
					SubTextT := ""
					SubTextB := ""
					SubTextI := ""
					SubTextO := ""
					Loop, 4
					{
						if (isLeftHand) {
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
				if (isLeftHand)
					Kee4Title = Left-Hand %Kee4Title%
				else
					Kee4Title = Right-Hand %Kee4Title%
				if (lastKeyRepeat)
					Kee4Title = %Kee4Title%, last key repeat ON
				else
					Kee4Title = %Kee4Title%, last key repeat OFF
				if (CableUp)
					Kee4Title = %Kee4Title%, cable UP
				else
					Kee4Title = %Kee4Title%, cable DOWN
					weight_text := 400
				Progress, 1:b zh0 fm32 fs21 w1400 ct%colour_text% cwBlack
					, %A_Space%%SubText% , %Kee4Title%, HUD, Courier New
			}
			{ ; Release any held keys
				KeyList := "Shift|Control|Alt|LWin|RWin|LControl|RControl|LShift|RShift|LAlt|RAlt"
				Loop, Parse, KeyList, |
				{
						If GetKeystate(A_Loopfield, "P")
								Send % "{" A_Loopfield " Up}"
				}
			}
		}
	}
	{
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
}

KEYUP(thisKey)
{
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
	global mode
	global ch_mode
	global lastSent
	if (keysWereActive >= 0 && thisKey <> firstKeyUp && thisKey <> secondKeyUp && thisKey <> thirdKeyUp)
	{
		; ToolTip, %thisKey% %keysAreActive%`n%firstKeyUp% %secondKeyUp% %thirdKeyUp%
		if (keysAreActive = 1)
		{
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
				SENDCOMMAND(lastSent)
			}
			Progress, 1:Off
	    ToolTip,
			firstKeyDown :=
			secondKeyDown :=
	    thirdKeyDown :=
			fourthKeyDown :=
			firstKeyUp :=
			secondKeyUp :=
			thirdKeyUp :=
			fourthKeyUp :=
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
	else if (keysWereActive = -1)
	{
		keysWereActive := 0
	}
}

Numpad2::
Numpad5::
Numpad8::
NumpadDiv::
	;ToolTip, %A_PriorHotkey% %A_ThisHotkey% %A_TimeSincePriorHotkey% %keysAreActive% %lastSent%
	;ToolTip, %keysAreActive%
	if (lastKeyRepeat && keysAreActive = 0 && InStr(A_PriorHotkey, A_ThisHotkey) <> 0 && A_TimeSincePriorHotkey > 0 && (A_TimeSincePriorHotkey < 130 || keysWereActive = -1)) {
		SENDCOMMAND(lastSent)
		keysWereActive := -1
	} else if (keysWereActive >= 0) {
		{ ; Rebind
			{
				if (!CableUp)
				{
					isLeftHand := 0
					if (A_ThisHotkey = "Numpad2") {
				    B_ThisHotkey := "Numpad1"
				  } else if (A_ThisHotkey = "Numpad5") {
				    B_ThisHotkey := "Numpad2"
				  } else if (A_ThisHotkey = "Numpad8") {
				    B_ThisHotkey := "Numpad3"
				  } else if (A_ThisHotkey = "NumpadDiv") {
				    B_ThisHotkey := "Numpad4"
					}
				}
				else
				{
					isLeftHand := 1
					if (A_ThisHotkey = "Numpad2") {
				    B_ThisHotkey := "Numpad4"
				  } else if (A_ThisHotkey = "Numpad5") {
				    B_ThisHotkey := "Numpad3"
				  } else if (A_ThisHotkey = "Numpad8") {
				    B_ThisHotkey := "Numpad2"
				  } else if (A_ThisHotkey = "NumpadDiv") {
				    B_ThisHotkey := "Numpad1"
					}
				}
			}
		}
		KEYDOWN(B_ThisHotkey, isLeftHand)
	}
return

Numpad3::
Numpad6::
Numpad9::
NumpadMult::
	;ToolTip, %A_PriorHotkey% %A_ThisHotkey% %A_TimeSincePriorHotkey% %keysAreActive% %lastSent%
	;ToolTip, %keysAreActive%
	if (lastKeyRepeat && keysAreActive = 0 && InStr(A_PriorHotkey, A_ThisHotkey) <> 0 && A_TimeSincePriorHotkey > 0 && (A_TimeSincePriorHotkey < 130 || keysWereActive = -1)) {
		SENDCOMMAND(lastSent)
		keysWereActive := -1
	} else if (keysWereActive >= 0) {
		{ ; Rebind
			{
				if (CableUp)
				{
					isLeftHand := 0
					if (A_ThisHotkey = "NumpadMult") {
				    B_ThisHotkey := "Numpad1"
				  } else if (A_ThisHotkey = "Numpad9") {
				    B_ThisHotkey := "Numpad2"
				  } else if (A_ThisHotkey = "Numpad6") {
				    B_ThisHotkey := "Numpad3"
				  } else if (A_ThisHotkey = "Numpad3") {
				    B_ThisHotkey := "Numpad4"
					}
				}
				else
				{
					isLeftHand := 1
					if (A_ThisHotkey = "NumpadMult") {
				    B_ThisHotkey := "Numpad4"
				  } else if (A_ThisHotkey = "Numpad9") {
				    B_ThisHotkey := "Numpad3"
				  } else if (A_ThisHotkey = "Numpad6") {
				    B_ThisHotkey := "Numpad2"
				  } else if (A_ThisHotkey = "Numpad3") {
				    B_ThisHotkey := "Numpad1"
					}
				}
			}
		}
		KEYDOWN(B_ThisHotkey, isLeftHand)
	}
return

Numpad2 Up::
Numpad3 Up::
Numpad5 Up::
Numpad6 Up::
Numpad8 Up::
Numpad9 Up::
NumpadMult Up::
NumpadDiv Up::
	{ ; Rebind
		{
			if (CableUp)
			{
				if (A_ThisHotkey = "NumpadMult Up" || A_ThisHotkey = "NumpadDiv Up") {
					B_ThisHotkey := "Numpad1 Up"
				} else if (A_ThisHotkey = "Numpad9 Up" || A_ThisHotkey = "Numpad8 Up") {
					B_ThisHotkey := "Numpad2 Up"
				} else if (A_ThisHotkey = "Numpad6 Up" || A_ThisHotkey = "Numpad5 Up") {
					B_ThisHotkey := "Numpad3 Up"
				} else if (A_ThisHotkey = "Numpad3 Up" || A_ThisHotkey = "Numpad2 Up") {
					B_ThisHotkey := "Numpad4 Up"
				}
			}
			else
			{
				if (A_ThisHotkey = "NumpadMult Up" || A_ThisHotkey = "NumpadDiv Up") {
					B_ThisHotkey := "Numpad4 Up"
				} else if (A_ThisHotkey = "Numpad9 Up" || A_ThisHotkey = "Numpad8 Up") {
					B_ThisHotkey := "Numpad3 Up"
				} else if (A_ThisHotkey = "Numpad6 Up" || A_ThisHotkey = "Numpad5 Up") {
					B_ThisHotkey := "Numpad2 Up"
				} else if (A_ThisHotkey = "Numpad3 Up" || A_ThisHotkey = "Numpad2 Up") {
					B_ThisHotkey := "Numpad1 Up"
				}
			}
		}
	}
	KEYUP(B_ThisHotkey)
return