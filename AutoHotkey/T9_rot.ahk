;-------------------------------------------------------------------------------
;
;  Numpad9 0.15                               by: Danny Ben Shitrit (aka Icarus)
;  T9 Input with the Numpad
;
;   • Enable Numlock to Activate
;   +------------+------------+---------+-----------+
;   | Numlock   | /         | *         | -         |
;   | On        | Prev Word | Next Word | Delete    |
;   +-----------+-----------+-----------+-----------+
;   | 7         | 8         | 9         | +         |
;   | Symbol    | ABC       | DEF       | Spell     |
;   +-----------+-----------+-----------|           |
;   | 4         | 5         | 6         |           |
;   | GHI       | JKL       | MNO       |           |
;   +-----------+-----------+-----------+-----------+
;   | 1         | 2         | 3         | Enter     |
;   | PQRS      | TUV       | WXYZ      |           |
;   +-----------+-----------+-----------|           |
;   | 0                     | .         |           |
;   | Space                 | Case      |           |
;   +-----------------------+-----------+-----------+
;
;   • Dictionary is downloaded automatically
;   • userdictionary.txt may contain any additional words
;   • Spelled words are automatically added to user dictionary
;   • Used words that are not the first in their code, will be automatically
;     added to the prioritywords.txt file, so that next time you enter the code
;     they will appear first (e.g. The first word for 4919 is "herd" instead
;     of "here" - the first time you use "here" it will be remembered as the
;     first word for 4919)
;   • Loading the dictionary may take a few seconds, a sound will be heard when
;     ready for input.
;
;-------------------------------------------------------------------------------
#SingleInstance Force
#NoEnv

#Include custom_functions.ahk



SetWorkingDir %A_ScriptDir%
SendMode Input

ENABLE_DEBUG := false   ; Enable to show detailed debug info
SHOW_INPUT   := false   ; (or true) Enable to show the input as a tooltip


Gosub Init
SoundPlay *64

Return

;-------------------------------------------------------------------------------
; INIT
;-------------------------------------------------------------------------------
Init:
  Suspend

  ; Download dictionary if necessary
  If ( Not FileExist( "dictionary.txt" ) )
    UrlDownloadToFile http://java.sun.com/docs/books/tutorial/collections/interfaces/examples/dictionary.txt, dictionary.txt

  If ( FileExist( "prioritywords.txt" ) )
    FileRead PriorityWords, prioritywords.txt

  ; Read all the words from dictionary and user dictionary
  FileRead Words, dictionary.txt
  If FileExist( "userdictionary.txt" )
    FileRead Words2, userdictionary.txt

  Words := PriorityWords . Words . Words2

  StringSplit Word, Words, `n, `r
  GlobalWordIndex := 1
  GlobalCapsMode  := 1      ; 123 = abc, Abc, ABC, 123, mt, MT

  CapsModeStrings := "abc,Abc,ABC,123,mt,MT"
  StringSplit CapsModeString, CapsModeStrings, `,

  ; Map letter to numpad key and default characters for single digit codes
  Chars := "ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789"
  ;Nums  := "88899944455566611112223333rtyijm,ad"
  Nums  := "66633388855522277774441111ymdtjari,"
  StringSplit Chr, Chars
  StringSplit Num, Nums
  Loop %Chr0% {
    ThisChr := Chr%A_Index%
    Char_%ThisChr% := Num%A_Index%
  }

  ; Make one variable for each code, with space separated list of words
  Loop %Word0% {
    If( Word%A_Index% = "" )
      Continue

    RegisterWordVariable( Word%A_Index% )
  }

  ; Add some symbol words
  Word_9 := ", . ? @ ! - + / * ( ) "" : % $ #"
  Word_99 := ":) `;) :] ?! ??"
  Word_999 := "... :-) ??? ?!? !!! --> <--"

  Suspend Off
Return



;-------------------------------------------------------------------------------
; T9 FUNCTIONS
;-------------------------------------------------------------------------------
RegisterWordVariable( word ) {
  ; Gets a word and registers it in the relevant a Word_%Code% variable

  Global

  NumCode := WordToCode( word )
  If( Word_%NumCode% <> "" ) and ( Not InStr( Word_%NumCode%, word ) )
    Word_%NumCode% .= " "

  If( Not InStr( Word_%NumCode%, word ) )
    Word_%NumCode% .= word
}

