;-------------------------------------------------------------------------------
;
;  chording_rot 0.02                               by: William (aka zelmon64)
;  Layout based on MessagEase and modelled after Numpad9 by Danny Ben Shitrit (aka Icarus)
;
;
;   • Enable Numlock to Activate
;   ┌─────────┬─────────┬─────────┬─────────┬───────────────────┐
;   │         │         │         │         │                   │ 9 6 3
;   │ Bkspace │    -    │    +    │   TAB   │       Enter       │ 8 5 2
;   │         │         │         │         │                   │ 7 4 1
;   └─────────┼─────────┼─────────┼─────────┼─────────┬─────────┤
;             │         │ 2  3  4 │ `  ^  ´ │ 5  6  7 │         │ 9 6 3
;             │    *    │ 1  a  - │ +  n  ! │ ?  i  8 │  Esc    │ 8 5 2
;             │         │ $  £  v │ /  l  \ │ x  =  € │         │ 7 4 1
;             ├─────────┼─────────┼─────────┼─────────┼─────────┤
;             │         │ {  N  % │ q  u  p │ |  C  } │         │ 9 6 3
;             │    /    │ (  h  k │ c  o  b │ m  r  ) │         │ 8 5 2
;             │         │ [  I  _ │ g  d  j │ @  S  ] │         │ 7 4 1
;             ├─────────┼─────────┼─────────┼─────────┤  Space  │
;             │ Numlock │ ~ ^A  y │ "  w  ' │ f  &  ° │         │ 9 6 3
;             │ On      │ <  t  * │ µ  e  z │ #  s  > │         │ 8 5 2
;             │         │ 0 BS +T │ ,  .  : │ ;  D  9 │         │ 7 4 1
;             └─────────┴─────────┴─────────┴─────────┴─────────┘
;
;   • Press Enter|Esc|Space after|before to Activate
;   ┌─────────┬─────────┬─────────┬─────────┬───────────────────┐
;   │         │         │         │         │                   │ 9 6 3
;   │         │         │         │         │       Enter       │ 8 5 2
;   │         │         │         │         │                   │ 7 4 1
;   └─────────┼─────────┼─────────┼─────────┼─────────┬─────────┤
;             │         │ ^+T|!+T │  F6|#↑  │  ^T|!T  │         │ 9 6 3
;             │         │  ^n|!F4 │  ^t|F11 │  ^w|F12 │  Esc    │ 8 5 2
;             │         │ +F3|Home│  ^f|↑   │ F3|PgUp │         │ 7 4 1
;             ├─────────┼─────────┼─────────┼─────────┼─────────┤
;             │         │  #←|#←  │  F5|#↓  │  #→|#→  │         │ 9 6 3
;             │         │  #x|#x  │  ^s|^s  │ ^+E|^+E │         │ 8 5 2
;             │         │   !z|←  │  !c|↓   │  !x|→   │         │ 7 4 1
;             ├─────────┼─────────┼─────────┼─────────┤  Space  │
;             │         │  ^-|#-  │!Spc|#Esc│  ^+|#+  │         │ 9 6 3
;             │         │Back|Prev│PrSc|Paus│ Fwd|Next│         │ 8 5 2
;             │         │ Vol-|End│Mute|AppM│Vol+|PgDn│         │ 7 4 1
;             └─────────┴─────────┴─────────┴─────────┴─────────┘
;
;   • Press *|/ before|after to Activate
;   ┌─────────┬─────────┬─────────┬─────────┬───────────────────┐
;   │         │         │         │         │                   │ 9 6 3
;   │         │         │         │         │                   │ 8 5 2
;   │         │         │         │         │                   │ 7 4 1
;   └─────────┼─────────┼─────────┼─────────┼─────────┬─────────┤
;             │         │  +^Home │ +^↑|+^↑ │  L1|L2  │         │ 9 6 3
;             │    *    │         │         │         │         │ 8 5 2
;             │         │  ^Home  │  ^↑|^↑  │  off|L1 │         │ 7 4 1
;             ├─────────┼─────────┼─────────┼─────────┼─────────┤
;             │         │ +^←|+^← │ +^↓|+^↓ │ +^→|+^→ │         │ 9 6 3
;             │    /    │         │         │         │         │ 8 5 2
;             │         │  ^←|^←  │  ^↓|^↓  │  ^→|^→  │         │ 7 4 1
;             ├─────────┼─────────┼─────────┼─────────┤         │
;             │         │  +^End  │ ^+C|^X  │ ^+V|^+Z │         │ 9 6 3
;             │         │         │         │         │         │ 8 5 2
;             │         │  ^End   │  ^C|^Z  │  ^V|^Y  │         │ 7 4 1
;             └─────────┴─────────┴─────────┴─────────┴─────────┘
;
;
;   ¨€
;   ←↑→↓▲►▼◄
;   │─┌┐└┘├┤┬┴┼
;   ≠±¦ꜛꜜµ≤≥≈≠∞
;
;
;-------------------------------------------------------------------------------


;Global
;tsphk := 800
  ;Global
  ;tsphk := 800
  ;If (getkeystate("Numpad5") && a_timesincepriorhotkey < tsphk)
  ;  SendInput, this is my cool text
  ;Else

SetStoreCapslockMode, Off

;   └─────────┼─────────┼─────────┼─────────┼─────────┬─────────┤
;             │         │ 2  3  4 │ `  ^  ´ │ 5  6  7 │         │ 9 6 3
;             │    *    │ 1  a  - │ +  n  ! │ ?  i  8 │  Esc    │ 8 5 2
;             │         │ $  £  v │ /  l  \ │ x  =  € │         │ 7 4 1
;             ├─────────┼─────────┼─────────┼─────────┼─────────┤

