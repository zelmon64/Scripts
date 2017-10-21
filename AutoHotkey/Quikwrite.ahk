; Quikwriting modeled input with a joystick
;	v0.12
;
JoystickNumber = 0
;
;
;   0    2  3   1  0  3   1  2    0
;     a  s  k │ █  ◄  ▲ │ p  f  n
;   4 m       │         │       l 6
;   7 q     1 │    2    │ 3     x 9
;     ────────          ─────────
;   1 h                         u 3
;   0 e     4      5      6     t 0
;   7 c                         y 9
;     ────────          ─────────
;   1 v     7 │    8    │ 9     j 3
;   4 w       │         │       r 6
;     o  g  z │ ▼  ►  ● │ b  d  i
;   0    8  9   7  0  9   7  8    0
;
;
{ ; Quikwrite definitions
	all_characters := Object()
	all_characters_long := Object()
	ArrayIndex1 := 1
	ArrayIndex2 := 2
	ArrayIndex3 := 3
	ArrayIndex4 := 4
	ArrayIndex5 := 5

	{ ; abc
		mode_1_characters =  %A_Space%              ,,,,,,,,,
		mode_1_characters =  %mode_1_characters% a, a, s, k, m,,, q,,TAid1,
		mode_1_characters =  %mode_1_characters%BS,SL,BS,CL,,,,Sy,FL,Ca,
		mode_1_characters =  %mode_1_characters% n, p, f, n,,, l,TAid2,, x,
		mode_1_characters =  %mode_1_characters% e, h,,TAid3, e,,TAid5, c,,TAid7,
		mode_1_characters =  %mode_1_characters%,,,,,,,,,,
		mode_1_characters =  %mode_1_characters% t,TAid4,, u,TAid6,, t,TAid8,, y,
		mode_1_characters =  %mode_1_characters% o, v,,TAid9, w,,, o, g, z,
		mode_1_characters =  %mode_1_characters%Sp,Tb,Fn,No,,,,En,Sp,NL,
		mode_1_characters =  %mode_1_characters% i,TAid0,, j,,, r, b, d, i,
		StringSplit, all_characters%ArrayIndex1%, mode_1_characters, `,
	}
	{ ; ABC
		mode_2_characters =   %A_Space%             ,,,,,,,,,
		mode_2_characters =  %mode_2_characters% A, A, S, K, M,,, Q,,,
		mode_2_characters =  %mode_2_characters%BS,SL,BS,CL,,,,Sy,FL,Ca,
		mode_2_characters =  %mode_2_characters% N, P, F, N,,, L,,, X,
		mode_2_characters =  %mode_2_characters% E, H,,, E,,, C,,,
		mode_2_characters =  %mode_2_characters%,,,,,,,,,,
		mode_2_characters =  %mode_2_characters% T,,, U,,, T,,, Y,
		mode_2_characters =  %mode_2_characters% O, V,,, W,,, O, G, Z,
		mode_2_characters =  %mode_2_characters%Sp,Tb,Fn,No,,,,En,Sp,NL,
		mode_2_characters =  %mode_2_characters% I,,, J,,, R, B, D, I,
		StringSplit, all_characters%ArrayIndex2%, mode_2_characters, `,
	}
	{ ; Symbols
		mode_3_characters =    %A_Space%            ,,,,,,,,,
		mode_3_characters =  %mode_3_characters% @, @, {, }, ^,,,In,,,
		mode_3_characters =  %mode_3_characters%BS,SL,BS,CL,,,,Sy,FL,Ca,
		mode_3_characters =  %mode_3_characters% C, (, ), C,,, #,,, ~,
		mode_3_characters =  %mode_3_characters%%A_Space%;,%A_Space%*,,,%A_Space%;,,,%A_Space%:,,,
		mode_3_characters =  %mode_3_characters%,,,,,,,,,,
		mode_3_characters =  %mode_3_characters% ',,, ",,, ',,, ``,
		mode_3_characters =  %mode_3_characters% |,Ec,,, &,,, |, /, \,
		mode_3_characters =  %mode_3_characters%Sp,Tb,Fn,No,,,,En,Sp,NL,
		mode_3_characters =  %mode_3_characters% .,,, !,,, ?, _, -, .,
		StringSplit, all_characters%ArrayIndex3%, mode_3_characters, `,
		ArrayIndex := 30
		all_characters%ArrayIndex3%%ArrayIndex% := " ,"
		ArrayIndex := 33
		all_characters%ArrayIndex3%%ArrayIndex% := " ,"
	}
	{ ; Numbers
		mode_4_characters =  %A_Space%            ,,,,,,,,,
		mode_4_characters =  %mode_4_characters% 0, 0, <, >, 1,,, 2,,,
		mode_4_characters =  %mode_4_characters%BS,SL,BS,CL,,,,Sy,FL,Ca,
		mode_4_characters =  %mode_4_characters% C, [, ], C,,,%A_Space%;,,, :,
		mode_4_characters =  %mode_4_characters% 3, !,,, 3,,, 4,,,
		mode_4_characters =  %mode_4_characters%,,,,,,,,,,
		mode_4_characters =  %mode_4_characters% =,,, +,,, =,,, -,
		mode_4_characters =  %mode_4_characters% 5, /,,, *,,, 5, 6, 7,
		mode_4_characters =  %mode_4_characters%Sp,Tb,Fn,No,,,,En,Sp,NL,
		mode_4_characters =  %mode_4_characters% .,,, 9,,, 8, $, P, .,
		StringSplit, all_characters%ArrayIndex4%, mode_4_characters, `,
		ArrayIndex := 30
		all_characters%ArrayIndex4%%ArrayIndex% := " ,"
		ArrayIndex := 33
		all_characters%ArrayIndex4%%ArrayIndex% := " ,"
		ArrayIndex := 98
		all_characters%ArrayIndex4%%ArrayIndex% := " %"
	}
	{ ; Functions
		mode_5_characters =  %A_Space%            ,,,,,,,,,
		mode_5_characters =  %mode_5_characters%^s,^s,RC,UD,HF,,,DN,,,
		mode_5_characters =  %mode_5_characters%BS,SL,BS,CL,,,,Sy,FL,Ca,
		mode_5_characters =  %mode_5_characters%VM,V+,V-,VM,,,#x,,,F4,
		mode_5_characters =  %mode_5_characters%^f,F3,,,^f,,,F2,,,
		mode_5_characters =  %mode_5_characters%,,,,,,,,,,
		mode_5_characters =  %mode_5_characters%!c,,,!z,,,!c,,,!x,
		mode_5_characters =  %mode_5_characters%Sr,Z-,,,Z+,,,Sr,CT,CW,
		mode_5_characters =  %mode_5_characters%Sp,Tb,Fn,No,,,,En,Sp,NL,
		mode_5_characters =  %mode_5_characters%PS,,,F6,,,F5,11,12,PS,
		StringSplit, all_characters%ArrayIndex5%, mode_5_characters, `,

		StringReplace, mode_5_characters_long, mode_5_characters, F2 , {F2} , All
		StringReplace, mode_5_characters_long, mode_5_characters_long, F3 , {F3} , All
		StringReplace, mode_5_characters_long, mode_5_characters_long, F4 , !{F4} , All
		StringReplace, mode_5_characters_long, mode_5_characters_long, F5 , {F5} , All
		StringReplace, mode_5_characters_long, mode_5_characters_long, F6 , {F6} , All
		StringReplace, mode_5_characters_long, mode_5_characters_long, 11 , {F11} , All
		StringReplace, mode_5_characters_long, mode_5_characters_long, 12 , {F12} , All
		StringReplace, mode_5_characters_long, mode_5_characters_long, Hm , {Home} , All
		StringReplace, mode_5_characters_long, mode_5_characters_long, Ed , {End} , All
		StringReplace, mode_5_characters_long, mode_5_characters_long, PU , {PgUp} , All
		StringReplace, mode_5_characters_long, mode_5_characters_long, PD , {PgDn} , All
		StringReplace, mode_5_characters_long, mode_5_characters_long, PS , {PrintScreen} , All
		StringReplace, mode_5_characters_long, mode_5_characters_long, VM , {Volume_Mute} , All
		StringReplace, mode_5_characters_long, mode_5_characters_long, V+ , {Volume_Up 5} , All
		StringReplace, mode_5_characters_long, mode_5_characters_long, V- , {Volume_Down 5} , All
		;StringReplace, mode_5_characters_long, mode_5_characters_long, Sr , !{Space} , All
		StringReplace, mode_5_characters_long, mode_5_characters_long, Sr , #{Tab} , All
		StringReplace, mode_5_characters_long, mode_5_characters_long, CW , {Alt DownTemp}{Tab} , All
		StringReplace, mode_5_characters_long, mode_5_characters_long, CT , {Control DownTemp}{Tab} , All
		StringReplace, mode_5_characters_long, mode_5_characters_long, Z+ , ^{=} , All
		StringReplace, mode_5_characters_long, mode_5_characters_long, Z- , ^{-} , All
		;StringReplace, mode_5_characters_long, mode_5_characters_long, TM , ^+{Escape} , All
		StringSplit, all_characters_long%ArrayIndex5%, mode_5_characters_long, `,
	}
}
;
;
; From "Joystick Test Script"
; If you want to unconditionally use a specific joystick number, change
; the following value from 0 to the number of the joystick (1-16).
; A value of 0 causes the joystick number to be auto-detected:
;JoystickNumber = 0

