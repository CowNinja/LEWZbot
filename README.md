Prerequisits:
1. You must be running MEMUplay android client:
	https://www.memuplay.com/download.html
	
Settings:
1. I've constrained the Android Client MEMUplay to run at a set resolution for now:
; LEWZ_SetDefaults.ahk
	; Define desired window position and size	
	Global App_Win_X := 0
	Global App_Win_Y := 0
	Global App_WinWidth := 730
	Global App_WinHeight := 1249
	
; CowNinja_Functions.ahk
Check_Window_Geometry:
	WinMove, %FoundAppTitle%, , App_Win_X, App_Win_Y, App_WinWidth, App_WinHeight ; Move the window preset coords

2. Account details are retrieved from LEWZ_User_Logins.ini in AHK directory and loaded into an array:
; LEWZ_SetDefaults.ahk
; load User Logins
User_Logins := {}
Loop, Read, LEWZ_User_Logins.ini
{
	row := StrSplit(A_LoopReadLine, ",")
	user := row[1]
	row.RemoveAt(1)
	User_Logins[user] := row
}
