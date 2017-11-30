;-------------------------------------------------------------------------------
;
;  Numpad9JT 1.0                                by: William Groom (aka zelmon64)
;  JustType Input with the Numpad (eight keys)
;  (based on the original Numpad9 by Danny Ben Shitrit (aka Icarus)
;   and JustType by Continous Path)
;
;   • Enable Numlock to Activate
;   +------------+------------+---------+-----------+
;   | Numlock   | /         | *         | -         |
;   | On        | Prev Word | Next Word | Delete    |
;   |           |  (Prior)  |  (Next)   |           |
;   +----Tab----+---Prior---+-Backspace-+-----------+
;   |  C  0  L  |  B  1  R  |  A  2  D  | +         |
;   |  "     :  |  -     ,  |  (     )  |           |
;   |  O     J  |  Z     .  |  F     X  | Spell     |
;   +---Spell---+-----------+---Enter---|           |
;   |  Q  9  U  |           |  T  @  H  |           |
;   |  8     /  |           |  ?     3  |           |
;   |  N     W  |           |  K     P  |           |
;   +Shift/Caps-+---Next----+--Symbols--+-----------+
;   |  I  7  S  |           |  e  4  g  | Enter     |
;   |  6     ;  |   Space   |  !     5  |           |
;   |  V     Y  |           |  m     '  |           |
;   +-----------+-----------+-----------|           |
;   | 0                     | .         |           |
;   | Space                 | Case      |           |
;   |  8                    |           |           |
;   +-----------------------+-----------+-----------+
;
;
;               Normal Layout
;   -------------------------------------
;   |----Tab----|---Prior---|-Backspace-|
;   |  C  0  L  |  B  1  R  |  A  2  D  |
;   |  "     :  |  -     ,  |  (     )  |
;   |  O     J  |  Z     .  |  F     X  |
;   -------------------------------------
;   |---Spell---|---Show----|---Enter---|
;   |  Q  9  U  |           |  T  @  H  |
;   |  8     /  |   Hold    |  ?     3  |
;   |  N     W  |           |  K     P  |
;   -------------------------------------
;   |Shift/Caps-|---Next----|--Symbols--|
;   |  I  7  S  |           |  e  4  g  |
;   |  6     ;  |   Space   |  !     5  |
;   |  V     Y  |           |  m     '  |
;   -------------------------------------
;
;               Shifted Layout
;   -------------------------------------
;   |----Tab----|---Prior---|-Backspace-|
;   |  C  =  L  |  B  +  R  |  A  %  D  |
;   |  $     :  |  _     ,  |  {     }  |
;   |  O     J  |  Z     .  |  F     X  |
;   -------------------------------------
;   |---Spell---|---Show----|---Enter---|
;   |  Q  &  U  |           |  T  #  H  |
;   |  |     \  |   Hold    |  [     ]  |
;   |  N     W  |           |  K     P  |
;   -------------------------------------
;   |Shift/Caps-|---Next----|--Symbols--|
;   |  I  *  S  |           |  e  `  g  |
;   |  ^     ;  |   Space   |  <     >  |
;   |  V     Y  |           |  m     '  |
;   -------------------------------------
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




SetWorkingDir %A_ScriptDir%
SendMode Input

ENABLE_DEBUG := false   ; Enable to show detailed debug info
SHOW_INPUT   := false   ; (or) Enable to show the input as a tooltip


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
  GlobalWordIndexPre := GlobalWordIndex
  GlobalCapsMode  := 1      ; 123 = abc, Abc, ABC, 123

  CapsModeStrings := "abc,Abc,ABC,123"
  StringSplit CapsModeString, CapsModeStrings, `,

  ; Map letter to numpad key and default characters for single digit codes
  ; Chars := "ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789"
  ; Nums  := "88899944455566611112223333rtyijm,ad"
  Chars := "BZRADFXTHKPEGMISVYQUNWCLOJ12346789"
  Nums  := "88899996666333111144447777I,entora"
  StringSplit Chr, Chars
  StringSplit Num, Nums
  Loop %Chr0% {
    ThisChr := Chr%A_Index%
    Char_%ThisChr% := Num%A_Index%
  }
  JTChars := "BZR1ADFX2THKP3EGM45ISVY76QUNW98CLOJ0"
  JTNumsd := "888899999666663333311111144444477777"
  JTNumsu := "791879138791367918679138479138479138"
  StringSplit JTChr, JTChars
  StringSplit JTNumd, JTNumsd
  StringSplit JTNumu, JTNumsu
  Loop %JTChr0% {
    ThisChr := JTChr%A_Index%
    JTChar_%ThisChr% := JTNumd%A_Index% * 10 + JTNumu%A_Index%
  }

  ; Make one variable for each code, with space separated list of words
  Loop %Word0% {
    If( Word%A_Index% = "" )
      Continue

    RegisterWordVariable( Word%A_Index% )
  }

  ; Add some symbol word
  Word_2 := ", . ? @ ! ' q - + / * ( ) : `; % $ #"
  Word_2 := ", . ? @ ! ' q `` - _ + = / \ | * ^ ( ) { } [ ] < > : `; % $ #"
  Word_22 := ":) `;) :] -> <-"
  Word_222 := "... :-) --> <--"
  StringReplace, Word_2, Word_2, q , " , All

  Suspend Off
