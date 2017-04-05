SayString := "Hallo im Blackholyman"

v := ComObjCreate("SAPI.SpVoice")

; Create a ListView:
Gui, Add, ListView, r10 w400 gMyListView, Voice

; Gather a list of Voices and put them into the ListView:
For T In v.GetVoices
    LV_Add("", T.GetDescription)

LV_ModifyCol()  ; Auto-size each column to fit its contents.

; Display the window and return. 
Gui, Show
return

MyListView: ; This will run whenever the user double clicks a row.
v.Voice := v.GetVoices().Item(A_EventInfo-1) ; Item is Zero based
v.rate := -3 ; slow down speak
v.Speak(SayString) ; announce String
return