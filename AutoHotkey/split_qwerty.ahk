; Imitating a split 40% keyboard with two numpads.
; The left one is identified by having the numlock ON.
; It is currently QWERTY because the 10-9-7 alpha layout fitted best.
;
;
;SetStoreCapslockMode, Off

ConditionalSendInput(c1, c2, c3, c4)
{
  If ( GetKeyState("NumpadEnd", "P") )
  {
    SendInput, {Control down}
  }
  Else
  {
    SendInput, {Control up}
  }
  If ( GetKeyState("NumpadLeft", "P") )
  {
    SendInput, {Shift down}
  }
  Else
  {
    SendInput, {Shift up}
  }
  If ( GetKeyState("NumpadHome", "P") )
  {
    SendInput, {Alt down}
  }
  Else
  {
    SendInput, {Alt up}
  }

  If ( GetKeyState("ScrollLock", "T") )
  {
    If ( GetKeyState("Capslock", "T") )
    {
      SendInput, % c4
    }
    Else
    {
      SetScrollLockState, Off
      SendInput, % c3
    }
  }
  Else
  {
    If ( GetKeyState("Capslock", "T") )
    {
      SendInput, % c2
    }
    Else
    {
      SendInput, % c1
    }
  }
  SendInput, {Control up}
  SendInput, {Shift up}
  SendInput, {Alt up}
  Return
}

ConditionalSendInputwithMouseMove(c1, mx, my, c3, c4)
{
  If ( GetKeyState("NumpadEnd", "P") )
  {
    SendInput, {Control down}
  }
  Else
  {
    SendInput, {Control up}
  }
  If ( GetKeyState("NumpadLeft", "P") )
  {
    SendInput, {Shift down}
  }
  Else
  {
    SendInput, {Shift up}
  }
  If ( GetKeyState("NumpadHome", "P") )
  {
    SendInput, {Alt down}
  }
  Else
  {
    SendInput, {Alt up}
  }

  If ( GetKeyState("ScrollLock", "T") )
  {
    If ( GetKeyState("Capslock", "T") )
    {
      SendInput, % c4
    }
    Else
    {
      SetScrollLockState, Off
      SendInput, % c3
    }
  }
  Else
  {
    If ( GetKeyState("Capslock", "T") )
    {
			SetMouseDelay, -1  ; Makes movement smoother.
      speed := 10
      mx *= speed
      my *= speed
      MouseMove, % mx, % my, 0, R
    }
    Else
    {
      SendInput, % c1
    }
  }
  SendInput, {Control up}
  SendInput, {Shift up}
  SendInput, {Alt up}
  Return
}

ConditionalSendInputwithMouseClick(c1, mbutton, action, c3, c4)
{
  If ( GetKeyState("NumpadEnd", "P") )
  {
    SendInput, {Control down}
  }
  Else
  {
    SendInput, {Control up}
  }
  If ( GetKeyState("NumpadLeft", "P") )
  {
    SendInput, {Shift down}
  }
  Else
  {
    SendInput, {Shift up}
  }
  If ( GetKeyState("NumpadHome", "P") )
  {
    SendInput, {Alt down}
  }
  Else
  {
    SendInput, {Alt up}
  }

  If ( GetKeyState("ScrollLock", "T") )
  {
    If ( GetKeyState("Capslock", "T") )
    {
      SendInput, % c4
    }
    Else
    {
      SetScrollLockState, Off
      SendInput, % c3
    }
  }
  Else
  {
    If ( GetKeyState("Capslock", "T") )
    {
			SetMouseDelay, -1  ; Makes movement smoother.
      MouseClick, % mbutton ,,, 1, 0, % action
    }
    Else
    {
      SendInput, % c1
    }
  }
  SendInput, {Control up}
  SendInput, {Shift up}
  SendInput, {Alt up}
  Return
}

