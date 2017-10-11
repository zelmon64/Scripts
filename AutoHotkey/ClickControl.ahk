#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

ButtonModePre := ""
ButtonMode := GuiUpdate("Left", ButtonModePre, 0)
ButtonDown := 0
ButtonLatch := 0
SetTitleMatchMode, 3

GuiUpdate(ButtonMode, ByRef ButtonModePre, ByRef ButtonLatch)
{
  If (ButtonMode = "Left")
  {
    If (ButtonLatch = 0 && ButtonMode = ButtonModePre)
      Return ButtonMode
    ButtonModePre := ButtonMode
    ButtonLatch := 0
  }
  Else If (ButtonLatch = 0 && ButtonMode <> ButtonModePre)
  {
    ButtonLatch := 1
    ; ButtonModePre := "Left"
  }
  Else If (ButtonLatch = 1 && ButtonMode <> ButtonModePre)
  {
    ; ButtonLatch := 0
    ButtonModePre := ButtonMode
  }
  Else If (ButtonLatch = 1 && ButtonMode = ButtonModePre)
  {
    ButtonLatch := 0
  }
  Else
    Return ButtonMode
  /*
  Else If (ButtonLatch := 1 && ButtonMode = ButtonModePre)
  {
    ButtonLatch := 0
  }
  ButtonModePre := ButtonMode
  */

  IfWinExist, ClickControl
  {
    WinGetPos, Xpos, Ypos  ; Uses the window found above.
    Gui Destroy
  }
  Gui, +AlwaysOnTop -SysMenu ; +Disabled -SysMenu +Owner avoids a taskbar button.
  Gui, font, s16, Verdana  ; Set 16-point Verdana.
  Gui, Add, Text,, Mouse left button`nfunction:

  Gui, font, s22, Verdana  ; Set 22-point Verdana.
  If ButtonLatch
  {
    Gui, Add, Text, cRed , %ButtonMode%
  }
  Else
    Gui, Add, Text,, %ButtonMode%
  ; Gui, Add, Text,, ButtonModePre: %ButtonModePre% %ButtonLatch%
  ; Gui, Add, Text,, ButtonLatch: %ButtonLatch%
  /*

  LockColour := EEAA99

  If (ButtonMode = "Left")
    Gui, Color, %LockColour%
  Else
    Gui, Color, Default
  Gui, Add, Button, Default, ___Left___

  If (ButtonMode = "Left Click")
    Gui, Color, %LockColour%
  Else
    Gui, Color, Default
  Gui, Add, Button,, &Left Click

  If (ButtonMode = "Left Drag")
    Gui, Color, %LockColour%
  Else
    Gui, Color, Default
  Gui, Add, Button,, L&eft Drag

  If (ButtonMode = "Left Double")
    Gui, Color, %LockColour%
  Else
    Gui, Color, Default
  Gui, Add, Button,, Le&ft Double

  If (ButtonMode = "Left Triple")
    Gui, Color, %LockColour%
  Else
    Gui, Color, Default
  Gui, Add, Button,, Lef&t Triple

  If (ButtonMode = "Right Click")
    Gui, Color, %LockColour%
  Else
    Gui, Color, Default
  Gui, Add, Button,, &Right Click

  If (ButtonMode = "Right Drag")
    Gui, Color, %LockColour%
  Else
    Gui, Color, Default
  Gui, Add, Button,, R&ight Drag

  If (ButtonMode = "Middle Click")
    Gui, Color, %LockColour%
  Else
    Gui, Color, Default
  Gui, Add, Button,, &Middle Click

  If (ButtonMode = "Middle Drag")
    Gui, Color, %LockColour%
  Else
    Gui, Color, Default
  Gui, Add, Button,, Mi&ddle Drag
  */

  Gui, Add, Button, Default, ___Left___
  ; Gui, Add, Text, cBlue gButton___Left___, ___Left___
  Gui, Add, Button,, &Left Click
  Gui, Add, Button,, L&eft Drag
  Gui, Add, Button,, Le&ft Double
  Gui, Add, Button,, Lef&t Triple
  Gui, Add, Button,, &Right Click
  Gui, Add, Button,, R&ight Drag
  Gui, Add, Button,, &Middle Click
  Gui, Add, Button,, Mi&ddle Drag

  If Xpos <>
  {
    Gui, Show, AutoSize X%Xpos% Y%Ypos% NoActivate, ClickControl
  }
  Else
    Gui, Show, AutoSize Center NoActivate, ClickControl

  IfWinActive, ClickControl
  {
     GroupAdd, GroupName, ClickControl
     GroupDeactivate, GroupName
  }
  ; Sleep, 2000
  Return ButtonMode
}
;Return

$LButton::
{
  /*
  If (ButtonMode <> ButtonModePre)
  {
    ButtonModePre := ButtonMode
    GuiUpdate(ButtonMode)
  }
  */
    IfWinExist, ClickControl
    {
      WinGet MMX, MinMax
      ; IfNotEqual MMX,0, WinRestore, Dasher
      ; IfWinActive,  Dasher
      ; SendInput, !{Tab}
      IfNotEqual MMX,0
      {
        WinGetPos, Xpos, Ypos, Width, Height  ; Uses the window found above.
        MouseGetPos, xpos, ypos, id, control
        WinGet, active_id, ID
      }
      Else
      {
        active_id := 0
        ID := 1
      }
    }
    Else
    {
      active_id := 0
      ID := 1
    }
  If (!WinActive(ClickControl) && active_id <> ID)
  {
     If (ButtonMode = "Left Click")
     {
       MouseClick, Left
       Sleep, 200
       If (ButtonLatch && !WinActive(ClickControl))
         ButtonMode := GuiUpdate(ButtonModePre, ButtonModePre, ButtonLatch)
     }
     Else If (ButtonMode = "Left Drag")
     {
       If ButtonDown
       {
         MouseClick, Left,,,,, U
         ButtonDown := 0
         Sleep, 200
         If (ButtonLatch && !WinActive(ClickControl))
           ButtonMode := GuiUpdate(ButtonModePre, ButtonModePre, ButtonLatch)
       }
       Else
       {
         MouseClick, Left,,,,, D
         ButtonDown := 1
       }
     }
     Else If (ButtonMode = "Left Double")
     {
       MouseClick, Left,,, 2
       Sleep, 200
       If (ButtonLatch && !WinActive(ClickControl))
         ButtonMode := GuiUpdate(ButtonModePre, ButtonModePre, ButtonLatch)
     }
     Else If (ButtonMode = "Left Triple")
     {
       MouseClick, Left,,, 3
       Sleep, 200
       If (ButtonLatch && !WinActive(ClickControl))
         ButtonMode := GuiUpdate(ButtonModePre, ButtonModePre, ButtonLatch)
     }
     Else If (ButtonMode = "Right Click")
     {
       MouseClick, Right
       Sleep, 200
       If (ButtonLatch && !WinActive(ClickControl))
         ButtonMode := GuiUpdate(ButtonModePre, ButtonModePre, ButtonLatch)
     }
     Else If (ButtonMode = "Right Drag")
     {
       If ButtonDown
       {
         MouseClick, Right,,,,, U
         ButtonDown := 0
         Sleep, 200
         If (ButtonLatch && !WinActive(ClickControl))
           ButtonMode := GuiUpdate(ButtonModePre, ButtonModePre, ButtonLatch)
       }
       Else
       {
         MouseClick, Right,,,,, D
         ButtonDown := 1
       }
     }
     Else If (ButtonMode = "Middle Click")
     {
       MouseClick, Middle
       Sleep, 200
       If (ButtonLatch && !WinActive(ClickControl))
         ButtonMode := GuiUpdate(ButtonModePre, ButtonModePre, ButtonLatch)
     }
     Else If (ButtonMode = "Middle Drag")
     {
       If ButtonDown
       {
         MouseClick, Middle,,,,, U
         ButtonDown := 0
         Sleep, 200
         If (ButtonLatch && !WinActive(ClickControl))
           ButtonMode := GuiUpdate(ButtonModePre, ButtonModePre, ButtonLatch)
       }
       Else
       {
         MouseClick, Middle,,,,, D
         ButtonDown := 1
       }
     }
     Else If (ButtonMode = "Right")
     {
       MouseClick, Right,,,,, D
     }
     Else  ;If (ButtonMode = "Left") ;
     {
       MouseClick, Left,,,,, D
     }
  }
  Else
  {
    If (active_id = ID)
      MouseClick, Left
    MouseClick, Left,,,,, D
  }
}
Return

$LButton Up::
{
  IfWinNotActive, ClickControl
  {
     If (ButtonMode = "Right" || (!ButtonDown && GetKeyState("RButton")))
     {
       MouseClick, Right,,,,, U
     }
     Else If (ButtonMode = "Left" || (!ButtonDown && GetKeyState("LButton")))
     {
       MouseClick, Left,,,,, U
     }
     Else If (ButtonMode = "Middle" || (!ButtonDown && GetKeyState("MButton")))
     {
       MouseClick, Middle,,,,, U
     }
  }
  Else
  {
     If (GetKeyState("RButton"))
     {
       MouseClick, Right,,,,, U
       ButtonDown := 0
     }
     Else If (GetKeyState("MButton"))
     {
       MouseClick, Middle,,,,, U
       ButtonDown := 0
     }
    MouseClick, Left,,,,, U
    ;MouseClick, Right,,,,, U  ;
    ;MouseClick, Middle,,,,, U
    ;Sleep, 200
    ;GroupAdd, GroupName, ClickControl
    ;GroupDeactivate, GroupName
  }
}
Return

Button___Left___:
     ButtonMode := GuiUpdate("Left", ButtonModePre, ButtonLatch)
Return

ButtonLeftClick:
     ButtonMode := GuiUpdate("Left Click", ButtonModePre, ButtonLatch)
Return

ButtonLeftDrag:
     ButtonMode := GuiUpdate("Left Drag", ButtonModePre, ButtonLatch)
     ButtonDown := 0
Return

ButtonLeftDouble:
     ButtonMode := GuiUpdate("Left Double", ButtonModePre, ButtonLatch)
Return

ButtonLeftTriple:
     ButtonMode := GuiUpdate("Left Triple", ButtonModePre, ButtonLatch)
Return

ButtonRightClick:
     ButtonMode := GuiUpdate("Right Click", ButtonModePre, ButtonLatch)
Return

ButtonRightDrag:
     ButtonMode := GuiUpdate("Right Drag", ButtonModePre, ButtonLatch)
     ButtonDown := 0
Return

ButtonMiddleClick:
     ButtonMode := GuiUpdate("Middle Click", ButtonModePre, ButtonLatch)
Return

ButtonMiddleDrag:
     ButtonMode := GuiUpdate("Middle Drag", ButtonModePre, ButtonLatch)
     ButtonDown := 0
Return
