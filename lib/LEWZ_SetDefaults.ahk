
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
	Global Client_Area_X := 1
	Global Client_Area_Y := 32
	Global Client_Area_W := 689
	Global Client_Area_H := 1216
	Global Client_Area_X2 := (Client_Area_X + Client_Area_W)
	Global Client_Area_Y2 := (Client_Area_Y + Client_Area_H)
	
	/*
	Default Window search:
	[options.x1:=0] (number), [options.y1:=0] (number) ; the search scope's upper left corner coordinates
	[options.x2:=A_ScreenWidth] (number), [options.y2:=A_ScreenHeight] (number) ; the search scope's lower right corner coordinates
	[options.err1:=1], [options.err0:=0] ; A number between 0 and 1 (0.1=10%) for fault tolerance of foreground (err1) and background (err0)
	[options.screenshot:=1] (boolean) ; Wether or not to capture a new screenshot or not. If the value is 0, the last captured screenshot will be used
	[options.findall:=1] (boolean) ; Wether or not to find all instances or just one.
	[options.joinqueries:=1] (boolean) ; Join all GraphicsSearch queries for combination lookup.
	[options.offsetx:=1] (number), [options.offsety:=0] (number) ; Set the Max offset for combination lookup
	*/
	Global optionsObjCoords := {   x1: Client_Area_X
                , y1: Client_Area_Y
                , x2: Client_Area_X2
                , y2: Client_Area_H
                , err1: 0.1
                , err0: 0.1
                , screenshot: 1
                , findall: 1
                , joinqueries: 0}
	Global optionsObjALL := {   x1: 1
                , y1: 32
                , x2: 689
                , y2: 1216
                , err1: 0.1
                , err0: 0.1
                , screenshot: 1
                , findall: 1 }
	Global optionsObjONE := {   x1: 1
                , y1: 32
                , x2: 689
                , y2: 1216
                , err1: 0.1
                , err0: 0.1
                , screenshot: 1
                , findall: 1
                , joinqueries: 1
                , offsetx: 1
                , offsety: 1 }

	Global MEmu_Operation_Recorder_X := App_Win_X
	Global MEmu_Operation_Recorder_Y := (App_Win_Y+App_WinHeight+1)
	Global Operation_Recorder_Window := "MEmu"
	Global WinMove_X := 0 ; initialize location upper left X coord of app window
	Global WinMove_Y := 0 ; initialize location upper left Y coord of app window
	; WinMove, 731, 1000
	; WinMove, MsgWinMove_X, MsgWinMove_Y
	Global MsgWinMove_X := (App_Win_X + App_WinWidth + 1) ; initialize location upper left X coord of MSg Window
	Global MsgWinMove_Y := (App_Win_Y + 1000) ; initialize location upper left Y coord of MSg Window


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

/*
; load User Logins
User_Logins := {}
Loop, Read, LEWZ_User_Logins.ini
{
	row := StrSplit(A_LoopReadLine, ",")
	user := row[1]
	row.RemoveAt(1)
	User_Logins[user] := row
}
*/
; load User Logins from LEWZ_User_Logins.ini
/*
	populates Base_Array array as follows:
	Account,row[1],
	User_Name_new,row[1],
	User_Name_old,row[2],
	User_Email,row[3],
	User_Pass,row[4],
	User_PIN,row[5],

	example input: 
	Account,Hack_722_01,
	User_Email,TestAccount@gmail.com,
	User_Name_new,Hack_722_01,
	User_Name_old,Hack 722.01,
	User_Pass,99999999,
	User_PIN,123456789,
*/


Base_Array := {}
Loop, Read, LEWZ_User_Logins.ini
{
	row := StrSplit(A_LoopReadLine, ",")
	User_Name_Input := row[1]
	Base_Array[User_Name_Input] := {User_Name_new : row[1]
	, User_Name_old : row[2]
	, User_Email : row[3]
	, User_Pass : row[4]
	, User_PIN : row[5]
	, User_Name_Captured : ""
	, User_City_Location_XY : ""
	, User_Found_Alliance : ""
	, User_Found_State : ""
	, User_VIP : ""
	, User_Power : ""
	, User_Diamonds : ""
	, Available_Fuel : ""
	, Available_Food : ""
	, Available_Steel : ""
	, Available_Alloy : ""
	, Inventory_Fuel : ""
	, Inventory_Food : ""
	, Inventory_Steel : ""
	, Inventory_Alloy : ""}	
	; Base_Array.Push(Value, Value2, ...)
	row.RemoveAt(1)
}

; Array_Gui(Base_Array)

/*
Headers := []
Base_Array := []
Loop, Read, LEWZ_User_Logins.ini
{
	if (A_Index = 1)
		Headers := StrSplit(A_LoopReadLine, ",")
	else ; if A_LoopField
	{
		obj := new CaseSenseList
		; for k, v in StrSplit(A_LoopReadLine, ",")
		row := StrSplit(A_LoopReadLine, ",")
		{
			cHead := Headers[k]
			obj[cHead] := v
			; MsgBox, % "key: " cHead " val = " v
			; obj.Push(o) ;doesn't work
		}
		; MsgBox, % Obj2Str2(o)
		; obj[A_Index-1] := o
		Base_Array.Push(obj)
	}
	; MsgBox, % Base_Array.1
}
Array_Gui(Base_Array)
*/

/*
Base_Array := []
Loop, Read, LEWZ_User_Logins.ini
{
	row := StrSplit(A_LoopReadLine, ",")
	User_Name_Input := row[1]
	Base_Array[%User_Name_Input%] := []
	Base_Array.User_Name_Input.User_Name_new := row[1]
	Base_Array.User_Name_Input.User_Name_old := row[2]
	Base_Array.User_Name_Input.User_Email := row[3]
	Base_Array.User_Name_Input.User_Pass := row[4]
	Base_Array.User_Name_Input.User_PIN := row[5]
	row.RemoveAt(1)
}
*/

/*
; verify working array
	for Account, vValue in Base_Array
	{
		vOutput .= "Account," Account ","
		for bKey, bValue in vValue
			vOutput .= bKey "," bValue ","
		
		; MsgBox, % "Account:" Account "`n vValue:" vValue[1] "`n Base_Array:" Base_Array[1] "`n bKey:" bKey "`n bValue:" bValue
		vOutput .= "`n"
	}
	MsgBox, % "final:" vOutput
*/

/*
change 
			global User_Name := Current_User_Name
			global User_Email := Current_User_Email
			global User_Pass := Current_User_Pass
			global User_PIN := Current_User_PIN


	Base_Array := {}
	User_Name := {}
	
	User_Name := {user_old: User_Name_old, 
	email: User_Email,
	PW: User_Pass,
	PIN: User_PIN,
	email: User_Name_Captured, 
	routine: Routine, 
	location: User_City_Location_Array,
	alliance: User_Found_Alliance,
	state: User_Found_State,
	vip: User_VIP,
	power: User_Power,
	diamonds: User_Diamonds,
	fuel_out: Available_Fuel
	fuel_store: Inventory_Fuel
	food_out: Available_Food
	food_store: Inventory_Food
	steel_out: Available_Steel
	steel_store: Inventory_Steel
	alloy_out: Available_Alloy
	alloy_store: Inventory_Alloy}]
*/

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


; Renamed GraphicSearch_query (auto), commented out graphics
    Global 011_Icon_LEWZ_Graphic := "|<011_Icon_LEWZ>0xF2F0F1@0.72$35.k0000NU0000n03kD1i0DkzDw0tna6M1Va6Ak03C0NU1yD0n0DwDVa0MM7XA0kn36M1Xa6AznzDsTzXqDkS"