ConditionalSendInputwithMouseScroll(c1, direction, c3, c4)
{
  If ( GetKeyState("NumpadEnd", "P") )
  {
    SendInput, {Control down}
  }
  Else
  {
    SendInput, {Control up}
  }
  If ( GetKeyState("NumpadLeft", "P") )
  {
    SendInput, {Shift down}
  }
  Else
  {
    SendInput, {Shift up}
  }
  If ( GetKeyState("NumpadHome", "P") )
  {
    SendInput, {Alt down}
  }
  Else
  {
    SendInput, {Alt up}
  }

  If ( GetKeyState("ScrollLock", "T") )
  {
    If ( GetKeyState("Capslock", "T") )
    {
      SendInput, % c4
    }
    Else
    {
      SetScrollLockState, Off
      SendInput, % c3
    }
  }
  Else
  {
    If ( GetKeyState("Capslock", "T") )
    {
    	ControlGetFocus, fcontrol, A
    	SendMessage, 0x114, %direction%, 0, %fcontrol%, A
    }
    Else
    {
      SendInput, % c1
    }
  }
  SendInput, {Control up}
  SendInput, {Shift up}
  SendInput, {Alt up}
  Return
}

ConditionalSendInputwithMouseButton(c1, mbuttoncur, mbuttonnew, c3, c4)
{
  If ( GetKeyState("NumpadEnd", "P") )
  {
    SendInput, {Control down}
  }
  Else
  {
    SendInput, {Control up}
  }
  If ( GetKeyState("NumpadLeft", "P") )
  {
    SendInput, {Shift down}
  }
  Else
  {
    SendInput, {Shift up}
  }
  If ( GetKeyState("NumpadHome", "P") )
  {
    SendInput, {Alt down}
  }
  Else
  {
    SendInput, {Alt up}
  }

  If ( GetKeyState("ScrollLock", "T") )
  {
    If ( GetKeyState("Capslock", "T") )
    {
      SendInput, % c4
    }
    Else
    {
      SetScrollLockState, Off
      SendInput, % c3
    }
  }
  Else
  {
    If ( GetKeyState("Capslock", "T") )
    {
      Return % mbuttonnew
    }
    Else
    {
      SendInput, % c1
    }
  }
  SendInput, {Control up}
  SendInput, {Shift up}
  SendInput, {Alt up}
  Return % mbuttoncur
}

scroll(direction)
{
	ControlGetFocus, fcontrol, A
	SendMessage, 0x114, %direction%, 0, %fcontrol%, A
  Sleep, 25
	;SoundBeep,2033,100
  Return
}

WheelLeft::scroll(0)
WheelRight::scroll(1)

MouseButton := Left

Backspace::ConditionalSendInput("{Backspace}", "{Backspace}", "{Delete}", "{Delete}")

NumpadSub::
  If ( GetKeyState("Numlock", "T") )
  {
    ConditionalSendInput("{Left}", "{Left}", "{Left}", "{Left}")
  }
  Else
  {
    ConditionalSendInput("{Raw}m", "{Raw}M", "{Raw};", "{Raw};")
  }
Return
Backspace & NumpadSub::
  If ( GetKeyState("Numlock", "T") )
  {
    ConditionalSendInputwithMouseScroll("{Home}", 0, "{Home}", "{Home}")
  }
  Else
  {
    ConditionalSendInputwithMouseMove("{Raw}M", 1, 1, "{Raw}:", "{Raw}:")
  }
Return

NumpadAdd::
  If ( GetKeyState("Numlock", "T") )
  {
    ConditionalSendInput("{Right}", "{Right}", "{Right}", "{Right}")
  }
  Else
  {
    ConditionalSendInput("{Raw}n", "{Raw}N", "{Raw}.", "{Raw}.")
  }
Return
Backspace & NumpadAdd::
  If ( GetKeyState("Numlock", "T") )
  {
    ConditionalSendInputwithMouseScroll("{End}", 1, "{End}", "{End}")
  }
  Else
  {
    ConditionalSendInputwithMouseMove("{Raw}N", 0, 1, "{Raw}>", "{Raw}>")
  }
Return

#UseHook On
Tab::ConditionalSendInput("{Raw}b", "{Raw}B", "{Raw},", "{Raw},")
Backspace & Tab::ConditionalSendInputwithMouseMove("{Raw}B", -1, 1, "{Raw}<", "{Raw}<")
#UseHook OFF

NumpadEnter::
  If ( GetKeyState("Numlock", "T") )
  {
    ConditionalSendInput("{Enter}", "{AppsKey}", "{Volume_Up}", "{Volume_Up}")
  }
  Else
  {
    ConditionalSendInput("{Space}", "{Space}", "{Tab}", "{Tab}")
  }
