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
    ConditionalSendInput("{Home}", "{Home}", "{Home}", "{Home}")
  }
  Else
  {
    ConditionalSendInput("{Raw}M", "{Raw}m", "{Raw}:", "{Raw}:")
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
    ConditionalSendInput("{End}", "{End}", "{End}", "{End}")
  }
  Else
  {
    ConditionalSendInput("{Raw}N", "{Raw}n", "{Raw}>", "{Raw}>")
  }
Return

NumpadEnter::
  If ( GetKeyState("Numlock", "T") )
  {
    ConditionalSendInput("{Enter}", "{Enter}", "{Volume_Up}", "{Volume_Up}")
  }
  Else
  {
    ConditionalSendInput("{Space}", "{Tab}", "{Tab}", "{Tab}")
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
    ConditionalSendInput("{Raw}Q", "{Raw}q", "{PgUp}", "{PgUp}")
  }
  Else
  {
    ConditionalSendInput("{Raw}L", "{Raw}l", "{Raw}?", "{Raw}?")
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
    ConditionalSendInput("{Raw}A", "{Raw}a", "{PgDn}", "{PgDn}")
  }
  Else
  {
    ConditionalSendInput("{Raw}P", "{Raw}p", "{Raw}@", "{Raw}@")
  }
Return

Numpad8::ConditionalSendInput("{Raw}s", "{Raw}S", "{Raw}4", "{Raw}4")
Backspace & Numpad8::ConditionalSendInput("{Raw}S", "{F7}", "{Raw}$", "{Raw}$")

Numpad5::ConditionalSendInput("{Raw}d", "{Raw}D", "{Raw}5", "{Raw}5")
Backspace & Numpad5::ConditionalSendInput("{Raw}D", "{F8}", "{Raw}%", "{Raw}%")

Numpad2::ConditionalSendInput("{Raw}f", "{Raw}F", "{Raw}6", "{Raw}6")
Backspace & Numpad2::ConditionalSendInput("{Raw}F", "{F9}", "{Raw}^", "{Raw}^")

Numpad7::ConditionalSendInput("{Raw}z", "{Raw}Z", "{Raw}1", "{Raw}1")
Backspace & Numpad7::ConditionalSendInput("{Raw}Z", "{F4}", "{Raw}!", "{Raw}!")

Numpad4::ConditionalSendInput("{Raw}x", "{Raw}x", "{Raw}2", "{Raw}2")
Backspace & Numpad4::ConditionalSendInput("{Raw}X", "{F5}", "{Raw}`", "{Raw}`")

Numpad1::ConditionalSendInput("{Raw}c", "{Raw}C", "{Raw}3", "{Raw}3")
Backspace & Numpad1::ConditionalSendInput("{Raw}C", "{F6}", "{U+00A3}", "{U+00A3}")

Numpad0::ConditionalSendInput("{Raw}v", "{Raw}V", "{Raw}0", "{Raw}0")
Backspace & Numpad0::ConditionalSendInput("{Raw}V", "{Raw}v", "{Volume_Down}", "{Volume_Down}")


NumpadEnd::Return ;ConditionalSendInput("{Raw}", "{Raw}", "{Raw}", "{Raw}")
Backspace & NumpadEnd::SendInput, {Escape} ;Return ;ConditionalSendInput("{Raw}", "{Raw}", "{Raw}", "{Raw}")

NumpadLeft::Return ;ConditionalSendInput("{Raw}", "{Raw}", "{Raw}", "{Raw}")
Backspace & NumpadLeft::SendInput, {Insert} ;Return ;ConditionalSendInput("{Raw}", "{Raw}", "{Raw}", "{Raw}")

NumpadHome::Return ;ConditionalSendInput("{Raw}", "{Raw}", "{Raw}", "{Raw}")
Backspace & NumpadHome::
  SendInput, {Control up}{Shift up}{Alt up}
  SetCapslockState, off
  SetScrollLockState, off
Return ;ConditionalSendInput("{Raw}", "{Raw}", "{Raw}", "{Raw}")

NumpadIns::ConditionalSendInput("{Raw}y", "{Raw}Y", "{PrintScreen}", "{PrintScreen}")
Backspace & NumpadIns::ConditionalSendInput("{Raw}Y", "{Raw}y", "{Raw}", "{Raw}")

NumpadDown::ConditionalSendInput("{Raw}u", "{Raw}U", "{Raw}-", "{Raw}-")
Backspace & NumpadDown::ConditionalSendInput("{Raw}U", "{Raw}u", "{Raw}_", "{Raw}_")

NumpadClear::ConditionalSendInput("{Raw}i", "{Raw}I", "{Raw}[", "{Raw}[")
Backspace & NumpadClear::ConditionalSendInput("{Raw}I", "{Raw}i", "{Raw}{", "{Raw}{")

NumpadUp::ConditionalSendInput("{Raw}o", "{Raw}O", "{Raw}]", "{Raw}]")
Backspace & NumpadUp::ConditionalSendInput("{Raw}O", "{Raw}o", "{Raw}}", "{Raw}}")

NumpadDel::ConditionalSendInput("{Raw}g", "{Raw}G", "{Raw}=", "{Raw}=")
Backspace & NumpadDel::ConditionalSendInput("{Raw}G", "{Raw}g", "{Raw}+", "{Raw}+")

NumpadPgDn::ConditionalSendInput("{Raw}h", "{Raw}H", "{Raw}'", "{Raw}'")
Backspace & NumpadPgDn::ConditionalSendInput("{Raw}H", "{Raw}h", "{U+0022}", "{U+0022}")

NumpadRight::ConditionalSendInput("{Raw}j", "{Raw}J", "{Raw}/", "{Raw}/")
Backspace & NumpadRight::ConditionalSendInput("{Raw}J", "{Raw}j", "{Raw}(", "{Raw}(")

NumpadPgUp::ConditionalSendInput("{Raw}k", "{Raw}K", "{Raw}\", "{Raw}\")
Backspace & NumpadPgUp::ConditionalSendInput("{Raw}K", "{Raw}k", "{Raw})", "{Raw})")

#UseHook On
Tab::ConditionalSendInput("{Raw}b", "{Raw}B", "{Raw},", "{Raw},")
Backspace & Tab::ConditionalSendInput("{Raw}B", "{Raw}b", "{Raw}<", "{Raw}<")
#UseHook OFF
