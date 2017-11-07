; Quikwriting modeled input with a joystick
;	v1.1
;
JoystickNumber := -1 ; 4 ; 2
#Include Quikwrite.ahk
/*
JoystickNumber := 0 ; 3 ; 4 ;
If (!Joystick_Connect(JoystickNumber, joy_buttons, joy_name, joy_info))
{
	Reload
}
*/
Menu, tray, Icon, %A_ScriptDir%\wheel_purple.ico, ,1

Loop
{
	{ ; Controller input manipulations
		{ ; Joystick polling
			/*
			buttons_down =
			Loop, %joy_buttons%
			{
				GetKeyState, joy%a_index%, %JoystickNumber%joy%a_index%
				if joy%a_index% = D
					buttons_down = %buttons_down%%a_space%%a_index%
			}
			{
				If (joy1 = "D" && joy3 = "D")
					joyp := 22500
				Else If (joy1 = "D" && joy2 = "D")
					joyp := 13500
				Else If (joy4 = "D" && joy3 = "D")
					joyp := 31500
				Else If (joy4 = "D" && joy2 = "D")
					joyp := 4500
				Else If (joy1 = "D")
					joyp := 18000
				Else If (joy2 = "D")
					joyp := 9000
				Else If (joy3 = "D")
					joyp := 27000
				Else If (joy4 = "D")
					joyp := 00000
				Else
					joyp := -1
				{
					joy1 := "U"
					joy2 := "U"
					joy3 := "U"
					joy4 := "U"
					joy5 := joy6
					joy9 := joy10
				}
			}
			GetKeyState, joyx, %JoystickNumber%JoyU
			axis_info = X%joyx%
			GetKeyState, joyy, %JoystickNumber%JoyR
			axis_info = %axis_info%%a_space%%a_space%Y%joyy%
			IfInString, joy_info, Z
			{
				GetKeyState, joyz, %JoystickNumber%JoyZ
				axis_info = %axis_info%%a_space%%a_space%Z%joyz%
				If joyz < 50
					joyz := 100 - joyz
				Else
					joyz := 50
			}
			*/
			{
				joy1 := "U"
				joy5 := "U"
				joy2 := "U"
				joy9 := "U"
				joyp := -1
			}
			{
			  State := XInput_GetState(JoystickNumber-1)
			  joyz := 50 + State.bRightTrigger / 5.10
			  joyx := 50 + State.sThumbRX / 655.34
				joyy := 50 + State.sThumbRY / -655.34
			  If State.wButtons & XINPUT_GAMEPAD_Y
			    joyp := 0
			  If State.wButtons & XINPUT_GAMEPAD_A
			    joyp := 18000
			  If State.wButtons & XINPUT_GAMEPAD_X
			    joyp := 27000
			  If State.wButtons & XINPUT_GAMEPAD_B
			    joyp := 9000
				If State.wButtons & XINPUT_GAMEPAD_Y && State.wButtons & XINPUT_GAMEPAD_B
			    joyp := 4500
				If State.wButtons & XINPUT_GAMEPAD_A && State.wButtons & XINPUT_GAMEPAD_X
			    joyp := 18000 + 4500
			  If State.wButtons & XINPUT_GAMEPAD_X && State.wButtons & XINPUT_GAMEPAD_Y
			    joyp := 27000 + 4500
			  If State.wButtons & XINPUT_GAMEPAD_B && State.wButtons & XINPUT_GAMEPAD_A
			    joyp := 9000 + 4500
			  If State.wButtons & XINPUT_GAMEPAD_RIGHT_THUMB
			    joy9 := "D"
			  If State.wButtons & XINPUT_GAMEPAD_RIGHT_SHOULDER
			    joy5 := "D"

			}
		}

		{ ; Controller disconnect
			If joyx <>
			{}
			Else If joyy <>
			{}
			Else
			{
				SoundBeep, 900, 100
				SoundBeep, 700, 100
				SoundBeep, 500, 200
				; break
				Reload
				Sleep 1000
				continue
			}
		}
	}

	MainLoop(joyx, joyy, joyz, joyp, joy1, joy2, joy5, joy9
		, joyx_pre, joyy_pre, joyp_pre, radius_pre, joy_mode_pre
		, joyx_0, joyy_0, joy_name, JoystickNumber, axis_info, buttons_down
		, character_code, SubText, button_click_pre, mouse_click_pre
		, loop_count, loop_count_repeat_base, loop_count_skip_base, HUD_loop_count_skip
		, HUD_loop_count_delay, HUD_loop_count, this_code, stick_mode, stick_centre
		, character_mode, ch_mode, amoffsetx, amoffsety, media_mode, dasher_mode
		, double_tap, audio_feedback, hold_pose, loop_count_max, rmin, rmax
		, joy_mode, rotate, recentre, daynight, Rumble_Mode)

}
Return