WordToCode( word ) {
  ; Gets a word and returns its numeric code

  Result := ""
  word := RegExReplace( word, "\W", "9" )
  StringSplit Char, Word
  Loop %Char0% {
    ThisChar := Char%A_Index%
    Result .= ( RegExMatch( ThisChar, "\d" ) ? ThisChar : Char_%ThisChar% )
  }
  ;Debug( "WordToCode:`tIN [" . word . "] OUT [" . Result . "]" )

  Return Result
}

ManageInput( inputChar ) {
  ; Called whenever 1-9 is pressed and prints the new word to the screen

  Global GlobalWordIndex

  Word := GetWordBeforeCursor()
  StringRight LastChar, Word, 1

  Debug( "ManageInput:`tIN [" . inputChar . "] WORD [" . Word . "]" )

  ; A symbol immediately after a word or word immediately after symbol
  If( ( RegExMatch( LastChar, "[a-zA-Z]" ) ) and ( inputChar="9" ) ) or ( ( RegExMatch( LastChar, "[^a-zA-Z]" ) ) and ( RegExMatch( inputChar, "[12345678]" ) ) ) {
    Word := ""
    GlobalWordIndex := 1
  }

  If( Not Word )
    PrintWord( InputChar, false )
  Else
    PrintWord( WordToCode( Word ) . inputChar )
}

GetWordBeforeCursor() {
  ; Returns the word that is currently shown before the carret

  Clipboard =
  Send ^+{Left}^c
  ClipWait 0.1
  Send ^+{Right}
  Word := Clipboard

  If( RegExMatch( Word, "\s$" ) ) or ( InStr( Word, "`n" ) )
    Word := ""

  If( RegExMatch( Word, "(\W+)$", Token ) )
    Word := RegExReplace( Token1, "\W", "9" )
  Else
    Word := RegExReplace( Word, "[\W]", "" )

  Debug( "GetWordBefo:`tOUT [" . Word . "]" )

  Return Word
}

PrintWord( code, cleanBefore=true ) {
  ; Gets a code and prints its word to the screen.
  ; If cleanBefore is true, it will erase the word before the carret

  Global

  If( Word_%code% = "" )
    WordToPrint := CodeToChars( code )
  Else {
    StringSplit Word, Word_%code%, %A_Space%
    GlobalWordIndex :=  ( GlobalWordIndex > Word0 ) ? 1 : ( GlobalWordIndex < 1 ? Word0 : GlobalWordIndex )
    WordToPrint := Word%GlobalWordIndex%
  }

  If( GlobalCapsMode = 2 )
    StringUpper WordToPrint, WordToPrint, T
  Else If( GlobalCapsMode = 3 )
    StringUpper WordToPrint, WordToPrint
  Else If( GlobalCapsMode = 4 )
  {
    ;WordToPrint := WordToCode( WordToPrint )
    If(WordToPrint = CodeToChars("1"))
      WordToPrint := WordToCode( CodeToChars("3") )
    Else If(WordToPrint = CodeToChars("2"))
      WordToPrint := WordToCode( CodeToChars("6") )
    Else If(WordToPrint = CodeToChars("3"))
      WordToPrint := WordToCode( CodeToChars("9") )
    Else If(WordToPrint = CodeToChars("4"))
      WordToPrint := WordToCode( CodeToChars("2") )
    Else If(WordToPrint = CodeToChars("5"))
      WordToPrint := WordToCode( CodeToChars("5") )
    Else If(WordToPrint = CodeToChars("6"))
      WordToPrint := WordToCode( CodeToChars("8") )
    Else If(WordToPrint = CodeToChars("7"))
      WordToPrint := WordToCode( CodeToChars("1") )
    Else If(WordToPrint = CodeToChars("8"))
      WordToPrint := WordToCode( CodeToChars("4") )
    Else
    {
      WordToPrint := WordToCode( CodeToChars("7") )
      cleanBefore := false
    }
  }

  If( cleanBefore )
    Send ^+{Left}

  SendRaw %WordToPrint%

  Debug( "PrintWord:`tIN [" . code . "] DO [" . WordToPrint . "]" )
}

