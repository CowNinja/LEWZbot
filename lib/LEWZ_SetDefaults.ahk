
; Last Empire War Z
; Last-Empire WarZ
; LastEmpire
; Longtech
; Lastwars

; #persistent
; check for error popup every 30 seconds
; settimer, Check_AppWindows_Timer, 30000

; restart App every minute if no battles take place
; settimer, Restart_App_Timer, 60000

; Reload script every 5 minutes
; SetTimer, Reload_Script, 300000
; return

; String concatenation
; str1 = %a%%b%
; or as an expression
; str2 := a b
; or with explicit concatenation operators
; str3 := a . b

FormatTime, FileDateTimeString,, yyyy-MM-dd@HHmm
FormatTime, LogDateTimeString,, yyyy-MM-dd HH:mm:ss
; LogPrefix := DateString . "@" . TimeString

; String concatenation with explicit concatenation operator
Global LogFile := ".\logs\" . FileDateTimeString . "_MEmu_log.csv"
Global CSVFile := ".\CSV\" . FileDateTimeString . "_Farms.csv"
Global AppendCSVFile := ".\CSV\" . FileDateTimeString . "_Append.csv"

; Open a console window for this demonstration:
DllCall("AllocConsole")
; Open the application's stdin/stdout streams in newline-translated mode.
; stdin	:= FileOpen("*", "r `n")	; Requires [v1.1.17+]
; stdout := FileOpen("*", "w `n")
Global stdout := FileOpen(LogFile, "w `n")
Global CSVout := FileOpen(CSVFile, "w `n")

; After running this script, right click the tray icon and click Exit to test the OnExit callback function.
; Register a function to be called on exit:
OnExit("ExitFunc")

; Register an object to be called on exit:
OnExit(ObjBindMethod(MyObject, "Exiting"))

ExitFunc(ExitReason, ExitCode)
{
	if ExitReason not in Logoff,Shutdown
	{
		;MsgBox, 4, , Are you sure you want to exit?,1000
		;IfMsgBox, No
		; 	return 1	; OnExit functions must return non-zero to prevent exit.
	}
	; Do not call ExitApp -- that would prevent other OnExit functions from being called.
}

class MyObject
{
	Exiting()
	{
		global
		; MsgBox, MyObject is cleaning up prior to exiting...
		stdout.WriteLine(A_NowUTC ",****************************************** ")
		stdout.WriteLine(A_NowUTC ",************* GRACEFUL EXIT ************** ")
		stdout.WriteLine(A_NowUTC ",****************************************** ")
		stdout.Close()
		CSVout.Close()
	}
}

; code to reposition all message box dialoges adjacent to right side of MEMUplay window
OnMessage(0x44, "Move_MsgBox")
Move_MsgBox(P)
{
	if (P = 1027)
	{
		Process, Exist
		DetectHiddenWindows, % (Setting_A_DetectHiddenWindows := A_DetectHiddenWindows) ? "On" :
		if WinExist("ahk_class #32770 ahk_pid " ErrorLevel)
			WinMove, MsgWinMove_X, MsgWinMove_Y	; WinMove, 731, 1000
		DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
	}
}

; Receives a custom message and up to two numbers from some other script or program (to send strings rather than numbers, see the example after this one).
OnMessage(0x5555, "MsgMonitor")
OnMessage(0x5556, "MsgMonitor")
MsgMonitor(wParam, lParam, msg)
{
    ; Since returning quickly is often important, it is better to use ToolTip than
    ; something like MsgBox that would prevent the function from finishing:
	; ToolTip Message %msg% arrived:`nWPARAM: %wParam%`nLPARAM: %lParam%
	Text_Found := wParam
	/*
	if wParam
		Text_Found := True
	else
		Text_Found := False
	*/
}