Numpad9::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}A
  } Else
    SendInput, {Raw}a
Return
Numpad9 & Numpad5::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}V
  } Else
    SendInput, {Raw}v
Return
Numpad9 & Numpad6::SendInput, {Raw}-
Numpad9 & Numpad8::SendInput, {U+00A3}
Numpad9 & Numpad2::SendInput, {Raw}$
Numpad9 & Numpad3::SendInput, {Raw}1
Numpad9 & Numpad1::SendInput, {Raw}2
Numpad9 & Numpad7::SendInput, {Raw}3
Numpad9 & Numpad4::SendInput, {Raw}4

Numpad6::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}N
  } Else
    SendInput, {Raw}n
Return
Numpad6 & Numpad5::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}L
  } Else
    SendInput, {Raw}l
Return
Numpad6 & Numpad9::SendInput, {Raw}+
Numpad6 & Numpad3::SendInput, {Raw}!
Numpad6 & Numpad7::SendInput, {U+0060}
Numpad6 & Numpad1::SendInput, {U+00B4}
Numpad6 & Numpad8::SendInput, {Raw}/
Numpad6 & Numpad2::SendInput, {Raw}\
Numpad6 & Numpad4::SendInput, {Raw}^

Numpad3::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}I
  } Else
    SendInput, {Raw}i
Return
Numpad3 & Numpad5::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}X
  } Else
    SendInput, {Raw}x
Return
Numpad3 & Numpad6::SendInput, {Raw}?
Numpad3 & Numpad4::SendInput, {Raw}5
Numpad3 & Numpad1::SendInput, {Raw}6
Numpad3 & Numpad7::SendInput, {Raw}7
Numpad3 & Numpad9::SendInput, {Raw}8
Numpad3 & Numpad8::SendInput, {Raw}€
Numpad3 & Numpad2::SendInput, {Raw}=

;             ├─────────┼─────────┼─────────┼─────────┼─────────┤
;             │         │ {  N  % │ q  u  p │ |  C  } │         │ 9 6 3
;             │    /    │ (  h  k │ c  o  b │ m  r  ) │         │ 8 5 2
;             │         │ [  I  _ │ g  d  j │ @  S  ] │         │ 7 4 1
;             ├─────────┼─────────┼─────────┼─────────┤  Space  │

