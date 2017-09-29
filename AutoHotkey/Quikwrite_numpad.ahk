#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance
SetMouseDelay, -1  ; Makes movement smoother.

;Menu, tray, Icon, %A_ScriptDir%\wheel.ico, ,1
{
	 If A_IsCompiled
   {
      Menu, tray, Icon, %A_ScriptFullPath%\wheel_green.ico, -159
   } else
   {
      Menu, tray, Icon, %A_ScriptDir%\wheel_green.ico, ,1
   }
 }

SetTimer, WatchHotkeys, 1

{ ; Variables
  character_mode := 1
  character_code := 0
  HUD_loop_count_skip := 12 ;10 ;3
  HUD_loop_count_delay := 80 ;30
  HUD_loop_count := -HUD_loop_count_delay
  audio_feedback := 1
	double_tap := 1 ; 0 ;
  character_mode_lists = Lowercase,Capitals,Symbols,Numbers,Functions
  StringSplit, character_mode_list, character_mode_lists, `,
  NumsDown := "0"
	button_click_pre := -1 ;95 ;
	mouse_click_pre := 0
	loop_count := 0
	loop_count_repeat_base := 30 ;10
	loop_count_skip_base := 2 ;3
}

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
		mode_5_characters =  %mode_5_characters%^s,^s,AF,DT,PU,,,PD,,,
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

Numpad1::
Numpad2::
Numpad3::
Numpad4::
Numpad5::
Numpad6::
Numpad7::
Numpad8::
Numpad9::
Numpad0::
Return

WatchHotkeys:
{
  { ; poll numpad keys
    NumsDownPre = %NumsDown%
    if GetKeyState("Numpad1")
      NumsDown := "1"
    else
      NumsDown := "0"
    if GetKeyState("Numpad2")
      NumsDown = %NumsDown%1
    else
      NumsDown = %NumsDown%0
    if GetKeyState("Numpad3")
      NumsDown = %NumsDown%1
    else
      NumsDown = %NumsDown%0
    if GetKeyState("Numpad4")
      NumsDown = %NumsDown%1
    else
      NumsDown = %NumsDown%0
    if ((GetKeyState("Numpad5") && character_code = 0) || (SubStr(NumsDownPre, 5, 1) = "1" && button_click_pre <> -1))
      NumsDown = %NumsDown%1
    else
      NumsDown = %NumsDown%0
    if GetKeyState("Numpad6")
      NumsDown = %NumsDown%1
    else
      NumsDown = %NumsDown%0
    if GetKeyState("Numpad7")
      NumsDown = %NumsDown%1
    else
      NumsDown = %NumsDown%0
    if GetKeyState("Numpad8")
      NumsDown = %NumsDown%1
    else
      NumsDown = %NumsDown%0
    if GetKeyState("Numpad9")
      NumsDown = %NumsDown%1
    else
      NumsDown = %NumsDown%0
    if ((GetKeyState("Numpad0") && button_click_pre = -1) || (SubStr(NumsDownPre, 10, 1) = "1" && button_click_pre <> -1))
      NumsDown = %NumsDown%1
    else
      NumsDown = %NumsDown%0

    ;StringRight, Key, A_ThisHotkey, 1 ;Grab just the number pushed, trim off the "$Numpad"
    ;ToolTip % "You pressed the " A_ThisHotkey ", NumsDown: " NumsDown
    ;ToolTip, NumsDown: %NumsDown%
  }

  ch_mode := mod(character_mode, 10)

  If (SubStr(NumsDown, 10, 1) = "1")
  {
    loop_count_repeat := 1 * loop_count_repeat_base
    loop_count_skip := 2 * loop_count_skip_base
    If (loop_count > loop_count_repeat * 5)
    {
      loop_count_skip := loop_count_skip_base / 2
    }

    If (NumsDown = "0000000011")
    {
      If (button_click_pre <> NumsDown)
      {
        If button_click_pre = -1
          loop_count := 1
        button_click_pre := NumsDown
        SendInput, {WheelUp}
      }
      Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
      {
  			SendInput, {WheelUp}
      }
      loop_count++
    }
    Else If (NumsDown = "0000001001")
    {
      If (button_click_pre <> NumsDown)
      {
        If button_click_pre = -1
          loop_count := 1
        button_click_pre := NumsDown
  			SendInput, {WheelRight}
      }
      Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
      {
        SendInput, {WheelRight}
      }
      loop_count++
    }
    Else If (NumsDown = "1000000001")
    {
      If (button_click_pre <> NumsDown)
      {
        If button_click_pre = -1
          loop_count := 1
        button_click_pre := NumsDown
        SendInput, {WheelDown}
      }
      Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
      {
        SendInput, {WheelDown}
      }
      loop_count++
    }
    Else If (NumsDown = "0010000001")
    {
      If (button_click_pre <> NumsDown)
      {
        If button_click_pre = -1
          loop_count := 1
        button_click_pre := NumsDown
        SendInput, {WheelLeft}
      }
      Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
      {
        SendInput, {WheelLeft}
      }
      loop_count++
    }
    Else If (NumsDown = "0010000011" && button_click_pre <> NumsDown)
    {
      button_click_pre := NumsDown
      MouseClick, Left,,, 1, 0, D
    }
    Else If (NumsDown = "1010000001" && button_click_pre <> NumsDown)
    {
      button_click_pre := NumsDown
      MouseClick, X1,,, 1, 0
    }
    Else If (NumsDown = "0000001011" && button_click_pre <> NumsDown)
    {
      button_click_pre := NumsDown
      MouseClick, Right,,, 1, 0, D
    }
    Else If (NumsDown = "1000001001" && button_click_pre <> NumsDown)
    {
      button_click_pre := NumsDown
      MouseClick, Middle,,, 1, 0
    }
    Else If (NumsDown = "0000000001" && button_click_pre <> -1)
    {
      If (button_click_pre = "0010000011")
      {
        MouseClick, Left,,, 1, 0, U
      }
      Else If (button_click_pre = "0000001011")
      {
        MouseClick, Right,,, 1, 0, U
      }
      button_click_pre := -1
    }
  }
  Else If (SubStr(NumsDown, 1, 1) = "1" || SubStr(NumsDown, 3, 1) = "1" || SubStr(NumsDown, 7, 1) = "1" || SubStr(NumsDown, 9, 1) = "1")
  {
    loop_count_repeat := 1 * loop_count_repeat_base
    loop_count_skip := 2 * loop_count_skip_base
    If (loop_count > loop_count_repeat * 4)
    {
      loop_count_skip := loop_count_skip_base / 2
    }
    mouse_move_mult := 15

    If (NumsDown = "0000000010")
    {
      If (button_click_pre <> NumsDown)
      {
        If button_click_pre = -1
          loop_count := 1
        button_click_pre := NumsDown
  			MouseMove, 0, -mouse_move_mult, 0, R
      }
      Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
      {
  			MouseMove, 0, -mouse_move_mult, 0, R
      }
      loop_count++
    }
    Else If (NumsDown = "0000001000")
    {
      If (button_click_pre <> NumsDown)
      {
        If button_click_pre = -1
          loop_count := 1
        button_click_pre := NumsDown
  			MouseMove, mouse_move_mult, 0, 0, R
      }
      Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
      {
        MouseMove, mouse_move_mult, 0, 0, R
      }
      loop_count++
    }
    Else If (NumsDown = "1000000000")
    {
      If (button_click_pre <> NumsDown)
      {
        If button_click_pre = -1
          loop_count := 1
        button_click_pre := NumsDown
        MouseMove, 0, mouse_move_mult, 0, R
      }
      Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
      {
        MouseMove, 0, mouse_move_mult, 0, R
      }
      loop_count++
    }
    Else If (NumsDown = "0010000000")
    {
      If (button_click_pre <> NumsDown)
      {
        If button_click_pre = -1
          loop_count := 1
        button_click_pre := NumsDown
        MouseMove, -mouse_move_mult, 0, 0, R
      }
      Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
      {
        MouseMove, -mouse_move_mult, 0, 0, R
      }
      loop_count++
    }
    Else If (NumsDown = "0010000010")
    {
      If (button_click_pre <> NumsDown)
      {
        If button_click_pre = -1
          loop_count := 1
        button_click_pre := NumsDown
        MouseMove, -mouse_move_mult, -mouse_move_mult, 0, R
      }
      Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
      {
        MouseMove, -mouse_move_mult, -mouse_move_mult, 0, R
      }
      loop_count++
    }
    Else If (NumsDown = "1010000000")
    {
      If (button_click_pre <> NumsDown)
      {
        If button_click_pre = -1
          loop_count := 1
        button_click_pre := NumsDown
        MouseMove, -mouse_move_mult, mouse_move_mult, 0, R
      }
      Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
      {
        MouseMove, -mouse_move_mult, mouse_move_mult, 0, R
      }
      loop_count++
    }
    Else If (NumsDown = "0000001010")
    {
      If (button_click_pre <> NumsDown)
      {
        If button_click_pre = -1
          loop_count := 1
        button_click_pre := NumsDown
        MouseMove, mouse_move_mult, -mouse_move_mult, 0, R
      }
      Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
      {
        MouseMove, mouse_move_mult, -mouse_move_mult, 0, R
      }
      loop_count++
    }
    Else If (NumsDown = "1000001000")
    {
      If (button_click_pre <> NumsDown)
      {
        If button_click_pre = -1
          loop_count := 1
        button_click_pre := NumsDown
        MouseMove, mouse_move_mult, mouse_move_mult, 0, R
      }
      Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
      {
        MouseMove, mouse_move_mult, mouse_move_mult, 0, R
      }
      loop_count++
    }
  }
  Else If (SubStr(NumsDown, 5, 1) = "1")
  {
    loop_count_repeat := 1 * loop_count_repeat_base
    loop_count_skip := 2 * loop_count_skip_base
    If (NumsDown = "0000100100")
    {
      If (button_click_pre <> NumsDown)
      {
        button_click_pre := NumsDown
        SendInput, {Up}
        loop_count := 1
      }
      Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
      {
        SendInput, {Up}
      }
      loop_count++
    }
    Else If (NumsDown = "0000110000")
    {
      If (button_click_pre <> NumsDown)
      {
        button_click_pre := NumsDown
        SendInput, {Right}
        loop_count := 1
      }
      Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
      {
        SendInput, {Right}
      }
      loop_count++
    }
    Else If (NumsDown = "0100100000")
    {
      If (button_click_pre <> NumsDown)
      {
        button_click_pre := NumsDown
        SendInput, {Down}
        loop_count := 1
      }
      Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
      {
        SendInput, {Down}
      }
      loop_count++
    }
    Else If (NumsDown = "0001100000")
    {
      If (button_click_pre <> NumsDown)
      {
        button_click_pre := NumsDown
        SendInput, {Left}
        loop_count := 1
      }
      Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
      {
        SendInput, {Left}
      }
      loop_count++
    }
    Else If (NumsDown = "0001100100" && button_click_pre <> NumsDown && double_tap = 0)
    {
      button_click_pre := NumsDown
      SendInput, {/}
    }
    Else If (NumsDown = "0001100100" && double_tap = 1)
    {
      If (button_click_pre <> NumsDown)
      {
        button_click_pre := NumsDown
        SendInput, {BackSpace}
        loop_count := -loop_count_repeat
      }
      Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
      {
        SendInput, {BackSpace}
      }
      loop_count++
    }
    Else If (NumsDown = "0101100000" && button_click_pre <> NumsDown)
    {
      button_click_pre := NumsDown
      SendInput, {Home}
    }
    Else If (NumsDown = "0000110100" && button_click_pre <> NumsDown && double_tap = 0)
    {
      button_click_pre := NumsDown
      SendInput, {#}
    }
    Else If (NumsDown = "0000110100" && double_tap = 1)
    {
      If (button_click_pre <> NumsDown)
      {
        button_click_pre := NumsDown
        SendInput, {Delete}
        loop_count := -loop_count_repeat
      }
      Else If (loop_count > loop_count_repeat && mod(loop_count, loop_count_skip) = 0)
      {
        SendInput, {Delete}
      }
      loop_count++
    }
    Else If (NumsDown = "0100110000" && button_click_pre <> NumsDown)
    {
      button_click_pre := NumsDown
      SendInput, {End}
    }
    Else If (NumsDown = "0000100000" && button_click_pre <> -1)
    {
      button_click_pre := -1
    }
  }
  Else If (SubStr(NumsDown, 2, 1) = "1" || SubStr(NumsDown, 4, 1) = "1" || SubStr(NumsDown, 6, 1) = "1" || SubStr(NumsDown, 8, 1) = "1")
  {
    character_code_pre := character_code
    { ; Joystick position
      If (NumsDown = "0000010000")
      {
        character_code := New_Code(character_code, 6)
      }
      Else If (NumsDown = "0000010100")
      {
        character_code := New_Code(character_code, 3)
      }
      Else If (NumsDown = "0000000100")
      {
        character_code := New_Code(character_code, 2)
      }
      Else If (NumsDown = "0001000100")
      {
        character_code := New_Code(character_code, 1)
      }
      Else If (NumsDown = "0001000000")
      {
        character_code := New_Code(character_code, 4)
      }
      Else If (NumsDown = "0101000000")
      {
        character_code := New_Code(character_code, 7)
      }
      Else If (NumsDown = "0100000000")
      {
        character_code := New_Code(character_code, 8)
      }
      Else If (NumsDown = "0100010000")
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

    If (character_code > 9 && audio_feedback <> 2)
    { ; Joystick position visual feedback
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
      Else If (all_characters%ch_mode%%character_code% = "DT")
      {
				If (double_tap = 0)
        {
          double_tap := 1
          SoundBeep, 900, 100
          SoundBeep, 1000, 100
        }
        Else
        {
          double_tap := 0
          SoundBeep, 1000, 100
          SoundBeep, 900, 100
        }
				If (character_mode > 20)
        	character_mode := 1
      }
      Else If (all_characters%ch_mode%%character_code% = "AF")
      {
				If (audio_feedback = 0)
        {
          audio_feedback := 1
          SoundBeep, 900, 100
        }
        Else If (audio_feedback = 1)
        {
          audio_feedback := 2
          SoundBeep, 900, 100
          Sleep, 100
          SoundBeep, 900, 100
        }
        Else
        {
          audio_feedback := 0
          SoundBeep, 900, 100
          Sleep, 100
          SoundBeep, 900, 100
          Sleep, 100
          SoundBeep, 900, 100
        }
				If (character_mode > 20)
        	character_mode := 1
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
        TAidnum := SubStr(all_characters%ch_mode%%character_code%, 5, 1)
	      If (TAidnum >= 0 && TAidnum <= 9)
	      {
          TAidnum := SubStr(all_characters%ch_mode%%character_code%, 5, 1)
					SendInput, %TAidnum%
					If (double_tap)
					{
            Sleep 100
            SendInput,  %TAidnum%
          }
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
    Else If (button_click_pre <> -1)
    {
      button_click_pre := -1
    }
  }
}
Return
