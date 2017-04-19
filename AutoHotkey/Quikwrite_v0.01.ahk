; Quikwriting modeled input with a joystick
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
;                                       0 1 2 3 4 5 6 7 8 9
/*
mode_1_characters =                        , , , , , , , , ,
mode_1_characters =  %mode_1_characters%a, ,s,k,m, , ,q, , ,
mode_1_characters =  %mode_1_characters%L,S,U, , , , , , , ,
mode_1_characters =  %mode_1_characters%n,p,f, , , ,l, , ,x,
mode_1_characters =  %mode_1_characters%e,h, , , , , ,c, , ,
mode_1_characters =  %mode_1_characters% , , , , , , , , , ,
mode_1_characters =  %mode_1_characters%t, , ,u, , , , , ,y,
mode_1_characters =  %mode_1_characters%o,v, , ,w, , , ,g,z,
mode_1_characters =  %mode_1_characters%R, , , , , , ,D, ,C,
mode_1_characters =  %mode_1_characters%i, , ,j, , ,r,b,d, ,
*/
all_characters := Object()
ArrayIndex1 := 1
ArrayIndex2 := 2
ArrayIndex3 := 3
ArrayIndex4 := 4
/*
all_characters%ArrayIndex1% := Object()
all_characters%ArrayIndex2% := Object()
all_characters%ArrayIndex3% := Object()
all_characters%ArrayIndex4% := Object()
*/
;                                       0 1 2 3 4 5 6 7 8 9
mode_1_characters =  %A_Space%              ,,,,,,,,,
mode_1_characters =  %mode_1_characters%a,a,s,k,m,,,q,,,
mode_1_characters =  %mode_1_characters%L,S,L,U,,,,,,,
mode_1_characters =  %mode_1_characters%n,p,f,n,,,l,,,x,
mode_1_characters =  %mode_1_characters%e,h,,,e,,,c,,,
mode_1_characters =  %mode_1_characters%,,,,,,,,,,
mode_1_characters =  %mode_1_characters%t,,,u,,t,,,,y,
mode_1_characters =  %mode_1_characters%o,v,,,w,,,o,g,z,
mode_1_characters =  %mode_1_characters%R,,,,,,,D,R,C,
mode_1_characters =  %mode_1_characters%i,,,j,,,r,b,d,i,
;StringSplit, mode_1_character, mode_1_characters, `,
StringSplit, all_characters%ArrayIndex1%, mode_1_characters, `,
;
;                                       0 1 2 3 4 5 6 7 8 9
mode_2_characters =   %A_Space%             ,,,,,,,,,
mode_2_characters =  %mode_2_characters%A,A,S,K,M,,,Q,,,
mode_2_characters =  %mode_2_characters%L,S,L,U,,,,,,,
mode_2_characters =  %mode_2_characters%N,P,F,N,,,L,,,X,
mode_2_characters =  %mode_2_characters%E,H,,,E,,,C,,,
mode_2_characters =  %mode_2_characters%,,,,,,,,,,
mode_2_characters =  %mode_2_characters%T,,,U,,T,,,,Y,
mode_2_characters =  %mode_2_characters%O,V,,,W,,,O,G,Z,
mode_2_characters =  %mode_2_characters%R,,,,,,,D,R,C,
mode_2_characters =  %mode_2_characters%I,,,J,,,R,B,D,I,
;StringSplit, mode_2_character, mode_2_characters, `,
StringSplit, all_characters%ArrayIndex2%, mode_2_characters, `,
;
;                                       0 1 2 3 4 5 6 7 8 9
mode_3_characters =    %A_Space%            ,,,,,,,,,
mode_3_characters =  %mode_3_characters%/,/,\,|,@,,,@,,,
mode_3_characters =  %mode_3_characters%L,S,L,U,,,,,,,
mode_3_characters =  %mode_3_characters%C,(,),C,,,[,,,],
mode_3_characters =  %mode_3_characters%;,#,,,;,,,:,,,
mode_3_characters =  %mode_3_characters%,,,,,,,,,,
mode_3_characters =  %mode_3_characters%',,,",,',,,,&,
mode_3_characters =  %mode_3_characters%*,^,,,*,,,*,{,},
mode_3_characters =  %mode_3_characters%R,,,,,,,D,R,C,
mode_3_characters =  %mode_3_characters%.,,,!,,,?,_,-,.,
;StringSplit, mode_3_character, mode_3_characters, `,
StringSplit, all_characters%ArrayIndex3%, mode_3_characters, `,
;
;                                       0 1 2 3 4 5 6 7 8 9
mode_4_characters =  %A_Space%            ,,,,,,,,,
mode_4_characters =  %mode_4_characters%0,0,<,>,1,,,2,,,
mode_4_characters =  %mode_4_characters%L,S,L,U,,,,,,,
mode_4_characters =  %mode_4_characters%C,(,),C,,,[,,,],
mode_4_characters =  %mode_4_characters%3,#,,,3,,,4,,,
mode_4_characters =  %mode_4_characters%,,,,,,,,,,
mode_4_characters =  %mode_4_characters%=,,,+,,=,,,,-,
mode_4_characters =  %mode_4_characters%5,/,,,*,,,5,6,7,
mode_4_characters =  %mode_4_characters%R,,,,,,,D,R,C,
mode_4_characters =  %mode_4_characters%.,,,9,,,8,$,P,.,
;StringSplit, mode_4_character, mode_4_characters, `,
StringSplit, all_characters%ArrayIndex4%, mode_4_characters, `,
;
;

