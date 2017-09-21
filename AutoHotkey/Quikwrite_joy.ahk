; Quikwriting modeled input with a joystick
;	v0.12
;
JoystickNumber = 0
;
;   █▲►▼◄●
;   ─│┌┐└┘├┤┬┴┼
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
		mode_3_characters =  %mode_3_characters% ~, ~, {, }, @,,,In,,,
		mode_3_characters =  %mode_3_characters%BS,SL,BS,CL,,,,Sy,FL,Ca,
		mode_3_characters =  %mode_3_characters% C, (, ), C,,, [,,, ],
		mode_3_characters =  %mode_3_characters%%A_Space%;,%A_Space%#,,,%A_Space%;,,,%A_Space%:,,,
		mode_3_characters =  %mode_3_characters%,,,,,,,,,,
		mode_3_characters =  %mode_3_characters% ',,, ",,, ',,, ``,
		mode_3_characters =  %mode_3_characters% |,Ec,,, ^,,, |, /, \,
		mode_3_characters =  %mode_3_characters%Sp,Tb,Fn,No,,,,En,Sp,NL,
		mode_3_characters =  %mode_3_characters% .,,, !,,, ?, _, &, .,
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
		mode_4_characters =  %mode_4_characters% C, (, ), C,,, [,,, ],
		mode_4_characters =  %mode_4_characters% 3, #,,, 3,,, 4,,,
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
		mode_5_characters =  %mode_5_characters%^s,^s,Hm,Ed,PU,,,PD,,,
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
      Menu, tray, Icon, %A_ScriptFullPath%, -159
   } else
   {
      Menu, tray, Icon, %A_ScriptDir%\wheel.ico
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
				JoystickNumber = %A_Index%
				break
			}
		}
		if JoystickNumber <= 0
		{
			; MsgBox The system does not appear to have any joysticks.
			; ExitApp
			Sleep, 1000
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
scroll(direction)
{
	ControlGetFocus, fcontrol, A
	SendMessage, 0x114, %direction%, 0, %fcontrol%, A
}

WindowGetRect(windowTitle*) {
    if hwnd := WinExist(windowTitle*) {
        VarSetCapacity(rect, 16, 0)
        DllCall("GetClientRect", "Ptr", hwnd, "Ptr", &rect)
        return {width: NumGet(rect, 8, "Int"), height: NumGet(rect, 12, "Int")}
    }
}

#SingleInstance
SetFormat, float, 03.3  ; Omit decimal point from axis position percentages. (03)
GetKeyState, joy_buttons, %JoystickNumber%JoyButtons
GetKeyState, joy_name, %JoystickNumber%JoyName
GetKeyState, joy_info, %JoystickNumber%JoyInfo
Loop
{
	{ ; Joystick polling
		buttons_down =
		Loop, %joy_buttons%
		{
			GetKeyState, joy%a_index%, %JoystickNumber%joy%a_index%
			if joy%a_index% = D
				buttons_down = %buttons_down%%a_space%%a_index%
		}
		GetKeyState, joyx, %JoystickNumber%JoyX
		axis_info = X%joyx%
		GetKeyState, joyy, %JoystickNumber%JoyY
		axis_info = %axis_info%%a_space%%a_space%Y%joyy%
		IfInString, joy_info, Z
		{
			GetKeyState, joyz, %JoystickNumber%JoyZ
			axis_info = %axis_info%%a_space%%a_space%Z%joyz%
		}
		IfInString, joy_info, R
		{
			GetKeyState, joyr, %JoystickNumber%JoyR
			axis_info = %axis_info%%a_space%%a_space%R%joyr%
		}
		IfInString, joy_info, U
		{
			GetKeyState, joyu, %JoystickNumber%JoyU
			axis_info = %axis_info%%a_space%%a_space%U%joyu%
		}
		IfInString, joy_info, V
		{
			GetKeyState, joyv, %JoystickNumber%JoyV
			axis_info = %axis_info%%a_space%%a_space%V%joyv%
		}
		IfInString, joy_info, P
		{
			GetKeyState, joyp, %JoystickNumber%JoyPOV
			axis_info = %axis_info%%a_space%%a_space%POV%joyp%
		}

		If (false)
		{
			joyx := 100 - joyx
			joyy := 100 - joyy
			If (joyp <> -1) ; || joyp = 13500)
				joyp := joyp + 18000
			If (joyp > 31500) ; || joyp = 22500)
				joyp := joyp - 18000 - 18000
		}

		If (joyp = 4500) ; || joyp = 13500)
			joy5 := "D"
		If (joyp = 31500) ; || joyp = 22500)
			joyz := 100
		If (joyp = 13500)
			joy2 := "D"
		If (joyp = 22500)
			joy1 := "D"
	}

	tdz := 60
	{ ; Modes
		If (stick_mode = 0) ; Mode selection
		{
			If (abs(joyx-50) > 15 || abs(joyy-50) > 15)
			{
				If (button_click_pre <> 9)
				{
					button_click_pre := 9
					stick_mode := 2
				}
			}
			Else If (joyz > 95)
			{
				If (button_click_pre <> 9)
				{
					button_click_pre := 9
					mouse_click_pre := 1
					stick_mode := 6
					;dasher_mode := 0
					;If (joyp = 9000)
					If (joy9 = "D")
					{
						;button_click_pre := 9000
						button_click_pre := 9
						;loop_count := 1
						If (dasher_mode = 1)
							dasher_mode := 0
						Else
							dasher_mode := 1
					}
					If (dasher_mode = 1)
					{
						SetTitleMatchMode, 2
						IfWinExist, Dasher
						{
						   WinGet MMX, MinMax, Dasher
						   IfNotEqual MMX,0, WinRestore, Dasher
							 IfWinActive,  Dasher
							 	SendInput, !{Tab}
						}
						Else
						{
							Run, "C:\Program Files (x86)\Dasher\Dasher 5.00\Dasher.exe" /config direct_joy
						}
					}
				}
			}
			Else If (joyp = 0)
			{
				If (button_click_pre <> 0)
				{
					button_click_pre := 0
					loop_count := 1
					stick_mode := 1
					character_mode := 5
				}
			}
			Else If (joyp = 18000)
			{
				If (button_click_pre <> 95)
				{
					button_click_pre := 95
					stick_mode := 3
				}
			}
			Else If (joyp = 9000 && button_click_pre <> 9000)
			{
				{
					button_click_pre := 9000
					stick_mode := 1
					loop_count := 1
					double_tap := 1
				}
			}
			Else If (joyp = 27000 && button_click_pre <> 27000)
			{
				{
					button_click_pre := 27000
					stick_mode := 1
					loop_count := 1
					double_tap := 0
				}
			}
			Else If (joy5 = "D")
			{
				If (button_click_pre <> 5)
				{
					button_click_pre := 5
					stick_mode := 1
					character_mode := 1
					If (joy9 = "D")
					{
						button_click_pre := 9
						;loop_count := 0
						If (audio_feedback = 0)
							audio_feedback := 1
						Else If (audio_feedback = 1)
							audio_feedback := 2
						Else
							audio_feedback := 0
					}
				}
			}
			Else If (joy1 = "D")
			{
				If (button_click_pre <> 1)
				{
					button_click_pre := 1
					stick_mode := 4
				}
			}
			Else If (joy2 = "D")
			{
				If (button_click_pre <> 3)
				{
					button_click_pre := 3
					stick_mode := 5
				}
			}
			Else If (button_click_pre = 9)
				button_click_pre := -1
		}
		Else If (stick_mode = 3) ; ACAT
		{
			If (joy9 = "D" || joy11 = "D")
			{
				If (button_click_pre <> 9)
				{
					button_click_pre := 9
					stick_mode := 0 ;2
					;SendInput, !{Space}
					;SendInput, #{Tab}
				}
			}
			Else If (button_click_pre = 9)
				button_click_pre := -1
			Else
			{
				If (joyp = 18000)
				{
					If (button_click_pre <> 95)
					{
						button_click_pre := 95
					}
				}
				Else If (joyp = 9000)
				{
					If (button_click_pre <> 9000 && button_click_pre <> 95)
					{
						button_click_pre := 9000
						loop_count_max := 30
						loop_count := 0
					}
				}
				Else If (joyp = 27000)
				{
					If (button_click_pre <> 27000 && button_click_pre <> 95)
					{
						button_click_pre := 27000
						loop_count_max := 15
						loop_count := 0
					}
				}
				Else If (joyz > 95 || joyu > 90 || joyv > 90)
				{
					If (button_click_pre = 95)
					{
						button_click_pre := 2
					}
				}
				Else If (joyz > 51)
				{
					; || joyu > 10 || joyv > 10
					If (button_click_pre <> 2 && button_click_pre <> 95)
					{
						button_click_pre := 2
						SetKeyDelay, 100
						Send {Blind}{F12 DownTemp}
						Send {Blind}{F12 Up}
						SetKeyDelay, -1
					}
				}
				Else If (joy5 = "D")
				{
					; || joyu > 10 || joyv > 10
					If (button_click_pre <> 2 && button_click_pre <> 95)
					{
					  If (loop_count >= loop_count_max || loop_count < 0)
					    loop_count := 0
						;loop_count += 1
						If (loop_count = 0)
							Progress, fs48 , -%loop_count%-, Count, Exercise, Courier New
						Else
							Progress,, -%loop_count%-
						loop_count_progress := (loop_count + 1) * 100 / loop_count_max
						If (hold_pose = 1)
							SoundBeep,900,100
						Progress, %loop_count_progress%
						;Progress, loop_count * 100 / 15
						If (hold_pose = 1)
							Sleep, 5000
					  ;Sleep, 100
						If (hold_pose = 1)
							SoundBeep,500,100
						v := ComObjCreate("SAPI.SpVoice")
						v.Voice := v.GetVoices().Item(1)
						;Progress, %loop_count_progress%
						;SplashTextOn,,, %loop_count%
						loop_count += 1
						Progress,, %loop_count%
						v.Speak(loop_count)
						;Progress, %loop_count_progress%
						;SplashTextOff
						If (loop_count >= loop_count_max)
							Progress, Off
						button_click_pre := 2
						;Send, {F12}
					}
				}
				Else If (joy2 = "D")
				{
					If (button_click_pre <> 3 && button_click_pre <> 95)
					{
						button_click_pre := 3
						hold_pose := 0
						;Progress, Off
					}
				}
				Else If (joy1 = "D")
				{
					If (button_click_pre <> 1 && button_click_pre <> 95)
					{
						button_click_pre := 1
						hold_pose := 1
						;Progress, Off
					}
				}
				Else If (button_click_pre <> -1 && button_click_pre <> 9 && button_click_pre <> 95)
					{
						button_click_pre := -1
					}
			}
		}
		Else If (stick_mode = 1) ; Typing
		{
			If (joy9 = "D" || joy11 = "D")
			{
				If (button_click_pre <> 9)
				{
					If (joyp = 000)
						stick_mode := 3
					Else
						stick_mode := 0 ; 2
					button_click_pre := 9
				}
			}
			Else If (button_click_pre = 9)
				button_click_pre := -1
			Else
			{
				loop_count_repeat := 1 * loop_count_repeat_base
				loop_count_skip := 2 * loop_count_skip_base
				If (joyp = 0)
				{
					If (button_click_pre <> 0)
					{
						button_click_pre := 0
						SendInput, {Up}
						loop_count := 1
					}
					Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
					{
						SendInput, {Up}
					}
					loop_count++
				}
				Else If (joyp = 9000)
				{
					If (button_click_pre <> 9000)
					{
						button_click_pre := 9000
						SendInput, {Right}
						loop_count := 1
					}
					Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
					{
						SendInput, {Right}
					}
					loop_count++
				}
				Else If (joyp = 18000)
				{
					If (button_click_pre <> 18000)
					{
						button_click_pre := 18000
						SendInput, {Down}
						loop_count := 1
					}
					Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
					{
						SendInput, {Down}
					}
					loop_count++
				}
				Else If (joyp = 27000)
				{
					If (button_click_pre <> 27000)
					{
						button_click_pre := 27000
						SendInput, {Left}
						loop_count := 1
					}
					Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
					{
						SendInput, {Left}
					}
					loop_count++
				}
				If (joy5 = "D" && button_click_pre <> 5 && button_click_pre <> 10)
				{
					If (double_tap = 0)
					{
						button_click_pre := 10
						SetKeyDelay, 100
						Send {#}
						SetKeyDelay, -1
					}
					Else
					{
						If (button_click_pre = 2)
							button_click_pre := 10
						Else
							button_click_pre := 5
						SendInput, {Control down}
					}
				}
				If (joyz > 55 && button_click_pre <> 10)
				{
					; || joyu > 10 || joyv > 10
					If (joyz > 75 && double_tap = 0)
					{
						button_click_pre := 10
						SetKeyDelay, 100
						Send {/}
						SetKeyDelay, -1
					}
					Else If (button_click_pre <> 2 && double_tap = 1)
					{
						If (button_click_pre = 5)
							button_click_pre := 10
						Else
							button_click_pre := 2
						SendInput, {Shift down}
					}
				}
				If (joy1 = "D")
				{
					If (button_click_pre <> 1)
					{
						button_click_pre := 1
						SendInput, {LWin down}
					}
				}
				If (joy2 = "D")
				{
					If (button_click_pre <> 3)
					{
						button_click_pre := 3
						SendInput, {Alt down}
					}
				}
				{
					If (joyp = -1 && joyz < 55 && joy1 <> "D" && joy2 <> "D" && joy5 <> "D" && button_click_pre <> -1 && button_click_pre <> 9)
						{
							; || joyu > 10 || joyv > 10  && joyu < 10 && joyv < 10
							;If (button_click_pre > 0 && button_click_pre < 9)
							{
								SendInput, {Control up}
								SendInput, {Shift up}
								SendInput, {LWin up}
								SendInput, {Alt up}
							}
							button_click_pre := -1
						}
				}
			}
		}
		Else If (stick_mode = 4) ; Media Control normal
		{
			If (joy9 = "D" || joy11 = "D")
			{
				If (button_click_pre <> 9)
				{
					stick_mode := 0 ; 2
					button_click_pre := 9
				}
			}
			Else If (button_click_pre = 9)
				button_click_pre := -1
			Else
			{
				loop_count_repeat := 4 * loop_count_repeat_base
				loop_count_skip := 4 * loop_count_skip_base
				If (joyp = 0)
				{
					If (button_click_pre <> 0)
					{
						button_click_pre := 0
						SendInput, {Up}
						loop_count := 1
					}
					Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
					{
						SendInput, {Up}
					}
					loop_count++
				}
				Else If (joyp = 18000)
				{
					If (button_click_pre <> 18000)
					{
						button_click_pre := 18000
						SendInput, {Down}
						loop_count := 1
					}
					Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
					{
						SendInput, {Down}
					}
					loop_count++
				}
				Else If (joyp = 9000)
				{
					If (button_click_pre <> 9000)
					{
						button_click_pre := 9000
						SendInput, {Media_Next}
					}
				}
				Else If (joyp = 27000)
				{
					If (button_click_pre <> 27000)
					{
						button_click_pre := 27000
						SendInput, {Media_Prev}
					}
				}
				Else If (joyy < 30 && joyx > 30 && joyx < 70)
				{
					If (button_click_pre <> 2)
					{
						button_click_pre := 2
						SendInput, {Volume_Up}
						loop_count := 1
					}
					Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
					{
						SendInput, {Volume_Up}
					}
					loop_count++
				}
				Else If (joyy > 70 && joyx > 30 && joyx < 70)
				{
					If (button_click_pre <> 2)
					{
						button_click_pre := 2
						SendInput, {Volume_Down}
						loop_count := 1
					}
					Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
					{
						SendInput, {Volume_Down}
					}
					loop_count++
				}
				Else If (joyx < 30 && joyy > 40 && joyy < 60)
				{
					If (button_click_pre <> 2)
					{
						button_click_pre := 2
						SendInput, {Left}
						loop_count := 1
					}
					Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
					{
						SendInput, {Left}
					}
					loop_count++
				}
				Else If (joyx > 70 && joyy > 40 && joyy < 60)
				{
					If (button_click_pre <> 2)
					{
						button_click_pre := 2
						SendInput, {Right}
						loop_count := 1
					}
					Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
					{
						SendInput, {Right}
					}
					loop_count++
				}
				If (joy5 = "D")
				{
					If (button_click_pre <> 5)
					{
						button_click_pre := 5
						SendInput, {Media_Play_Pause}
					}
				}
				If (joyz > 95)
				{
					; || joyu > 10 || joyv > 10
					If (button_click_pre <> 2)
					{
						button_click_pre := 2
						SendInput, {Media_Stop}
					}
				}
				If (joy1 = "D")
				{
					If (button_click_pre <> 1)
					{
						button_click_pre := 1
						SendInput, {F11}
					}
				}
				If (joy2 = "D")
				{
					If (button_click_pre <> 3)
					{
						button_click_pre := 3
						SendInput, {w}
					}
				}
				{
					If (joyp = -1 && abs(joyx-50) < 5 && abs(joyy-50) < 5 && joyz < 55 && joy1 <> "D" && joy2 <> "D" && joy5 <> "D" && button_click_pre <> -1 && button_click_pre <> 9)
						{
							button_click_pre := -1
						}
				}
			}
		}
		Else If (stick_mode = 5) ; Media Control Amazon
		{
			If (joy9 = "D" || joy11 = "D")
			{
				If (button_click_pre <> 9)
				{
					stick_mode := 0 ; 2
					button_click_pre := 9
				}
			}
			Else If (button_click_pre = 9)
				button_click_pre := -1
			Else
			{
				loop_count_repeat := 4 * loop_count_repeat_base
				loop_count_skip := 4 * loop_count_skip_base
				If (joyp = 0)
				{
					If (button_click_pre <> 0)
					{
						button_click_pre := 0
						SendInput, {Up}
						loop_count := 1
					}
					Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
					{
						SendInput, {Up}
					}
					loop_count++
				}
				Else If (joyp = 18000)
				{
					If (button_click_pre <> 18000)
					{
						button_click_pre := 18000
						SendInput, {Down}
						loop_count := 1
					}
					Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
					{
						SendInput, {Down}
					}
					loop_count++
				}
				Else If (joyp = 9000)
				{
					If (button_click_pre <> 9000)
					{
						button_click_pre := 9000
						SendInput, {Right}
						loop_count := 1
					}
					Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
					{
						SendInput, {Right}
					}
					loop_count++
				}
				Else If (joyp = 27000)
				{
					If (button_click_pre <> 27000)
					{
						button_click_pre := 27000
						SendInput, {Left}
						loop_count := 1
					}
					Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
					{
						SendInput, {Left}
					}
					loop_count++
				}
				Else If (joyy < 30 && joyx > 30 && joyx < 70)
				{
					If (button_click_pre <> 2)
					{
						button_click_pre := 2
						SendInput, {Volume_Up}
						loop_count := 1
					}
					Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
					{
						SendInput, {Volume_Up}
					}
					loop_count++
				}
				Else If (joyy > 70 && joyx > 30 && joyx < 70)
				{
					If (button_click_pre <> 2)
					{
						button_click_pre := 2
						SendInput, {Volume_Down}
						loop_count := 1
					}
					Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
					{
						SendInput, {Volume_Down}
					}
					loop_count++
				}
				Else If (joyx < 30 && joyy > 40 && joyy < 60)
				{
					If (button_click_pre <> 2)
					{
						button_click_pre := 2
						SendInput, {Volume_Mute}
					}
				}
				Else If (joyx > 70 && joyy > 40 && joyy < 60)
				{
					If (button_click_pre <> 2)
					{
						button_click_pre := 2
						SendInput, {Volume_Mute}
					}
				}
				If (joy5 = "D")
				{
					If (button_click_pre <> 5)
					{
						button_click_pre := 5
						SendInput, {Space}
					}
				}
				If (joyz > 95)
				{
					; || joyu > 10 || joyv > 10
					If (button_click_pre <> 2)
					{
						button_click_pre := 2
						SendInput, {Escape}
					}
				}
				If (joy1 = "D")
				{
					If (button_click_pre <> 1)
					{
						button_click_pre := 1
						SendInput, {F11}
					}
				}
				If (joy2 = "D")
				{
					If (button_click_pre <> 3)
					{
						button_click_pre := 3
						SendInput, {f}
					}
				}
				{
					If (joyp = -1 && abs(joyx-50) < 5 && abs(joyy-50) < 5 && joyz < 55 && joy1 <> "D" && joy2 <> "D" && joy5 <> "D" && button_click_pre <> -1 && button_click_pre <> 9)
						{
							button_click_pre := -1
						}
				}
			}
		}
		Else If (stick_mode = 6) ; Absolute mouse
		{
			If (joy9 = "D" || joy11 = "D")
			{
				If (button_click_pre <> 9)
				{
					stick_mode := 0
					button_click_pre := 9
				}
			}
			Else If (button_click_pre = 9)
				button_click_pre := -1
			Else
			{
				loop_count_repeat := 4 * loop_count_repeat_base
				loop_count_skip := 4 * loop_count_skip_base
				If (joyp = 0 && dasher_mode = 0)
				{
					If (mouse_click_pre <> 2)
					{
						mouse_click_pre := 2
						MouseClick, Right,,, 1, 0, ;D
					}
					;amoffsetx := -(joyx - 50) / 100
					;amoffsety := -(joyy - 50) / 100
				}
				Else If (joyp = 0)
				{
					button_click_pre := 0
					loop_count := 1
					stick_mode := 2
					WinMinimize, Dasher
				}
				Else If (joyp = 18000)
				{
					If (button_click_pre <> 18000)
					{
						button_click_pre := 18000
						If (dasher_mode = 0)
							SendInput, #{Tab}
						Else
						{
							stick_mode := 2
							dasher_mode := 0
							WinClose, Dasher
						}
					}
				}
				Else If (joyp = 9000)
				{
					If (button_click_pre <> 9000)
					{
						button_click_pre := 9000
						SendInput, {Right}
						loop_count := 1
					}
					Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
					{
						SendInput, {Right}
					}
					loop_count++
				}
				Else If (joyp = 27000)
				{
					If (button_click_pre <> 27000)
					{
						button_click_pre := 27000
						SendInput, {Left}
						loop_count := 1
					}
					Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
					{
						SendInput, {Left}
					}
					loop_count++
				}
				Else If (joy2 = "D" && dasher_mode = 1)
				{
					If (button_click_pre <> 3)
					{
						button_click_pre := 3
						SendInput, {Backspace}
						loop_count := 1
					}
					Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
					{
						SendInput, {Backspace}
					}
					loop_count++
				}
				If (joyz > 55)
				{
					; || joyu > 10 || joyv > 10
					If (mouse_click_pre <> 1)
					{
						mouse_click_pre := 1
						MouseClick, Left,,, 1, 0, ;D  ; Hold down the left mouse button.
					}
				}
				If (joy5 = "D")
				{
					If (mouse_click_pre <> 2 && dasher_mode = 1)
					{
						mouse_click_pre := 2
						MouseClick, Right,,, 1, 0, ;D
					}
					Else If (button_click_pre <> 5 && dasher_mode = 0)
					{
						button_click_pre := 5
						amoffsetx := (joyx - 50) ;/ 100
						amoffsety := (joyy - 50) ;/ 100
					}
				}
				If (joy1 = "D")
				{
					If (button_click_pre <> 1)
					{
						button_click_pre := 1
						SendInput, {Enter}
					}
				}
				If (joy2 = "D")
				{
					If (button_click_pre <> 3 && dasher_mode = 0)
					{
						button_click_pre := 3
						SendInput, {Escape}
					}
				}
				{
					If (joyz < 55 && joy5 <> "D" && joyp = -1 && mouse_click_pre <> -1)
					{
						;  && joyu < 10 && joyv < 10
						If (mouse_click_pre = 1)
						{
							;MouseClick, Left,,, 1, 0, U
						}  ; Release the mouse button.
						Else If (mouse_click_pre = 2)
						{
							;MouseClick, Right,,, 1, 0, U
						}  ; Release the mouse button.
						mouse_click_pre := -1
						; button_click_pre := -1
					}
				}
				{
					If (joy1 <> "D" && joy2 <> "D" && joy5 <> "D" && joyp = -1 && button_click_pre <> -1)
					{
						button_click_pre := -1
					}
				}
			}
		}
		Else ; stick_mode = 2 ; Relative mouse
		{
			If (joy9 = "D" || joy11 = "D")
			{
				If (button_click_pre <> 9)
				{
					stick_mode := 0
					button_click_pre := 9
				}
			}
			Else If (button_click_pre = 9)
				button_click_pre := -1
			Else
			{
				loop_count_repeat := 1 * loop_count_repeat_base
				loop_count_skip := 1 * loop_count_skip_base
				If (joyp = 0)
				{
					If (button_click_pre <> 0)
					{
						button_click_pre := 0
						SendInput, {WheelUp}
						loop_count := 1
					}
					Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
					{
						SendInput, {WheelUp}
					}
					loop_count++
				}
				Else If (joyp = 9000)
				{
					If (button_click_pre <> 9000)
					{
						button_click_pre := 9000
						SendInput, {WheelRight}
						;scroll(1)
						loop_count := 1
					}
					Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
					{
						SendInput, {WheelRight}
						;scroll(1)
					}
					loop_count++
				}
				Else If (joyp = 18000)
				{
					If (button_click_pre <> 18000)
					{
						button_click_pre := 18000
						SendInput, {WheelDown}
						loop_count := 1
					}
					Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
					{
						SendInput, {WheelDown}
					}
					loop_count++
				}
				Else If (joyp = 27000)
				{
					If (button_click_pre <> 27000)
					{
						button_click_pre := 27000
						SendInput, {WheelLeft}
						;scroll(0)
						loop_count := 1
					}
					Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
					{
						SendInput, {WheelLeft}
						;scroll(0)
					}
					loop_count++
				}
				If (joyz > 55)
				{
					; || joyu > 10 || joyv > 10
					If (mouse_click_pre <> 1 && mouse_click_pre <> 21 && mouse_click_pre <> 12)
					{
						If (mouse_click_pre = 2)
							mouse_click_pre := 21
						Else
							mouse_click_pre := 1
						MouseClick, Left,,, 1, 0, D  ; Hold down the left mouse button.
					}
				}
				If (joy5 = "D")
				{
					If (mouse_click_pre = 4 && mouse_click_pre <> 42)
					{
						mouse_click_pre := 42
						MouseClick, X2,,, 1, 0
					}
					Else If (mouse_click_pre <> 2 && mouse_click_pre <> 23 && mouse_click_pre <> 42 && mouse_click_pre <> 21 && mouse_click_pre <> 12)
					{
						If (mouse_click_pre = 1)
							mouse_click_pre := 12
						Else
							mouse_click_pre := 2
						MouseClick, Right,,, 1, 0, D
					}
				}
				If (joy2 = "D")
				{
					If (mouse_click_pre = 2)
					{
						mouse_click_pre := 23
						MouseClick, Middle,,, 1, 0, D
						MouseClick, Right,,, 1, 0, U
						MouseClick, Middle,,, 1, 0, U
						;SendInput, #{Esc}
						; MouseClick, Middle,,, 1, 0, D
					}
					Else If (mouse_click_pre <> 3 && mouse_click_pre <> 23)
					{
						mouse_click_pre := 3
						; MouseClick, Middle,,, 1, 0, D
					}
				}
				If (joy1 = "D")
				{
					If (mouse_click_pre <> 4 && mouse_click_pre <> 42)
					{
						mouse_click_pre := 4
						; MouseClick, X1,,, 1, 0, D
					}
				}
				{
					If (joyz < 55 && joy1 <> "D" && joy2 <> "D" && joy5 <> "D" && mouse_click_pre <> -1)
					{
						;  && joyu < 10 && joyv < 10
						If (mouse_click_pre = 1)
						{
							MouseClick, Left,,, 1, 0, U
						}  ; Release the mouse button.
						Else If (mouse_click_pre = 2)
						{
							MouseClick, Right,,, 1, 0, U
						}  ; Release the mouse button.
						Else If (mouse_click_pre = 12 || mouse_click_pre = 21)
						{
							MouseClick, Left,,, 1, 0, U
							MouseClick, Right,,, 1, 0, U
						}  ; Release the mouse buttons.
						Else If (mouse_click_pre = 23)
						{
						}
						Else If (mouse_click_pre = 3)
						{
							MouseClick, Middle,,, 1, 0
						}  ; Press the mouse button.
						Else If (mouse_click_pre = 4)
						{
							MouseClick, X1,,, 1, 0
						}  ; Press the mouse button.
						mouse_click_pre := -1
					}
				}
				{
					If (joyp = -1 && button_click_pre <> -1 && button_click_pre <> 9)
						{
							button_click_pre := -1
						}
				}
			}
		}
	}

  ;tol = 25
	dz := 5
	joyx -= 50
	joyy -= 50
	theta := 0
	pi := 4 * atan(1)
	region := 45 * pi / 180
	radius2 := joyx*joyx + joyy*joyy
	radius := sqrt(radius2)
	; tol := 20 * pi / 180 * exp((dz - radius) * 3 / (50 - dz))
	; tol := 25 * pi / 180 * exp((dz - radius) * 2 / (50 - dz))
	tol := 22.5 * pi / 180 * exp((dz - radius) * 5 / (50 - dz))

	If (radius2 > dz*dz)
	{
		theta := atan( abs(joyy / joyx) )
		If (joyy > 0)
		{
			If (joyx < 0)
			{
				theta := pi + theta
			}
			Else
			{
				theta := 2 * pi - theta
			}
		}
		Else
		{
			If (joyx < 0)
			{
				theta := pi - theta
			}
		}
	}

	ch_mode := mod(character_mode, 10)

	If (stick_mode = 2) ; Relative mouse positioning
	{
		mdz := 5
		ms := 0.01 ; 10
		If (radius2 > mdz*mdz)
		{
			SetMouseDelay, -1  ; Makes movement smoother.
			; Relative mouse positioning
			MouseMove, joyx * abs(joyx) * ms, joyy * abs(joyy) * ms, 0, R
		}
	}
	Else If (stick_mode = 6) ; Absolute mouse positioning
	{
		mdz := 2.5 ;5
		; If (abs(joyx) > mdz || abs(joyy) > mdz)
		If (radius2 > mdz*mdz || !stick_centre)
		{
			If (radius2 > mdz*mdz)
				stick_centre := 0
			Else
				stick_centre := 1

			SetMouseDelay, -1  ; Makes movement smoother.

			If (abs(joyx) < mdz)
				joyx := 0
			Else If (joyx > 0)
				joyx -= mdz
			Else
				joyx += mdz

			If (abs(joyy) < mdz)
				joyy := 0
			Else If (joyy > 0)
				joyy -= mdz
			Else
				joyy += mdz
			;joyx += 50 - mdz
			;joyy += 50 - mdz

			If ((amoffsetx) > mdz)
				joyx += 50 - mdz + amoffsetx - mdz
			Else If (amoffsetx < -mdz)
				joyx += 50 + amoffsetx
			Else
				joyx += 50 - mdz

			If ((amoffsety) > mdz)
				joyy += 50 - mdz + amoffsety - mdz
			Else If (amoffsety < -mdz)
				joyy += 50 + amoffsety
			Else
				joyy += 50 - mdz

			joyx /= (100 - mdz - mdz)
			joyy /= (100 - mdz - mdz)
			;amoffsetx += 50 - mdz
			;amoffsetx /= (100 - mdz - mdz)
			;amoffsety += 50 - mdz
			;amoffsety /= (100 - mdz - mdz)

			If (dasher_mode = 1)
			{
				SetTitleMatchMode, 2
				DasherTb := 30
				DasherBb := 40
				DasherLb := -10
				DasherRb := 10
				DasherX := 0
				DasherY := 0
				;CoordMode, Pixel, Client
				WinGetPos, DasherX, DasherY, Width, Height, Dasher
				;rect := WindowGetRect("Dasher")
				Width -= DasherLb + DasherRb
				DasherX += DasherLb
				Height -= DasherTb + DasherBb
				DasherY += DasherTb
				CoordMode, Mouse, Screen
				MouseMove, DasherX + (joyx) * Width, DasherY + (joyy) * Height, 0
			}
			Else
			{
				WinGetPos, , , Width, Height, A
				CoordMode, Mouse, Window
				;MouseMove, (joyx - amoffsetx) * Width, (joyy - amoffsety) * Height, 0
				MouseMove, (joyx) * Width, (joyy) * Height, 0
				;MouseMove, (joyx - (amoffsetx - mdz) / (100 - mdz - mdz)) * Width, (joyy - (amoffsety - mdz) / (100 - mdz - mdz)) * Height, 0
			}
		}
	}
	Else If (stick_mode = 1 && radius2 > dz*dz)
	{
		character_code_pre := character_code
		{ ; Joystick position
			If (theta < region / 2 - tol || theta > 2 * pi - region / 2 + tol)
			{
				character_code := New_Code(character_code, 6)
			}
		  Else If (theta < region * 3 / 2 - tol && theta > region / 2 + tol)
			{
				character_code := New_Code(character_code, 3)
			}
		  Else If (theta < region * 5 / 2 - tol && theta > region * 3 / 2 + tol)
			{
				character_code := New_Code(character_code, 2)
			}
		  Else If (theta < region * 7 / 2 - tol && theta > region * 5 / 2 + tol)
			{
				character_code := New_Code(character_code, 1)
			}
		  Else If (theta < region * 9 / 2 - tol && theta > region * 7 / 2 + tol)
			{
				character_code := New_Code(character_code, 4)
			}
		  Else If (theta < region * 11 / 2 - tol && theta > region * 9 / 2 + tol)
			{
				character_code := New_Code(character_code, 7)
			}
		  Else If (theta < region * 13 / 2 - tol && theta > region * 11 / 2 + tol)
			{
				character_code := New_Code(character_code, 8)
			}
		  Else If (theta < region * 15 / 2 - tol && theta > region * 13 / 2 + tol)
			{
				character_code := New_Code(character_code, 9)
			}
		}

		if (character_code <> character_code_pre && audio_feedback <> 0)
		{ ; Joystick position audio feedback
			If (character_code > 9)
			{
				BeepDur := 100
				character_code_audio := character_code
				If (Mod(character_code, 10) = 0)
					character_code_audio /= 10
				If (false)
				{
					If (Mod(character_code_audio, 10) = 1)
						SoundBeep,440.000,BeepDur
					Else If (Mod(character_code_audio, 10) = 2)
						SoundBeep,493.883,BeepDur
					Else If (Mod(character_code_audio, 10) = 3)
						SoundBeep,523.251,BeepDur
					Else If (Mod(character_code_audio, 10) = 4)
						SoundBeep,880.000,BeepDur
					Else If (Mod(character_code_audio, 10) = 6)
						SoundBeep,587.330,BeepDur
					Else If (Mod(character_code_audio, 10) = 7)
						SoundBeep,783.991,BeepDur
					Else If (Mod(character_code_audio, 10) = 8)
						SoundBeep,698.456,BeepDur
					Else If (Mod(character_code_audio, 10) = 9)
						SoundBeep,659.255,BeepDur
				}
				If (true)
				{
					If (Mod(character_code_audio, 10) = 2)
						SoundBeep, 440.000, BeepDur
					Else If (Mod(character_code_audio, 10) = 1)
						SoundBeep, 493.883, BeepDur
					Else If (Mod(character_code_audio, 10) = 3)
						SoundBeep, 523.251, BeepDur
					Else If (Mod(character_code_audio, 10) = 4)
						SoundBeep, 587.330, BeepDur
					Else If (Mod(character_code_audio, 10) = 6)
						SoundBeep, 659.255, BeepDur
					Else If (Mod(character_code_audio, 10) = 7)
						SoundBeep, 698.456, BeepDur
					Else If (Mod(character_code_audio, 10) = 9)
						SoundBeep, 783.991, BeepDur
					Else If (Mod(character_code_audio, 10) = 8)
						SoundBeep, 880.000, BeepDur
				}
			}
		}

		{ ; Joystick position visual feedback
		  If (character_code > 9 && audio_feedback <> 2)
		  {
			  If (character_code_pre = 0)
			  {
					; Space
					{
						option1 := "  "
						option2 := "  "
						option3 := "  "
						option4 := "  "
						option6 := "  "
						option7 := "  "
						option8 := "  "
						option9 := "  "
					}

					; Outer Ring
					{
			    	{
							character_index := 11
							character11 := % all_characters%ch_mode%%character_index%
							character_index++
							character12 := % all_characters%ch_mode%%character_index%
							character_index++
							character13 := % all_characters%ch_mode%%character_index%
							character_index++
							character14 := % all_characters%ch_mode%%character_index%
							character_index += 3
							character17 = % all_characters%ch_mode%%character_index%
							character_index += 2
							If (StrLen(all_characters%ch_mode%%character_index%) <> 5 )
								character19 = % "  "
							Else
								character19 = % " " + SubStr(all_characters%ch_mode%%character_index%, 5, 1)
						}

				    {
							character_index := 21
							character21 := % all_characters%ch_mode%%character_index%
							character_index++
							character22 := % all_characters%ch_mode%%character_index%
							character_index++
							character23 := % all_characters%ch_mode%%character_index%
							character_index += 4
							character27 := % all_characters%ch_mode%%character_index%
							character_index++
							character28 := % all_characters%ch_mode%%character_index%
							character_index++
							character29 := % all_characters%ch_mode%%character_index%
						}

				    {
							character_index := 31
							character31 := % all_characters%ch_mode%%character_index%
							character_index++
							character32 := % all_characters%ch_mode%%character_index%
							character_index++
							character33 := % all_characters%ch_mode%%character_index%
							character_index += 3
							character36 := % all_characters%ch_mode%%character_index%
							character_index++
							If (StrLen(all_characters%ch_mode%%character_index%) <> 5 )
								character37 = % "  "
							Else
								character37 = % " " + SubStr(all_characters%ch_mode%%character_index%, 5, 1)
							character_index += 2
							character39 := % all_characters%ch_mode%%character_index%
						}

				    {
							character_index := 41
							character41 := % all_characters%ch_mode%%character_index%
							character_index += 2
							If (StrLen(all_characters%ch_mode%%character_index%) <> 5 )
								character43 = % "  "
							Else
								character43 = % " " + SubStr(all_characters%ch_mode%%character_index%, 5, 1)
							character_index++
							character44 := % all_characters%ch_mode%%character_index%
							character_index += 2
							If (StrLen(all_characters%ch_mode%%character_index%) <> 5 )
								character46 = % "  "
							Else
								character46 = % " " + SubStr(all_characters%ch_mode%%character_index%, 5, 1)
							character_index++
							character47 := % all_characters%ch_mode%%character_index%
							character_index += 2
							If (StrLen(all_characters%ch_mode%%character_index%) <> 5 )
								character49 = % "  "
							Else
								character49 = % " " + SubStr(all_characters%ch_mode%%character_index%, 5, 1)
						}

				    {
							character_index := 61
							If (StrLen(all_characters%ch_mode%%character_index%) <> 5 )
								character61 = % "  "
							Else
								character61 = % " " + SubStr(all_characters%ch_mode%%character_index%, 5, 1)
							character_index += 2
							character63 := % all_characters%ch_mode%%character_index%
							character_index++
							If (StrLen(all_characters%ch_mode%%character_index%) <> 5 )
								character64 = % "  "
							Else
								character64 = % " " + SubStr(all_characters%ch_mode%%character_index%, 5, 1)
							character_index += 2
							character66 := % all_characters%ch_mode%%character_index%
							character_index++
							If (StrLen(all_characters%ch_mode%%character_index%) <> 5 )
								character67 = % "  "
							Else
								character67 = % " " + SubStr(all_characters%ch_mode%%character_index%, 5, 1)
							character_index += 2
							character69 := % all_characters%ch_mode%%character_index%
						}

				    {
							character_index := 71
							character71 := % all_characters%ch_mode%%character_index%
							character_index += 2
							If (StrLen(all_characters%ch_mode%%character_index%) <> 5 )
								character73 = % "  "
							Else
								character73 = % " " + SubStr(all_characters%ch_mode%%character_index%, 5, 1)
							character_index++
							character74 := % all_characters%ch_mode%%character_index%
							character_index += 3
							character77 := % all_characters%ch_mode%%character_index%
							character_index++
							character78 := % all_characters%ch_mode%%character_index%
							character_index++
							character79 := % all_characters%ch_mode%%character_index%
						}

				    {
							character_index := 83
							;character84 := % all_characters%ch_mode%%character_index%
							;character_index--
							character83 := % all_characters%ch_mode%%character_index%
							character_index--
							character82 := % all_characters%ch_mode%%character_index%
							character_index--
							character81 := % all_characters%ch_mode%%character_index%
							character_index := 87
							character87 := % all_characters%ch_mode%%character_index%
							character_index++
							character88 := % all_characters%ch_mode%%character_index%
							character_index++
							character89 := % all_characters%ch_mode%%character_index%
						}

				    {
							character_index := 91
							If (StrLen(all_characters%ch_mode%%character_index%) <> 5 )
								character91 = % "  "
							Else
								character91 = % " " + SubStr(all_characters%ch_mode%%character_index%, 5, 1)
							character_index += 2
							character93 := % all_characters%ch_mode%%character_index%
							character_index += 3
							character96 := % all_characters%ch_mode%%character_index%
							character_index++
							character97 := % all_characters%ch_mode%%character_index%
							character_index++
							character98 := % all_characters%ch_mode%%character_index%
							character_index++
							character99 := % all_characters%ch_mode%%character_index%
						}
					}

					; Inner Ring
					{
						If (character_code < 20)
				    {
							character_index := 11
							option1 := % all_characters%ch_mode%%character_index%
							character_index++
							option2 := % all_characters%ch_mode%%character_index%
							character_index++
							option3 := % all_characters%ch_mode%%character_index%
							character_index++
							option4 := % all_characters%ch_mode%%character_index%
							character_index += 3
							option7 = % all_characters%ch_mode%%character_index%
							character_index += 2
							If (StrLen(all_characters%ch_mode%%character_index%) <> 5 )
								option9 = % "  "
							Else
								option9 = % " " + SubStr(all_characters%ch_mode%%character_index%, 5, 1)
						}
						Else If (character_code < 30)
				    {
							character_index := 21
							option1 := % all_characters%ch_mode%%character_index%
							character_index++
							option2 := % all_characters%ch_mode%%character_index%
							character_index++
							option3 := % all_characters%ch_mode%%character_index%
							character_index += 4
							option7 := % all_characters%ch_mode%%character_index%
							character_index++
							option8 := % all_characters%ch_mode%%character_index%
							character_index++
							option9 := % all_characters%ch_mode%%character_index%
						}
						Else If (character_code < 40)
				    {
							character_index := 31
							option1 := % all_characters%ch_mode%%character_index%
							character_index++
							option2 := % all_characters%ch_mode%%character_index%
							character_index++
							option3 := % all_characters%ch_mode%%character_index%
							character_index += 3
							option6 := % all_characters%ch_mode%%character_index%
							character_index++
							If (StrLen(all_characters%ch_mode%%character_index%) <> 5 )
								option7 = % "  "
							Else
								option7 = % " " + SubStr(all_characters%ch_mode%%character_index%, 5, 1)
							character_index += 2
							option9 := % all_characters%ch_mode%%character_index%
						}
						Else If (character_code < 60)
				    {
							character_index := 41
							option1 := % all_characters%ch_mode%%character_index%
							character_index += 2
							If (StrLen(all_characters%ch_mode%%character_index%) <> 5 )
								option3 = % "  "
							Else
								option3 = % " " + SubStr(all_characters%ch_mode%%character_index%, 5, 1)
							character_index++
							option4 := % all_characters%ch_mode%%character_index%
							character_index += 2
							If (StrLen(all_characters%ch_mode%%character_index%) <> 5 )
								option6 = % "  "
							Else
								option6 = % " " + SubStr(all_characters%ch_mode%%character_index%, 5, 1)
							character_index++
							option7 := % all_characters%ch_mode%%character_index%
							character_index += 2
							If (StrLen(all_characters%ch_mode%%character_index%) <> 5 )
								option9 = % "  "
							Else
								option9 = % " " + SubStr(all_characters%ch_mode%%character_index%, 5, 1)
						}
						Else If (character_code < 70)
				    {
							character_index := 61
							If (StrLen(all_characters%ch_mode%%character_index%) <> 5 )
								option1 = % "  "
							Else
								option1 = % " " + SubStr(all_characters%ch_mode%%character_index%, 5, 1)
							character_index += 2
							option3 := % all_characters%ch_mode%%character_index%
							character_index++
							If (StrLen(all_characters%ch_mode%%character_index%) <> 5 )
								option4 = % "  "
							Else
								option4 = % " " + SubStr(all_characters%ch_mode%%character_index%, 5, 1)
							character_index += 2
							option6 := % all_characters%ch_mode%%character_index%
							character_index++
							If (StrLen(all_characters%ch_mode%%character_index%) <> 5 )
								option7 = % "  "
							Else
								option7 = % " " + SubStr(all_characters%ch_mode%%character_index%, 5, 1)
							character_index += 2
							option9 := % all_characters%ch_mode%%character_index%
						}
						Else If (character_code < 80)
				    {
							character_index := 71
							option1 := % all_characters%ch_mode%%character_index%
							character_index += 2
							If (StrLen(all_characters%ch_mode%%character_index%) <> 5 )
								option3 = % "  "
							Else
								option3 = % " " + SubStr(all_characters%ch_mode%%character_index%, 5, 1)
							character_index++
							option4 := % all_characters%ch_mode%%character_index%
							character_index += 3
							option7 := % all_characters%ch_mode%%character_index%
							character_index++
							option8 := % all_characters%ch_mode%%character_index%
							character_index++
							option9 := % all_characters%ch_mode%%character_index%
						}
						Else If (character_code < 90)
				    {
							character_index := 83
							;option4 := % all_characters%ch_mode%%character_index%
							;character_index--
							option3 := % all_characters%ch_mode%%character_index%
							character_index--
							option2 := % all_characters%ch_mode%%character_index%
							character_index--
							option1 := % all_characters%ch_mode%%character_index%
							character_index := 87
							option7 := % all_characters%ch_mode%%character_index%
							character_index++
							option8 := % all_characters%ch_mode%%character_index%
							character_index++
							option9 := % all_characters%ch_mode%%character_index%
						}
						Else
				    {
							character_index := 91
							If (StrLen(all_characters%ch_mode%%character_index%) <> 5 )
								option1 = % "  "
							Else
								option1 = % " " + SubStr(all_characters%ch_mode%%character_index%, 5, 1)
							character_index += 2
							option3 := % all_characters%ch_mode%%character_index%
							character_index += 3
							option6 := % all_characters%ch_mode%%character_index%
							character_index++
							option7 := % all_characters%ch_mode%%character_index%
							character_index++
							option8 := % all_characters%ch_mode%%character_index%
							character_index++
							option9 := % all_characters%ch_mode%%character_index%
						}
					}
			  }

				character := % all_characters%ch_mode%%character_code%
				If (character = "")
					character := "  "

				mode_title := % character_mode_list%ch_mode%
				If (character_mode > 20)
				{
					mode_title = %mode_title% Latch
				}

				SubText = %A_Space%|---------+---------+---------|`n
										|%character11% %character12% %character13% |%character21% %character22% %character23% |%character31% %character32% %character33% |`n
										|%character14% %character19%    |%character27% %character28% %character29% |   %character37% %character36% |`n
										|%character17%    %option1% |   %option2%    |%option3%    %character39% |`n
										|---------+---------+---------|`n
										|%character41% %character43%    |         |   %character61% %character63% |`n
										|%character44% %character46% %option4% |         |%option6% %character64% %character66% |`n
										|%character47% %character49%    |         |   %character67% %character69% |`n
										|---------+---------+---------|`n
										|%character71%    %option7% |   %option8%    |%option9%    %character93% |`n
										|%character74% %character73%    |%character81% %character82% %character83% |   %character91% %character96% |`n
										|%character77% %character78% %character79% |%character87% %character88% %character89% |%character97% %character98% %character99% |`n
										|---------+---------+---------|

				HUD_loop_count++

				DetectHiddenWindows, on
				bar_TransValue_steps := 4
				bar_TransValue := 150 / bar_TransValue_steps

				If (HUD_loop_count > 0 && mod(HUD_loop_count, HUD_loop_count_skip) = 0)
				{
					bar_TransValue_step := HUD_loop_count / HUD_loop_count_skip
					If (bar_TransValue_step < bar_TransValue_steps + 1)
					{
						bar_TransValue_current := bar_TransValue * bar_TransValue_step
						If (mod(bar_TransValue_step, 4) = 1)
						{
							{
								Progress, 1:b zh0 fm32 fs28 w800 ctRed cwBlack
					      	, %A_Space%%SubText% , % mode_title, HUDbackground1, Courier New
								WinSet, Transparent, % bar_TransValue_current, HUDbackground1
								Progress, 5:b zh0 fm32 fs28 w800 ctRed cwBlack
					      	, `n`n`n`n`n`n`n`n`n`n`n`n
					        , % mode_title, HUDforeground5, Courier New
								WinSet, Transparent, 100, HUDforeground5
								WinSet, TransColor, 000000, HUDforeground5
								Progress, 9:b zh0 fm32 fs28 w800 ctRed cwBlack
					      	, `n`n`n`n`n`n%A_Space%              %character%               `n`n`n`n`n`n
					        , %A_Space%, HUDforeground2, Courier New
								WinSet, TransColor, 000000, HUDforeground2
							}
						}
						Else If (mod(bar_TransValue_step, 4) = 2)
						{
							{
								Progress, 3:b zh0 fm32 fs28 w800 ctRed cwBlack
					      	, %A_Space%%SubText% , % mode_title, HUDbackground3, Courier New
								WinSet, Transparent, % bar_TransValue_current, HUDbackground3
								Progress, 5:b zh0 fm32 fs28 w800 ctRed cwBlack
					      	, `n`n`n`n`n`n`n`n`n`n`n`n
					        , % mode_title, HUDforeground5, Courier New
								WinSet, Transparent, 100, HUDforeground5
								WinSet, TransColor, 000000, HUDforeground5
								Progress, 7:b zh0 fm32 fs28 w800 ctRed cwBlack
					      	, `n`n`n`n`n`n%A_Space%              %character%               `n`n`n`n`n`n
					        , %A_Space%, HUDforeground3, Courier New
								WinSet, TransColor, 000000, HUDforeground3
							}
						}
						Else If (mod(bar_TransValue_step, 4) = 3)
						{
							{
								Progress, 4:b zh0 fm32 fs28 w800 ctRed cwBlack
					      	, %A_Space%%SubText% , % mode_title, HUDbackground4, Courier New
								WinSet, Transparent, % bar_TransValue_current, HUDbackground4
								Progress, 5:b zh0 fm32 fs28 w800 ctRed cwBlack
					      	, `n`n`n`n`n`n`n`n`n`n`n`n
					        , % mode_title, HUDforeground5, Courier New
								WinSet, Transparent, 100, HUDforeground5
								WinSet, TransColor, 000000, HUDforeground5
								Progress, 6:b zh0 fm32 fs28 w800 ctRed cwBlack
					      	, `n`n`n`n`n`n%A_Space%              %character%               `n`n`n`n`n`n
					        , %A_Space%, HUDforeground4, Courier New
								WinSet, TransColor, 000000, HUDforeground4
							}
						}
						Else
						{
							{
								Progress, 2:b zh0 fm32 fs28 w800 ctRed cwBlack
					      	, %A_Space%%SubText% , % mode_title, HUDbackground2, Courier New
								WinSet, Transparent, % bar_TransValue_current, HUDbackground2
								Progress, 5:b zh0 fm32 fs28 w800 ctRed cwBlack
					      	, `n`n`n`n`n`n`n`n`n`n`n`n
					        , % mode_title, HUDforeground5, Courier New
								WinSet, Transparent, 100, HUDforeground5
								WinSet, TransColor, 000000, HUDforeground5
								Progress, 8:b zh0 fm32 fs28 w800 ctRed cwBlack
					      	, `n`n`n`n`n`n%A_Space%              %character%               `n`n`n`n`n`n
					        , %A_Space%, HUDforeground3, Courier New
								WinSet, TransColor, 000000, HUDforeground3
							}
						}
					}
				}

				If (character_code <> character_code_pre)
				{
					Progress, 6:OFF
					Progress, 7:OFF
					Progress, 8:OFF
					Progress, 9:OFF
					Progress, 10:b zh0 fm32 fs28 w800 ctRed cwBlack
		      , `n`n`n`n`n`n%A_Space%              %character%               `n`n`n`n`n`n
		        , %A_Space%, HUDforeground, Courier New
					WinSet, TransColor, 000000, HUDforeground
				}
		  }
		}
	}
  Else
  {

    If (character_code <> 0)
    {
      ; SendInput, %character_code%
			If (character_code = 20 || character_code = 22)
      {
        SendInput, {Backspace}
      }
      Else If (character_code = 21) ; || character_code = 24)
      {
				If (character_mode = 3)
        	character_mode := 1
				Else If (character_mode = 33)
        	character_mode := 3
				Else
        	character_mode := 33
      }
      Else If (character_code = 27)
      {
				If (character_mode = 3)
        	character_mode := 1
				Else
        	character_mode := 3
      }
      Else If (character_code = 23) ; || character_code = 26)
      {
				If (character_mode = 2)
        	character_mode := 1
				Else If (character_mode = 22)
        	character_mode := 2
				Else
        	character_mode := 22
      }
      Else If (character_code = 29)
      {
				If (character_mode = 2)
        	character_mode := 1
				Else
        	character_mode := 2
      }
      Else If (character_code = 28)
      {
				If (character_mode = 5)
        	character_mode := 1
				Else If (character_mode = 55)
        	character_mode := 5
				Else
        	character_mode := 55
      }
      Else If (character_code = 80 || character_code = 88)
      {
        SendInput, {Space}
      }
      Else If (character_code = 87) ; || character_code = 84)
      {
				If (false) ;(mod(character_mode, 10) = 5)
				{
        	SendInput, !{Enter}
					If (character_mode > 20)
						character_mode := 1
				}
				Else
        	SendInput, {Enter}
      }
      Else If (character_code = 81)
      {
        SendInput, {Tab}
      }
      Else If (character_code = 89) ; || character_code = 86)
      {
				If (character_mode = 4)
        	character_mode := 1
				Else If (character_mode = 44)
        	character_mode := 4
				Else
        	character_mode := 44
      }
      Else If (character_code = 83)
      {
				If (character_mode = 4)
        	character_mode := 1
				Else
        	character_mode := 4
      }
      Else If (character_code = 82)
      {
				If (character_mode = 5)
        	character_mode := 1
				Else
        	character_mode := 5
      }
      Else If (all_characters%ch_mode%%character_code% = "Ec")
      {
				SendInput, {Escape}
				If (character_mode > 20)
        	character_mode := 1
      }
      Else If (all_characters%ch_mode%%character_code% = "In")
      {
				SendInput, {Insert}
				If (character_mode > 20)
        	character_mode := 1
      }
      Else If (StrLen(all_characters%ch_mode%%character_code%) = 5 && SubStr(all_characters%ch_mode%%character_code%, 1, 4) = "TAid")
      {
				;SendEvent, % " " + SubStr(all_characters%ch_mode%%character_code%, 2, 1)
	      If (SubStr(all_characters%ch_mode%%character_code%, 5, 1) = "1")
	      {
					;SendRaw, 11
					;SendEvent, {Numpad1}
					;SendEvent, {1}{1}
					;Sleep, 200
					;SendEvent, {1}
					SetKeyDelay, 100
					Send {1}
					If (double_tap)
						Send {1}
					SetKeyDelay, -1
	      }
	      Else If (SubStr(all_characters%ch_mode%%character_code%, 5, 1) = "2")
	      {
					;SendRaw, 22
					SetKeyDelay, 100
					Send {2}
					If (double_tap)
						Send {2}
					SetKeyDelay, -1
					;SendEvent, {2}{2}
					;SendEvent, {Numpad2}
	      }
	      Else If (SubStr(all_characters%ch_mode%%character_code%, 5, 1) = "3")
	      {
					;SendRaw, 33
					SetKeyDelay, 100
					Send {3}
					If (double_tap)
						Send {3}
					SetKeyDelay, -1
					;SendEvent, {3}{3}
					;SendEvent, {Numpad3}
	      }
	      Else If (SubStr(all_characters%ch_mode%%character_code%, 5, 1) = "4")
	      {
					;SendRaw, 44
					SetKeyDelay, 100
					Send {4}
					If (double_tap)
						Send {4}
					SetKeyDelay, -1
					;SendEvent, {4}{4}
					;SendEvent, {Numpad4}
	      }
	      Else If (SubStr(all_characters%ch_mode%%character_code%, 5, 1) = "5")
	      {
					;SendRaw, 55
					SetKeyDelay, 100
					Send {5}
					If (double_tap)
						Send {5}
					SetKeyDelay, -1
					;SendEvent, {5}{5}
					;SendEvent, {Numpad5}
	      }
	      Else If (SubStr(all_characters%ch_mode%%character_code%, 5, 1) = "6")
	      {
					;SendRaw, 66
					SetKeyDelay, 100
					Send {6}
					If (double_tap)
						Send {6}
					SetKeyDelay, -1
					;SendEvent, {6}{6}
					;SendEvent, {Numpad6}
	      }
	      Else If (SubStr(all_characters%ch_mode%%character_code%, 5, 1) = "7")
	      {
					SetKeyDelay, 100
					Send {7}
					If (double_tap)
						Send {7}
					SetKeyDelay, -1
	      }
	      Else If (SubStr(all_characters%ch_mode%%character_code%, 5, 1) = "8")
	      {
					SetKeyDelay, 100
					Send {8}
					If (double_tap)
						Send {8}
					SetKeyDelay, -1
	      }
	      Else If (SubStr(all_characters%ch_mode%%character_code%, 5, 1) = "9")
	      {
					SetKeyDelay, 100
					Send {9}
					If (double_tap)
						Send {9}
					SetKeyDelay, -1
	      }
	      Else If (SubStr(all_characters%ch_mode%%character_code%, 5, 1) = "0")
	      {
					SetKeyDelay, 100
					Send {0}
					If (double_tap)
						Send {0}
					SetKeyDelay, -1
	      }
      }
      Else
      {
				If (all_characters%ch_mode%%character_code% <> "")
				{
					If (ch_mode < 5)
					{
						SendRaw, % SubStr(all_characters%ch_mode%%character_code%, 2, 1)
					}
		      Else
		      {
						Progress, 1:Off
				    Progress, 2:Off
						Progress, 3:Off
						Progress, 4:Off
						Progress, 5:Off
						Progress, 6:Off
						Progress, 7:Off
						Progress, 8:Off
						Progress, 9:Off
						Progress, 10:Off
						SendInput, % all_characters_long%ch_mode%%character_code%
					}
					If (character_mode > 20)
						character_mode := 1
				}
			}

	    character_code = 0
			;HUD_loop_count = 0
			HUD_loop_count := -HUD_loop_count_delay
	    Progress, 1:Off
	    Progress, 2:Off
			Progress, 3:Off
			Progress, 4:Off
			Progress, 5:Off
			Progress, 6:Off
			Progress, 7:Off
			Progress, 8:Off
			Progress, 9:Off
			Progress, 10:Off
    }
  }
	;ToolTip, %joy_name% (#%JoystickNumber%):`n%axis_info%`nButtons Down: %buttons_down%`n`n(right-click the tray icon to exit)`ncharacter_code: %character_code%%A_Space%theta: %theta%%A_Space%loop_count: %loop_count%
	Sleep, 1
}
return