Return



;-------------------------------------------------------------------------------
; T9 FUNCTIONS
;-------------------------------------------------------------------------------
RegisterWordVariable( word ) {
  ; Gets a word and registers it in the relevant a Word_%Code% variable

  Global

  NumCode := WordToCode( word, true )
  If( Word_%NumCode% <> "" ) and ( Not InStr( Word_%NumCode%, word ) )
    Word_%NumCode% .= " "

  If( Not InStr( Word_%NumCode%, word ) )
    Word_%NumCode% .= word
}

WordToCode( word, registering=false ) {
  ; Gets a word and returns its numeric code
  Global GlobalCapsMode
  Global GlobalWordIndexPre
  Result := ""
  If GlobalWordIndexPre <> 0
    word := RegExReplace( word, "\W", "2" )
  StringSplit Char, Word
  Loop %Char0% {
    ThisChar := Char%A_Index%
    If GlobalWordIndexPre <> 0
      Result .= ( RegExMatch( ThisChar, "\d" ) ? ThisChar : Char_%ThisChar% )
    Else If GlobalCapsMode <> 1
    {
      symbols := { "^":14, "`;":16, "*":18, "'":33, "<":34, ">":36, "`":38
                  , "|":44, "\":46, "&":48, "[":64, "]":66, "#":68
                  , "$":74, ":":76, "=":78, ".":83, "_":84, ",":86, "+":88
                  , "{":94, "}":96, "%":98 }
      If symbols.HasKey(ThisChar)
        Result .= symbols[ThisChar]
      Else if ThisChar = "
        Result .= 74
      Else
        Result .= ( RegExMatch( ThisChar, "[^a-zA-Z0-9]" ) ? ThisChar : JTChar_%ThisChar% )
    }
    Else
    {
      symbols := { "`;":16, "'":33, "!":34, "/":46, "?":64, "@":68
                  , ":":76, ".":83, "-":84, ",":86, "(":94, ")":96 }
      If symbols.HasKey(ThisChar)
        Result .= symbols[ThisChar]
      Else if ThisChar = "
        Result .= 74
      Else
        Result .= ( RegExMatch( ThisChar, "[^a-zA-Z0-9]" ) ? ThisChar : JTChar_%ThisChar% )
    }
  }
  If Not registering
  {
    If GlobalWordIndexPre <> 0
      Debug( "WordToCode:`tIN [" . word . "] OUT [" . Result . "]" )
    Else
      Debug( "WordToJTCod:`tIN [" . word . "] OUT [" . Result . "]" )
  }

  Return Result
}