; SetDefaults()
{
	; Global ; This word may be omitted if the first line of this function will be something like "local MyVar".
	; Variables used for logins
	Global User_Name := ""
	Global User_Email := ""
	Global User_Pass := ""
	Global User_PIN := ""

	Global rand_min := 0 ; Min time wait between buttons (ms)
	Global rand_max := 10 ; Max time wait between buttons (ms)
	Global rand_wait
	Random, rand_wait, %rand_min%, %rand_max%
	Global Delay_Pico := 10 ; 50 ; default delay for PICO pauses
	Global Delay_Micro := (5*Delay_Pico + 0) ; 50 ; default delay for MICRO pauses
	Global Delay_Short := (2*Delay_Micro + 0) ; 100 ; default delay for SHORT pauses
	Global Delay_Medium := (5*Delay_Short + 0) ; 500 ; default delay for MEDIUM pauses
	Global Delay_Long := (2*Delay_Medium + 0) ; 1000 ; default delay for LONG pauses

	; Entire desktop coordinates
	Global SysGet, VirtualWidth, 78
	Global SysGet, VirtualHeight, 79

	; Global VirtualWidth := SysGet(78)
	; Global VirtualHeight := SysGet(79)
	; MsgBox, VirtualWidth: %VirtualWidth% and VirtualHeight: %VirtualHeight%

	Global VirtualWidth := (VirtualWidth /4)
	; MsgBox, VirtualWidth: %VirtualWidth% and VirtualHeight: %VirtualHeight%

	; redraw output window after 14 lines
	Global GUI_Count := 0

	; variables used for finding pictures
	Global image_name := ""
	Global FoundPictureX := 0
	Global FoundPictureY := 0
	Global Fuzzy_Diff := 1

	; variables used for clicking
	Global Min_Pix := -5 ; Min pixel varience when clicking
	Global Max_Pix := 5 ; Max pixel varience when clicking
	Global X_Pixel_offset := 0 ; offset pixel incase changing resolution
	Global Y_Pixel_offset := -32 ; -66 ; offset pixel incase changing resolution
	Global rand_pixel := 0 ; variable used to store resulting random pixel varience
	Global X_Pixel := 0 ; variable used to store computed X click point
	Global Y_Pixel := 0 ; variable used to store computed Y click point

	; variables used for finding app window geometry
	Global FoundAppTitle := ""
	Global FoundAppClass := ""
	Global FoundAppControl := ""
	Global FoundAppProcess := ""
	Global FoundAppID := ""
	Global FoundAppPID := 0
	Global NewTitle := "LEWZ0"
	Global FoundAppX := 0
	; Global FoundAppX := 1200
	; Global FoundAppX := 2400
	; Global FoundAppX := 3600
	Global FoundAppY := 0
	Global FoundAppWidth := 0
	Global FoundAppHeight := 0

	; Variables for storing discovered window geometry
	Global UpperX := 0 ; initialize upper left X coord of app window
	Global UpperY := 0 ; initialize upper left Y coord of app window
	Global LowerX := 0 ; initialize lower right X coord of app window
	Global LowerY := 0 ; initialize lower right Y coord of app window
	Global WinWidth := 0 ; initialize Width of app window
	Global WinHeight := 0 ; initialize Height of app window

	; Define desired window position and size	
	Global App_Win_X := 0
	Global App_Win_Y := 0
	Global App_WinWidth := 730
	Global App_WinHeight := 1249
	; actual Game Area within MEMUplay, based on MEMUplay being set to 730 x 1249:
	; ClassNN: Qt5QWindowIcon19
	; Text: RenderWindowWindow
	; Client: x: 1 y: 32 w: 689 h: 1216
	Global MEmu_Operation_Recorder_X := App_Win_X
	Global MEmu_Operation_Recorder_Y := (App_Win_Y+App_WinHeight+1)
	Global Operation_Recorder_Window := "MEmu"
	Global WinMove_X := 0 ; initialize location upper left X coord of app window
	Global WinMove_Y := 0 ; initialize location upper left Y coord of app window
	; WinMove, 731, 1000
	; WinMove, MsgWinMove_X, MsgWinMove_Y
	Global MsgWinMove_X := (App_Win_X + App_WinWidth + 1) ; initialize location upper left X coord of MSg Window
	Global MsgWinMove_Y := (App_Win_Y + 1000) ; initialize location upper left Y coord of MSg Window

	Global GameArea_X1 := App_Win_X
	Global GameArea_Y1 := (App_Win_Y + 33)
	Global GameArea_X2 := (App_Win_X + 688)
	Global GameArea_Y2 := App_WinHeight
	Global GameArea_H := (App_WinHeight - 33)
	Global GameArea_W := (App_WinWidth - 43)

	; OCR Variables
	Global Capture2TextPATH := "C:\Users\CowNi\Desktop\MEmu\lib\Capture2Text\"
	Global Capture2TextCLI := "Capture2Text_CLI.exe"
	Global Capture2TextEXE := "Capture2Text.exe"
	Global OCR_X := 115
	Global OCR_Y := 30
	Global OCR_W := 560
	Global OCR_H := 75
	Global Text_Found := False

	; variables for desert oasis tower coordinates
	Global Desert_Tower_X := 0
	Global Desert_Tower_Y := 0

	; Messaging Variables
	Global Boss_User_name := "Hack Root"
	Global Chat_Message := "Hello Everyone"
	Global Message_To_The_Boss := "DEFAULT Routine Completed,"

	; if true Pause prompt pop up
	Global Pause_Script := False
	Global Subroutine_Running := "Main"
	Global Last_Subroutine_Running := "Main"

	; CoordMode settings
	CoordMode Mouse, Screen ; Coordinates are relative to the desktop (entire screen).
	; CoordMode Mouse, Relative ; Coordinates are relative to the active window.
	; CoordMode Mouse, Window ; Synonymous with Relative and recommended for clarity.
	; CoordMode Mouse, Client ; Coordinates are relative to the active window's client area, which excludes the window's title bar, menu (if it has a standard one) and borders. Client coordinates are less dependent on OS version and theme.

	CoordMode Pixel, Screen ; Coordinates are relative to the desktop (entire screen).
	; CoordMode Pixel, Relative ; Coordinates are relative to the active window.
	; CoordMode Pixel, Window ; Synonymous with Relative and recommended for clarity.
	; CoordMode Pixel, Client ; Coordinates are relative to the active window's client area, which excludes the window's title bar, menu (if it has a standard one) and borders. Client coordinates are less dependent on OS version and theme.

	; room and battle time out
	; Global Room_Wait_Count := 0 ; COUNTS UP, wait time in room
	; Global Timeout_Count := 100 ; SET, loop wait count, set value
	; Global View_click := False ; IF False, reset viewpoint in battle
	; Global Resetting_Posit := False ; Set default reset view to false
	; Global Go_Back_Home_Delay_Long := False ; set default delay to false, or NOT LONG

	; counter resets every successful battle
	; Global Battle_counter := 0 ; COUNTS UP, how many battles

	; counter resets every successful program restart
	Global Main_Loop_Counter := 0 ; COUNTS UP, how many loops
	Global Reset_App_Yes := 0 ; IF 1, reset program
	Global Restart_Loops := 60 ; SET, restart app after looping through main program this many times
}
; return