Return
Backspace & NumpadEnter::
  If ( GetKeyState("Numlock", "T") )
  {
    If ( GetKeyState("ScrollLock", "T") )
    {
      SetScrollLockState, Off
      If ( GetKeyState("Capslock", "T") )
      {
        SetCapslockState, Off
        SendInput, {Raw}
      }
      Else
      {
        SendInput, {Capslock}
      }
    }
    Else
    {
      If ( GetKeyState("Capslock", "T") )
      {
        SendInput, {ScrollLock}
      }
      Else
      {
        SendInput, {ScrollLock}
      }
    }
  }
  Else
  {
    If ( GetKeyState("ScrollLock", "T") )
    {
      SetScrollLockState, Off
      If ( GetKeyState("Capslock", "T") )
      {
        SetCapslockState, Off
        SendInput, {Raw}
      }
      Else
      {
        SendInput, {Capslock}
      }
    }
    Else
    {
      If ( GetKeyState("Capslock", "T") )
      {
        SendInput, {ScrollLock}
      }
      Else
      {
        SendInput, {ScrollLock}
      }
    }
  }
Return

NumpadMult::
  If ( GetKeyState("Numlock", "T") )
  {
    ConditionalSendInput("{Raw}q", "{Raw}Q", "{Up}", "{Up}")
  }
  Else
  {
    ConditionalSendInput("{Raw}l", "{Raw}L", "{Raw}|", "{Raw}|")
  }
Return
Backspace & NumpadMult::
  If ( GetKeyState("Numlock", "T") )
  {
    ConditionalSendInput("{Raw}Q", "{WheelUp}", "{PgUp}", "{PgUp}")
  }
  Else
  {
    ConditionalSendInputwithMouseMove("{Raw}L", 1,0, "{Raw}?", "{Raw}?")
  }
Return

Numpad9::ConditionalSendInput("{Raw}w", "{Raw}W", "{Raw}7", "{Raw}7")
Backspace & Numpad9::ConditionalSendInput("{Raw}W", "{F10}", "{Raw}&", "{Raw}&")

Numpad6::ConditionalSendInput("{Raw}e", "{Raw}E", "{Raw}8", "{Raw}8")
Backspace & Numpad6::ConditionalSendInput("{Raw}E", "{F11}", "{Raw}*", "{Raw}*")

Numpad3::ConditionalSendInput("{Raw}r", "{Raw}R", "{Raw}9", "{Raw}9")
Backspace & Numpad3::ConditionalSendInput("{Raw}R", "{F12}", "{Volume_Mute}", "{Volume_Mute}")

NumpadDot::ConditionalSendInput("{Raw}t", "{Raw}T", "{Raw}.", "{Raw}.")
Backspace & NumpadDot::ConditionalSendInput("{Raw}T", "{Raw}t", "{Raw}~", "{Raw}~")
NumpadDiv::
  If ( GetKeyState("Numlock", "T") )
  {
    ConditionalSendInput("{Raw}a", "{Raw}A", "{Down}", "{Down}")
  }
  Else
  {
    ConditionalSendInput("{Raw}p", "{Raw}P", "{Raw}#", "{Raw}#")
  }
Return
Backspace & NumpadDiv::
  If ( GetKeyState("Numlock", "T") )
  {
    ConditionalSendInput("{Raw}A", "{WheelDown}", "{PgDn}", "{PgDn}")
  }
  Else
  {
    ConditionalSendInputwithMouseMove("{Raw}P", 1,-1, "{Raw}@", "{Raw}@")
  }
Return

Numpad8::ConditionalSendInput("{Raw}s", "{Raw}S", "{Raw}4", "{Raw}4")
Backspace & Numpad8::ConditionalSendInput("{Raw}S", "{F5}", "{Raw}$", "{Raw}$")

Numpad5::ConditionalSendInput("{Raw}d", "{Raw}D", "{Raw}5", "{Raw}5")
Backspace & Numpad5::ConditionalSendInput("{Raw}D", "{F6}", "{Raw}%", "{Raw}%")

Numpad2::ConditionalSendInput("{Raw}f", "{Raw}F", "{Raw}6", "{Raw}6")
Backspace & Numpad2::ConditionalSendInput("{Raw}F", "{F8}", "{Raw}^", "{Raw}^")

