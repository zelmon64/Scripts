; Quikwriting modeled input with a joystick
;	v1.1
;
JoystickNumber := -1 ; 4 ; 2
#Include Quikwrite.ahk
Menu, tray, Icon, %A_ScriptDir%\wheel_purple.ico, ,1

Loop
{
	{ ; Controller input manipulations
		{ ; Joystick polling
			{
				; TestJoystick(JoystickNumber)
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