;    Global 022_Quit_OK_Button_Graphic := "|<022_Quit_OK_Button>*200$25.sDvyFltyFwwyNzCSRzbCSzvaDTwlDjyM7rzA9vziCRzbDCTnbn7vnwlltzA1wzY"
    Global 021_Quit_Title_Graphic := "|<021_Quit_Title>*200$41.VXzzzbqDnzzzzYznzzzz/zbzzzw7zjbttUDzDDnntTySTbbmzwwzDDZzttyST/znnwwyLzbbttwjzTDnntTwyTbbmTlwzDDaT7twSTC0Ts0wyC0zsNtyE"
    Global 023_Rebuild_Button_Graphic := "|<023_Rebuild_Button>*80$23.07zyw7zxyDzvwTVrsw0jlk0T33k0CDk0wTU3s073k0D7XzS77yyC7xwA73wQ07sQ0k"
;  Global 10_Commander_Title_Graphic := "|<10_Commander_Title>*200$48.7zzzszzz7zzztzzz7zzztzzz7zzztzzz7zzzlzzz7nUz0Dw77m0T0Dk17kyDlzXt7lzDlz7w7nzDlzDw7nzDlzDy7nzDlyDy7nzDlyDy7nzDlyTy7nzDlyDy7nzDlzDy7nzDlzDw7nzDlz7w7nzDlzXs7nzDlzk1U"
  Global 1A_Settings_Button_Graphic := "|<1A_Settings_Button>#1474@0.38$66.z6Tzztzznzzsszzztyjnzztzzzxty7zzznzzzytyDrzzrzzzzszzrzzjzzzzszzbzzrzzzzwzzbzznzzzzwTzDzzzzzzzz7yDzwXzzTzzUkzztTzzzzzk1zzzzzznzzzzzzrzzzvzvzzzzrzzzvzvzzzzvzzzvzvzzzztzzzvzvzzzzxzyzvzvzzzzxTzzrzvzzzzx7zbjz7zzzztzzsTyzzzzzbvzzzyzzzzzjrzzzzVzzkzTjzzzz0zzaSzbzzzzTTzjdzrzzzzTTzDnzU"
;    Global 1A0_Settings_Title_Graphic := "|<1A0_Settings_Title>*240$56.ntzzzzzzz/zjzzzjyzxztzzzvzjzTyTzzyzvzrzzz7z7wTxzzz0T0Q1wjzzjryzvz9zznyzjyznXzxzbvzjwy3yTtyzvzDwTbyTjyznzns07vzjwzySTzyzvzDzbjzzjyznztvzzvzjwTyTTzyzvz7zbnzzjyzmzvwzjvzbwlVznbz7szD1zy3zlzbm"
    Global 1A1_Account_Button_Graphic := "|<1A1_Account_Button>*240$48.0000000000Dzz00000zzzy0003zzzzU007zzzzk00Dzzzzs00Dzzzzw00Tzzzzw00zvzzzy00zvzzzz00zzzzzz00zzzzzz00zvzzzz00zvzzzz00zzzzzz01zzzzzz01zzzzzzU1zzzzzzU1zzzzzzU1zzzzzzU1zzzzzzU1zzzzzzU3zzzzzzU3zy00DzU3zs00DzkU"
;      Global 1A10_Account_Title_Graphic := "|<1A10_Account_Title>*240$67.zXzzzzzzzzzzlzzzzzzzzzzqzzzzzzzzzzvjzzzzzzzzzzrzzzzzzzzzxvzzAzwnzzzyyzzTjxyTtnyzTzTvxzjvyzTbzTyxzvvzjjvzjzyzzvznjxzrzzTzxzxryTnzzDzyzyvzDvzzjzyzzMz3xzzrzzTzhztyTztzzjzozyzjzyzznzuzzTrzjTyxzxTzbvzjjyyzxDzvyzjvyTDyjzwzjjySTryrzzTwTztzwyw"
      Global 1A12_Switch_Button_Graphic := "|<1A12_Switch_Button>*240$59.wTzzzyzzzz77zzzxzzzyzbzzzzxzztzjzzzzvzznzTzzzzrzzbztyzjQ1w3DzvwzSzTnnDzrlxxyzjv1zbVvvxyTrkzjPrrvwzzwzTrDjrvzzwyPizTjrzzxyrhyzTjyzvxjPxyzDxzrsyDvxyTlzDlyTrvyz8wzXwzjnyQw7zjzzTly7U"
;        Global 1A120_Switch_Title_Graphic := "|<1A120_Switch_Title>*200$55.XwDzzzzzlXzbzzzzzsnzlzzzzzwPzwzzzzzyBzzzTnzTw0TzzDszjC0DzzrwTbblUzztw7nnss1zwyHvtwT03zT9twyDz0zjgwyT7zwDnbSTDXzzXtnbTblzzlyvnDnsrzwzRtbtwPzyTYyrwyBzyDsT3yT6TzDwTVzDX3z7yDkzbss0Dz7wzny8"
        Global 1A123_WarZ_Button_Graphic := "|<1A123_WarZ_Button>*60$20.DkT3s7ky0w7UD1s3kS0s7260kVUAMM2640Vl00w0UD083k20y1UDUQ3s71z1U"
;          Global 1A1230_WarZ_Accounts_Title_Graphic := "|<1A1230_WarZ_Accounts_Title>*200$44.DzwTzzznzzDzzzQzzzzzzXDzzzzzsnzzzzzyAzznz1w0Dzwz0703zzDXtyAzzntyDXDzwyTnsnzzDbzyAzznsTzXDzwz0zsnzzDy3yAzznzwDXDzwzznsnzzDDwyAzznlzDX7zwyDXsk0DDk1z003ny0zsU"
          Global 1A1232_OtherAccount_Button_Graphic := "|<1A1232_OtherAccount_Button>*240$39.qTyzzzxzvrzzzTjSzzzzzVoDVkzrSxzyTyvryzrzrSzrqzzvryzrTjSzryvxvryzrjTSzvyz7xrzXrU"
          Global 1A1234_Email_Box_Button_Graphic := "|<1A1234_Email_Box_Button>*200$42.000001b000003b000001b30MM307DrzyDlbTzzyTvbsz77Mvbzz777vbzz77Tvbzz77TvbsL77svbwz77RvbTz77Tvb7X26DtaU"
          Global 1A1235_PW_Box_Button_Graphic := "|<1A1235_PW_Box_Button>*200$50.zVwDlyslzwzXyTySTzTtzjxbalk7QPXRvgAzrsz3yv3Twzbwzwlr7PvTDzCRnrCtnnnzTxzjwwwzXzDly6CA0000000300000000k00000008"
          Global 1A1237_UseEmailLog_Button_Graphic := "|<1A1237_UseEmailLog_Button>*240$35.TtzzzyznzzzxzbzzzvzDzzzryT1z1jwxtxtTtnvruznbzjpzbbzTXzDny07yTsxzjwzxvzTvrvrzTbbrbzCzbDrD3zlzls"
            Global 1A12371_OK_Button_Graphic := "|<1A12371_OK_Button>*240$24.sDvyrbvwjvvxTtvvTxvrTxvjTxvDTxsDTxsbTxtnTxvvTtvxjvvwrrvysDvzU"