Numpad7::ConditionalSendInput("{Raw}z", "{Raw}Z", "{Raw}1", "{Raw}1")
Backspace & Numpad7::ConditionalSendInput("{Raw}Z", "{F2}", "{Raw}!", "{Raw}!")

Numpad4::ConditionalSendInput("{Raw}x", "{Raw}x", "{Raw}2", "{Raw}2")
Backspace & Numpad4::ConditionalSendInput("{Raw}X", "{F3}", "{Raw}`", "{Raw}`")

Numpad1::ConditionalSendInput("{Raw}c", "{Raw}C", "{Raw}3", "{Raw}3")
Backspace & Numpad1::ConditionalSendInput("{Raw}C", "{F4}", "{U+00A3}", "{U+00A3}")

Numpad0::ConditionalSendInput("{Raw}v", "{Raw}V", "{Raw}0", "{Raw}0")
Backspace & Numpad0::ConditionalSendInputwithMouseClick("{Raw}V", MouseButton, "U", "{Volume_Down}", "{Volume_Down}")




NumpadEnd::Return ;ConditionalSendInput("{Raw}", "{Raw}", "{Raw}", "{Raw}")
Backspace & NumpadEnd::SendInput, {Escape} ;Return ;ConditionalSendInput("{Raw}", "{Raw}", "{Raw}", "{Raw}")

NumpadLeft::Return ;ConditionalSendInput("{Raw}", "{Raw}", "{Raw}", "{Raw}")
Backspace & NumpadLeft::SendInput, {Insert} ;Return ;ConditionalSendInput("{Raw}", "{Raw}", "{Raw}", "{Raw}")

NumpadHome::Return ;ConditionalSendInput("{Raw}", "{Raw}", "{Raw}", "{Raw}")
Backspace & NumpadHome::
  SendInput, {Control up}{Shift up}{Alt up}
  SetCapslockState, off
  SetScrollLockState, off
  Reload
  Sleep 1000 ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
  MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
  IfMsgBox, Yes, Edit
Return ;ConditionalSendInput("{Raw}", "{Raw}", "{Raw}", "{Raw}")

NumpadIns::ConditionalSendInput("{Raw}y", "{Raw}Y", "{PrintScreen}", "{PrintScreen}")
Backspace & NumpadIns::ConditionalSendInputwithMouseClick("{Raw}Y", MouseButton, "D", "{Backspace}", "{Backspace}")

NumpadDown::ConditionalSendInput("{Raw}u", "{Raw}U", "{Raw}-", "{Raw}-")
Backspace & NumpadDown::MouseButton:=ConditionalSendInputwithMouseButton("{Raw}U", MouseButton, "Middle", "{Raw}_", "{Raw}_")

NumpadClear::ConditionalSendInput("{Raw}i", "{Raw}I", "{Raw}[", "{Raw}[")
Backspace & NumpadClear::ConditionalSendInputwithMouseMove("{Raw}I", -1,-1, "{Raw}{", "{Raw}{")

NumpadUp::ConditionalSendInput("{Raw}o", "{Raw}O", "{Raw}]", "{Raw}]")
Backspace & NumpadUp::ConditionalSendInputwithMouseMove("{Raw}O", 0,-1, "{Raw}}", "{Raw}}")

NumpadDel::ConditionalSendInput("{Raw}g", "{Raw}G", "{Raw}=", "{Raw}=")
Backspace & NumpadDel::MouseButton:=ConditionalSendInputwithMouseButton("{Raw}G", MouseButton, "Left", "{Raw}+", "{Raw}+")

NumpadPgDn::ConditionalSendInput("{Raw}h", "{Raw}H", "{Raw}'", "{Raw}'")
Backspace & NumpadPgDn::MouseButton:=ConditionalSendInputwithMouseButton("{Raw}H", MouseButton, "Right", "{U+0022}", "{U+0022}")

NumpadRight::ConditionalSendInput("{Raw}j", "{Raw}J", "{Raw}/", "{Raw}/")
Backspace & NumpadRight::ConditionalSendInputwithMouseMove("{Raw}J", -1,0, "{Raw}(", "{Raw}(")

NumpadPgUp::ConditionalSendInput("{Raw}k", "{Raw}K", "{Raw}\", "{Raw}\")
Backspace & NumpadPgUp::ConditionalSendInputwithMouseClick("{Raw}K", MouseButton, "", "{Raw})", "{Raw})")