; SetDefaults()

stdout.WriteLine(A_NowUTC ",****************************************** ")
stdout.WriteLine(A_NowUTC ",******** STARTUP & INITIALIZATION ******** ")
stdout.WriteLine(A_NowUTC ",****************************************** ")

; load User Logins
User_Logins := {}
Loop, Read, LEWZ_User_Logins.ini
{
	row := StrSplit(A_LoopReadLine, ",")
	user := row[1]
	row.RemoveAt(1)
	User_Logins[user] := row
}

/*
; load Colors
Base_Colors := {}
Loop, Read, LEWZ_Base_Colors.ini
{
	row := StrSplit(A_LoopReadLine, ",")
	Base := row[1]
	row.RemoveAt(1)
	Base_Colors[Base] := row
}
*/

; start program as soon as window is detected
; populate FoundAppTitle variable

Key_Menu() ; display Key menu

; Win_WaitRegEX("LEWZ")

; FoundAppTitle := ""

/*
MsgBox, 1. FoundAppTitle:"%FoundAppTitle%" FoundAppID:"%FoundAppID%"
App_Title_Text := "LEWZ00"
AppX := Win_WaitRegEX(App_Title_Text, Timeout="10", ExcludeText="Note", ExcludeTitle="Note")
FoundAppTitle := AppX.title
FoundAppID := AppX.ID
WinMinimize, ahk_id %FoundAppID%
MsgBox, 3. FoundAppTitle:"%FoundAppTitle%" FoundAppID:"%FoundAppID%"
WinRestore, ahk_id %FoundAppID%

WinMinimize, %FoundAppTitle%
MsgBox, 3. FoundAppTitle:"%FoundAppTitle%" FoundAppID:"%FoundAppID%"
WinRestore, %FoundAppTitle%

App_Title_Text := "LEWZ00"
AppX := Win_WaitRegEX(App_Title_Text, ExcludeText="Note", ExcludeTitle="Note")
FoundAppTitle := AppX.title
FoundAppID := AppX.ID
; MsgBox, 1. FoundAppTitle:"%FoundAppTitle%" FoundAppID:"%FoundAppID%"
*/