;            ; 1A12372_Yes_Button
;            Global 1A12373_VisitNow_Button_Graphic := "|<1A12373_VisitNow_Button>*70$36.DsXzwFDkXzwF7lzzzl7lXUw07XX0Q03XW0AFXXWCAFX7W7wFl7X0QFl7XUAFkDWQAFsDWCAFsDW0AEsTW0AEwTX0QMU"
              Global 1A123730_EnterPIN_Title_Graphic := "|<1A123730_EnterPIN_Title>*200$69.00Dzzz7zzzzvzzzzzszzzzzTzzzzz7zzzzvzzzzzszzzzzTzzzVw1zzzznzzwk7UDs3yMTzzUwT7y67k3zzwTlszbwy700TXzD7tznls01wztszDySDTzzbzD7tznlvzzwztsyDyCTTzzbzD7k01nvzzwztsyDzyTTzzbzD7lzznvzzwztsyDzyTTzzbzD7tzznvzzwztszDySTDzzbzDXwzbns00wztwDVlyTU"
;              Global 1A123731_ForgotLoginPW_Button_Graphic := "|<1A123731_ForgotLoginPW_Button>*137$68.03zzzzzzzzyLzzzzzzzzzzVzzzzzzzzzzsTzsDt7kny3s7zw0y1k0y0S1zyC7VwQD3XsTz7lsyDXlwSE1lyCTbwsz7Y0QzXbtzCDttTzDstyTnXyS7znyCTbwszbVzwzXbtzCDtsTz7styTnXwS7zlwSTXswT7VzyC7bwQD3XsTzk3tz03s1y7zy3yTw8zUznzzzzzzyDzzzzzzzzzzXzzzzzzzzznlzzzzzzzzzw0TzzzU"
;              Global 1A123732_StartNewGame_Button_Graphic := "|<1A123732_StartNewGame_Button>*57$70.D7lzzzzwTzzxyD7zzzzlzzzrwQTzzzz7zzzTl0TVy8k7zsRzw1s1s30Ty0HzwT7XUD7zlk1zlszC7wTyDW0z7zwszlzzzA1wTznXz7zzsw3lz0CDwTzk3y77lwszlzwTDwQS7nXz7zXwzllszCDwTyDnz77Xwszlzsz7wwSDXXz7zXsDXtwQCDwTz700zls0MzsTy08"
;          Global 1A1241_ArmsSupply_Title_Graphic := "|<1A1241_ArmsSupply_Title>*50$22.sDzzUTzw1zzk7zz4Ds8EzUVXy0C7sEsTV7lyAT3slwDX00SA01sk07XTwCBzkszzXXzy6DzsMs"
;          Global 1A1242_HotSale_Title_Graphic := "|<1A1242_HotSale_Title>*50$30.Dz7zzDz7zzDz7zzDz7y3Dz7s0Dz7k0007Uk0073w0073y0077yDz77yDz77yDz77yDz77yDz73yDz73wDz71sDz7U0Dz7k0U"
;  Global 21_Fuel_Button_Graphic := "|<21_Fuel_Button>*97$29.Tzzzy7zzzy3zzzzlw03znk03zl0zbznXzDzq7yDzw7yTzsDwTzUDszz0D1xw001vk00HnU007rUQ0Tnk1zzU0TzzUDzzzDzkzzwTjzy0zTzyzizzzzxzU"
;  Global 22_Food_Button_Graphic := "|<22_Food_Button>*103$28.zzw7zzy07zzU0Dzw00Ty000zU001k000200000000000000000000000000040000k0007000C4000lE013500AAQ00klk033bU"
;  Global 23_Steel_Button_Graphic := "|<23_Steel_Button>*109$31.zzzXzzzz0Dzzz00zzz017zz01bzz00bzz003zz001zz003zz003zz003tz003sz001sz001sT001sT001sD001sD001sD001sDU01wDz01wDzk1wDzz0wDyTswDzU"
;  Global 24_Alloy_Button_Graphic := "|<24_Alloy_Button>*81$39.zzzzjzzzzzUjzzzzUzXzzy01wDzy00y1zz00C0DzU0701zw0Q00Dzs7001zzw000Dzzk007zDz003zVzs00zwAz00TUBXs07w1zD03s0zzs1w07zy1y00zzyS001zzs000liz000zcrw00Dzazk03w"
  Global 30_VIP_Title_Graphic := "|<30_VIP_Title>*50$39.Dy73s01zksT00Dy73sTkzVsT3z7wD3sTszVsT3z3sT3sTsT3sT3z3sT3sTYC7sT00Vkz3s06A7sT00kVz3sTy4DsT3zsXz3sTz0TsT3zs3z3sTzUzsT3zU"
;    Global 312_VIPRaffle_Button_Graphic := "|<312_VIPRaffle_Button>*119$65.DtnU0zk0TzkTnbDlzXwTzUT7CTnz7wzz4ySQzbyDtkA8wwtyDwTX6ANltk0zs0CSMnbnU1zk0TwlXDbDzzXwS1XYTCTzz7sk379yQzzyDt7aC3wtzzwTmTASDtnzzszYQMwTnbzzlzA0F"
;  ; 40_Troops_Title
;  Global 50_ControlDesk_Title_Graphic := "|<50_ControlDesk_Title>*240$51.0DzzzzzbtwzzzzzwzDnzzzzzbtzDzzzzwzDwzzzzzbtzbsbyFwyDyyTTjbbVzrrxtywtDywzjDzaNzrbxwzwbDyw0DkzUtzbbzzlwHDwxzzzbb9zjbzzyQxDtyzzTnblwTnxtwwy0Dz6TXDbw"
;    Global 501_ControlDeskExpand_Button_Graphic := "|<501_ControlDeskExpand_Button>*240$47.7k003zzyDU007zrwT000DzbzzzzzzzjzzzzzzzDzzzzzzzDzzzzzzyDzzzzzzyTzzzzzzwTzzzzzzwTzzzzzzszzzzzzzk7k003zzUDU007zz3zz1tzzy7zzzzzzwTzzzzzzszzzzzzzXzzzzzzzDzzzzzzwTzzzzzztzzzzzzzblw000zzTXs001zwzU"
;    Global 502_ControlDeskCollapse_Button_Graphic := "|<502_ControlDeskCollapse_Button>*240$41.7s00DzyDU007zsT000DzrzzzzzzTzzzzzyzzzzzzvzzzzzzbzzzzzzTzzzzzwzzzzzzlzzzzzzbzzzzzyD7k003wyDU007tzzk7zTlzzzzzznzzzzzzXzzzzzzbzzzzzzjzzzzzzDzzzzzzTzzzzzzHw000zybs001zzU"
;  Global 60_Quest_Title_Graphic := "|<60_Quest_Title>*240$64.w3zzzzzzzzzDnzzzzzzzztzbzzzzzzzzjzDzzzzzzzwzyzzzzzzzzrzvzzzzXzyDTzbnzTttzDhzyTDxzDrxzLzxwzrxzDbwTzrnzTjyyTxzzTDxyzvtzrzxwzrnzjlzTzbnzT00zlxzyTDxwzzzwrzvwzrnzzzxDzjnzTjzzzkzwzDxyTzzz9zrwzbxzzbwnwztwTvwzTrU3zkBzX7y8s"
;  Global 70_Speaker_Title_Graphic := "|<70_Speaker_Title>*240$61.01zzzzzzzzbzjzzzzzzzrzvzzzzzzzvzwzzzzzzzxzzTzzzzzzyzzjzzzYTzzTzbxnzTryvjzrzyzjvxzLzrxzjjyzzlzbxzzrzyzszlyzxvzzTwzyTTytzzDyTzj7wRzzbyDzrbzyzznzrzvvzzjzvzvzxxzzrzSzxzyyzzvzTTyzzDjxyzjjyTzbnxzjTvyjzvyxzzzzzs"
  Global 71_Speaker_Claim_Button_Graphic := "|<71_Speaker_Claim_Button>*240$65.k3yzzztzzzzDnxzzzzzzzwTnvzzzzzzztzrrzzzzzzzrzbjzzzzzzzjzzTs7wyEC1TzyzDbtwS/kzzxyzbntyDnzzvzzDbnwTrzzrzyTDbxzjzzjzwyTDvzDzzTs1wyTryTzyzDntwzjwzzxyzbntzTtztvtzDbnyzlzrrnyTDbxzVzDjbsyTDvzHwzTbVwyTrys3yzUntwzjx"
    Global 821_World_Button_Graphic := "|<821_World_Button>*70$17.01y03w07s0Dk4DUA7kMDkyDlzzU7zU0zU0zU1y03s07U08"
    Global 822_Home_Button_Graphic := "|<822_Home_Button>*65$19.zk0Ts3zw1zy0zz0BzU0zk0Ds0Dw07y03y00z00TU0E"