; END OF CONFIG SECTION. Do not make changes below this point unless
; you wish to alter the basic functionality of the script.

;Menu, tray, Icon, %A_ScriptDir%\wheel.ico, ,1
{
	 If A_IsCompiled
   {
      Menu, tray, Icon, %A_ScriptFullPath%,1,1
   } else
   {
      Menu, tray, Icon, %A_ScriptDir%\wheel.ico, ,1
   }
 }

; Auto-detect the joystick number if called for:
if JoystickNumber <= 0
{
	Loop  ; Query each joystick number to find out which ones exist.
	{
		Loop 16  ; Query each joystick number to find out which ones exist.
		{
			GetKeyState, JoyName, %A_Index%JoyName
			if JoyName <>
			{
				GetKeyState, joy_info, %A_Index%JoyInfo
				IfInString, joy_info, Z
				{
					JoystickNumber = %A_Index%
					break
				}
			}
		}
		if JoystickNumber <= 0
		{
			; MsgBox The system does not appear to have any joysticks.
			; ExitApp
			Sleep, 15000
			Reload
		}
		Else
		{
			SoundBeep, 500, 100
			SoundBeep, 700, 100
			SoundBeep, 900, 200
			break
		}
	}
}
Else
{
	Loop  ; Query each joystick number to find out which ones exist.
	{
		GetKeyState, JoyName, %JoystickNumber%JoyName
		if JoyName <>
		{
			GetKeyState, joy_info, %A_Index%JoyInfo
			IfInString, joy_info, Z
			{
				SoundBeep, 500, 100
				SoundBeep, 700, 100
				SoundBeep, 900, 200
				break
			}
		}
		Sleep, 10000
		Reload
	}
}