/*
AppTitle1 := "(LEWZ001)"
AppTitle2 := "(LEWZ002)"
AppTitle3 := "(LEWZ003)"
AppTitle4 := "(LEWZ004)"
AppTitle5 := "LEWZ001"
AppTitle6 := "LEWZ002"
AppTitle7 := "LEWZ003"
AppTitle8 := "LEWZ004"

loop
{
	WinWait, %AppTitle1%, , 0
	if ErrorLevel = 0
	{
		FoundAppTitle := AppTitle1
		NewTitle := "LEWZ001"
		FoundAppX := 0
		break
	}
	WinWait, %AppTitle2%, , 0
	if ErrorLevel = 0
	{
		FoundAppTitle := AppTitle2
		NewTitle := "LEWZ002"
		FoundAppX := 1200
		break
	}
	WinWait, %AppTitle3%, , 0
	if ErrorLevel = 0
	{
		FoundAppTitle := AppTitle3
		NewTitle := "LEWZ003"
		FoundAppX := 2400
		break
	}
	WinWait, %AppTitle4%, , 0
	if ErrorLevel = 0
	{
		FoundAppTitle := AppTitle4
		NewTitle := "LEWZ004"
		FoundAppX := 3600
		break
	}
	WinWait, %AppTitle5%, , 0
	if ErrorLevel = 0
	{
		FoundAppTitle := AppTitle5
		NewTitle := "LEWZ001"
		FoundAppX := 0
		break
	}
	WinWait, %AppTitle6%, , 0
	if ErrorLevel = 0
	{
		FoundAppTitle := AppTitle6
		NewTitle := "LEWZ002"
		FoundAppX := 1200
		break
	}
	WinWait, %AppTitle7%, , 0
	if ErrorLevel = 0
	{
		FoundAppTitle := AppTitle7
		NewTitle := "LEWZ003"
		FoundAppX := 2400
		break
	}
	WinWait, %AppTitle8%, , 0
	if ErrorLevel = 0
	{
		FoundAppTitle := AppTitle8
		NewTitle := "LEWZ004"
		FoundAppX := 3600
		break
	}
	if FoundAppTitle != ""
		break
} until FoundAppTitle != ""


	; WinActivate, ahk_id %FoundAppID%
	; WinSetTitle, ahk_id %FoundAppID%, , %FoundAppTitle%

	; if !WinActive(FoundAppTitle), WinActivate, %FoundAppTitle%
	WinSetTitle, %NewTitle%
	FoundAppTitle := NewTitle
*/
Select_App()