; From "Joystick Test Script"
; If you want to unconditionally use a specific joystick number, change
; the following value from 0 to the number of the joystick (1-16).
; A value of 0 causes the joystick number to be auto-detected:
JoystickNumber = 2

; END OF CONFIG SECTION. Do not make changes below this point unless
; you wish to alter the basic functionality of the script.

; Auto-detect the joystick number if called for:
if JoystickNumber <= 0
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
		MsgBox The system does not appear to have any joysticks.
		ExitApp
	}
}

character_code = 0
character_code_pre = 0
this_code = 0
character_mode = 1
mode_characters := Object()
/*
all_characters := Object()
ArrayIndex1 := 1
ArrayIndex2 := 2
ArrayIndex3 := 3
ArrayIndex4 := 4
all_characters%ArrayIndex1% := Object()
all_characters%ArrayIndex2% := Object()
all_characters%ArrayIndex3% := Object()
all_characters%ArrayIndex4% := Object()

ArrayCount := 0
Loop 100
{
	ArrayCount += 1
	all_characters%ArrayIndex1%%ArrayCount% := mode_1_character%ArrayCount%
	all_characters%ArrayIndex2%%ArrayCount% := mode_2_character%ArrayCount%
	all_characters%ArrayIndex3%%ArrayCount% := mode_3_character%ArrayCount%
	all_characters%ArrayIndex4%%ArrayCount% := mode_4_character%ArrayCount%
}
*/