;  Global 83_ActiveSkill_Button_Graphic := "|<83_ActiveSkill_Button>*240$42.DzzzzzzbzzzzzwrzTzzzksDzzzzUw7zzzzVw3tzzy7z1xzzw7z0zTzsDzUDjzkTzs7rzUzzw3uz1zzy1zw3zzz0Ts7zU"
      Global 8301_ActiveSkill_Title_Graphic := "|<8301_ActiveSkill_Title>*46$16.330AA0kk333wA0kk330AA0kk330AA0kk330AA0kk330AA0kk332"
      Global 8302_ActiveSkill_Title_Graphic := "|<8302_ActiveSkill_Title>*46$16.110440EE310A40EE110440EE110440EE110440EE110440kE312"
    Global 831_Blue_Use_Button_Graphic := "|<831_Blue_Use_Button>*60$10.Dkz3wDkz3wDkz3wDkz3wDkS00U"
    Global 832_Green_Use_Button_Graphic := "|<832_Green_Use_Button>#89@0.34$10.030w3kD0w3kD0w3kD0w3kD0w3kDzs"
      Global 8331_Instructor_Title_Graphic := "|<8331_Instructor_Title>*117$15.1k0MM0Q0w84C0S467060730303U01k1y0zk7z2zwrzw"
      Global 8332_Magic_Title_Graphic := "|<8332_Magic_Title>*130$26.01k001u000z000D01kC004300F1U00ks0kwQ1zzDyzzrvrzzzzzzU"
      Global 8333_WildHarvest_Title_Graphic := "|<8333_WildHarvest_Title>*108$17.000000007zkDzU1l03U0r03zw7zwDzsTzszzlkTnszrzzwzrt7jzzz"
      Global 8341_Bumper_Title_Graphic := "|<8341_Bumper_Title>*126$18.zU3zU3z03y23U030010U1001001001U01c00y00zU0zw0U"
      Global 8351_AbilityRsrch_Title_Graphic := "|<8351_AbilityRsrch_Title>*138$23.00400M2040103ztUTzwXzzyC00CrU7zTzzrzzzs"
      Global 8352_FirstRiches_Title_Graphic := "|<8352_FirstRiches_Title>*153$14.zwCzXDw2jXCNbXHkIMVVA6/0GtwrENrCy"
      Global 8353_FullofStrength_Title_Graphic := "|<8353_FullofStrength_Title>*93$16.k1y87sUHm1bs7k000000000000284HkT31wA7kkT31y"
      Global 8354_Promotion_Title_Graphic := "|<8354_Promotion_Title>*89$12.bszyl6tbtbtbtbtbtbtbt7k6Tw7sU"
      Global 8355_SkillfulWork_Title_Graphic := "|<8355_SkillfulWork_Title>*118$20.rUDys3zm0zyU/rs2wy0jjUDk0000000000000000000000000TzUDkM3y"
      Global 8356_SpecTrain_Title_Graphic := "|<8356_SpecTrain_Title>*80$24.0E030E2308260828E4000400800UQ000y000y100z008zW00zkE4zks4zsE0U"
;  Global 84_Officer_Button_Graphic := "|<84_Officer_Button>*120$55.w7ssbzzzzs0wMnzzzzsyAQzzzzzszWCTy7zzwzs02Q1sD0Tw376QM3VDyFnWT9wnbz8tlDwyNnzYQsby0AtzmCQHz06Qzl7C9wbzDDtXb4QHtbVllnX0Mtns1xtnkS0tzXzzzzzlzw"
;  Global 85_Items_Button_Graphic := "|<85_Items_Button>*130$44.DzzzzzznbzzzzzwtzzzzzzCTzzjjzn3kS01s4tsX33AMCQwFlnD3bDYwwlwtk1DDC3CQ0Hnnk3bDwwwzktntDDAwCAQnnnD3nUSwws6"
;  Global 86_Mail_Button_Graphic := "|<86_Mail_Button>*123$33.7yDztUTVzzA3wDzzUTVzzw1tC1tVD9X7A9tAwtVaNzbAAnD0tVaNU7AC7AwtVktbbAD7AstVttUHAzzzDTw"
    Global 860_Mail_Title_Graphic := "|<860_Mail_Title>*50$35.3zwDzy3zkTzw7zUzzs7y1zzkDw3y3UTs7k10TUD008z4S70Ew8sT0Vslzy1XVXy03327k066AD00C0MQDUS1ksT0w3Vkw1s73Vs3sS7U07kwD01"
      Global 8601_Read_Confirm_Button_Graphic := "|<8601_Read_Confirm_Button>*100$31.U0zU1U0DU0EQ7Us8T1Uy0TkkTUDsMTk7zwDw3zy7y3zz3z1zzVzUTzkzkDzsTs7wADs3y63w0y7Vw003s0603w07U3zU7U"
      Global 8602_Read_Mark_Button_Graphic := "|<8602_Read_Mark_Button>*100$25.7wDXVy7lky3kMT1sA70w23UQF1kC8YF7628X71YlU0kMk0QAFwCC8y770zc"
