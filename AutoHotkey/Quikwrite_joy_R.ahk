; Quikwriting modeled input with a joystick
;	v1.1
;
JoystickNumber := 0 ; 3 ; 1
#Include Quikwrite.ahk
Rumble_Mode := 0 ; 2 ;
audio_feedback := 0 ; 1
Angle_Offset := -3.14159 / 8 ; 15 ; 12 ; 6 ; 2 ;
Menu, tray, Icon, %A_ScriptDir%\wheel_red.ico, ,1

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
			  joyx := 50 + State.sThumbRX / 645
				joyy := 50 + State.sThumbRY / -645
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
			  If ((State.wButtons & XINPUT_GAMEPAD_RIGHT_THUMB) || (State.wButtons & XINPUT_GAMEPAD_START))
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
		, joy_mode, rotate, recentre, daynight, Rumble_Mode, Angle_Offset)

}
Return