Numpad8::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}H
  } Else
    SendInput, {Raw}h
Return
Numpad8 & Numpad5::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}K
  } Else
    SendInput, {Raw}k
Return
Numpad8 & Numpad4::SendInput, {Raw}_
Numpad8 & Numpad7::SendInput, {Insert}
Numpad8 & Numpad1::SendInput, {Raw}[
Numpad8 & Numpad2::SendInput, {Raw}(
Numpad8 & Numpad3::SendInput, {Raw}{
Numpad8 & Numpad9::SendInput, {NumLock}
Numpad8 & Numpad6::SendInput, {U+0025}

Numpad5::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}O
  } Else
    SendInput, {Raw}o
Return
Numpad5 & Numpad7::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}G
  } Else
    SendInput, {Raw}g
Return
Numpad5 & Numpad8::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}C
  } Else
    SendInput, {Raw}c
Return
Numpad5 & Numpad9::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}Q
  } Else
    SendInput, {Raw}q
Return
Numpad5 & Numpad6::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}U
  } Else
    SendInput, {Raw}u
Return
Numpad5 & Numpad3::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}P
  } Else
    SendInput, {Raw}p
Return
Numpad5 & Numpad2::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}B
  } Else
    SendInput, {Raw}b
Return
Numpad5 & Numpad1::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}J
  } Else
    SendInput, {Raw}j
Return
Numpad5 & Numpad4::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}D
  } Else
    SendInput, {Raw}d
Return

Numpad2::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}R
  } Else
    SendInput, {Raw}r
Return
Numpad2 & Numpad5::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}M
  } Else
    SendInput, {Raw}m
Return
Numpad2 & Numpad6::SendInput, {Raw}|
Numpad2 & Numpad3::SendInput, {Capslock}
Numpad2 & Numpad9::SendInput, {Raw}}
Numpad2 & Numpad8::SendInput, {Raw})
Numpad2 & Numpad7::SendInput, {Raw}]
Numpad2 & Numpad1::SendInput, {ScrollLock}
Numpad2 & Numpad4::SendInput, {Raw}@

;             ├─────────┼─────────┼─────────┼─────────┤  Space  │
;             │ Numlock │ ~ ^A  y │ "  w  ' │ f  &  ° │         │ 9 6 3
;             │ On      │ <  t  * │ µ  e  z │ #  s  > │         │ 8 5 2
;             │         │ 0 BS +T │ ,  .  : │ ;  D  9 │         │ 7 4 1
;             └─────────┴─────────┴─────────┴─────────┴─────────┘

Numpad7::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}T
  } Else
    SendInput, {Raw}t
Return
Numpad7 & Numpad5::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}Y
  } Else
    SendInput, {Raw}y
Return
Numpad7 & Numpad4::SendInput, {Raw}*
Numpad7 & Numpad6::SendInput, +{Tab}
Numpad7 & Numpad9::SendInput, {Backspace}
Numpad7 & Numpad3::SendInput, {Raw}0
Numpad7 & Numpad1::SendInput, {Raw}<
Numpad7 & Numpad2::SendInput, {Raw}~
Numpad7 & Numpad8::SendInput, ^{a}

Numpad4::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}E
  } Else
    SendInput, {Raw}e
Return
Numpad4 & Numpad5::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}W
  } Else
    SendInput, {Raw}w
Return
Numpad4 & Numpad2::SendInput, {Raw}'
Numpad4 & Numpad1::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}Z
  } Else
    SendInput, {Raw}z
Return
Numpad4 & Numpad3::SendInput, {Raw}:
Numpad4 & Numpad6::SendInput, {Raw}.
Numpad4 & Numpad9::SendInput, {Raw},
Numpad4 & Numpad7::SendInput, {U+03BC}
Numpad4 & Numpad8::SendInput, {Raw}"

Numpad1::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}S
  } Else
    SendInput, {Raw}s
Return
Numpad1 & Numpad5::
  If ( GetKeyState("ScrollLock", "T") ) {
    SetScrollLockState, Off
    SendInput, {Raw}F
  } Else
    SendInput, {Raw}f