ManageInput( inputChar ) {
  ; Called whenever 1-9 is pressed and prints the new word to the screen

  Global GlobalWordIndex

  Word := GetWordBeforeCursor()
  StringRight LastChar, Word, 1

  Debug( "ManageInput:`tIN [" . inputChar . "] WORD [" . Word . "]" )

  ; A symbol immediately after a word or word immediately after symbol
  If( ( RegExMatch( LastChar, "[a-zA-Z]" ) ) and ( inputChar="2" ) ) ;or ( ( RegExMatch( LastChar, "[^a-zA-Z]" ) ) and ( RegExMatch( inputChar, "[13456789]" ) ) )
  {
    Word :=
    GlobalWordIndex := 1
  }

  If Word =
    PrintWord( InputChar, false )
  Else If( Word = "2" )
  {
    Send {Backspace}
    PrintWord( WordToCode( Word ) . inputChar, false )
  }
  Else
    PrintWord( WordToCode( Word ) . inputChar )
}

GetWordBeforeCursor() {
  ; Returns the word that is currently shown before the carret
  Global GlobalWordIndexPre

  Clipboard =
  Send ^+{Left}^c
  ClipWait 0.3
  Word := Clipboard
  Send ^v

  If( RegExMatch( Word, "\s$" ) or InStr( Word, "`n" )  or InStr( Word, "\R" ) )
    Word := ""

  If Word <>
  {
    If( RegExMatch( Word, "(\W+)$", Token ) )
      Word := GlobalWordIndexPre <> 0 ? RegExReplace( Token, "\W", "2" ) : Word
    Else If( RegExMatch( Word, "[^a-zA-Z0-9]$" ) )
      Word := GlobalWordIndexPre <> 0 ? "2" : Word
    Else
      Word := RegExReplace( Word, "[\W]", "" )
  }

  Debug( "GetWordBefo:`tOUT [" . Word . "]" )

  Return Word
}

PrintWord( code, cleanBefore=true ) {
  ; Gets a code and prints its word to the screen.
  ; If cleanBefore is true, it will erase the word before the carret

  Global
  If (GlobalWordIndexPre = 0) ;&& GlobalWordIndex = 2)
    GlobalWordIndex := GlobalWordIndex = 2 ? 1 : -1
  GlobalWordIndexPre := GlobalWordIndex

  If( GlobalWordIndex = 0 )
  {
    WordToPrint := CodeToJTChars( code )
    GlobalWordIndex := 1
  }
  Else If( Word_%code% = "" )
    WordToPrint := CodeToChars( code )
  Else {
    StringSplit Word, Word_%code%, %A_Space%
    GlobalWordIndex :=  ( GlobalWordIndex > Word0 ) ? 1 : ( GlobalWordIndex < 0 ? Word0 : GlobalWordIndex )
    WordToPrint := Word%GlobalWordIndex%
  }

  If( GlobalCapsMode = 2 )
    StringUpper WordToPrint, WordToPrint, T
  Else If( GlobalCapsMode = 3 )
    StringUpper WordToPrint, WordToPrint
  Else If( GlobalCapsMode = 4 )
    WordToPrint := WordToCode( WordToPrint )

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

