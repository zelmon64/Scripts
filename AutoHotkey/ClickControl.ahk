#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

ButtonModePre := ""
ButtonModePrePre := ""
ButtonMode := GuiUpdate("Left", ButtonModePre, ButtonModePrePre, 0)
ButtonDown := 0
ButtonLatch := 0
SetTitleMatchMode, 3
Global MyUpDown

GuiUpdate(ButtonMode, ByRef ButtonModePre, ByRef ButtonModePrePre, ByRef ButtonLatch)
{
  If (ButtonMode = "Left")
  {
    If (ButtonLatch = 0 && ButtonMode = ButtonModePre)
      Return ButtonMode
    ButtonModePre := ButtonMode
    ButtonModePrePre := ButtonMode
    ButtonLatch := 0
  }
  Else If (ButtonMode <> ButtonModePre)  ; ButtonLatch = 0 && 
  {
    ButtonLatch := 1
    ; ButtonModePre := "Left"
    ButtonModePre := ButtonMode
  }
  Else If (ButtonLatch = 1 && ButtonMode = ButtonModePre)
  {
    ButtonLatch := 0
    ButtonModePrePre := ButtonMode
  }
  Else
    Return ButtonMode

  TextWidth := 200

  IfWinExist, ClickControl
  {
    WinGetPos, Xpos, Ypos  ; Uses the window found above.
    Gui Destroy
  }
  Gui, +AlwaysOnTop -SysMenu ; +Disabled -SysMenu +Owner avoids a taskbar button.
  ; Gui, font, s16 bold cRed, Verdana  ; Set 16-point Verdana.
  ; Gui, Add, Text, w%TextWidth%, Mouse left button`nfunction:

  Gui, font, s22 bold, Verdana  ; Set 22-point Verdana.
  If ButtonLatch
  {
    Gui, Add, Text, center cRed, %ButtonMode%
  }
  Else
    Gui, Add, Text, center cBlack, %ButtonMode%

  ; GuiControl, Text, %ButtonMode%, Center

  Gui, Add, Button, w%TextWidth% Default, Left
  ; Gui, Add, Text, cBlue gButtonLeft, Left
  Gui, Add, Button, w%TextWidth%, &Left Click
  Gui, Add, Button, w%TextWidth%, L&eft Drag
  Gui, Add, Button, w%TextWidth%, Le&ft Double
  Gui, Add, Button, w%TextWidth%, Lef&t Triple
  Gui, Add, Button, w%TextWidth%, &Right Click
  Gui, Add, Button, w%TextWidth%, R&ight Drag
  Gui, Add, Button, w%TextWidth%, &Middle Click
  Gui, Add, Button, w%TextWidth%, Mi&ddle Drag
  ; Gui, Add, Edit, w%TextWidth%
  ; Global MyUpDown
  ; Gui, Add, UpDown, vMyUpDown Range1-10, 5
  Gui, Add, Button, w%TextWidth%, &Scroll Click
  Gui, Add, Button, w%TextWidth%, S&croll Mode

  {
     If (ButtonMode = "Left" && !ButtonLatch)
     {
       GuiControl, Disable, Button1
     }
     Else If (ButtonMode = "Left Click" && !ButtonLatch)
     {
       GuiControl, Disable, Button2
     }
     Else If (ButtonMode = "Left Drag" && !ButtonLatch)
     {
       GuiControl, Disable, Button3
     }
     Else If (ButtonMode = "Left Double" && !ButtonLatch)
     {
       GuiControl, Disable, Button4
     }
     Else If (ButtonMode = "Left Triple" && !ButtonLatch)
     {
       GuiControl, Disable, Button5
     }
     Else If (ButtonMode = "Right Click" && !ButtonLatch)
     {
       GuiControl, Disable, Button6
     }
     Else If (ButtonMode = "Right Drag" && !ButtonLatch)
     {
       GuiControl, Disable, Button7
     }
     Else If (ButtonMode = "Middle Click" && !ButtonLatch)
     {
       GuiControl, Disable, Button8
     }
     Else If (ButtonMode = "Middle Drag" && !ButtonLatch)
     {
       GuiControl, Disable, Button9
     }
     Else If (ButtonMode = "Scroll Click" && !ButtonLatch)
     {
       GuiControl, Disable, Button10
     }
     Else If (ButtonMode = "Scroll Mode" && !ButtonLatch)
     {
       GuiControl, Disable, Button11
     }
  }

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
  IfWinExist, ClickControl
  {
    WinGet MMX, MinMax, ClickControl
    IfEqual MMX,0
    {
      MouseGetPos, , , Mouse_id
      WinGet, ClickControl_id, ID, ClickControl
      If (ClickControl_id = Mouse_id)
      {
        OverClickControl := 1
      }
      Else
      {
        OverClickControl := 0
      }
      ; ToolTip, OverClickControl: %OverClickControl%  ; `nMMX: %MMX% `nMouse_id: %Mouse_id% `nClickControl_id: %ClickControl_id%
    }
    Else
    {
      OverClickControl := 0
    }
  }
  Else
  {
    OverClickControl := 0
  }
	If (!WinActive(ClickControl) && !OverClickControl)
  {
     If (ButtonMode = "Left Click")
     {
       MouseClick, Left
       Sleep, 200
       If (ButtonLatch && !WinActive(ClickControl))
         ButtonMode := GuiUpdate(ButtonModePrePre, ButtonModePrePre, ButtonModePre, ButtonLatch)
     }
     Else If (ButtonMode = "Left Drag")
     {
       If ButtonDown
       {
         MouseClick, Left,,,,, U
         ButtonDown := 0
         Sleep, 200
         If (ButtonLatch && !WinActive(ClickControl))
           ButtonMode := GuiUpdate(ButtonModePrePre, ButtonModePrePre, ButtonModePre, ButtonLatch)
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
         ButtonMode := GuiUpdate(ButtonModePrePre, ButtonModePrePre, ButtonModePre, ButtonLatch)
     }
     Else If (ButtonMode = "Left Triple")
     {
       MouseClick, Left,,, 3
       Sleep, 200
       If (ButtonLatch && !WinActive(ClickControl))
         ButtonMode := GuiUpdate(ButtonModePrePre, ButtonModePrePre, ButtonModePre, ButtonLatch)
     }
     Else If (ButtonMode = "Right Click")
     {
       MouseClick, Right
       Sleep, 200
       If (ButtonLatch && !WinActive(ClickControl))
         ButtonMode := GuiUpdate(ButtonModePrePre, ButtonModePrePre, ButtonModePre, ButtonLatch)
     }
     Else If (ButtonMode = "Right Drag")
     {
       If ButtonDown
       {
         MouseClick, Right,,,,, U
         ButtonDown := 0
         Sleep, 200
         If (ButtonLatch && !WinActive(ClickControl))
           ButtonMode := GuiUpdate(ButtonModePrePre, ButtonModePrePre, ButtonModePre, ButtonLatch)
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
         ButtonMode := GuiUpdate(ButtonModePrePre, ButtonModePrePre, ButtonModePre, ButtonLatch)
     }
     Else If (ButtonMode = "Middle Drag")
     {
       If ButtonDown
       {
         MouseClick, Middle,,,,, U
         ButtonDown := 0
         Sleep, 200
         If (ButtonLatch && !WinActive(ClickControl))
           ButtonMode := GuiUpdate(ButtonModePrePre, ButtonModePrePre, ButtonModePre, ButtonLatch)
       }
       Else
       {
         MouseClick, Middle,,,,, D
         ButtonDown := 1
       }
     }
     Else If (ButtonMode = "Scroll Click")
     {
       WinGetPos, , , Width, Height, A
       CoordMode, Mouse, Window
       MouseGetPos, xpos, ypos
       ; ToolTip, X: %Xpos% %Width% `nY: %Ypos% %Height% %H34%  ; `nMMX: %MMX% `nMouse_id: %Mouse_id%
       If (xpos < (Width / 4))
       {
         SendInput, {WheelLeft}
       }
       Else If (xpos > (Width * 3 / 4))
       {
         SendInput, {WheelRight}
       }
       If (ypos < (Height / 4))
       {
         SendInput, {WheelUp}
       }
       Else If (ypos > (Height * 3 / 4))
       {
         SendInput, {WheelDown}
       }
       If (ButtonLatch && !WinActive(ClickControl))
         ButtonMode := GuiUpdate(ButtonModePrePre, ButtonModePrePre, ButtonModePre, ButtonLatch)
     }
     Else If (ButtonMode = "Scroll Mode")
     {
       MouseGetPos, , , Mouse_id
       WinActivate, ahk_id %Mouse_id%
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
     Else If (ButtonMode = "Scroll Mode")
     {
       WinGetPos, , , Width, Height, A
       CoordMode, Mouse, Window
       Loop_Index := 0
       Loop
       {
         MouseGetPos, xpos, ypos
         tol := 10
         If (A_Index > 500 || xpos < tol || xpos > Width - tol || ypos < tol || ypos > Height - tol)
         {
           If (ButtonLatch && !WinActive(ClickControl))
             ButtonMode := GuiUpdate(ButtonModePrePre, ButtonModePrePre, ButtonModePre, ButtonLatch)
           ; ToolTip  ; `n
           Break
         }
         If (xpos < (Width / 4))
         {
           ++Loop_Index
           SendInput, {WheelLeft}
         }
         Else If (xpos > (Width * 3 / 4))
         {
           ++Loop_Index
           SendInput, {WheelRight}
         }
         If (ypos < (Height / 4))
         {
           ++Loop_Index
           If Loop_Index > 100
           {
             If (ButtonLatch && !WinActive(ClickControl))
               ButtonMode := GuiUpdate(ButtonModePrePre, ButtonModePrePre, ButtonModePre, ButtonLatch)
             SendInput, {Home}
             Break
           }
           SendInput, {WheelUp}
         }
         Else If (ypos > (Height * 3 / 4))
         {
           ++Loop_Index
           If Loop_Index > 100
           {
             If (ButtonLatch && !WinActive(ClickControl))
               ButtonMode := GuiUpdate(ButtonModePrePre, ButtonModePrePre, ButtonModePre, ButtonLatch)
             SendInput, {End}
             Break
           }
           SendInput, {WheelDown}
         }
         ; ToolTip, X: %Xpos% %Width% `nY: %Ypos% %Height% %H34%  ; `n
         If Loop_Index > 50
           Sleep, 10
         Else If Loop_Index > 10
           Sleep, 50
         Else
           Sleep, 100
       }
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

GuiContextMenu:
WinMinimize, ClickControl
Return

GuiEscape:
GuiClose:
ExitApp
Return

ButtonLeft:
     ButtonMode := GuiUpdate("Left", ButtonModePre, ButtonModePrePre, ButtonLatch)
Return

ButtonLeftClick:
     ButtonMode := GuiUpdate("Left Click", ButtonModePre, ButtonModePrePre, ButtonLatch)
Return

ButtonLeftDrag:
     ButtonMode := GuiUpdate("Left Drag", ButtonModePre, ButtonModePrePre, ButtonLatch)
     ButtonDown := 0
Return

ButtonLeftDouble:
     ButtonMode := GuiUpdate("Left Double", ButtonModePre, ButtonModePrePre, ButtonLatch)
Return

ButtonLeftTriple:
     ButtonMode := GuiUpdate("Left Triple", ButtonModePre, ButtonModePrePre, ButtonLatch)
Return

ButtonRightClick:
     ButtonMode := GuiUpdate("Right Click", ButtonModePre, ButtonModePrePre, ButtonLatch)
Return

ButtonRightDrag:
     ButtonMode := GuiUpdate("Right Drag", ButtonModePre, ButtonModePrePre, ButtonLatch)
     ButtonDown := 0
Return

ButtonMiddleClick:
     ButtonMode := GuiUpdate("Middle Click", ButtonModePre, ButtonModePrePre, ButtonLatch)
Return

ButtonMiddleDrag:
     ButtonMode := GuiUpdate("Middle Drag", ButtonModePre, ButtonModePrePre, ButtonLatch)
     ButtonDown := 0
Return

ButtonScrollClick:
     ButtonMode := GuiUpdate("Scroll Click", ButtonModePre, ButtonModePrePre, ButtonLatch)
     ButtonDown := 0
Return

ButtonScrollMode:
     ButtonMode := GuiUpdate("Scroll Mode", ButtonModePre, ButtonModePrePre, ButtonLatch)
     ButtonDown := 0
Return