;    Global 861_Messages_Button_Graphic := "|<861_Messages_Button>*148$61.w07U000000S03k000000DU1s0000007k1w0000003w0y0Q0603Vy0v0zUTs7wv0RUxsSS7jRkAksAC771yMCsQ771XUzC6QA3XU1k3b7CDzky0T1lXb7zsDk7wstXXU00y0TQBllk00701y7ksM061X0z3sQC130lkTUwC3XlsswRkQ70zkTsDyM41UDU3s1wE"
;    Global 862_Alliance_Button_Graphic := "|<862_Alliance_Button>*149$69.1k1kks000000D0C670000001s1kk0000000T0C600000003Q1kk03U0A00tUC671z1rs37C1kksSwDzUslkC6771lsQCC61kksECC1VlksC6701lkAAA71kks7yC1XXzsC673zlkAQTzVkkswCC1XbzwC6771lkAAs1lkkskCC1Va0CC6771lkACk0lkkswyC1Uy07C673ylkA3U0Mkkk7a41UA"
;    Global 863_Battles_Button_Graphic := "|<863_Battles_Button>*149$63.zs000003U07zk0030kQ00kC000s63U060s0070kQ00k70S0sD3U760sDwTzyQ3ykC3nnyznUty3kMC70kQC7zw30ks63XUTzk0670kQQ3kC0zks63Xzy0sTy70kQTzk73Uks63XU60ss670kQQ0k770ks63XU60ssC70kQC3zy3bkQ73VszzUTz3syQ7yU"
;    Global 864_Activities_Button_Graphic := "|<864_Activities_Button>*149$65.7U001k00006T0003U0000Ar01s700000Pa0Dsznb0tnrC0xtz761XbgQ3UssCA773sM70lkQQAC7ksA1XUsMMQD1kM071klksTzUk0C3Vn1kzzVU0Q71a3Vzz300sC3Q73U770lkQ7kC60CC3XUs7UQA0ACD3VkD0sM0QDw7nUA1kM"
;      Global 8641_SPAR_Button_Graphic := "|<8641_SPAR_Button>*149$65.zsQ00000Q01UsE00000s020s000001k041k0301k3U68073TUDz70zM0C7zUzyC7js0QC3VkwQC7y0sM770sss5z1kkCC1llk8TXVUQM3XXzk7730sk777zU7C61lUCCC00CQA3X0QQM00QsM770sss20tkkCC3lksD7XVUQDDXVszy730sDz71zk"
;      Global 8642_AAR_Button_Graphic := "|<8642_AAR_Button>*149$62.0s0sMQ00000D0C67000003k3VU000001w0sM000000PUC600Q01UCM3VVkTkRy3b0sMQDS7zklkC6771lsQQA3VVkUQQ373UsMQ0770lUsC670zlkAzy3VVkzwQ3DzksMQS770rzwC6771lkBk3XVVlUQQ3M0ssMQQ770y06C677blkDU1nVVkzgQ3k0AMMM3n20s"
;      Global 8643_CSB_Button_Graphic := "|<8643_CSB_Button>*149$62.7w000000007zU00000003kQ00000000s3U0000000A0s1UQ0703X06DsTk7w3yk03yTS3bVvs00w71lkMMC00C3UQQ6C3U03Us3701k800sC0sy0T300C3UC7w3yk13Us3UDU7w0ssC0k0Q0D0CC3UAM7C3s73UQ761nUrXks7XVssQQzsC0zkDw3z3s103k0y0T8"
;      Global 8644_Desert_Button_Graphic := "|<8644_Desert_Button>*147$64.zk000000003zk00000000A7U00000000k70000000030Q0s0C03U0w0sDs3y0zUzk3VvkQw7D3z0C63XUssQCA0ss6C3b0skk3X0Ms0Q3X30CDzVw1zyAA0szy3y7zskk3X001wQ0330QA000tk0AA1ks0A3b00kkC3UMsCC133zk7XXlkwQADy0Dw7y1zUkz00D07k1w22"
;      Global 8645_Other_Button_Graphic := "|<8645_Other_Button>*147$60.7w00Q00000Ty0kQ00000w70kQ00000s3UkQ00000k3VsQs0C03k1byTy0zUzk1nwTz1vkzU1kkS73UksU1kkQ330ssU1kkQ370skU1kkQ37zskk1kkQ37zskk1kkQ3700kk1UkQ3700ks3UkQ3700ks70kQ33UEkTT0sQ31lskDy0yQ30zkkU"
;    Global 865_LEWZ_Button_Graphic := "|<865_LEWZ_Button>*149$67.k000001k0Tzs000000s0C0A000000Q070600C07UC03U300TkDwTk1k1U0QwDDDs0s0k0Q673Vk0Q0M0A3XUks0Dzg001lk0Q07zq00TsT0C03U300zw7w701k1U0sC0T3U0s0k0M703Vk0Q0M0A3X0ss0C0A073lUMQ0707znrswQD03zzzszwDw3k1zz"
;    Global 866_System_Button_Graphic := "|<866_System_Button>*148$59.Ts00000001zs00003003Us000060060s0000A00A1m0kC0s0sM0C1lz7y7ws0Q77j7sSxs0MCQ731kRz0sMsC63UszVlkk0A60kDVnVw0MDzU73a1z0kTz073A0T1Uk10C6s0731U20QDUkC63U60sD1kQA70z7US1lkQ7bjy0s3zUy7y7k0k1w0w3l"
;  Global 87_Alliance_Button_Graphic := "|<87_Alliance_Button>*134$70.zzXbjzzzzzzznyCQTzzzzzzy7stvzzzzzzzsTXbzzzzzzzzYyCTzXznz7zAHstls7U7k7knDXb76C6CASDASCQQwswtwlttstlznbn7nDbXXb7kCTAzw00CCQQ0twnzk00stlnnbn7zDDlXb6TCTATwwzaCQMwtwtwlryMtll1bnX7XTsXb706D70T2"
    Global 870_AllianceMenu_Title_Graphic := "|<870_AllianceMenu_Title>*50$30.zVzswzUzswz0zswz0Tssz0Tksy4Tksy4DkswADkswC7kswC7kssS7kssT3kssT3ksk03ksk01ksU01ksVzUksXzkks3zkks3zsEs3zsEsU"
    Global 874_Help_Button_Graphic := "|<874_Help_Button>**40$35.07zy7nny1zyTzU0Tnks443i73401sQUA03UvMM03VYvkE3WNzs03ITks03Xz0Q13zwAS07zE0DU3g007u20087k000Rns000S0wk"
      Global 8740_Help_Title_Graphic := "|<8740_Help_Title>*50$41.3zkzzzk7zVzzzUDz3zzz0Ty7zzy0zwDy7w1zsTk3s3zky03k7zVw07U003ky700071wC000C7wQ000Q00s3zks00k7zVk01UDz3Vzz0Ty73zy0zwC3zw1zsS7ss3zkw01k7zVw03UDz3w0D4"
      Global 8741_Build_Button_Graphic := "|<8741_Build_Button>*58$33.07zz600Tzsk03zzC1wDzzkDV7X61wMwMk037X600swMk037X60w8wMk7V3X60w8A8kU"
      Global 8742_BuildIcon_Button_Graphic := "|<8742_BuildIcon_Button>*50$17.y1sTz00S01zU23U830k200040MDzkzzk"
      Global 8743_BuildBuild_Button_Graphic := "|<8743_BuildBuild_Button>*45$10.0001s7US1s000007UT1w70E0002"
      Global 8744_BuildGray_Button_Graphic := "|<8744_BuildGray_Button>0xFFFFFF@0.21$13.zzzzzzz0TU7k3s1w0y3zzzzzzzzzw0y0T0DUTkDs7zzzzzzy"
      Global 8745_BuildBlue_Button_Graphic := "|<8745_BuildBlue_Button>0xFFFFFF@0.21$12.zzzzlzk7k7k3k7k7kTzzzzzzkDk3k3k3k3k3k7kzzzzzU"
      Global 8746_FactoryWorld_Button_Graphic := "|<8746_FactoryWorld_Button>*50$15.01s0D01s07008000000000000s07s0Dk0TUky4"
      Global 8747_FactoryWorld_Button_Graphic := "|<8747_FactoryWorld_Button>*48$13.U3k1s0A020100c0T01s6T3Vz"
      Global 8751_Wages_Button_Graphic := "|<8751_Wages_Button>*26$33.0D07U80k0s0260620k1kksU0D60001sk000D600s1slz60D67UUEUkM0206000M0s00XU7UA"
      Global 8752_Wages_Button_Graphic := "|<8752_Wages_Button>*26$32.0306000U0U08880MD27033kU000y8000DW0103kU000w8Q0Q0200000U0U00A0M0U"