Return
Numpad1 & Numpad2::SendInput, {Raw}&
Numpad1 & Numpad8::SendInput, {U+00B0}
Numpad1 & Numpad7::SendInput, {Raw}>
Numpad1 & Numpad9::SendInput, {Raw}9
Numpad1 & Numpad3::SendInput, {Delete}
Numpad1 & Numpad6::SendInput, {U+003B}
Numpad1 & Numpad4::SendInput, {Raw}#

;   • Press Enter|Esc|Space after|before to Activate
;   ┌─────────┬─────────┬─────────┬─────────┬───────────────────┐
;   │         │         │         │         │                   │ 9 6 3
;   │         │         │         │         │       Enter       │ 8 5 2
;   │         │         │         │         │                   │ 7 4 1
;   └─────────┼─────────┼─────────┼─────────┼─────────┬─────────┤
;             │         │ ^+T|!+T │  F6|#↑  │  ^T|!T  │         │ 9 6 3
;             │         │  ^n|!F4 │  ^t|F11 │  ^w|F12 │  Esc    │ 8 5 2
;             │         │ +F3|Home│  ^f|↑   │ F3|PgUp │         │ 7 4 1
;             ├─────────┼─────────┼─────────┼─────────┼─────────┤
;             │         │  #←|#←  │  F5|#↓  │  #→|#→  │         │ 9 6 3
;             │         │  #x|#x  │  ^s|^s  │ ^+E|^+E │         │ 8 5 2
;             │         │   !z|←  │  !c|↓   │  !x|→   │         │ 7 4 1
;             ├─────────┼─────────┼─────────┼─────────┤  Space  │
;             │         │  ^-|#-  │!Spc|#Esc│  ^+|#+  │         │ 9 6 3
;             │         │Back|Prev│PrSc|Paus│ Fwd|Next│         │ 8 5 2
;             │         │ Vol-|End│Mute|AppM│Vol+|PgDn│         │ 7 4 1
;             └─────────┴─────────┴─────────┴─────────┴─────────┘

NumpadEnter::SendInput, {NumpadEnter}
NumpadDot::SendInput, {Esc}
Numpad0::SendInput, {Space}

Numpad9 & NumpadEnter::SendInput, ^+{Tab}
NumpadEnter & Numpad9::SendInput, !+{Tab}
Numpad6 & NumpadEnter::SendInput, {F6}
NumpadEnter & Numpad6::SendInput, #{Up}
Numpad3 & NumpadEnter::SendInput, ^{Tab}
NumpadEnter & Numpad3::SendInput, !{Tab}

Numpad9 & NumpadDot::SendInput, ^{n}
NumpadDot & Numpad9::SendInput, !{F4}
Numpad6 & NumpadDot::SendInput, ^{t}
NumpadDot & Numpad6::SendInput, {F11}
Numpad3 & NumpadDot::SendInput, ^{w}
NumpadDot & Numpad3::SendInput, {F12}

Numpad9 & Numpad0::SendInput, +{F3}
Numpad0 & Numpad9::SendInput, {Home}
Numpad6 & Numpad0::SendInput, ^{f}
Numpad0 & Numpad6::SendInput, {Up}
Numpad3 & Numpad0::SendInput, {F3}
Numpad0 & Numpad3::SendInput, {PgUp}

Numpad8 & NumpadEnter::SendInput, #{Left}
NumpadEnter & Numpad8::SendInput, #{Left}
Numpad5 & NumpadEnter::SendInput, {F5}
NumpadEnter & Numpad5::SendInput, #{Down}
Numpad2 & NumpadEnter::SendInput, #{Right}
NumpadEnter & Numpad2::SendInput, #{Right}

Numpad8 & NumpadDot::SendInput, #{x}
NumpadDot & Numpad8::SendInput, #{x}
Numpad5 & NumpadDot::SendInput, ^{s}
NumpadDot & Numpad5::SendInput, ^{s}
Numpad2 & NumpadDot::SendInput, ^+{Esc}
NumpadDot & Numpad2::SendInput, ^+{Esc}