CodeToChars( code ) {
  ; Gets a code and returns the raw characters it represents.
  ; This is called when the code does not have a word

  StringSplit Digit, Code
  Result := ""
  Loop %Digit0% {
    ThisDigit := Digit%A_Index%
    Result .= Char_%ThisDigit%
  }
  Debug( "CodeToChars:`tIN [" . code . "] OUT [" . Result . "]" )
  Return Result
}

Spell() {
  ; Opens an input dialog for entering a new word.
  ; The word will be added to the userdictionary.txt file if it is a new word

  Word := GetWordBeforeCursor()
  If( Word )
    Send ^+{Left}

  StringReplace Word, Word, 9,,All

  InputBox Word, Spell,,,140,90,,,,,%Word%
  Result := ErrorLevel ? "" : Word
  Debug( "Spell:`t`tOUT [" . word  . "]" )
  Return Result
}

AddWord( word ) {
  ; Adds a word to the userdictionary.txt file if it is a new word

  Debug( "AddWord:`t" . word )
  If( word <> "" ) {
    StringLower word, word
    WordCode := WordToCode( word )
    If( Not InStr( Word_%WordCode%, word ) ) and ( RegExMatch( word, "^[a-zA-Z]+$" ) ) {
      FileAppend %word%`n, userdictionary.txt
      RegisterWordVariable( word )
    }
  }
}

HandlePriorityWords:
  ; Called when the last entered word was not the first in its code.
  ; Will add it as the first word to the code, and write it to the priority
  ; words file for next sessions
  LastWord := GetWordBeforeCursor()
  If( Not RegExMatch( LastWord, "^[a-zA-Z]+$" ) )
    Return

  LastWordCode := WordToCode( LastWord )
  If( Not InStr( PriorityWords, LastWord ) ) {
    FileAppend %LastWord%`n, prioritywords.txt
    PriorityWords .= LastWord . "`n"
    Word_%LastWordCode% := LastWord . " " . Word_%LastWordCode%
  }
Return

;-------------------------------------------------------------------------------
; OTHER FUNCTIONS
;-------------------------------------------------------------------------------
Debug( text ) {
  Global DebugMessage, ENABLE_DEBUG

  If( Not ENABLE_DEBUG )
    Return

  SetTimer CleanDebugMessage, Off
  DebugMessage .= text . "`n"
  Tooltip %DebugMessage%
  SetTimer CleanDebugMessage, -300

}

CleanDebugMessage:
  DebugMessage := ""
Return

GlobalCapsModeSet( val ) {
  Global
  GlobalCapsMode := val
  ;If( val <= 6 )
  ;  GlobalCapsMode := val
  ;Else
  ;  GlobalCapsMode := 1
  If( GlobalCapsMode > 6 )
    GlobalCapsMode := 1
  If( GlobalCapsMode = 1 )
    Progress, b zh0 fs32, abc
  Else If( GlobalCapsMode = 2 )
    Progress, b zh0 fs32, Abc
  Else If( GlobalCapsMode = 3 )
    Progress, b zh0 fs32, ABC
  Else If( GlobalCapsMode = 4 )
    Progress, b zh0 fs32, 123
  Else If( GlobalCapsMode = 5 )
    Progress, b zh0 fs32, mt
  Else If( GlobalCapsMode = 6 )
    Progress, b zh0 fs32, MT
  Else
    Progress, b zh0 fs32, error
  Sleep,200
  Progress, Off
Return
}

;-------------------------------------------------------------------------------
; HOTKEYS
;-------------------------------------------------------------------------------

^ESC::
  ExitApp
Return

Numpad1::
Numpad2::
Numpad3::
Numpad4::
Numpad5::
Numpad6::
Numpad7::
Numpad8::
Numpad9::
  Debug( "---INPUT:`t" . A_ThisHotkey )

  If( A_ThisHotkey = "Numpad9" ) and ( GlobalWordIndex <> 1 )
    Gosub HandlePriorityWords

  ThisCode := SubStr( A_ThisHotkey, 7,1 )
  If( SHOW_INPUT )
    Tooltip [%ThisCode%]
  If( GlobalCapsMode = 5 )
  {
    If( A_ThisHotkey = "Numpad6" )
      MultiTap(":a:send a, :b:send b, :c:send c, :2:send 2",400)
    Else If( A_ThisHotkey = "Numpad3" )
      MultiTap(":d:send d, :e:send e, :f:send f, :3:send 3",400)
    Else If( A_ThisHotkey = "Numpad8" )
      MultiTap(":g:send g, :h:send h, :i:send i, :4:send 4",400)
    Else If( A_ThisHotkey = "Numpad5" )
      MultiTap(":j:send j, :k:send k, :l:send l, :5:send 5",400)
    Else If( A_ThisHotkey = "Numpad2" )
      MultiTap(":m:send m, :n:send n, :o:send o, :6:send 6",400)
    Else If( A_ThisHotkey = "Numpad7" )
      MultiTap(":p:send p, :q:send q, :r:send r, :s:send s, :7:send 7",400)
    Else If( A_ThisHotkey = "Numpad4" )
      MultiTap(":t:send t, :u:send u, :v:send v, :8:send 8",400)
    Else If( A_ThisHotkey = "Numpad1" )
      MultiTap(":w:send w, :x:send x, :y:send y, :z:send z, :9:send 9",400)
    Else If( A_ThisHotkey = "Numpad9" )
      MultiTap(":-:send {-}, send {:}, :@:send {@}, :.:send {.}, :':send {'}, :0:send {0}, :1:send {1}",400)
  }
  Else If( GlobalCapsMode = 6 )
  {
    If( A_ThisHotkey = "Numpad6" )
      MultiTap(":A:send A, :B:send B, :C:send C, :2:send 2",400)
    Else If( A_ThisHotkey = "Numpad3" )
      MultiTap(":D:send D, :E:send E, :F:send F, :3:send 3",400)
    Else If( A_ThisHotkey = "Numpad8" )
      MultiTap(":G:send G, :H:send H, :I:send I, :4:send 4",400)
    Else If( A_ThisHotkey = "Numpad5" )
      MultiTap(":J:send J, :K:send K, :L:send L, :5:send 5",400)
    Else If( A_ThisHotkey = "Numpad2" )
      MultiTap(":M:send M, :N:send N, :O:send O, :6:send 6",400)
    Else If( A_ThisHotkey = "Numpad7" )
      MultiTap(":P:send P, :Q:send Q, :R:send R, :S:send S, :7:send 7",400)
    Else If( A_ThisHotkey = "Numpad4" )
      MultiTap(":T:send T, :U:send U, :V:send V, :8:send 8",400)
    Else If( A_ThisHotkey = "Numpad1" )
      MultiTap(":W:send W, :X:send X, :Y:send Y, :Z:send Z, :9:send 9",400)
    Else If( A_ThisHotkey = "Numpad9" )
      MultiTap(":_:send {_}, :+:send {+}, :%:send {%}, :#:send {#}, :/:send {/}, :\:send {\}",400)
  }
  Else
    ManageInput( ThisCode )
Return

NumpadDown::NumpadRight
NumpadUp::NumpadLeft
NumpadLeft::NumpadDown
NumpadRight::NumpadUp

NumpadPgDn::NumpadPgUp
NumpadPgUp::NumpadHome
NumpadHome::NumpadEnd
NumpadEnd::NumpadPgDn

NumpadClear::Esc
NumpadIns::
  Send ^f
Return
;NumpadDel

Numpad0::
  If( GlobalWordIndex <> 1 )
    Gosub HandlePriorityWords

  ;Send {Space}
  MultiTap("Send {Space}, :.:send {.}{Space}, :':send {'}",300)
  GlobalWordIndex := 1
  If( SHOW_INPUT )
    Tooltip [0] - Space
Return

NumpadSub::
  Send {Backspace}
  GlobalWordIndex := 1
  If( SHOW_INPUT )
    Tooltip [-] - Del
  ManageInput("")
Return

NumpadMult::
  GlobalWordIndex++
  If( SHOW_INPUT )
    Tooltip [*] - Next
  ManageInput("")
Return

NumpadDiv::
  GlobalWordIndex--
  If( SHOW_INPUT )
    Tooltip [/] - Prev
  ManageInput("")
Return

NumpadDot::
  ;GlobalCapsMode++
  ;MultiTap("GlobalCapsModeSet( GlobalCapsMode + 1 ), GlobalCapsModeSet( GlobalCapsMode - 1 ), GlobalCapsModeSet( 5 )",400)
  ; 123 = abc, Abc, ABC, 123, mt, MT, ::GlobalCapsModeSet(  ), :abc:GlobalCapsModeSet( 1 ), :Abc:GlobalCapsModeSet( 2 ), :ABC:GlobalCapsModeSet( 3 ), :123:GlobalCapsModeSet( 4 ), :mt:GlobalCapsModeSet( 5 ), :MT:GlobalCapsModeSet( 6 )
  ;Progress, b zh0 fs32, % GlobalCapsMode

  If( GlobalCapsMode = 1 )
    MultiTap(":Abc:GlobalCapsModeSet( 2 ), :ABC:GlobalCapsModeSet( 3 ), :123:GlobalCapsModeSet( 4 ), :mt:GlobalCapsModeSet( 5 ), :MT:GlobalCapsModeSet( 6 )",400)
  Else If( GlobalCapsMode = 2 )
    MultiTap(":abc:GlobalCapsModeSet( 1 ), :ABC:GlobalCapsModeSet( 3 ), :123:GlobalCapsModeSet( 4 ), :mt:GlobalCapsModeSet( 5 ), :MT:GlobalCapsModeSet( 6 )",400)
  Else If( GlobalCapsMode = 3 )
    MultiTap(":abc:GlobalCapsModeSet( 1 ), :Abc:GlobalCapsModeSet( 2 ), :123:GlobalCapsModeSet( 4 ), :mt:GlobalCapsModeSet( 5 ), :MT:GlobalCapsModeSet( 6 )",400)
  Else If( GlobalCapsMode = 4 )
    MultiTap(":abc:GlobalCapsModeSet( 1 ), :mt:GlobalCapsModeSet( 5 ), :Abc:GlobalCapsModeSet( 2 ), :ABC:GlobalCapsModeSet( 3 ), :MT:GlobalCapsModeSet( 6 )",400)
  Else If( GlobalCapsMode = 5 )
    MultiTap(":MT:GlobalCapsModeSet( 6 ), :abc:GlobalCapsModeSet( 1 ), :Abc:GlobalCapsModeSet( 2 ), :ABC:GlobalCapsModeSet( 3 ), :123:GlobalCapsModeSet( 4 )",400)
  Else If( GlobalCapsMode = 6 )
    MultiTap(":mt:GlobalCapsModeSet( 5 ), :abc:GlobalCapsModeSet( 1 ), :Abc:GlobalCapsModeSet( 2 ), :ABC:GlobalCapsModeSet( 3 ), :123:GlobalCapsModeSet( 4 )",400)
  Else
    GlobalCapsModeSet( 1 )

  ;If( GlobalCapsMode < 4 )
  ;  MultiTap(":abc:GlobalCapsModeSet( 1 ), ::GlobalCapsModeSet( 2 ), ::GlobalCapsModeSet( 3 )",400)
  ;If( GlobalCapsMode > 6 )
  ;  GlobalCapsMode := 1
  If( SHOW_INPUT )
    Tooltip % "[.] - " . CapsModeString%GlobalCapsMode%
  ;Progress, b zh0 fs32, % CapsModeString%GlobalCapsMode%
  ;Sleep,200
  ;Progress, Off
Return

NumpadAdd::
  If( SHOW_INPUT )
    Tooltip [+] - Spell

  Word := Spell()
  If( Word <> "" ) {
    AddWord( Word )
    Send %Word%
  }
Return

NumpadEnter::
  If( GlobalWordIndex <> 1 )
    Gosub HandlePriorityWords
  GlobalWordIndex := 1
  Send {Enter}
Return


/*------------------------------------------------------------------------------
/* REVISION HISTORY
/*------------------------------------------------------------------------------

  0.15  2010 09 07
    Fixed  : Did not work properly in all text editors due to the different
             behavior of the right arrow key after a text has been selected.
             Fix is in GetWordBeforeCursor() line 168 (send right).
    Added  : Ctrl+ESC to exit

  0.14  2008 07 10
    Added  : Automatic registration for priority words - when words that are
             not the first in their code are used, they are registered as the
             priority words for future use (i.e. they will appear first when
             that code is entered again).
    Added  : Priority words - words in prioritywords.txt will appear first when
             their code is entered
    Changed: Some minor changes

  0.13  2008 07 09
    Fixed  : Added words were not immediately available
    Changed: Minor changes in initialization sequence

  0.12  2008 07 09
    Fixed  : Some symbol related bugs

  0.11  2008 07 09
    Initial Release

/*------------------------------------------------------------------------------*/