;      Global 8750_Wages_Title_Graphic := "|<8750_Wages_Title>*50$45.kDkzzzzy1y7zzzzk7Uzzzzw0wDkDz3U7Vs0TU40sC01s0V31k0C00MMS7Vkw333ly47kQ8TQ0Vz7V7w0ADsw0y01Vz7U7U2ADsy0w7lVzDkDVw47ly1wDUkQDkDU0201z1w00M0TsTk03U4"
;    Global 877_Technology_Button_Graphic := "|<877_Technology_Button>*50$31.07zzzU7zzzlzzzsMzs7k0Ts1k0Ds0MM7wS8S3wT4TVy00Dsz007wTU0XwDlyEw7sSAQ3y6601z07U4"
;      Global 8770_Technology_Title_Graphic := "|<8770_Technology_Title>*50$39.01zzzzs0Tzzzz3zzzzzsTzXzy73zk3y08Ts0DU03z01w00Tky73s3w7ksTUTVy77w3w00kzsTU027z3w00EzsTVzy7z3wDzkzkTUzz3w3y7tsT0Tk07003z01w04"
;      Global 8771_Tech_Rank_Button_Graphic := "|<8771_Tech_Rank_Button>0xD5A261@0.92$11.Tx060A0M0k1U3zu0A0M0k1U3060A"
;      Global 8772_TechLocked_Title_Graphic := "|<8772_TechLocked_Title>*55$69.Dzzzzzszzzztzzzzzz7zzzzDzzzzzszzzztzzzzwz7zzzzDzw7y0syTlztzz0DU37Xs3wDzlkswMsyCD1zwTaDn6DXstDzbwFzsXwza9zwzWDz0z7wnDz7wFzs3s06NzszWDz2D00nDz7wFyMlszyNzwzaDn777wlDzXwswMwQT680AD7U77XVls00k1y1syC0DY"
;      Global 8773_TechOK_Button_Graphic := "|<8773_TechOK_Button>*133$31.y1znzw0Dszw01wTwDkSDwDyD7yDzXXwDzllw7zsswHzyAQPzz6ARzzX0SzzlUDDzlk3bzssFnzwQQMzwCC4DwD7X3wDXsU0DlwQ0Dtz8"
;      Global 8774_MaxClear_Button_Graphic := "|<8774_MaxClear_Button>*130$51.s3szzzzzw0D7zzzzz7sszzzzztzX7zzzzzDyMy3w3t3zz70D0D0Tzststssvzz6DbTbDTzsnwTstvzz603k7DTyMk0M0ttzn6TyDbDDwMnynwtsz76DaT7DU1ssklUty0T7UD0XDwDzy7wSTw"
;      Global 8775_MaxCD_Title_Graphic := "|<8775_MaxCD_Title>0xFC0000@0.67$41.003k0A000Ds0s000tk3k003VkDU0061UT3U0A31a700M76A601kCQM003UQkk0070v3U0061rzk00A3DzU00M60A000sQ0MA00zk0ks00z01Us"
;      Global 8776_TechBuy_Title_Graphic := "|<8776_TechBuy_Title>*83$35.07zzzy03zzzwz7zzztz7zzznySTAz7wwy9wDVtwFs07nsnk07blb1z7DX6HzCT7AbyQyCFDwtwQ6TllkwA07U1ss0zUrtzzzzzXzzzzzDzzzzsT"
    Global 878_Boss_Button_Graphic := "|<878_Boss_Button>*45$21.00033XUTwTll16600UE083830C0k0X44"
;      Global 8780_Boss_Title_Graphic := "|<8780_Boss_Title>*130$63.U7zzzzzzzzs07zzzzzzzz00TzzzzzzzsTVzzzzzzzz3yDzzzzzzzsTkzzzzzzzz3z7w3zk7z0sTky07w0TU13yDksT3VsQ8T3wTXsyD7s00z3yCDtsz003szlszz7z3wD7zD1zsDsTkszsw1zUD3z77z7s3zU8TssztzsDzU3z77yDzkzz0TssTllz7Ds3y7XwCDssz0T1wD3syD3k00Tk0z01w080DzUDy0zk3U"
;    Global 901_Menu_Expand_Button_Graphic := "|<901_Menu_Expand_Button>*200$36.Dzzzzs1zzzzU0Tzzy0U7zzs1k0zzUDw0Ty0Tz07s0zzk003zzs007zzw00Tzzz00zzzzk3zzzzs7zzzzyTzzU"
;    Global 902_Menu_Collapse_Button_Graphic := "|<902_Menu_Collapse_Button>*200$36.zzwTzzzzs7zzzzU1zzzz00zzzw00Dzzk007zzU1U1zy0Ds0zw0Ty0Dk3zzU30Dzzw10zzzy03zzzzkDzzzzwU"
;  Global 91_ActivityCtr_Button_Graphic := "|<91_ActivityCtr_Button>0xFCFCF4@0.29$23.0000000000001w00Ty00zz07zzkTznozz3vzz6rzz7jzzTzzwzzXw3z7w7yzs7zzkDvzs7vz17rk/zy67wFk8"
    Global 910_ActivityCtr_Title_Graphic := "|<910_ActivityCtr_Title>*200$63.y7zzzzTtzzzkzzzzlzzzzy3zzzyDzzzzaTzzzlzzzzwnzy3s3tnzbbDz0C0DCDtstzlsyDttzDD7wTXlzDDtlwzbySDtsySTXwzzlzDbnnwT7zyDtwyQTntzzlzDnbU0TDzyDtyQw01szzlzDnb7zDbzyDtz9tzswznlzDtDDzbXwSDtz1vzwyTblzDwTTzXs1z1tzXw"
    Global 917_DesertWonder_Button_Graphic := "|<917_DesertWonder_Button>#537@0.27$46.vy7s00037kD0000AD0s0000ky3U00031sA1s00C7VkTsxwsy73zrzvnwsSDzrjDvVkSyCxri71vkzrTkQ3j3rtz1kCwDTXw70vkxyDUS3j3nky1sCwDD1s7lnkwQ70DzD3s"
      Global 9170_DesertWonder_Title_Graphic := "|<9170_DesertWonder_Title>*200$68.TsznzzzzzzzryDwzzzzzzzxz1yDzzzzzzzTkTXzzzzzzznwbtzUztUzy4z9yTk3wE7y0DbDblwT1sz7ntnlwTXkzDnwSQwyDwwTlszbj7DbzD7wSDtntntztlz7byAyMyTyQTltzXDaTbzb7wSTwbxbtztlz7bz1z1yTwQTltzkTkTXzD7wSDwDwDwzXlz7nzXzXz7lwTlwTszszs0z7wTU8"
    Global 91A_GoldenChest_Button_Graphic := "|<91A_GoldenChest_Button>*50$32.03ks0E0QA04073313VklsFwQAS4T737V7lklsFwQAS4T737V7lklsEsQAA40730003UE08"
      Global 91A0_GoldenChest_Title_Graphic := "|<91A0_GoldenChest_Title>*50$38.01zzzw1sDzzz1z1zzzkTsTwDwDy7w0z3zny07kzzz00wDzzVw73zzsTVky0QDsQD073z33k1kzkkzsQDwADz73z33zlkzVkTwS7sQ3y7Vw7001s03k00z01w00Ts0z2"
      Global 91A1_Free_title_Graphic := "|<91A1_Free_title>*52$19.34A3kD0000000Tly78T040E"