{ ; Variables
	character_code = 0
	character_code_pre = 0
	button_click_pre := -1 ;95 ;
	mouse_click_pre := 0
	loop_count := 0
	loop_count_repeat_base := 30 ;10
	loop_count_skip_base := 2 ;3
	;loop_count_repeat := 10
	;loop_count_skip := 3
	;HUD_loop_count := 0
	;HUD_loop_count_repeat := 10
	HUD_loop_count_skip := 12 ;10 ;3
	HUD_loop_count_delay := 80 ;30
	HUD_loop_count := -HUD_loop_count_delay
	this_code = 0
	stick_mode := 0 ;3 ; 1
	stick_centre := 1
	character_mode = 1
	ch_mode := 1
	amoffsetx := 0
	amoffsety := 0
	media_mode := 4
	dasher_mode := 0
	double_tap := 1
	audio_feedback := 1
	hold_pose := 0
	loop_count_max := 15
	rmin := 1
	rmax := 45
	joy_mode := 0
	joyx_pre := 0
	joyy_pre := 0
	joyx_0 := 0
	joyy_0 := 0
	radius_pre := 0
	rotate := 0
	recentre := 1
	daynight := 1
	Rumble_Mode := 1 ; 0 ;
}

character_mode_lists = Lowercase,Capitals,Symbols,Numbers,Functions
StringSplit, character_mode_list, character_mode_lists, `,

New_Code(character_code, this_code)
{
  If (character_code = 0)
  {
    Return this_code * 10
  }
  Else If (character_code = this_code * 10)
  {
	  Return character_code
  }
  Else If (Mod(character_code, 10) = 0)
  {
    Return character_code + this_code
  }
  Else If (Mod(character_code, 10) <> this_code)
  {
    Return (character_code // 10) * 10 + this_code
  }
  Return character_code
}

#SingleInstance
SetFormat, float, 03.3  ; Omit decimal point from axis position percentages. (03)
GetKeyState, joy_buttons, %JoystickNumber%JoyButtons
GetKeyState, joy_name, %JoystickNumber%JoyName
GetKeyState, joy_info, %JoystickNumber%JoyInfo
#Include XInput.ahk