New_Code(character_code, this_code)
{
  ;this_code = 1
  If (character_code = 0)
  {
    Return this_code * 10
    ;character_code := this_code * 10
  }
  Else If (character_code = this_code * 10)
  {
    ; character_code = 10
	  Return character_code
  }
  Else If (Mod(character_code, 10) = 0)
  {
    Return character_code + this_code
    ;character_code += this_code
  }
  Else If (Mod(character_code, 10) <> this_code)
  {
    ;character_code := (character_code // 10) * 10 + this_code
    Return (character_code // 10) * 10 + this_code
  }
  Return character_code
}

#SingleInstance
SetFormat, float, 03  ; Omit decimal point from axis position percentages.
GetKeyState, joy_buttons, %JoystickNumber%JoyButtons
GetKeyState, joy_name, %JoystickNumber%JoyName
GetKeyState, joy_info, %JoystickNumber%JoyInfo
Loop
{
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

  tol = 25

  If (joyx < 50 - tol)
  {
    If (joyy < 50 - tol)
    {
      this_code = 1
      character_code := New_Code(character_code, this_code)
    }
    Else If (joyy > 50 + tol)
    {
      this_code = 7
      character_code := New_Code(character_code, this_code)
    }
    Else
    {
      this_code = 4
      character_code := New_Code(character_code, this_code)
    }
  }
  Else If (joyx > 50 + tol)
  {
    If (joyy < 50 - tol)
    {
      this_code = 3
      character_code := New_Code(character_code, this_code)
    }
    Else If (joyy > 50 + tol)
    {
      this_code = 9
      character_code := New_Code(character_code, this_code)
    }
    Else
    {
      this_code = 6
      character_code := New_Code(character_code, this_code)
    }
  }
  Else If (joyy < 50 - tol)
  {
    this_code = 2
    character_code := New_Code(character_code, this_code)
  }
  Else If (joyy > 50 + tol)
  {
    this_code = 8
    character_code := New_Code(character_code, this_code)
  }
  Else
  {
    ;If (character_code <> 0 && character_code // 10 <> Mod(character_code, 10))
    If (character_code <> 0)
    {
      ; SendInput, %character_code%
			If (character_code = 20 || character_code = 22)
      {
        SendInput, {Backspace}
      }
      Else If (character_code = 21)
      {
				If (character_mode = 3)
        	character_mode := 1
				Else
        	character_mode := 3
      }
      Else If (character_code = 23)
      {
				If (character_mode = 2)
        	character_mode := 1
				Else
        	character_mode := 2
      }
      Else If (character_code = 80 || character_code = 88)
      {
        SendInput, {Space}
      }
      Else If (character_code = 87)
      {
        SendInput, {Enter}
      }
      Else If (character_code = 89)
      {
				If (character_mode = 4)
        	character_mode := 1
				Else
        	character_mode := 4
      }
      Else
      {
				;SendInput, % all_characters%character_mode%%character_code%
				SendRaw, % all_characters%character_mode%%character_code%
			}
			/*
      Else If (character_mode = 1)
      {
        SendInput, % mode_1_character%character_code%
			}
      Else If (character_mode = 2)
      {
				SendInput, % mode_2_character%character_code%
			}
      Else If (character_mode = 3)
      {
        SendInput, % mode_3_character%character_code%
			}
      Else If (character_mode = 4)
      {
        SendInput, % mode_4_character%character_code%
			}
      Else
      {
				SendInput, % all_characters%character_mode%%character_code%
			}
			*/

	    character_code = 0
	    Progress, Off
    }
  }

  /*
  Progress, b zh0 fm32 fs28 w800 ctRed cwBlack
  ,  %A_Space%|---------+---------+---------|`n
              | a  s  k | S  L  U | p  f  m |`n
              | m       |         |       l |`n
              | q       |         |       x |`n
              |---------+---------+---------|`n
              | h       |         |       u |`n
              | e       |         |       t |`n
              | c       |         |       y |`n
              |---------+---------+---------|`n
              | v       |         |       j |`n
              | w       |         |       r |`n
              | o  g  z | D  R  C | b  d  i |`n
              |---------+---------+---------|
    ,,, Courier New
  */

  If (character_code < 10 || character_code = character_code_pre)
  {
    character_code_pre := character_code
  }
  Else
  {
    character_code_pre := character_code

		If (character_code = character_code_pre)
    {
      ;character := % mode_1_character%character_code%
	    character11 := A_Space
	    character12 := A_Space
	    character13 := A_Space
	    character14 := A_Space
	    character17 := A_Space
	    character21 := A_Space
	    character22 := A_Space
	    character23 := A_Space
	    character31 := A_Space
	    character32 := A_Space
	    character33 := A_Space
	    character36 := A_Space
	    character39 := A_Space
	    character41 := A_Space
	    character44 := A_Space
	    character47 := A_Space
	    character63 := A_Space
	    character66 := A_Space
	    character69 := A_Space
	    character71 := A_Space
	    character74 := A_Space
	    character77 := A_Space
	    character78 := A_Space
	    character79 := A_Space
	    character87 := A_Space
	    character88 := A_Space
	    character89 := A_Space
	    character93 := A_Space
	    character96 := A_Space
	    character97 := A_Space
	    character98 := A_Space
	    character99 := A_Space

			/*
			ArrayCount := 0
		  Loop 100
		  {
				ArrayCount += 1
				If (character_mode = 1)
		    {
					mode_character%ArrayCount% := mode_1_character%ArrayCount%
					;mode_character := mode_1_character
				}
				Else If (character_mode = 2)
		    {
					mode_character[ArrayCount] := mode_2_character%ArrayCount%
					;mode_character := mode_2_character
				}
				Else If (character_mode = 3)
		    {
					mode_character[ArrayCount] := mode_3_character%ArrayCount%
					;mode_character := mode_3_character
				}
				Else If (character_mode = 4)
		    {
					mode_character[ArrayCount] := mode_4_character%ArrayCount%
					;mode_character := mode_4_character
				}
				Else
		    {
					mode_character[ArrayCount] := mode_1_character%ArrayCount%
					;mode_character := mode_1_character
				}
			}
			*/
			/*
			If (character_mode = 1)
			{
				mode_character := mode_1_character
			}
			Else If (character_mode = 2)
			{
				mode_character := mode_2_character
			}
			Else If (character_mode = 3)
			{
				mode_character := mode_3_character
			}
			Else If (character_mode = 4)
			{
				mode_character := mode_4_character
			}
			Else
			{
				mode_character := mode_1_character
			}
			*/

			;character := % mode_character%character_code%
			;character := % mode_character%12%
			;character := all_characters[character_mode][character_code]
			character := % all_characters%character_mode%%character_code%

			If (character_code < 20)
	    {
				character_index := 11
				character11 := % all_characters%character_mode%%character_index%
				character_index++
				character12 := % all_characters%character_mode%%character_index%
				character_index++
				character13 := % all_characters%character_mode%%character_index%
				character_index++
				character14 := % all_characters%character_mode%%character_index%
				character_index += 3
				character17 = % all_characters%character_mode%%character_index%
			}
			Else If (character_code < 30)
	    {
				character_index := 21
				character21 := % all_characters%character_mode%%character_index%
				character_index++
				character22 := % all_characters%character_mode%%character_index%
				character_index++
				character23 := % all_characters%character_mode%%character_index%
			}
			Else If (character_code < 40)
	    {
				character_index := 31
				character31 := % all_characters%character_mode%%character_index%
				character_index++
				character32 := % all_characters%character_mode%%character_index%
				character_index++
				character33 := % all_characters%character_mode%%character_index%
				character_index += 3
				character36 := % all_characters%character_mode%%character_index%
				character_index += 3
				character39 := % all_characters%character_mode%%character_index%
			}
			Else If (character_code < 60)
	    {
				character_index := 41
				character41 := % all_characters%character_mode%%character_index%
				character_index += 3
				character44 := % all_characters%character_mode%%character_index%
				character_index += 3
				character47 := % all_characters%character_mode%%character_index%
			}
			Else If (character_code < 70)
	    {
				character_index := 63
				character63 := % all_characters%character_mode%%character_index%
				character_index += 3
				character66 := % all_characters%character_mode%%character_index%
				character_index += 3
				character69 := % all_characters%character_mode%%character_index%
			}
			Else If (character_code < 80)
	    {
				character_index := 71
				character71 := % all_characters%character_mode%%character_index%
				character_index += 3
				character74 := % all_characters%character_mode%%character_index%
				character_index += 3
				character77 := % all_characters%character_mode%%character_index%
				character_index++
				character78 := % all_characters%character_mode%%character_index%
				character_index++
				character79 := % all_characters%character_mode%%character_index%
			}
			Else If (character_code < 90)
	    {
				character_index := 87
				character87 := % all_characters%character_mode%%character_index%
				character_index++
				character88 := % all_characters%character_mode%%character_index%
				character_index++
				character89 := % all_characters%character_mode%%character_index%
			}
			Else
	    {
				character_index := 93
				character93 := % all_characters%character_mode%%character_index%
				character_index += 3
				character96 := % all_characters%character_mode%%character_index%
				character_index++
				character97 := % all_characters%character_mode%%character_index%
				character_index++
				character98 := % all_characters%character_mode%%character_index%
				character_index++
				character99 := % all_characters%character_mode%%character_index%
			}

      Progress, b zh0 fm32 fs28 w800 ctRed cwBlack
      ,  %A_Space%|---------+---------+---------|`n
                  | %character11%  %character12%  %character13% | %character21%  %character22%  %character23% | %character31%  %character32%  %character33% |`n
                  | %character14%       |         |       %character36% |`n
                  | %character17%       |         |       %character39% |`n
                  |---------+---------+---------|`n
                  | %character41%       |         |      %character63%  |`n
                  | %character44%       |    %character%    |       %character66% |`n
                  | %character47%       |         |       %character69% |`n
                  |---------+---------+---------|`n
                  | %character71%       |         |       %character93% |`n
                  | %character74%       |         |       %character96% |`n
                  | %character77%  %character78%  %character79% |  %character87%  %character88% %character89% | %character97%  %character98%  %character99% |`n
                  |---------+---------+---------|
        ,,, Courier New
    }
    Else If (character_code < 20)
    {
      character := % mode_1_character%character_code%
      Progress, b zh0 fm32 fs28 w800 ctRed cwBlack
      ,  %A_Space%|---------+---------+---------|`n
                  | a  s  k |         |         |`n
                  | m       |         |         |`n
                  | q       |         |         |`n
                  |---------+---------+---------|`n
                  |         |         |         |`n
                  |         |    %character%    |         |`n
                  |         |         |         |`n
                  |---------+---------+---------|`n
                  |         |         |         |`n
                  |         |         |         |`n
                  |         |         |         |`n
                  |---------+---------+---------|
        ,,, Courier New
    }
    Else If (character_code < 30)
    {
      character := % mode_1_character%character_code%
      Progress, b zh0 fm32 fs28 w800 ctRed cwBlack
      ,  %A_Space%|---------+---------+---------|`n
                  |         | S  L  U |         |`n
                  |         |         |         |`n
                  |         |         |         |`n
                  |---------+---------+---------|`n
                  |         |         |         |`n
                  |         |    %character%    |         |`n
                  |         |         |         |`n
                  |---------+---------+---------|`n
                  |         |         |         |`n
                  |         |         |         |`n
                  |         |         |         |`n
                  |---------+---------+---------|
        ,,, Courier New
    }
    Else If (character_code < 40)
    {
      character := % mode_1_character%character_code%
      Progress, b zh0 fm32 fs28 w800 ctRed cwBlack
      ,  %A_Space%|---------+---------+---------|`n
                  |         |         | p  f  m |`n
                  |         |         |       l |`n
                  |         |         |       x |`n
                  |---------+---------+---------|`n
                  |         |         |         |`n
                  |         |    %character%    |         |`n
                  |         |         |         |`n
                  |---------+---------+---------|`n
                  |         |         |         |`n
                  |         |         |         |`n
                  |         |         |         |`n
                  |---------+---------+---------|
        ,,, Courier New
    }
    Else If (character_code < 60)
    {
      character := % mode_1_character%character_code%
      Progress, b zh0 fm32 fs28 w800 ctRed cwBlack
      ,  %A_Space%|---------+---------+---------|`n
                  |         |         |         |`n
                  |         |         |         |`n
                  |         |         |         |`n
                  |---------+---------+---------|`n
                  | h       |         |         |`n
                  | e       |    %character%    |         |`n
                  | c       |         |         |`n
                  |---------+---------+---------|`n
                  |         |         |         |`n
                  |         |         |         |`n
                  |         |         |         |`n
                  |---------+---------+---------|
        ,,, Courier New
    }
    Else If (character_code < 70)
    {
      character := % mode_1_character%character_code%
      Progress, b zh0 fm32 fs28 w800 ctRed cwBlack
      ,  %A_Space%|---------+---------+---------|`n
                  |         |         |         |`n
                  |         |         |         |`n
                  |         |         |         |`n
                  |---------+---------+---------|`n
                  |         |         |       u |`n
                  |         |    %character%    |       t |`n
                  |         |         |       y |`n
                  |---------+---------+---------|`n
                  |         |         |         |`n
                  |         |         |         |`n
                  |         |         |         |`n
                  |---------+---------+---------|
        ,,, Courier New
    }
    Else If (character_code < 80)
    {
      character := % mode_1_character%character_code%
      Progress, b zh0 fm32 fs28 w800 ctRed cwBlack
      ,  %A_Space%|---------+---------+---------|`n
                  |         |         |         |`n
                  |         |         |         |`n
                  |         |         |         |`n
                  |---------+---------+---------|`n
                  |         |         |         |`n
                  |         |    %character%    |         |`n
                  |         |         |         |`n
                  |---------+---------+---------|`n
                  | v       |         |         |`n
                  | w       |         |         |`n
                  | o  y  z |         |         |`n
                  |---------+---------+---------|
        ,,, Courier New
    }
    Else If (character_code < 90)
    {
      character := % mode_1_character%character_code%
      Progress, b zh0 fm32 fs28 w800 ctRed cwBlack
      ,  %A_Space%|---------+---------+---------|`n
                  |         |         |         |`n
                  |         |         |         |`n
                  |         |         |         |`n
                  |---------+---------+---------|`n
                  |         |         |         |`n
                  |         |    %character%    |         |`n
                  |         |         |         |`n
                  |---------+---------+---------|`n
                  |         |         |         |`n
                  |         |         |         |`n
                  |         | D  R  C |         |`n
                  |---------+---------+---------|
        ,,, Courier New
    }
    Else
    {
      character := % mode_1_character%character_code%
      Progress, b zh0 fm32 fs28 w800 ctRed cwBlack
      ,  %A_Space%|---------+---------+---------|`n
                  |         |         |         |`n
                  |         |         |         |`n
                  |         |         |         |`n
                  |---------+---------+---------|`n
                  |         |         |         |`n
                  |         |    %character%    |         |`n
                  |         |         |         |`n
                  |---------+---------+---------|`n
                  |         |         |       j |`n
                  |         |         |       r |`n
                  |         |         | b  d  i |`n
                  |---------+---------+---------|
        ,,, Courier New
    }
  }
  ;Else
  ;  Progress, Off

	;ToolTip, %joy_name% (#%JoystickNumber%):`n%axis_info%`nButtons Down: %buttons_down%`n`n(right-click the tray icon to exit)`n(character_code: )%character_code%
	Sleep, 100
}
return