;  Global 92_Benefits_Button_Graphic := "|<92_Benefits_Button>*200$59.zzzzzzsTzytzzzzzjzzxtzzzzzTxzvvzzzzyznzrrVs7ksvXkCSxrjSvrjS0xvjQxrjSywnrStvjSyRxXyxnzSxz/vDxvjyxvzbrTvrjxvrjDCRrjzzrjC1z7jzzzz73"
    Global 920_Benefits_Title_Graphic := "|<920_Benefits_Title>*200$63.DwTzzzzzzztznzzzzzzzzDyTzzzzzzztzlzUzrVzw7DyTk3yE7z09znwTDkwTnt7szbsyDnwzU0DtzbnyD7w00zDwyTlszVzXtzXnyD7wDyD00STls01zts07nyD00DzDDzyTltztzttzznyDDzDzDDzyTlsztzlszznyDby7wTXwyTlwTU07y0DnyDk1U"
    Global 921_BattleHonor_Button_Graphic := "|<921_BattleHonor_Button>*200$42.zzzVzzzzzzVzzzzzz0zzzzzz0zzzzzz0zzzzzy0zzzzzw0zzzzzs0zzzzzk0Tzzzzk0Tzzzzk0TzzzzU0Tzzzs00Tzzz000TkT0000TU00000T070000y0Tk000w03y000s0DU"
      Global 9221_Claim_Button_Graphic := "|<9221_Claim_Button>*42$15.031sMTX3wMTz3zsTz3zsTz3wMTV1wM034"
      Global 9222_Claim_Button_Graphic := "|<9222_Claim_Button>*55$30.0sk000Mk00QMksAwMksQ0MUMQ08U8QU"
    Global 923_DailySignin_Button_Graphic := "|<923_DailySignin_Button>*200$36.00s07100M07300M07300M07LDwMD7LTwszbTTwtzaTTsvzbTTwvzjTTyvzzTDzzzzyQDzzzwTzvzztTznzrlTsk7bn01k0Dr01k0Dr01k0Dz01k0TzU"
    Global 924_MonthlyPackage_Button_Graphic := "|<924_MonthlyPackage_Button>**45$13.U000UM8z0Rk7wVzMDz3zsTy6nlAQXDVa4"
    Global 925_MonthlySignin_Button_Graphic := "|<925_MonthlySignin_Button>*200$20.zzzjzzvzzwzzzDzzXzzszzwTzz7zzVzzsTzy7zzVzzkkzsA003k00zy0S"
    Global 926_SelectReward_Button_Graphic := "|<926_SelectReward_Button>0xDDC35E@0.40$54.1zzzU01zz0zzs0003z3zy00000T7zs000003DzU1U0001zy07zk000zs0zzzk00zk3zzzz00z07zzzzy0w0zzzzzzws3zzzzzzzkDzzzzzzzUzzzzzzzz3zzzzzzzzDzzzzzzzzU"
      Global 9271_SelectionChest_Button_Graphic := "|<9271_SelectionChest_Button>*40$24.0A00U000U000U000U9U0U9U0U103U0040A080A0M3s0Mbk0kbk10zU3wU"
      Global 9272_SelectionChest_Button_Graphic := "|<9272_SelectionChest_Button>*170$35.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzUTsDzw0zUTzs1zUzznVz1zzb3y3zzCDw7zyQTsTzwxznzzxzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzs"
    Global 928_SingleCumulation_Button_Graphic := "|<928_SingleCumulation_Button>0xEFF3F5@0.40$59.000001s000000001w00000C0k1w000003tk1s000007s03s000007w07s00000Ts0Ty00004zs3Tzk300/z0Dzzk6007zADzzsBUM7ywDzzwGDn3zwTvzysTjzzzzrzxzvzzzzzrTtzrzzzzzwznzDzzjzzszbyDzzjzzvyDyDzzDzzzczwDzzTzzzlzxzzyzzzyBzzzzzzzzsvzzzzzzzzrs"
    Global 929_WarriorTrial_Button_Graphic := "|<929_WarriorTrial_Button>*50$21.zszzy3zzkDzy0zzU3zs07z00Dk00w007U00U"
;      Global 929A_Steel250k_Title_Graphic := "|<929A_Steel250k_Title>*200$19.zxzzwzzwzzyzzw1twUNwk1w01w01w01w01z01zw0zzUzzwzw"
;      Global 929B_Alloy62k_Title_Graphic := "|<929B_Alloy62k_Title>*200$41.szzzzztnzzzzznDzzzzzqTzzzzzdzzzzzzHzzyzzybzzrzzwTzyTzzszzxzzzlzzzzzzXzzzzzz7zzzzzxDzzzxzuTzzzjzozzzxzz9zzzrzyzzzzzzxzzzzzznzzzzzzjzzzzzzzzzzzzxzzzzzzvs"
;      Global 929C_Food1_5M_Title_Graphic := "|<929C_Food1_5M_Title>*200$41.wTzzzzltzzzzznbzzzzzbDzzzzzCzzrzyzNzzjzzynzzsyzxDzzkTzuTzzkzzozzzVzzfzzz3zz7zzy7zyDz7wDztTUTwTzmy0Tszzhs03vzzPk01rzyrk07zzvjw1tzzrzyDzzzjzzTzzyzzzzzzxs"
;      Global 929D_Fuel1_5M_Title_Graphic := "|<929D_Fuel1_5M_Title>*200$41.wTzzzznlzzzzzbXzzzzziDzzzzzAzzzzzyNzzxzzybzznzzxDzzbzzuTzzzzzkzzzzzzXzzzzzz7zzzzzyTzzzzzyzzzzzzpzzzzzzfzzzzzzLzzzzzyjzzzzzvzzzzzzrzzzzzzjzzzzzyzzzzzzxzzzzzzrzzzzzzTzzzzzyz"
;    Global 934_CSB_Button_Graphic := "|<934_CSB_Button>*109$44.sTzzzzzw1zzzzzySTzzzzzDnvvzDtnzks70s4zwwtnaQDzCTAzbnznbn3sQzwtwwDVDnCTDly9tnnmSPm0QwFk68kDTUy3kM"
;    Global 936_DesertOasis_Button_Graphic := "|<936_DesertOasis_Button>*200$48.1zzzzzzzCTzzzzzzTDzzzzztTjryzrztTjBvDBltTaSniSntTaynyyrvTa0sy0rvTizzCzrvTizzazrvTCTraTrtAzBvjBrxXzXwTXzyU"
;    Global 938_EliteDual_Button_Graphic := "|<938_EliteDual_Button>*117$41.sTzzzzz0SzzvzySQzzbzwwlyz7vtz1kA71lzbCQQtkTDyttvsST1nk3yQw3bUBwtnrDDntnbCSTlXb4SQNkD70wQ7"
;    Global 93F_WarZArena_Button_Graphic := "|<93F_WarZArena_Button>0xFBC8CA@0.32$32.Tvyvv7yzyylzjTjgTznvv3zwSzkzz7jsDzlzy3zwTzUzz7zsDztzy3zyzzUzzjzs7zvzy1zyzz0Tzjzk7zvzw1zyzz0Tzjzk7zvzw0zzzz0Dzzzk3zzzs0zzzy0DzzzU3zzzs8"
      Global B224_CityBuffs_Button_Graphic := "|<B224_CityBuffs_Button>*50$16.0010sa3aEAN0tY3aMCNUta3U002"
        Global B2240_CityBuffs_Title_Graphic := "|<B2240_CityBuffs_Title>*40$28.00Tzwz1zzny7byDsQDkzVkz3w73w00wDk07kz00D3w00QDkzUkz3y23wDwADkzkkz3y33wDkA7U01k000DU0U"
        Global B2241_Shield_Button_Graphic := "|<B2241_Shield_Button>*30$29.03lzk03XzUQ77z1w60C3wA0A3ws0M0Dk0E07VkU077V7k6D27sAS4DsMw8DklsED1XkU037V00CD28"
          Global B22410_Shield_Title_Graphic := "|<B22410_Shield_Title>*38$34.01sTzUQ3Vzy7wC7zzTkMETlzVU0S7yC01s3zs03U3zUw601y7kM03sT1X07Vw6DUC7kMbUMT1Wz1Uw67y67kMTkMT1Vz0Vw600C7kM01sT1W"