CodeToJTChars( code ) {
  ; Gets a code and returns the raw Just Type characters it represents.
  ; This is called when the GlobalWordIndex is zero
  Global GlobalCapsMode
  If GlobalCapsMode <> 1
  {
    JTChr := Array(A_Space,,,,,,,,,
              ,"v",,"y","^",,"`;","i","*","s",
              ,,,,,,,,,,
              ,"m",,"'","<",,">","e","``","g",
              ,"n",,"w","|",,"\","q","&","u",
              ,,,,,,,,,,
              ,"k",,"p","[",,"]","t","#","h",
              ,"o",,"j","$",,":","c","=","l",
              ,"z",,".","_",,",","b","+","r",
              ,"f",,"x","{",,"}","a","%","d")
  }
  Else
  {
    var = "
    JTChr := Array(A_Space,,,,,,,,,
              ,"v",,"y","6",,"`;","i","7","s",
              ,,,,,,,,,,
              ,"m",,"'","!",,"5","e","4","g",
              ,"n",,"w","8",,"/","q","9","u",
              ,,,,,,,,,,
              ,"k",,"p","?",,"3","t","@","h",
              ,"o",,"j",var,,":","c","0","l",
              ,"z",,".","-",,",","b","1","r",
              ,"f",,"x","(",,")","a","2","d")
  }

  StringSplit Digit, Code
  Result := ""
  ThisDigit := ""
  Loop %Digit0% {
    If A_Index > Digit.Length() / 2
      break
    ThisIndex1 := (A_Index - 1) * 2 + 1
    ThisIndex2 := (A_Index - 1) * 2 + 2
    ThisDigit1 := Digit%ThisIndex1%
    ThisDigit2 := Digit%ThisIndex2%
    ThisDigit3 := ThisDigit1 * 10 + ThisDigit2
    ThisDigit .= ThisDigit3
    Result .= JTChr[ThisDigit3]
  }
  Debug( "CodeToJTChs:`tIN [" . code . "] OUT [" . Result . "]" )
  Return Result
}