Numpad8 & Numpad0::SendInput, !{z}
Numpad0 & Numpad8::SendInput, {Left}
Numpad5 & Numpad0::SendInput, !{c}
Numpad0 & Numpad5::SendInput, {Down}
Numpad2 & Numpad0::SendInput, !{x}
Numpad0 & Numpad2::SendInput, {Right}

Numpad7 & NumpadEnter::SendInput, ^{-}
NumpadEnter & Numpad7::SendInput, #{-}
Numpad4 & NumpadEnter::SendInput, !{Space}
NumpadEnter & Numpad4::SendInput, #{Esc}
Numpad1 & NumpadEnter::SendInput, ^{+}
NumpadEnter & Numpad1::SendInput, #{=}

Numpad7 & NumpadDot::SendInput, {Browser_Back}
NumpadDot & Numpad7::SendInput, {Media_Prev}
Numpad4 & NumpadDot::SendInput, !{PrintScreen}
NumpadDot & Numpad4::SendInput, {Media_Play_Pause}
Numpad1 & NumpadDot::SendInput, {Browser_Forward}
NumpadDot & Numpad1::SendInput, {Media_Next}

Numpad7 & Numpad0::SendInput, {Volume_Down}
Numpad0 & Numpad7::SendInput, {End}
Numpad4 & Numpad0::SendInput, {Volume_Mute}
Numpad0 & Numpad4::SendInput, {AppsKey}
Numpad1 & Numpad0::SendInput, {Volume_Up}
Numpad0 & Numpad1::SendInput, {PgDn}

;   • Press *|/ before|after to Activate
;   ┌─────────┬─────────┬─────────┬─────────┬───────────────────┐
;   │         │         │         │         │                   │ 9 6 3
;   │         │         │         │         │                   │ 8 5 2
;   │         │         │         │         │                   │ 7 4 1
;   └─────────┼─────────┼─────────┼─────────┼─────────┬─────────┤
;             │         │  +^Home │ +^↑|+^↑ │  L1|L2  │         │ 9 6 3
;             │    *    │         │         │         │         │ 8 5 2
;             │         │  ^Home  │  ^↑|^↑  │  off|L1 │         │ 7 4 1
;             ├─────────┼─────────┼─────────┼─────────┼─────────┤
;             │         │ +^←|+^← │ +^↓|+^↓ │ +^→|+^→ │         │ 9 6 3
;             │    /    │         │         │         │         │ 8 5 2
;             │         │  ^←|^←  │  ^↓|^↓  │  ^→|^→  │         │ 7 4 1
;             ├─────────┼─────────┼─────────┼─────────┤         │
;             │         │  +^End  │ ^+C|^X  │ ^+V|^+Z │         │ 9 6 3
;             │         │         │         │         │         │ 8 5 2
;             │         │  ^End   │  ^C|^Z  │  ^V|^Y  │         │ 7 4 1
;             └─────────┴─────────┴─────────┴─────────┴─────────┘

NumpadMult::SendInput, {NumpadMult}
NumpadDiv::SendInput, {NumpadDiv}

Numpad9 & NumpadMult::SendInput, +^{Home}
NumpadMult & Numpad9::SendInput, +^{Home}
Numpad9 & NumpadDiv::SendInput, ^{Home}
NumpadDiv & Numpad9::SendInput, ^{Home}

Numpad6 & NumpadMult::SendInput, +^{Up}
NumpadMult & Numpad6::SendInput, +^{Up}
Numpad6 & NumpadDiv::SendInput, ^{Up}
NumpadDiv & Numpad6::SendInput, ^{Up}

Numpad8 & NumpadMult::SendInput, +^{Left}
NumpadMult & Numpad8::SendInput, +^{Left}
Numpad8 & NumpadDiv::SendInput, ^{Left}
NumpadDiv & Numpad8::SendInput, ^{Left}