;          Global B22411_Shield_Ends_Title_Graphic := "|<B22411_Shield_Ends_Title>0xF5F5F5@0.21$40.zw003U3zk00C0A09s0sMk1zlzbv07zDyzzySCtvXztkz3iD073wCzg0QDktzk1kz3Vz073wCkzzQCxvbzxkvzjy"
          Global B22412_GetUse_Button_Graphic := "|<B22412_GetUse_Button>*47$29.01zzs61zzkz3wD3y7U4DyC00TzwAAw0kwNs0U0Hk100bz2017w002Ds0S470E0000U0001U04"
          Global B22413_Replace_OK_Button_Graphic := "|<B22413_Replace_OK_Button>*62$25.U3lw00sw0wQQ8y6AAz346TlW7Dsk7bwM3nyA0tz64Az366DVXV3lls00sw80AQ4"
;    Global B34_CommandCtr_Button_Graphic := "|<B34_CommandCtr_Button>*100$69.zrzjTzzzzw5DzrzXzzzzz0QSnNkzzzzzU3rxskTzzzzk02ywMDzzzzs827mQ3zzzU63k0za/zyzw00607z9zzfzs0000zwzzujzk0007znzzqzzXk00zy0zzvzzzU07zc2jzzzzw00zzU0zxzzz007zw03zrzzs00zzk0DzTzzU07zx00zzzzw00zz403zzzzU27zwk0Dzzzw0Ezzz01zzzzU07zzs07zzzw00zzzU0TzzzU07zzy03zzzw0Czzzs0DzzzU6I"
;        ; B3420_ActiveSkill_Title
        Global B3430_Recruit_Title_Graphic := "|<B3430_Recruit_Title>*118$57.01zzzzzzzs03zzzzzzz7sDzzzzzzszVzzzzzzz7yDzzzzzzszkzUzy3yM7z7k1z07k0zlw07kES07yD3syDVkszVsz3XyCD00T7wQTlls07kzXXzyD01y00QzzlsyDk037zyD7sy7zwzzlsz7lzzXzyD7wT7zwTtlszVszzXyCD7yD3wSDXlszkw07k0SD7z7k1z07ltzszUzy3yTU"
        Global B3440_Craft_Title_Graphic := "|<B3440_Craft_Title>*133$54.U0Tzzzzzt00Dzzzzzs00Dzzzzzs7zzzzzzzz7zzzzzzzz7zzzzzzzz7zzUNwzXs7zz01szXs7zy7VszXs7zyDlszXs00wDtszXs00wTtszXs7zwTtszXs7zwTtszXs7zwTtszXs7zwTtszXs7zwTtwzXs7zwTtwzXs7zyDlwTXs7zy7VwC3s00D01y03s00DU1z0XsU"
        Global B3450_Collision_Title_Graphic := "|<B3450_Collision_Title>*130$47.z0zzzzXls0Tzzz7XU0TzzyD67sTzzwSATszzzswFzlzzzlsXzly0zXl7zzs0z7UTzzVkyD0zzy7swS1zzwTlsw3zzszlls7zzXzXXkDzz7z77UDzyDyCD4TyATwQS8zwQTsswEzlszXlslzXlz7XlUwDksT7XU0Tk0yD7k3zk7wS8"
        Global B3460_RuneExtract_Title_Graphic := "|<B3460_RuneExtract_Title>*129$65.U7zzzzzzzzy01zzzzzzzzw01zzzzzzzzszVzzzzzzzzlzVzzzzzzzzXzXzzzzzzzz7z77wTA3zkCDyCDsw03y0ATwQTls63sQ8zkszXkz7lw1z3lz7VyD7w00DXyD7wSDs00z7wSDswDU03yDswTls00TXwTlszXk00z7szXlz7Xzlz7lz7XyD7zXy7XyD7wSDz7yDXwSDsyDuDwD3UwTlwD0TwS01szXw08zsS0Xlz7w0s"
      Global B350_Depot_Title_Graphic := "|<B350_Depot_Title>*40$26.001zk00Tw007z003zzkzzzwDwEz3y0DkzU3wDs0z3y1zkzUzwDsTz3y7zkzVzwDsTz3y7zkzVzwDsTy3y7zUzVzsDsTz3y7s"
      Global B351_Free_Button_Graphic := "|<B351_Free_Button>*38$15.01s0D01s7z0z0zk7y00E0200k7y0zk7y0zk7y0zkU"
      Global B352_Help_Button_Graphic := "|<B352_Help_Button>*58$30.7wTzs7wTzs7wTzs7wT1s7wS0M7wQ8M00MQM00MQ800M087wM007wM007wM007wM00U"
      Global B353_Request_Button_Graphic := "|<B353_Request_Button>*38$15.07s0T01sw77ksz67kU0A0300M770sM7X0wA7kUz6U"
      Global B354_Reward_Button_Graphic := "|<B354_Reward_Button>*38$15.03s0D7Usy77kky401U0M030ss730w87VUy47k4"
      Global B361_Click_Button_Graphic := "|<B361_Click_Button>*36$22.23k08A00lk03620AMw0l3s34DwAEy0l003400AM00k003200AE08"
      Global BD01_Desert_building_Title_Graphic := "|<BD01_Desert_building_Title>*60$49.07s0TU1s11s87UEQ3swD3kwC3wCDlkz31y73zszVU03UDw00k01s0w00M00y0C00A7zzw3Xzy3zzzVlzz1zy7sMTzUTb3wQDtk21k0D00s01s0Dk0Q8"
        Global WD111_Steal_Button_Graphic := "|<WD111_Steal_Button>*60$26.1kDk0M1k0A0A077X71lszkQ0C0603000002"
;    Global WNC_Coord_Button_Graphic := "|<WNC_Coord_Button>#458@0.67$27.7zzz1zzzyTzzznzsDzTw0Tzz01zzk0Dzy00zzU07zw00zzU07zw00zzU07zw01zzk0Dvy03zTs1zvzszzDzzzszzzy3zzzUTzzwU"
;      Global WNC0_Coord_Title_Graphic := "|<WNC0_Coord_Title>*50$64.zzzzzzzzzz3zzzzzzzzzwDzzzzzzzzzkUDyDzVzATz00TUDw1s0w400s0T03U3007300s060A00w4D1VsM7Uk3s0y4DkUw7UTy7s0z27kz1zsTk7w8T3w7zVz0TkVwDkTq7w1z27kz1y0TU7w8T3w3kVy4DkVwDk623sEy67kS00A03U0MTU001s0C03Vy00UTU1w0T7w03zzUTw3zzw6M"
;      Global WNC1_GoTo_Button_Graphic := "|<WNC1_GoTo_Button>*141$52.w7zzzzzzzU7zzzzzzwSDzzzbzzXwzzzyTzyTlzzztzzlzzUDy0w37zy8Ts7U4TznsztwS3zyDnzbnwDUMzDySDkS1bwztsz1z6TnzbXw7wNzDySDmTlXwztwz8z7DXzbnsksQQTyD37U3s3zsC0T0zkTzly7U"
















