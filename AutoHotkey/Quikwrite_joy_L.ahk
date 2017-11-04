; Quikwriting modeled input with a joystick
;	v1.1
;
JoystickNumber := 1
#Include Quikwrite.ahk
/*
JoystickNumber := 0 ; 3 ; 4 ;
If (!Joystick_Connect(JoystickNumber, joy_buttons, joy_name, joy_info))
{
	Reload
}
*/
Rumble_Mode := 2 ; 0 ;
Menu, tray, Icon, %A_ScriptDir%\wheel_blue.ico, ,1

Loop
{
	{ ; Controller input manipulations
		{ ; Joystick polling
			; buttons_down =
			{
				joy1 := "U"
				joy5 := "U"
				joy2 := "U"
				joy9 := "U"
				joyp := -1
			}
			/*
			{
				GetKeyState, joy5, %JoystickNumber%joy5
				if joy5 = D
					buttons_down = %buttons_down%%a_space%5
			}
			{
				GetKeyState, joy9, %JoystickNumber%joy9
				if joy9 = D
					buttons_down = %buttons_down%%a_space%9
			}
			GetKeyState, joyx, %JoystickNumber%JoyX
			axis_info = X%joyx%
			GetKeyState, joyy, %JoystickNumber%JoyY
			axis_info = %axis_info%%a_space%%a_space%Y%joyy%
			IfInString, joy_info, Z
			{
				GetKeyState, joyz, %JoystickNumber%JoyZ
				axis_info = %axis_info%%a_space%%a_space%Z%joyz%
				If joyz < 50
					joyz := 50
			}
			IfInString, joy_info, P
			{
				GetKeyState, joyp, %JoystickNumber%JoyPOV
				axis_info = %axis_info%%a_space%%a_space%POV%joyp%
			}
			*/
			{
			  State := XInput_GetState(JoystickNumber-1)
			  joyz := 50 + State.bLeftTrigger / 5.10
			  joyx := 50 + State.sThumbLX / 655.34
				joyy := 50 + State.sThumbLY / -655.34
			  If State.wButtons & XINPUT_GAMEPAD_DPAD_UP
			    joyp := 0
			  If State.wButtons & XINPUT_GAMEPAD_DPAD_DOWN
			    joyp := 18000
			  If State.wButtons & XINPUT_GAMEPAD_DPAD_LEFT
			    joyp := 27000
			  If State.wButtons & XINPUT_GAMEPAD_DPAD_RIGHT
			    joyp := 9000
				If State.wButtons & XINPUT_GAMEPAD_DPAD_UP && State.wButtons & XINPUT_GAMEPAD_DPAD_RIGHT
			    joyp := 4500
				If State.wButtons & XINPUT_GAMEPAD_DPAD_DOWN && State.wButtons & XINPUT_GAMEPAD_DPAD_LEFT
			    joyp := 18000 + 4500
			  If State.wButtons & XINPUT_GAMEPAD_DPAD_LEFT && State.wButtons & XINPUT_GAMEPAD_DPAD_UP
			    joyp := 27000 + 4500
			  If State.wButtons & XINPUT_GAMEPAD_DPAD_RIGHT && State.wButtons & XINPUT_GAMEPAD_DPAD_DOWN
			    joyp := 9000 + 4500
			  If State.wButtons & XINPUT_GAMEPAD_LEFT_THUMB
			    joy9 := "D"
			  If State.wButtons & XINPUT_GAMEPAD_LEFT_SHOULDER
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