Numpad5 & NumpadMult::SendInput, +^{Down}
NumpadMult & Numpad5::SendInput, +^{Down}
Numpad5 & NumpadDiv::SendInput, ^{Down}
NumpadDiv & Numpad5::SendInput, ^{Down}

Numpad2 & NumpadMult::SendInput, +^{Right}
NumpadMult & Numpad2::SendInput, +^{Right}
Numpad2 & NumpadDiv::SendInput, ^{Right}
NumpadDiv & Numpad2::SendInput, ^{Right}

Numpad7 & NumpadMult::SendInput, +^{End}
NumpadMult & Numpad7::SendInput, +^{End}
Numpad7 & NumpadDiv::SendInput, ^{End}
NumpadDiv & Numpad7::SendInput, ^{End}

Numpad4 & NumpadMult::SendInput, ^{x}
NumpadMult & Numpad4::SendInput, +^{c}
Numpad4 & NumpadDiv::SendInput, ^{z}
NumpadDiv & Numpad4::SendInput, ^{c}

Numpad1 & NumpadMult::SendInput, +^{z}
NumpadMult & Numpad1::SendInput, +^{v}
Numpad1 & NumpadDiv::SendInput, ^{y}
NumpadDiv & Numpad1::SendInput, ^{v}

;AutoTrim, Off

NumpadDiv & Numpad3::Progress, Off
NumpadMult & Numpad3::
{
  Progress, b zh0 fm32 fs28 w800 ctRed cwBlack
  ,  %A_Space%|---------+---------+---------|`n
              | 2  3  4 | '  ^  ' | 5  6  7 |`n
              | 1  a  - | +  n  ! | ?  i  8 |`n
              | $  E  v | /  l  \ | x  =  E |`n
              |---------+---------+---------|`n
              | {  N  / | q  u  p | |  C  } |`n
              | (  h  k | c  o  b | m  r  ) |`n
              | [  I  _ | g  d  j | @  S  ] |`n
              |---------+---------+---------|`n
              | ~  A  y | "  w  ' | f  &  D |`n
              | <  t  * | M  e  z | #  s  > |`n
              | 0 BS +T | .  .  : | . Del 9 |`n
              |---------+---------+---------|
    , Main,, Courier New
}
Return
Numpad3 & NumpadMult::
{
  Progress, b zh0 fm32 fs28 w800 ctRed cwBlack
  ,  %A_Space%|---------+---------+---------|`n
              | ^+T|!+T |  F6|#Up |  ^T|!T  |`n
              |  ^n|!F4 |  ^t|F11 |  ^w|F12 |`n
              | +F3|Home|  ^f|Up  | F3|PgUp |`n
              |---------+---------+---------|`n
              |   #Lft  |  F5|#Dn |   #Rt   |`n
              |    #x   |   ^s    |  ^+Esc  |`n
              | !z|Lft  |  !c|Dn  |  !x|Rt  |`n
              |---------+---------+---------|`n
              |  ^-|#-  |!Spc|#Esc|  ^+|#+  |`n
              |Back|Prev|PrSc|paus| Fwd|Next|`n
              |  V-|End |Mute|AppM|  V+|PgDn|`n
              |---------+---------+---------|
    , Enter|Dot|0 after|before,, Courier New
}
Return
Numpad3 & NumpadDiv::
{
  Progress, b zh0 fm32 fs28 w800 ctRed cwBlack
  ,  %A_Space%|---------+---------+---------|`n
              | +^Home  |   +^Up  |  L1|L2  |`n
              |         |         |         |`n
              |  ^Home  |   ^Up   | off|L3  |`n
              |---------+---------+---------|`n
              |  +^Left | +^Down  | +^Right |`n
              |         |         |         |`n
              |  ^Left  | ^Down   |  ^Right |`n
              |---------+---------+---------|`n
              |  +^End  | ^+C|^X  | ^+V|^+Z |`n
              |         |         |         |`n
              |  ^End   |  ^C|^Z  |  ^V|^Y  |`n
              |---------+---------+---------|
    , *|/ before|after,, Courier New
}
Return
