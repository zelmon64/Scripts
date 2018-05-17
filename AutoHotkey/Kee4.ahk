; Kee4 modeled input with a numpad
;	v1.0
;﻿#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Menu, tray, Icon, %A_ScriptDir%\Kee4_2.ico, ,1

{ ; Kee4 definitions
	all_characters := Object()
	all_characters_long := Object()
	ArrayIndex1 := 1
	ArrayIndex2 := 2
	ArrayIndex3 := 3
	ArrayIndex4 := 4
	ArrayIndex5 := 5
	character_mode_lists = Lowercase,Capitals,Numbers,Mode Select,Navigation
	StringSplit, character_mode_list, character_mode_lists, `,

	{ ; abc
		mode_1_characters =  %A_Space%,,,,,,,,,
		mode_1_characters =  %mode_1_characters%Spc,Spc, l , i , w ,   ,Spc, n , p , j ,
		mode_1_characters =  %mode_1_characters% a , o , a , h , c ,   , m , a , f , g ,
		mode_1_characters =  %mode_1_characters% e , y , t , e , v ,   , r , s , e , x ,
		mode_1_characters =  %mode_1_characters%MdS, u , d , q ,MdS,   , b , k , z ,MdS,
		StringSplit, all_characters%ArrayIndex1%, mode_1_characters, `,
	}
	{ ; ABC
		mode_2_characters =   %A_Space%,,,,,,,,,
		mode_2_characters =  %mode_2_characters%Spc,Spc, L , I , W ,   ,Spc, N , P , J ,
		mode_2_characters =  %mode_2_characters% A , O , A , H , C ,   , M , A , F , G ,
		mode_2_characters =  %mode_2_characters% E , Y , T , E , V ,   , R , S , E , X ,
		mode_2_characters =  %mode_2_characters%MdS, U , D , Q ,MdS,   , B , K , Z ,MdS,
		StringSplit, all_characters%ArrayIndex2%, mode_2_characters, `,
	}
	{ ; Numbers
		mode_3_characters =   %A_Space%,,,,,,,,,
		mode_3_characters =  %mode_3_characters% = , = , 1 , 3 , 9 ,   , = , * , \ , - ,
		mode_3_characters =  %mode_3_characters%Comma, 2 ,Comma, 5 , 7 ,   , + ,Comma,%A_Space%; , & ,
		mode_3_characters =  %mode_3_characters% . , 4 , 6 , . , ^ ,   , / , : , . , # ,
		mode_3_characters =  %mode_3_characters%MdS, 0 , 8 , @ ,MdS,   , `% , | , $ ,MdS,
		StringSplit, all_characters%ArrayIndex3%, mode_3_characters, `,
		ArrayIndex := 20
		all_characters%ArrayIndex3%%ArrayIndex% := " , "
		ArrayIndex += 2
		all_characters%ArrayIndex3%%ArrayIndex% := " , "
		ArrayIndex += 5
		all_characters%ArrayIndex3%%ArrayIndex% := " , "
	}
	{ ; Symbols / Mode Select
		mode_4_characters =   %A_Space%,,,,,,,,,
		mode_4_characters =  %mode_4_characters%CaL,CaL,Tab,cRi,End,   ,CaL, : , ? ,UDo,
		mode_4_characters =  %mode_4_characters%NuL,Ent,NuL,Del,cDe,   , %Space%; ,Nul, Comma,RDo,
		mode_4_characters =  %mode_4_characters%MdS,cLe,BkS,MdS,cEd,   , ! , . ,MdS, ( ,
		mode_4_characters =  %mode_4_characters%Nav,Hom,cBS,cHo,Nav,   , ' , " , ) ,Nav,
		StringSplit, all_characters%ArrayIndex4%, mode_4_characters, `,
		ArrayIndex := 28
		all_characters%ArrayIndex4%%ArrayIndex% := " , "
	}
	{ ; Navigation
		mode_5_characters =  %A_Space%,,,,,,,,,
		mode_5_characters =  %mode_5_characters%Lft,Lft,Tab,cRt,End,   ,Lft,PRE,   , < ,
		mode_5_characters =  %mode_5_characters%Dwn,Ent,Dwn,Del,cDe,   ,Esc,Dwn, _ , [ ,
		mode_5_characters =  %mode_5_characters% Up,cLt,BkS, Up,cEd,   ,   , ~ , Up, { ,
		mode_5_characters =  %mode_5_characters%Rit,Hom,cBS,cHo,Rit,   , > , ] , } ,Rit,
		StringSplit, all_characters%ArrayIndex5%, mode_5_characters, `,
	}
}

SENDCOMMAND(ThisCommand := "")
{
	global mode
	global ch_mode
	global modePRE
	if (ThisCommand = "MdS") {
		if (mode = 4) {
			mode := modePRE
		}
		else if (mode = 44) {
			mode := 4
		}
		else {
			mode := 44
		}
	} else if (ThisCommand = "CaL") {
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
	} else if (ThisCommand = "NuL") {
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
		if (mode = 5 || modePRE = 5) {
			mode := 1
			modePRE := mode
		}
		else if (mode = 55) {
			mode := 5
		}
		else {
			mode := 55
		}
	} else if (ThisCommand = "PRE") {
		mode := modePRE
	} else
	{
		if (ThisCommand = "Spc") {
			SendInput, {Space}
			;lastSent := "Space"
			;Send, {%lastSent%}
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
		} else if (ThisCommand = "Rit") {
			SendInput, {Right}
		} else if (ThisCommand = "Lft") {
			SendInput, {Left}
		} else if (ThisCommand = "Up") {
			SendInput, {Up}
		} else if (ThisCommand = "Dwn") {
			SendInput, {Down}
		} else if (ThisCommand = "cRt") {
			SendInput, ^{Right}
		} else if (ThisCommand = "cLt") {
			SendInput, ^{Left}
		} else if (ThisCommand = "cUp") {
			SendInput, ^{Up}
		} else if (ThisCommand = "cDn") {
			SendInput, ^{Down}
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
		} else if (ThisCommand = "UDo") {
			SendInput, ^{z}
		} else if (ThisCommand = "RDo") {
			SendInput, ^{y}
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

HUD(ByRef SubTextT, ByRef SubTextB, index := 1, ch_mode := 1)
{
	global all_characters
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
		option5 := % all_characters%ch_mode%%option_index%
		option_index++
		option6 := % all_characters%ch_mode%%option_index%
		option_index++
		option7 := % all_characters%ch_mode%%option_index%
		option_index++
		option8 := % all_characters%ch_mode%%option_index%
		SubTextT = %SubTextT%| %option1% %option2% %option3% %option4% |
		SubTextB = %SubTextB%| %option5% %option6% %option7% %option8% |
	}
}

{ ; Variables
	firstKeyDown :=
	secondKeyDown :=
	firstKeyUp :=
	keysAreActive := 0
	keysWereActive := 0
	mode := 1
	ch_mode := mod(mode, 10)
	modePRE := mode
	lastSent :=
	Horizontal := 1
	daynight := 0
}

Numpad0::
Numpad1::
Numpad2::
Numpad3::
Numpad4::
Numpad7::
NumpadEnter::
	;ToolTip, %A_PriorHotkey% %A_ThisHotkey% %A_TimeSincePriorHotkey% %keysAreActive% %lastSent%
	;ToolTip, %keysAreActive%
	if (keysAreActive = 0 && InStr(A_PriorHotkey, A_ThisHotkey) <> 0 && A_TimeSincePriorHotkey > 0 && (A_TimeSincePriorHotkey < 200 || keysWereActive = -1)) {
		SENDCOMMAND(lastSent)
		keysWereActive := -1
	}
	else if (keysWereActive = 0) {
		{ ; Rebind
		  if (A_ThisHotkey = "Numpad0") {
		    B_ThisHotkey := "Numpad4"
		  }
		  else if (A_ThisHotkey = "Numpad1" && Horizontal) {
		    B_ThisHotkey := "Numpad3"
		  }
		  else if (A_ThisHotkey = "Numpad4" && Horizontal) {
		    B_ThisHotkey := "Numpad2"
		  }
		  else if (A_ThisHotkey = "Numpad7") {
		    B_ThisHotkey := "Numpad1"
		  }
		  else if (A_ThisHotkey = "NumpadEnter") {
		    B_ThisHotkey := "Numpad4"
		  }
		  else {
		    B_ThisHotkey := A_ThisHotkey
		  }
		}
	  if (keysAreActive = 0) {
	    firstKeyDown := B_ThisHotkey
	    keysAreActive++
			{ ; HUD
					SubTextT := ""
					SubTextB := ""
					HUD(SubTextT, SubTextB, SubStr(B_ThisHotkey, 7, 1), ch_mode)
					SubText = %A_Space%
											|+-----------------+|`n
											|%SubTextT%|`n
											||                 ||`n
											|%SubTextB%|`n
											|+-----------------+|

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
					, %A_Space%%SubText% , % mode_title, HUDbackground1, Courier New
			}
	  }
	  else if (keysAreActive = 1 && B_ThisHotkey <> firstKeyDown) {
	    secondKeyDown := B_ThisHotkey
	    keysAreActive++
	  }
	  else if (keysAreActive = 2 && B_ThisHotkey <> firstKeyDown && B_ThisHotkey <> secondKeyDown)
	  {
	    thirdKeyDown := B_ThisHotkey
	    keysAreActive++
			Progress, 1:Off
			{ ; HUD
				SubTextT := ""
				SubTextB := ""
				Loop, 4
				{
					HUD(SubTextT, SubTextB, A_Index, ch_mode)
				}
				SubText = %A_Space%
										|+-----------------++-----------------++-----------------++-----------------+|`n
										|%SubTextT%|`n
										||                 ||                 ||                 ||                 ||`n
										|%SubTextB%|`n
										|+-----------------++-----------------++-----------------++-----------------+|

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
					, %A_Space%%SubText% , % mode_title, HUDbackground1, Courier New
			}
	    ToolTip,
	  }
	  else if (keysAreActive = 3 && B_ThisHotkey <> firstKeyDown && B_ThisHotkey <> secondKeyDown && B_ThisHotkey <> thirdKeyDown)
	  {
	    mode := 1
			ch_mode := mod(mode, 10)
			modePRE := 1
	    keysAreActive++
			Progress, 1:Off
			{ ; HUD
				SubText := ""
				Loop, 4
				{
					thisMode := A_Index + 1
					SubTextT := ""
					SubTextB := ""
					Loop, 4
					{
						HUD(SubTextT, SubTextB, A_Index, thisMode)
					}
					mode_title := % character_mode_list%thisMode%
					mode_title = %A_Space%%mode_title%`n
					SubText = %SubText% %mode_title%
											|+-----------------++-----------------++-----------------++-----------------+|`n
											|%SubTextT%|`n
											||                 ||                 ||                 ||                 ||`n
											|%SubTextB%|`n
											|+-----------------++-----------------++-----------------++-----------------+|`n


				}
				If (daynight)
					colour_text := "00FF00" ; Red FF0000 ; Green 008000 ; Lime 00FF00
				Else
					colour_text := "FF0000" ; Red FF0000 ; Green 008000 ; Lime 00FF00
				weight_text := 400
				Progress, 1:b zh0 fm32 fs28 w1800 ct%colour_text% cwBlack
					, %A_Space%%SubText% , Kee4, HUDbackground1, Courier New
			}
	  }
	}
return

Numpad0 Up::
Numpad1 Up::
Numpad2 Up::
Numpad3 Up::
Numpad4 Up::
Numpad7 Up::
NumpadEnter Up::
	{ ; Rebind
		if (A_ThisHotkey = "Numpad0 Up")
		{
	    B_ThisHotkey := "Numpad4 Up"
	  }
	  else if (A_ThisHotkey = "Numpad1 Up" && Horizontal)
		{
	    B_ThisHotkey := "Numpad3 Up"
	  }
	  else if (A_ThisHotkey = "Numpad4 Up" && Horizontal)
		{
	    B_ThisHotkey := "Numpad2 Up"
	  }
	  else if (A_ThisHotkey = "Numpad7 Up")
		{
	    B_ThisHotkey := "Numpad1 Up"
	  }
	  else if (A_ThisHotkey = "NumpadEnter Up")
		{
	    B_ThisHotkey := "Numpad4 Up"
	  }
	  else
		{
	    B_ThisHotkey := A_ThisHotkey
	  }
	}
  if (keysAreActive = 1)
  {
    character_code := SubStr(firstKeyDown, 7, 1) * 10
    if (keysWereActive = 0)
    {
      ;ToolTip, %firstKeyDown% %B_ThisHotkey%: `n%character_code%
    }
    else if (keysWereActive = 1)
    {
      if (SubStr(firstKeyDown, 7, 1) <> SubStr(B_ThisHotkey, 7, 1)) {
        character_code += SubStr(secondKeyDown, 7, 1)
      }
      else {
        character_code += SubStr(secondKeyDown, 7, 1) + 5
      }

      ;ToolTip, %firstKeyDown% %secondKeyDown% %firstKeyUp% %B_ThisHotkey%: `n%character_code%
    }
		lastSent := % all_characters%ch_mode%%character_code%
		SENDCOMMAND(lastSent)

		Progress, 1:Off
		firstKeyDown :=
		secondKeyDown :=
		firstKeyUp :=
		keysAreActive := 0
		keysWereActive := 0
  }
  else if (keysAreActive = 2)
  {
    firstKeyUp := B_ThisHotkey
    keysWereActive++
    keysAreActive--
  }
  else if (keysAreActive > 2)
  {
    firstKeyDown :=
    secondKeyDown :=
    thirdKeyDown :=
    firstKeyUp :=
    keysAreActive := 0
    keysWereActive := 0
		Progress, 1:Off
    ;ToolTip,
  }
	else if (keysWereActive = -1)
	{
		keysWereActive := 0
	}
return