Spell() {
  ; Opens an input dialog for entering a new word.
  ; The word will be added to the userdictionary.txt file if it is a new word

  Word := GetWordBeforeCursor()
  If( Word )
    Send ^+{Left}

  StringReplace Word, Word, 7,,All

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

;-------------------------------------------------------------------------------
; HOTKEYS
;-------------------------------------------------------------------------------

^ESC::
  ExitApp
Return

Numpad5::
  Global GlobalCapsMode
  If GlobalCapsMode <> 1
  {
    SubText = %A_Space%|-------------JustType--------------|`n
                       |----Tab----|---Prior---|-Backspace-|`n
                       |  C  =  L  |  B  +  R  |  A  `%  D  |`n
                       |  $     :  |  _     ,  |  {     }  |`n
                       |  O     J  |  Z     .  |  F     X  |`n
                       |-----------------------------------|`n
                       |---Spell---|---Show----|---Enter---|`n
                       |  Q  &  U  |           |  T  #  H  |`n
                       |  |     \  |   Hold    |  [     ]  |`n
                       |  N     W  |           |  K     P  |`n
                       |-----------------------------------|`n
                       |Shift/Caps-|---Next----|--Symbols--|`n
                       |  I  *  S  |           |  e  ``  g  |`n
                       |  ^     `;  |   Space   |  <     >  |`n
                       |  V     Y  |           |  m     '  |`n
                       |-----------------------------------|
  }
  Else
  {
    SubText = %A_Space%|-------------JustType--------------|`n
                       |----Tab----|---Prior---|-Backspace-|`n
                       |  C  0  L  |  B  1  R  |  A  2  D  |`n
                       |  "     :  |  -     ,  |  (     )  |`n
                       |  O     J  |  Z     .  |  F     X  |`n
                       |-----------------------------------|`n
                       |---Spell---|---Show----|---Enter---|`n
                       |  Q  9  U  |           |  T  @  H  |`n
                       |  8     /  |   Hold    |  ?     3  |`n
                       |  N     W  |           |  K     P  |`n
                       |-----------------------------------|`n
                       |Shift/Caps-|---Next----|--Symbols--|`n
                       |  I  7  S  |           |  e  4  g  |`n
                       |  6     `;  |   Space   |  !     5  |`n
                       |  V     Y  |           |  m     '  |`n
                       |-----------------------------------|
  }
  /*
  SubText = %A_Space%+----Tab----+---Prior---+-Backspace-+`n
                     |  C  0  L  |  B  1  R  |  A  2  D  |`n
                     |  "     :  |  -     ,  |  (     )  |`n
                     |  O     J  |  Z     .  |  F     X  |`n
                     +---Spell---+-----------+---Enter---|`n
                     |  Q  9  U  |           |  T  @  H  |`n
                     |  8     /  |           |  ?     3  |`n
                     |  N     W  |           |  K     P  |`n
                     +Shift/Caps-+---Next----+--Symbols--+`n
                     |  I  7  S  |           |  e  4  g  |`n
                     |  6     `;  |   Space   |  !     5  |`n
                     |  V     Y  |           |  m     '  |`n
                     +-----------+-----------+-----------|`n
  */
  Progress, 1:b zh0 fm32 fs24 wm400 w800 ct00FF00 cwBlack
    , %A_Space%%SubText%
    , ; JustType
    , , Courier New
  KeyWait, %A_ThisHotkey%
  Progress, 1:off
Return


Numpad1::
Numpad2::
Numpad3::
Numpad4::
Numpad6::
Numpad7::
Numpad8::
Numpad9::
  Debug( "---INPUT:`t" . A_ThisHotkey )

  Global GlobalCapsMode
  If GlobalCapsMode <> 1
  {
    JTChr := Array(A_Space,,,,,,,,,
              ,"v",,"y","^ "," "," `;","i","*","s",
              ," ",," ","","Space",""," "," "," ",
              ,"m",,"'","<",,">","e","``","g",
              ,"n",,"w","| "," "," \","q","&","u",
              ,,,,,,,,,,
              ,"k",,"p","[ "," "," ]","t","#","h",
              ,"o",,"j","$ "," "," :","c","=","l",
              ,"z",,".","_ "," "," ,","b","+","r",
              ,"f",,"x","{ "," "," }","a","%","d")
  }
  Else
  {
    var = "
    JTChr := Array(A_Space,,,,,,,,,
              ,"v",,"y","6 "," "," `;","i","7","s",
              ," ",," ","","Space",""," "," "," ",
              ,"m",,"'","! "," "," 5","e","4","g",
              ,"n",,"w","8 "," "," /","q","9","u",
              ,,,,,,,,,,
              ,"k",,"p","? "," "," 3","t","@","h",
              ,"o",,"j",var," ",":","c","0","l",
              ,"z",,".","- "," "," ,","b","1","r",
              ,"f",,"x","( "," "," )","a","2","d")
  }
  /*
  var = "
  JTChr := Array(A_Space,,,,,,,,,
            ,"v",,"y","6 "," "," `;","i","7","s",
            ," ",," ","","Space",""," "," "," ",
            ,"m",,"'","! "," "," 5","e","4","g",
            ,"n",,"w","8 "," "," /","q","9","u",
            ,,,,,,,,,,
            ,"k",,"p","? "," "," 3","t","@","h",
            ,"o",,"j",var," ",":","c","0","l",
            ,"z",,".","- "," "," ,","b","1","r",
            ,"f",,"x","( "," "," )","a","2","d")
  */
  JTBtn := Array("+Shift/Caps-+"
               , "+---Next----+"
               , "+--Symbols--+"
               , "+---Spell---+",
               , "+---Enter---+"
               , "+----Tab----+"
               , "+---Prior---+"
               , "+-Backspace-+")
  ThisCode := SubStr( A_ThisHotkey, 7,1 )
  ThisCode10 := ThisCode * 10
  Progress, 2:b zh0 fm32 fs24 wm400 w300 ct00FF00 cwBlack
    , % " -----------`n " JTBtn[ThisCode]"`n |  " JTChr[ThisCode10 + 7] "  " JTChr[ThisCode10 + 8] "  " JTChr[ThisCode10 + 9] "  |`n |  " JTChr[ThisCode10 + 4] " " JTChr[ThisCode10 + 5] " " JTChr[ThisCode10 + 6] "  |`n |  " JTChr[ThisCode10 + 1] "     " JTChr[ThisCode10 + 3] "  |`n +-----------+"
    , ; JustType
    , , Courier New
	KeyWait, %A_ThisHotkey%, T0.2    ; T is the timeout in seconds. If it times out, the var ErrorLevel is set to 1.
	If (ErrorLevel = 1 || GetKeyState("Numpad5") || (A_PriorHotkey = "Numpad5" && A_TimeSincePriorHotkey < 500))
	{
    If (A_ThisHotkey = "Numpad1")
    {
      GlobalCapsMode++
      If( GlobalCapsMode > 3 ) ; Don't use GlobalCapsMode = 4 because not all number keys are used.
        GlobalCapsMode := 1
      If( SHOW_INPUT )
        Tooltip % "[.] - " . CapsModeString%GlobalCapsMode%
    }
    Else If (A_ThisHotkey = "Numpad2")
    {
      GlobalWordIndex++
      If( SHOW_INPUT )
        Tooltip [*] - Next
      ManageInput("")
    }
    Else If (A_ThisHotkey = "Numpad3")
  	{
      If (GlobalWordIndex <> 1)
        Gosub HandlePriorityWords

      ThisCode := SubStr( "Numpad2", 7,1 )
      If( SHOW_INPUT )
        Tooltip [%ThisCode%]
      ManageInput( ThisCode )
    }
    Else If (A_ThisHotkey = "Numpad4")
    {
      Progress, 1:off
      Progress, 2:Off
      If( SHOW_INPUT )
        Tooltip [+] - Spell

      Word := Spell()
      If( Word <> "" ) {
        AddWord( Word )
        Send %Word%
      }
    }
    Else If (A_ThisHotkey = "Numpad5")
    {
    }
    Else If (A_ThisHotkey = "Numpad6")
    {
      If( GlobalWordIndex <> 1 )
        Gosub HandlePriorityWords
      GlobalWordIndex := 1
      Send {Enter}
    }
    Else If (A_ThisHotkey = "Numpad7")
    {
      If( GlobalWordIndex <> 1 )
        Gosub HandlePriorityWords
      GlobalWordIndex := 1
      Send {Tab}
    }
    Else If (A_ThisHotkey = "Numpad8")
    {
      GlobalWordIndex--
      If( SHOW_INPUT )
        Tooltip [/] - Prev
      ManageInput("")
    }
    Else If (A_ThisHotkey = "Numpad9")
    {
      Send {Backspace}
      GlobalWordIndex := 1
      If( SHOW_INPUT )
        Tooltip [-] - Del
      ManageInput("")
    }
  }
  Else If (A_ThisHotkey = "Numpad2")
  {
    If( GlobalWordIndex <> 1 )
      Gosub HandlePriorityWords

    Send {Space}
    GlobalWordIndex := 1
    If( GlobalCapsMode = 2 )
      GlobalCapsMode := 1
    If( SHOW_INPUT )
      Tooltip [0] - Space
  }
	Else
	{
    If( SHOW_INPUT )
      Tooltip [%ThisCode%]
    ManageInput( ThisCode )
  }
	KeyWait, %A_ThisHotkey%
  Progress, 2:Off
Return

Numpad0::
  If( GlobalWordIndex <> 1 )
    Gosub HandlePriorityWords

  Send {Space}
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
  GlobalCapsMode++
  If( GlobalCapsMode > 4 )
    GlobalCapsMode := 1
  If( SHOW_INPUT )
    Tooltip % "[.] - " . CapsModeString%GlobalCapsMode%
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

  1.0   2017 11 30
    Added  : Disambiguous JustType character string accessed by pressing the
             `Prior` key once (it cannot be accessed with the `Next` key). More
             symbols are available when Shift/Caps is active.
             All symbols are available by cycling through after holding the
             `Symbols` key once.
             Visual feedback on key press and show entire layout when 5 is held.
    Removed: The Shift/Caps key cannot set GlobalCapsMode = 4 because not all of
             the number keys are used so it cannot be used to type strngs of
             numbers.
    Fixed  : Changing the punctuation no longer deletes the preceding word.
    Changed: Modifed to only need to use the numpad keys 1,2,3,4,6,7,8 and 9.
             The number 5 key can be pressed instead of a long press of the
             other keys.
             Rearanged the charaters to the JustType BRZ layout.

/*------------------------------------------------------------------------------
/* Original Numpad9 REVISION HISTORY
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
