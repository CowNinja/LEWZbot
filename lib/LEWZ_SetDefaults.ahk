
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
	/*
	Default Window search:
	[options.x1:=0] (number), [options.y1:=0] (number) ; the search scope's upper left corner coordinates
	[options.x2:=A_ScreenWidth] (number), [options.y2:=A_ScreenHeight] (number) ; the search scope's lower right corner coordinates
	[options.err1:=1] (number), [options.err0:=0] (number) ; Fault tolerance of graphic and background (0.1=10%)
	[options.screenshot:=1] (boolean) ; Wether or not to capture a new screenshot or not. If the value is 0, the last captured screenshot will be used
	[options.findall:=1] (boolean) ; Wether or not to find all instances or just one.
	[options.joinqueries:=1] (boolean) ; Join all GraphicsSearch queries for combination lookup.
	[options.offsetx:=1] (number), [options.offsety:=0] (number) ; Set the Max offset for combination lookup
	*/
	Global optionsObjALL := {   x1: 1
                , y1: 32
                , x2: 689
                , y2: 1216
                , err1: 0
                , err0: 0
                , screenshot: 1
                , findall: 1 }
	Global optionsObjONE := {   x1: 1
                , y1: 32
                , x2: 689
                , y2: 1216
                , err1: 0
                , err0: 0
                , screenshot: 1
                , findall: 0 }

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

; Load  graphic variables
; Title/Tag (Manual), Renamed query (auto)
0_Icon_LEWZ_Graphic := "|<0_Icon_LEWZ>*200$48.Dzzzzzz0DzzzzbzDDzzzzbzDDzjyzbzDDy1sC3zDDwtnbbzDDxtnrjz0Dzxnzjz0Dz1szjzDDw9wDjzDDwxz7jzDDxxzbjzDDxtnrbzD0AFlbbz00C5sDXz0U"

1_Quit_OK_Button_Graphic := "|<1_Quit_OK_Button>*139$27.yDzzz0T7tlVsyQT77Xbwsswzb6D7wMXtzn0zDyM3tzn0T7wMlwzb77bwswQT77nlVsyD0T7syDzzw"
1_Quit_Title_Graphic := "|<1_Quit_Title>*112$44.z7zzzvzy0TzzwTz03zzz7bVwTzzztszXzzzyQTswzbC07zDDll01zlnwQSATwQz77b7z7DlltlzlnwQSQTwQz77b7z7DlltlznnwQSSTswz77bXyT7lltwS7lsQSDU3y077Uw0zkFlwDz3zzzzzzszzzzzzzDzzzzs"

  10_Commander_Title_Graphic := "|<10_Commander_Title>*150$67.s0zzzzzzzzzs0DzzzzzzzzszXzzzzzzzzszkzzzzzzzzwTwTzzzzzzzyTyDs7yMDUzaDzzk0y0107k7zzkwD1s73s3zzsz7Vy7swNzzszllz7wSAzzwTsszXyD6TzyDwQTlz7XDzz7zCDszXlbzzXzb7wTlsnztlznXyDswMzsszllz7wSATwQTsszXyD67wT7swTlz7XVwDVsSDszXls0Ds0T7wTlss"
  1A_Settings_Button_Graphic := "|<1A_Settings_Button>*100$66.07zzttxzzzzDnzzttzzzzzTvzzttzzzzzTvzzUkzz3zzTzw3kkxsFw0Dzttttxtwts0znwttxvwvws7rwttxvwnyzXnwttxvwnyztk0ttxvwnyztrzttxnwnyztrzttxnwnwTtnxttxnwvwDntttwxnwtsU7w3wwRvww6U"
    1A0_Settings_Title_Graphic := "|<1A0_Settings_Title>*150$69.s0zzzzzzz7zw03zzzlz7szzXwDzzyDszzzszlzzzlz7zzz7z7zzyDszzzszszUy080wwM7zzk1k1077U4TzwCDlz7sw7Uzz7syDsz7Vy0zszblz7swTw0yDwSDsz7Xzw3kz3lz7swTzsC00SDsz7Xzzkk03lz7swTzz6DzyDsz7Xtzslzzlz7swTDz77zyDsz7Xszkszblz7swTVwDXsyDsT7Xy03y07sDUswTU"
    1A1_Account_Button_Graphic := "|<1A1_Account_Button>*200$40.w000007U00000A00000000000000000000000000000000000000000000000000000000000000000000Dzz0003zzzw00zzzzs07zzzzk0TDzzzU3wTzsy0Tlzzbw1z7znzk7U7zDDU"
      1A10_Account_Title_Graphic := "|<1A10_Account_Title>*150$68.zUzzzzzzzzzzsDzzzzzzzzzw3zzzzzzzzzz0Tzzzzzzzzzn7zw3zkDzzzsszy0Ds0zkDyCDy13w47s0z7XzXwSDlwC7lwTlz77ySDswT7wTtlzb7yCDly7zwTzlznXwDXzy7zwTwk03szzVzz7zA00yDzszznzn007Xzy7zwTwXzlsTtlzb7z8zwT7wQTtlzmDzXlz73wQTs7zsy7XsS7Xy1zy7k0z03sT4zzly0zs3z03U"
      1A12_Switch_Button_Graphic := "|<1A12_Switch_Button>*180$67.k7zzzyTzzznk1zzzzDjzztlwTzzzzbzzwtz7zzzzlzzyQznzzzzszszCTzbtwQk7k7U7zlsySSDllklzwwDDD7lwsw3yS7bbXtzQzUTCHbnlwzyTy7nBntsyTzDzntaNwwTDzbzwwrBySDbznjyT3ozD7nztnzDVsTbXtzQtzDlwDnlwTCS07szDtwD2DD"
        1A120_Switch_Title_Graphic := "|<1A120_Switch_Title>*180$68.k0TzzzzXzzzsz3zzzztwTzwTsTzzzzz7zzDz7zzzzzlzznztzzzzzwTz4zySTlzTw1y0DzzbwTbX0T3Vzzsy7tswTXw7zzDUySD7szU7zntDbXlyTy07wyHnswT7zy0zbAwyD7lzzy7tnbDXlwTzzsyQtrswT7zzyDrCNyD7lzTzXwraTXlwTrzsz9wbswTbwzyDkT3yD7szDzby7kzXlz7kzVzXwDsy7s200zszbyDVz0U"
        1A123_WarZ_Button_Graphic := "|<1A123_WarZ_Button>*180$63.TkzXzzzzk03y7wzzzzzzsDkTbzzzzzy9ynwzzzzTzXDaT7s3wVzstwntyADUTyDDbDDbswTznwtttwzbbzwTbDDDzwwzz7wtxnzz7bzlzbDaTs0wzwTyHwnw7bbzbzmTaTbwwzszy3y7szbbyDzkTkzDswzXzz7y7sy7bsTzszszX0wz004"
          1A1230_WarZ_Accounts_Title_Graphic := "|<1A1230_WarZ_Accounts_Title>*180$68.Tszlzzzzzy03y7wTzzzzzzwzVzDzzzzzzzDkTnzzzzzzznwXszUTn7zzwTAyDU3w1zzz7XDbkwT1zzzVsntwTblzzzmSSQTzswTzzwbbb7zyDDzzy8ttnzz3nzzz7AyQzk0wzzznnDnDsyDDzzswnwXwTXnzzwT1z1yDswzzyDkTkTXyDDzzXy7y7szXnzzlzVzVz7UwzzsTszsTk0DDzy08"
          1A1232_OtherAccount_Button_Graphic := "|<1A1232_OtherAccount_Button>*180$63.UTyzzzzzDzttvrzzzzszzTiSzzzzzLzvwUkD1kTmT1TbSQnaTyvnXyvrawnzrSyTbSwk6Twtrvwvra0nzUCzTbSwryTs0rtxvraznzDaSaDSwnaTvyva7srb1nyTnVU"
          1A1234_Email_Box_Button_Graphic := "|<1A1234_Email_Box_Button>*122$70.000002A000A0000000k000k000000300030D7xsT2A0y3wBaMsn6Ak6AMlg9V30Mn00lXAka4A1XA034AnyMElyAk3wEnA1V3AMn0Ml3Ak64AlXA1X6AFaMEnCAk6QMlXlV37sn0Dkz3U"
          1A1235_PW_Box_Button_Graphic := "|<1A1235_PW_Box_Button>*126$70.70s7UwEV3kgTyDkz7tX6TXnw8lW4FaQH2AAkk6A1U9HAAUX37sw7UZgUm6AAlUQ3XGW38Mkm60E6DCAAUX2ANVA8MskW3DszXwTVVVy87m0U30M001U0D00000000000A00000000000k00000000002"
          1A1237_UseEmailLog_Button_Graphic := "|<1A1237_UseEmailLog_Button>*135$68.TlzzzzzzzzzrwTzzzzzzzzxz7UTUTtwy3wTlk3k7yTD0T7wQwswzXnXXlz7DiTDwslwQTllzblzCQz77wQ3k0TtbDtlz7kA0DyNnyQTlzX7zzUwzb3wtwNzzsD7lkyCD6Djz3tww07k3k3zly0D83y1y1zwTk7vzzzzzzzbzzzzzzzzzznzzzzzzzzzzszzzy"
            1A12371_OK_Button_Graphic := "|<1A12371_OK_Button>*138$26.k7lyM0wT4T77XDtllnyQMwzX4TDwkDnzA3wzn0TDslXnyAQQzb7b7llssswT70T7sU"
            ; 1A12372_Yes_Button
              1A123730_EnterPIN_Title_Graphic := "|<1A123730_EnterPIN_Title>*134$61.00zU7y0Ds0UsDU0y03s00z7VsS7VsS0zVVyD7sQTUTstz7XySDsDwTzXkzz3zDyDz1s3zUDbz7k0y0Ds0nzXU0Tk1z01zlUyDz0Tw0Tslz7zwDzkDsEzXnz7Dw3wMTlszX3y0sSDkwTllz00D10C3VsC1UTk13U0y00zzw3lw1zk6TzzzzzzzzzDzzzzzzzzzk"
              1A123731_ForgotLoginPW_Button_Graphic := "|<1A123731_ForgotLoginPW_Button>*137$68.03zzzzzzzzyLzzzzzzzzzzVzzzzzzzzzzsTzsDt7kny3s7zw0y1k0y0S1zyC7VwQD3XsTz7lsyDXlwSE1lyCTbwsz7Y0QzXbtzCDttTzDstyTnXyS7znyCTbwszbVzwzXbtzCDtsTz7styTnXwS7zlwSTXswT7VzyC7bwQD3XsTzk3tz03s1y7zy3yTw8zUznzzzzzzyDzzzzzzzzzzXzzzzzzzzznlzzzzzzzzzw0TzzzU"
              1A123732_StartNewGame_Button_Graphic := "|<1A123732_StartNewGame_Button>*57$70.D7lzzzzwTzzxyD7zzzzlzzzrwQTzzzz7zzzTl0TVy8k7zsRzw1s1s30Ty0HzwT7XUD7zlk1zlszC7wTyDW0z7zwszlzzzA1wTznXz7zzsw3lz0CDwTzk3y77lwszlzwTDwQS7nXz7zXwzllszCDwTyDnz77Xwszlzsz7wwSDXXz7zXsDXtwQCDwTz700zls0MzsTy08"

  21_Fuel_Button_Graphic := "|<21_Fuel_Button>*97$29.Tzzzy7zzzy3zzzzlw03znk03zl0zbznXzDzq7yDzw7yTzsDwTzUDszz0D1xw001vk00HnU007rUQ0Tnk1zzU0TzzUDzzzDzkzzwTjzy0zTzyzizzzzxzU"
  22_Food_Button_Graphic := "|<22_Food_Button>*103$28.zzw7zzy07zzU0Dzw00Ty000zU001k000200000000000000000000000000040000k0007000C4000lE013500AAQ00klk033bU"
  23_Steel_Button_Graphic := "|<23_Steel_Button>*109$31.zzzXzzzz0Dzzz00zzz017zz01bzz00bzz003zz001zz003zz003zz003tz003sz001sz001sT001sT001sD001sD001sD001sDU01wDz01wDzk1wDzz0wDyTswDzU"
  24_Alloy_Button_Graphic := "|<24_Alloy_Button>*81$39.zzzzjzzzzzUjzzzzUzXzzy01wDzy00y1zz00C0DzU0701zw0Q00Dzs7001zzw000Dzzk007zDz003zVzs00zwAz00TUBXs07w1zD03s0zzs1w07zy1y00zzyS001zzs000liz000zcrw00Dzazk03w"

  30_VIP_Title_Graphic := "|<30_VIP_Title>*126$44.Dzlty0DnzwQT00QTyD7k037zXlwTsFzkwT7z2DwT7lzsXz7lwTy8TVwT7zX7sz7lzslyDlwTwAT7wT7y7Xlz7k03swTlw01z6DwT3zzlXz7lzzwMzlwTzzUTwT7zzs7z7lzzy1zlwTzzkzwT7zzwDz7lzzU"
    312_VIPRaffle_Button_Graphic := "|<312_VIPRaffle_Button>*119$65.DtnU0zk0TzkTnbDlzXwTzUT7CTnz7wzz4ySQzbyDtkA8wwtyDwTX6ANltk0zs0CSMnbnU1zk0TwlXDbDzzXwS1XYTCTzz7sk379yQzzyDt7aC3wtzzwTmTASDtnzzszYQMwTnbzzlzA0F"

  ; 40_Troops_Title
  ; 50_ControlDesk_Title
  ; 60_Quest_Title
  ; 70_Speaker_Title

  71_Speaker_Claim_Button_Graphic := "|<71_Speaker_Claim_Button>*148$66.w3yDzzwzzzzk0yDzzszzzzUkSDzzwzzzzXwCDzzzzzzz7yCDzzzzzzz7yCDwDzzsT3DzCDk3ww040DzyDV1ww000DzyD7lwwDVwDzyDDlwwTXwDzyDztwwTXwDzyDw1wwTXwDzyDk1wwTXwDzyDXlwwTXwDzCD7twwTXw7yCDDtwwTXw7yCDDlwwTXwXwSD7lwwTXwU0SD00wwTXws0yDU0wwTXwU"
    821_World_Button_Graphic := "|<821_World_Button>*132$54.Ebtzw0Nz0M3lzs1ty0A3lzk3ts8C3ny0KNk8C0Hs0kM00C03l1kE0k6M1X1nUFs6M000U0nsYNU0001nsYw6000tnsUw7403tnsUw7btntnslyDXlntlslyDlXntsUlyDk7nts0U"
    822_Home_Button_Graphic := "|<822_Home_Button>*136$56.DwzzzzzzznzDzzzzzzwznzzzzzzzDwz7zntzlnzDUT087s4znlXlUkwM00swQwSCT00CTbDbnbkzn7tntws0DwlyQyTA03zATbDbn7wznbtntwtzDwswQyTCTXzD6CDbnVUznk7Xlsw0U"

  83_ActiveSkill_Button_Graphic := "|<83_ActiveSkill_Button>*125$52.yTzzyTzzzkzzwtzzzz3zznzzzzsDwCDzzzzYTUENDbUyNwsnaSQ1nbXnCNtbbDCTwtbCTA0tznbAk0U1bzCQr02TaTAtmQTlyQsnbVtxDsk76SDXYznUwNwz0zzzzzzzzDU"
    830_ActiveSkill_Title_Graphic := "|<830_ActiveSkill_Title>**50$45.T7sa0Nfj074k3BBnyQa0TdgztYk1xBa3AaDjdgkBYnZxBbVwattdgTk4yTBBkzkbbNdjUT4tnBBTUQaQNdczlo3XBBwTaXANdjUQownBBA1abbNdhkAoyPBBbzaaltdiTtonDBBs0QaQtdg"
    831_Blue_Use_Button_Graphic := "|<831_Blue_Use_Button>**50$36.A4k000A4U000A4U000A4Xy3yA4z77bA4w1g1A4dsttA4dgtgA4tznwA4wTFwA4i3k0A4blnzAAzwnzaQvgtbbttwtyk3g1w1s7C3i3U"
    832_Green_Use_Button_Graphic := "|<832_Green_Use_Button>**50$36.A4k000A4k000A4ny1wA4rz7zA4w3i3A4wtwtA4twtwA4tzvAA4cznwA4g7E0A4b1k0AAzsnzYAzQn7bttwtznlsswws3A1g1U"
      8331_Instructor_Title_Graphic := "|<8331_Instructor_Title>**50$69.y00000B00000k00001w00006000008U0000k000014000060z000Mk7jUsnzy7zb7Tzw76H0tkCU+QMUUm03Q0w1E7446EyDDnsu3sUUmCtti/4Ft446H3CAT8WA8UUmMNtzt4F1446H1D1y8WM8UUmM9w1t4H1446H1Bw38WM8UUmM9lyB4H14A6H1DttcWM8VUmM9n3BAH17s6H1CStcuMAS0mM9syB1H1U4aH1D03A+M71rnsDi1kzT0TzU"
      8332_Magic_Title_Graphic := "|<8332_Magic_Title>**50$69.y0Ts00000z00k37000004s060ss00000r00M67000007s730ksDk0S0y7vQCr7zkTzrlxNVatwz7nyzQ3ABrQ0tk4ozDRnivDnAz6bnvaNrPz/bwoyMQnSvwNNlabb3rvrTz/AAowkSSStzlFUqba3nrrS0+86owkTSyz3tF0qba3Narnz+AAowkPBqySNNVabr3ACrn7/CQoyTNVayTlwz6btvAQqlsDXUoz0Nn6r0MT0abS4"
      8333_WildHarvest_Title_Graphic := "|<8333_WildHarvest_Title>**50$55.y3w3vvw07n3b35Ba03NVlVban01gkkknTNU0qAMMNjgk0PaRaMrqMTxnAnAnvAzytaRaNBaw3QzSvAanMw/DjD6HNwz5bbba9gwtmnrvn4qSMNNvhtWPCA6itaQVBb43HAnAkana1dasqMHNl0otMNANgskmAAAAAqSQN6C762PD7wX71X1BalsFn0lUanQ1cTUTUTTbVy"
      8341_Bumper_Title_Graphic := "|<8341_Bumper_Title>**50$69.zz00000000000Q000000000T1k000000007z6000000000kQnsDjTbwDzq1aT1xzzzlzzkAmM9dUw7BkS7aH1B1XARVsztmM9cT3tgTXwQH1B7szBbC03mM9dnCNgkrz7H1BANXBg6zwOM9dXANhUS1nH3BANXBg3k6OMNdXANhUK0nH3BANXBi6kCOQtdXANglrzXNyBANXBbwzsvDVdXANgTU0CM1BANXBU107VkzdXANhkTzs7zxwTXxjzU"
      8351_AbilityRsrch_Title_Graphic := "|<8351_AbilityRsrch_Title>**50$69.CA1A04SODw01VU9U0bnHtU0QC1A07qPzA03Ak9zkynTtzUNa1DzbqPzDy7Ss9UCznTUAknn11soyOT7a6SQ8TbbnHtwMrlV7CQyOTAnAnA9knbnHtaNjtlA6QyOTANcz69UHbnHtXD00lA2QyOTANs079UnbnHtVbTyNA6QyOTAAnzn8lnbnFtVas6B7wwyODC660NcT6bnFswkk3B81oyOBVb60MjkwbnHiANU1xzz7zvxzXA"
      8352_FirstRiches_Title_Graphic := "|<8352_FirstRiches_Title>**50$69.zzwz007s000003qM00n0000006r006M0001zwzs7Un0000A3ny7zaTs0S1U6TtyynzkTyA0nzQ0yQD7ntUCSP7Xm8Rk3DzbnlyS7nwz9zsqSQtlzDDx00Cnn3yQNtXU01qQMTn3DTwDz6na06MNnzVzwqQk0n3C00A1qna3yMNlztUCqQMTn3CTzA0rnn7SMNnVtU6SSTnn3DQQA0nntwSMNtzdU6SPU7n3DblA0nnD3qMNi0TU7zszwz3wsDU"
      8353_FullofStrength_Title_Graphic := "|<8353_FullofStrength_Title>**50$68.TzsDU000000D0D7s0000003XUta0000000nz6NU0000009ktiSxw7UDTmM7TbzzDz3zza1zUSwrvsj1tsDwDYDk796CDw7bsTlwu7lkzsNaDwzaXyT0z6Nb6QNdlZy0taNVbz+MNDy7NaMNzna2SDsqNa400tUbkDBaNV7zyM9g0nNaMFzya2HUAqNa6MDdUaQ7BbNVb7OM9XzbNyMMzaa2QTlr7a37ndUbU1tltUs1mM9S1wDzs7Vsy3s"
      8354_Promotion_Title_Graphic := "|<8354_Promotion_Title>**50$66.00w0000000000A00000000DzC00000000A7bzsDkTzjwA1bzwzwTzzyA1biDsyPUwDA3bgTU7MAF3DzDVzDnsy7nDzBbyTttzDv40RbCsttXAN01xaAsRtXANDztiAkRvX8NDzViAkBv38NA01iAkBv38NA01iAkRv38NA01iAsNv38NA01iCstv38NA01i6Tnv38NA01i7DXP38NA01g3U7P38Pw01w3kST3sTU"
      8355_SkillfulWork_Title_Graphic := "|<8355_SkillfulWork_Title>**50$61.w0wP03DBakwQ79U1janNwzlYk0znNgwswmMDTNgyOM6NATzwqSDA3waSTyPA1bUyHSTDBa0lzU9wRbanlwDy4wQnnNwzUTWQQNtgqFy0tgQAwqP8TwCkC6SPBYszXMX3DBamS1tgtlbanN30AqyQnnNgVk6PT6NtgqGQ7BBngwqP9DzCaQySPBYlz6H6DDBamQ0DBXbbanN7UT7kzzzTjVzy1kDCD73W"
      8356_SpecTrain_Title_Graphic := "|<8356_SpecTrain_Title>**50$65.Dzs00000001s1s00000003Vks00000006Tsk000001w9stbzw0S0TyH0vDzw7z1yya0yPUQzDbUDD1wkwRk7iTCDw1XwTDXtyC7z3CQwzbbCT0z6MNnXbADjk7AktbzCMDDy7PUnDyQU1lz6r1a00t03kDBi3Azzn1tU6PAAtzza7lUAqQNn1zCQnUtgznb7SDlXzXMzDbwqTbXyCk0v7li0TU0ta3b07D3nkDXDy7UwDz8"

  84_Officer_Button_Graphic := "|<84_Officer_Button>*120$55.w7ssbzzzzs0wMnzzzzsyAQzzzzzszWCTy7zzwzs02Q1sD0Tw376QM3VDyFnWT9wnbz8tlDwyNnzYQsby0AtzmCQHz06Qzl7C9wbzDDtXb4QHtbVllnX0Mtns1xtnkS0tzXzzzzzlzw"

  85_Items_Button_Graphic := "|<85_Items_Button>*130$44.DzzzzzznbzzzzzwtzzzzzzCTzzjjzn3kS01s4tsX33AMCQwFlnD3bDYwwlwtk1DDC3CQ0Hnnk3bDwwwzktntDDAwCAQnnnD3nUSwws6"

  86_Mail_Button_Graphic := "|<86_Mail_Button>*123$33.7yDztUTVzzA3wDzzUTVzzw1tC1tVD9X7A9tAwtVaNzbAAnD0tVaNU7AC7AwtVktbbAD7AstVttUHAzzzDTw"
    860_Mail_Title_Graphic := "|<860_Mail_Title>*127$48.3zwDzzts3zwDzzss3zsDzzts1zsDzzzs1zkDzzzs0zkDk7ts0zmDU3ts4TWD3Vts4TaD7lts6T6Dzlts6D6Dzlts6DCDk1ts76CDU1ts76SD7lts7YSDDlts7USCDlts7UyC7lts7kyD31ts7lyDU1ts7tyTkNtsU"
      8601_Read_Confirm_Button_Graphic := "|<8601_Read_Confirm_Button>*155$71.w3zw7yDyD01lU1zU3wDsQ03W01y03sDks074D3sS3kTVkzy0z3Vy7UT3Vzw3z73y70y73zs7yCDwC0wC7zkDzwTwQEsQDzUTzszsslks0D0zzlzllVVk0S1zzXzXXV3U0w3zz7z77W73zs7zyDyCD0C7zkDwQTsQT0QDzUTksTlsz0sTz0TXsT3ly1kzy8A7kMDXy3VzwM0Tk0z7w73zss1zs3yDwC7zl"
      8602_Read_Mark_Button_Graphic := "|<8602_Read_Mark_Button>*147$49.7yTnw3wy3y7ly0QS0z3sT06C8T1sDXn647UwblsW63kSFtwl79kCAwwM7YN76S0Q1nAXb70S0tYlU3b76AkMk0nnXWQANwNsltCC8zAyMw7b4zWT4T8"
    861_Messages_Button_Graphic := "|<861_Messages_Button>*148$61.w07U000000S03k000000DU1s0000007k1w0000003w0y0Q0603Vy0v0zUTs7wv0RUxsSS7jRkAksAC771yMCsQ771XUzC6QA3XU1k3b7CDzky0T1lXb7zsDk7wstXXU00y0TQBllk00701y7ksM061X0z3sQC130lkTUwC3XlsswRkQ70zkTsDyM41UDU3s1wE"
    862_Alliance_Button_Graphic := "|<862_Alliance_Button>*149$69.1k1kks000000D0C670000001s1kk0000000T0C600000003Q1kk03U0A00tUC671z1rs37C1kksSwDzUslkC6771lsQCC61kksECC1VlksC6701lkAAA71kks7yC1XXzsC673zlkAQTzVkkswCC1XbzwC6771lkAAs1lkkskCC1Va0CC6771lkACk0lkkswyC1Uy07C673ylkA3U0Mkkk7a41UA"
    863_Battles_Button_Graphic := "|<863_Battles_Button>*149$63.zs000003U07zk0030kQ00kC000s63U060s0070kQ00k70S0sD3U760sDwTzyQ3ykC3nnyznUty3kMC70kQC7zw30ks63XUTzk0670kQQ3kC0zks63Xzy0sTy70kQTzk73Uks63XU60ss670kQQ0k770ks63XU60ssC70kQC3zy3bkQ73VszzUTz3syQ7yU"
    864_Activities_Button_Graphic := "|<864_Activities_Button>*149$65.7U001k00006T0003U0000Ar01s700000Pa0Dsznb0tnrC0xtz761XbgQ3UssCA773sM70lkQQAC7ksA1XUsMMQD1kM071klksTzUk0C3Vn1kzzVU0Q71a3Vzz300sC3Q73U770lkQ7kC60CC3XUs7UQA0ACD3VkD0sM0QDw7nUA1kM"
      8641_SPAR_Button_Graphic := "|<8641_SPAR_Button>*149$65.zsQ00000Q01UsE00000s020s000001k041k0301k3U68073TUDz70zM0C7zUzyC7js0QC3VkwQC7y0sM770sss5z1kkCC1llk8TXVUQM3XXzk7730sk777zU7C61lUCCC00CQA3X0QQM00QsM770sss20tkkCC3lksD7XVUQDDXVszy730sDz71zk"
      8642_AAR_Button_Graphic := "|<8642_AAR_Button>*149$62.0s0sMQ00000D0C67000003k3VU000001w0sM000000PUC600Q01UCM3VVkTkRy3b0sMQDS7zklkC6771lsQQA3VVkUQQ373UsMQ0770lUsC670zlkAzy3VVkzwQ3DzksMQS770rzwC6771lkBk3XVVlUQQ3M0ssMQQ770y06C677blkDU1nVVkzgQ3k0AMMM3n20s"
      8643_CSB_Button_Graphic := "|<8643_CSB_Button>*149$62.7w000000007zU00000003kQ00000000s3U0000000A0s1UQ0703X06DsTk7w3yk03yTS3bVvs00w71lkMMC00C3UQQ6C3U03Us3701k800sC0sy0T300C3UC7w3yk13Us3UDU7w0ssC0k0Q0D0CC3UAM7C3s73UQ761nUrXks7XVssQQzsC0zkDw3z3s103k0y0T8"
      8644_Desert_Button_Graphic := "|<8644_Desert_Button>*147$64.zk000000003zk00000000A7U00000000k70000000030Q0s0C03U0w0sDs3y0zUzk3VvkQw7D3z0C63XUssQCA0ss6C3b0skk3X0Ms0Q3X30CDzVw1zyAA0szy3y7zskk3X001wQ0330QA000tk0AA1ks0A3b00kkC3UMsCC133zk7XXlkwQADy0Dw7y1zUkz00D07k1w22"
      8645_Other_Button_Graphic := "|<8645_Other_Button>*147$60.7w00Q00000Ty0kQ00000w70kQ00000s3UkQ00000k3VsQs0C03k1byTy0zUzk1nwTz1vkzU1kkS73UksU1kkQ330ssU1kkQ370skU1kkQ37zskk1kkQ37zskk1kkQ3700kk1UkQ3700ks3UkQ3700ks70kQ33UEkTT0sQ31lskDy0yQ30zkkU"
    865_LEWZ_Button_Graphic := "|<865_LEWZ_Button>*149$67.k000001k0Tzs000000s0C0A000000Q070600C07UC03U300TkDwTk1k1U0QwDDDs0s0k0Q673Vk0Q0M0A3XUks0Dzg001lk0Q07zq00TsT0C03U300zw7w701k1U0sC0T3U0s0k0M703Vk0Q0M0A3X0ss0C0A073lUMQ0707znrswQD03zzzszwDw3k1zz"
    866_System_Button_Graphic := "|<866_System_Button>*148$59.Ts00000001zs00003003Us000060060s0000A00A1m0kC0s0sM0C1lz7y7ws0Q77j7sSxs0MCQ731kRz0sMsC63UszVlkk0A60kDVnVw0MDzU73a1z0kTz073A0T1Uk10C6s0731U20QDUkC63U60sD1kQA70z7US1lkQ7bjy0s3zUy7y7k0k1w0w3l"

  87_Alliance_Button_Graphic := "|<87_Alliance_Button>*134$70.zzXbjzzzzzzznyCQTzzzzzzy7stvzzzzzzzsTXbzzzzzzzzYyCTzXznz7zAHstls7U7k7knDXb76C6CASDASCQQwswtwlttstlznbn7nDbXXb7kCTAzw00CCQQ0twnzk00stlnnbn7zDDlXb6TCTATwwzaCQMwtwtwlryMtll1bnX7XTsXb706D70T2"
    870_AllianceMenu_Title_Graphic := "|<870_AllianceMenu_Title>**50$68.7s14WT000001X0F8YE00000Mk4G9400000A414WT0000031UF8bU00001WM4G9wDz3zyNn14WH70sb1qQkF8YH0780B7A4G94nsm3lnFV4WF9zAXwMqMF8YHsl8la9W4G94zwGMNaAl4WF7y4a6NzAF8YHU19VY01YG95lwGMN00N4WFNz4a6HzaF8YIMF9VZzwoG956AGMNM3B4WFFz4a6I0lF8YKD19Vb04QG95k0OMNk1X4WFC3aa6Q0TzDblzzjVy"
    874_Help_Button_Graphic := "|<874_Help_Button>**50$44.y3k07k0BUa01A02M9U0H00a2M04k09UaDtDzmM9j7HqCa2P0ow0tzbbbDDC01vxnrNU0QzAxaNzb03DMaM9nznq9a2QzwxaNUbCxDNaM9tzHnva2T4Iw0xUasRj8PsD7ySrw00000BU000003M000000q000000DU8"
      8740_Help_Title_Graphic := "|<8740_Help_Title>**50$58.A0n000n000k3A003A0030Ak00Ak00A0n1zknTzkk3AC3XBi3X0AlU3Ao07A0nASAnESATzAnwPB7wE00qANgoMl003NzWnF1YTzBXy/B46Hzwq00goENA0nM02nF0Yk3BbzvB46H0AqM0AoENA0nMkwnFX4k3BXjvB7QH0An7tgoDXA0n60CnE0Qk3AQ1nB63j0DkTyDoTw0000T00FT00000001408"
    875_Wages_Button_Graphic := "|<875_Wages_Button>**50$66.wD3k0000000wB6k0000000aNak0000000qNak0000000mEYny7zXy7wmkor7CBb7C7Hqwg1g0i1g3PqRdttsgtttPaRjhtwtgvxNjNDwvAtwtz9jNC0nAs0gD9jPAwnAs1j3A93NwnAvzztANXNAvAtbzNANWNstwdzvt4EaM0w0g1s36kqC4i4a3g77ky7zjwXz7y00000DxU000000009lU00000000A3000000000Dz0000U"
      8750_Wages_Title_Graphic := "|<8750_Wages_Title>**50$69.V4Ak00000004Mla00000000X2AU00000004GFATw7zsTwDWH9a1lkN61nYmPBU3A09U6MoPNcwP7lMwO+b+9AnFa/AnHQtnDyO8FH3OPZ6MznH2+TtFNgmC0OEFE0/3AaFXnG2+01C94aNuOMFHzsM8onAHF2+MCy366N6OAlNXwkEkXDXNy/7vn62A8MNX1AQOAkNVUNA09k6My1s7zszl7zVs000DUCy8Dk3000001zn0000000009wM000000001U60004"
    877_Technology_Button_Graphic := "|<877_Technology_Button>*108$68.03zzzyTzzzzk0TzzzbzzzzzXzzzztzzzzzwzzzzyTzzzzzDw7wDYDgDsTny0w0s1s1s1wz7DDCCCCSSTDntXlbnbXDXnsyNztwtwnwwy06TyTCTAzDDU1bzbnbnDnnsztztwtwnwwzDyTiTCTAzDDlvnnbnbn7bny0Q0twtws1wzkDUSTCTD0s"
      8770_Technology_Title_Graphic := "|<8770_Technology_Title>*129$61.003zzzzzXzU01zzzzzlzk00zzzzzszzsTzzzzzwTzwTzzzzzyDzyDzzzzzz7zz7zs7zUTW1zXzk1z07k0TlzksT3VsC7szsyDXwQDXwTszXXyCDlyDwTllzb7sz7w7kszzXwTXy00QTzlyDlz00CDzsz7szVzz7zwTXwTszzXzyDlyDwTzlz77sz7y7twTXXwTXzVsS7XlyDlzs0TU1sz7szy0zs3wTW"
      8771_Tech_Rank_Button_Graphic := "|<8771_Tech_Rank_Button>*78$50.U3zzzzwzk0DzzzzDwTVzzzznz7yTzzzwzlzXzzQDDwTss3k1nl7yQ0QAQsly7Db7XAQ03rtnsmD00TwQzA3lz7U7Dn0wTtkNnwl77yMyQzAslzaTbDnDATtblnwnl7y80AzAy9zX0XTrjm"
      8772_TechLocked_Title_Graphic := "|<8772_TechLocked_Title>*55$69.Dzzzzzszzzztzzzzzz7zzzzDzzzzzszzzztzzzzwz7zzzzDzw7y0syTlztzz0DU37Xs3wDzlkswMsyCD1zwTaDn6DXstDzbwFzsXwza9zwzWDz0z7wnDz7wFzs3s06NzszWDz2D00nDz7wFyMlszyNzwzaDn777wlDzXwswMwQT680AD7U77XVls00k1y1syC0DY"
      8773_TechOK_Button_Graphic := "|<8773_TechOK_Button>*133$31.y1znzw0Dszw01wTwDkSDwDyD7yDzXXwDzllw7zsswHzyAQPzz6ARzzX0SzzlUDDzlk3bzssFnzwQQMzwCC4DwD7X3wDXsU0DlwQ0Dtz8"
      8774_MaxClear_Button_Graphic := "|<8774_MaxClear_Button>*130$51.s3szzzzzw0D7zzzzz7sszzzzztzX7zzzzzDyMy3w3t3zz70D0D0Tzststssvzz6DbTbDTzsnwTstvzz603k7DTyMk0M0ttzn6TyDbDDwMnynwtsz76DaT7DU1ssklUty0T7UD0XDwDzy7wSTw"
      8775_MaxCD_Title_Graphic := "|<8775_MaxCD_Title>0xFC0000@0.67$41.003k0A000Ds0s000tk3k003VkDU0061UT3U0A31a700M76A601kCQM003UQkk0070v3U0061rzk00A3DzU00M60A000sQ0MA00zk0ks00z01Us"
      8776_TechBuy_Title_Graphic := "|<8776_TechBuy_Title>*83$35.07zzzy03zzzwz7zzztz7zzznySTAz7wwy9wDVtwFs07nsnk07blb1z7DX6HzCT7AbyQyCFDwtwQ6TllkwA07U1ss0zUrtzzzzzXzzzzzDzzzzsT"
    878_Boss_Button_Graphic := "|<878_Boss_Button>*105$45.0Tzzzzzs0zzzzzz7XzzzzztyTzzzzzDnwDsDkNyS0y0w17XXXXX700wyASNw03btXz7tyMzC3w7Dl7tw7s9yAzDwTsDlblbnDVwQSQSNw03k3k3001z0z0y3U"
      8780_Boss_Title_Graphic := "|<8780_Boss_Title>*130$63.U7zzzzzzzzs07zzzzzzzz00TzzzzzzzsTVzzzzzzzz3yDzzzzzzzsTkzzzzzzzz3z7w3zk7z0sTky07w0TU13yDksT3VsQ8T3wTXsyD7s00z3yCDtsz003szlszz7z3wD7zD1zsDsTkszsw1zUD3z77z7s3zU8TssztzsDzU3z77yDzkzz0TssTllz7Ds3y7XwCDssz0T1wD3syD3k00Tk0z01w080DzUDy0zk3U"

    901_Menu_Expand_Button_Graphic := "|<901_Menu_Expand_Button>*126$37.1zzzzs0Dzzzk01zzzU40Dzz03U1zw07s0Ds07z00k0Dzk000Tzy000TzzU00Tzzw00zzzz01zzzzs1zzzzz3zzs"
    902_Menu_Collapse_Button_Graphic := "|<902_Menu_Collapse_Button>*129$37.zzw3zzzzs0zzzzs07zzzk00zzzk00DzzU003zzU000Tz00w07z01zU0y07zw060DzzU00Dzzw00zzzzU1zzzzy8"

  91_ActivityCtr_Button_Graphic := "|<91_ActivityCtr_Button>**50$58.7k07ZU2zU0NU0SK0/y01a7zDzDzTbBgxwzyzsyQqn1VrPPXjKPPnDQvjSxPrhwZvixhpjSrmLgvqqI0u19SrjPPmHhwZhSxYjTiyvqlvrNf7RrjNhjBagBsyRaqqHPkzzDySDTP8"
    910_ActivityCtr_Title_Graphic := "|<910_ActivityCtr_Title>**50$69.3w00000TU01sMk000T3A008360003QNU010kM000NXw00D630003AD000smM0zvtvzsDjAtUS3s1Nn1ZVbA70C0/CAMc8sklsyDNtXB3B6CTXtnD4NcNglb6PANgqN6BXAkvNXBan8n6N63vANgqN6Tl8U0NXAnW8U0B403ANaQl401ck0NXAla87zDa3vANX9V1zwwknNXANA8A1bXyPANV1V10ASDXNvAAM8U"
    917_DesertWonder_Button_Graphic := "|<917_DesertWonder_Button>*121$62.00zzzzzzzzly7zzzzzzzwTkzzzzzzzx7y7zzzzzzzFzlzTzzzzzUTwC0s3s7407z3CAwtsU41zsblDSSABYTy88Hz7V7t7zWD4DlslyFzkbzUwzwTYTw9zw7Dz7t7z6TzklzlyFzVXxSATgTYTssSLnXv7s7sT0Aws1ly0ETs76T0QDW"
    ; 91A_GoldenChest_Button
      ; 91A0_GoldenChest_Title
      ; 91A1_Free_title

  92_Benefits_Button_Graphic := "|<92_Benefits_Button>**50$62.zs0000C4w08300003TD02yntzVxryNyhZzzwztzbzvvsQ3MA4kwCwxnDQvbCSxUSynrTNmZjvvbghraIdNyyM39Q1Z+HXgqzmLTtGZzPtjwZryIdzqyxv9QxZ/SxUTVmLktGnkzyTzbjzrjzy"
    920_Benefits_Title_Graphic := "|<920_Benefits_Title>**50$66.U0s00000000U0A00000000XyA00000000XD400000000W347z3zy0zsW14C3XC71kSW34M0n81XU6XDAtwv3lb7XXwAnyP7saTnU0NX6PCMYMlU0RXy/A8YTlXyDXy/88gTlX77U0/88g01W1bU0/88g01W1bbzv88gzzW1bW0388YE0W3bX3n88YMSXz6nzP88aSvXyClyP88a7nU0QM0P88X03U1sS1n88VkCzzk7zXsDUzwU"
    921_BattleHonor_Button_Graphic := "|<921_BattleHonor_Button>*88$44.0Tzzznzk3zySQzwwzzbbDzDb3kUnsHnUQ8Aw00tnbbCQ0Dwttnb3lkCSQs0yMnbbC0DYwttnbnlCCSQts0s3XXD0Uz4wwvsM"
    ; 922_Claim_Button
    923_DailySignin_Button_Graphic := "|<923_DailySignin_Button>**50$51.kuU000BU4no0001g0DjbzzkBzthxvzb1jrDyg3UMBkASpDQt1iwsyfPhcBqXlpNRh1iovif/hcBqXBpPRh1ioDidvhcBqY1pURh1iotzjPxsDyw"
    924_MonthlyPackage_Button_Graphic := "|<924_MonthlyPackage_Button>**50$66.0s001M000008A001M00000Dhz7xPrwTty9bXiDSyCtfX9b9g7QwbkD9DiwvnNfnjCx8DwvT3Dnhgw1vUvD3A3Bg0DqQvD3tnBgzU"
    925_MonthlySignin_Button_Graphic := "|<925_MonthlySignin_Button>*89$66.zbyTzy1vzzzbbyTzw0vzzzbbyTzwwzzzz1USHnwyvsiV1UCHnwzvU60bbCNXyDvb6QbbCNbz1vbaQbbCNbzsvjaQbbCQDzwvjaQbbCQDtwvbaQbbCSDwwvb6QVbCSTw0vU6QljiyTz3vsCyU"
    926_SelectReward_Button_Graphic := "|<926_SelectReward_Button>*91$47.kTznzzzz0TzbzzzCSTzDzzyMwwCT7ks9zkAw70kEzCNnaQnsSSHD9xbyA0a0HzDyM3A0byNwnyNzDwltbgtvCNk7UNk60ksTVvsT7l"
    927_SelectionChest_Button_Graphic := "|<927_SelectionChest_Button>*90$43.sCTzzzzk3DzzzyNtbzzzz9yE7ky70zs1kC1UTwQnqQtDySNt7wbzDA0kyHzba0y79yHnDznaSNtbgtnUAws70ssTTS7kyE"
    928_SingleCumulation_Button_Graphic := "|<928_SingleCumulation_Button>*92$66.UTzzzzztzzy6TzzzzztzySTDzzzzztzyTTAxkACQtkQ6Twwk0CQtUACTwwnXaQtbCSTwwnraQtzCSTwwnraQtkCSTgwnraQtbCSTAwnraQtbCSCAsnraQtbCSUS0nra0tUD6U"
    ; 929_WarriorTrial_Button
    934_CSB_Button_Graphic := "|<934_CSB_Button>*109$44.sTzzzzzw1zzzzzySTzzzzzDnvvzDtnzks70s4zwwtnaQDzCTAzbnznbn3sQzwtwwDVDnCTDly9tnnmSPm0QwFk68kDTUy3kM"
    936_DesertOasis_Button_Graphic := "|<936_DesertOasis_Button>*117$48.0TzzzzzvCDzzzzztDDzzzzztDb1sD1kkDaQnaQltDaSnyQntDYQlyQntDY0wC0ntDYTz6TntDCTraTnt0SAn6Ans0z1sD1nwU"
    938_EliteDual_Button_Graphic := "|<938_EliteDual_Button>*117$41.sTzzzzz0SzzvzySQzzbzwwlyz7vtz1kA71lzbCQQtkTDyttvsST1nk3yQw3bUBwtnrDDntnbCSTlXb4SQNkD70wQ7"
    93F_WarZArena_Button_Graphic := "|<93F_WarZArena_Button>*115$38.STTzz07XbzzzlstzzzsACM71yH/iMlzAqHzAzXhoy3DtsRC0nwy77bAyDXlnnDbwwSEnk3DbUAw0U"
      B224_CityBuffs_Button_Graphic := "|<B224_CityBuffs_Button>*190$40.0DzySTxwzzvvzrnrrDDVTDSM8Ak1xtvnnnnrbjj3TbSSyr1yRtvuTXnnbj9C0D0Soi2"
        B2240_CityBuffs_Title_Graphic := "|<B2240_CityBuffs_Title>*130$66.0Dzzzz0y1zz03zzzy7wDzz01zzzyDwTzzDkzzzyDszzzDszzzyTszzzDsTzzwDszzzDsQTlk1U3s3DswTlk1U3k0DkwTlwDszVsD1wTlyTszXw03wTlyTszXw01wTlyTszXzDswTlyTszUTDwQTlyTszs3DwQTlyTszy0DwQTlyTszzkDwQTlyTszzwDwQTlyTsz7wDsSDVyTsz3w00y61yTszVkU"
        B2241_Shield_Button_Graphic := "|<B2241_Shield_Button>*103$60.03zzzzzzzz01zzzzzzzzDszzzzzzzzDwzzzzz3zzDwy3w3w1y3Dws1s1sss1Dstststwts01nwvwlynw03nwTslznwDzk0S0nzk0Dzk0s0nzk0DznzlwlwnzDznwnwtwnyDzlwnssslwDzsklUw1skDzw1s4S7w1U"
          B22410_Shield_Title_Graphic := "|<B22410_Shield_Title>*128$64.00Tzzzzzzzw00zzzzzzzzlzVzzzzzzzz7z7zzzzzzzwTyDzzzzzzzlzsz0Tw1zk77zXs0z03y0ATyD7VwS7kwFzlsz7XwS7s7y7XyDzlszU00yDszz7XzE07k03y0SDz3zz00D01tzwTzw00sD7bzlzzlzzXwSDz7zzXzyDlszwTzyDzsz7Xy1zzsTbXsS7k7zzksS20wC4TzzU3w03s0lzzz0Ts6Dk7U"
          B22411_Shield_Ends_Title_Graphic := "|<B22411_Shield_Ends_Title>0xFEFEFE@0.79$60.zw000U00E0k0000U0000k0000U0000k03U0U000Ck0TkyXs0Fvk0MFVa40FVzsEF1Y00F1k0EH0a00F1k0EH0Xs0F1k0EH0UA0F1k0EH1U60F1k0EF1Y60F1zwEEnaA0F1U"
          B22412_Replace_OK_Button_Graphic := "|<B22412_Replace_OK_Button>*138$25.k7lyE1sy1wQS9zCCAzb6CTlWDDwkDbyM7nzA1tz6AQzX76TnXn7llsllsyA1wTY"

    B34_CommandCtr_Button_Graphic := "|<B34_CommandCtr_Button>*100$69.zrzjTzzzzw5DzrzXzzzzz0QSnNkzzzzzU3rxskTzzzzk02ywMDzzzzs827mQ3zzzU63k0za/zyzw00607z9zzfzs0000zwzzujzk0007znzzqzzXk00zy0zzvzzzU07zc2jzzzzw00zzU0zxzzz007zw03zrzzs00zzk0DzTzzU07zx00zzzzw00zz403zzzzU27zwk0Dzzzw0Ezzz01zzzzU07zzs07zzzw00zzzU0TzzzU07zzy03zzzw0Czzzs0DzzzU6I"
        ; B3420_ActiveSkill_Title
        B3430_Recruit_Title_Graphic := "|<B3430_Recruit_Title>*118$57.01zzzzzzzs03zzzzzzz7sDzzzzzzszVzzzzzzz7yDzzzzzzszkzUzy3yM7z7k1z07k0zlw07kES07yD3syDVkszVsz3XyCD00T7wQTlls07kzXXzyD01y00QzzlsyDk037zyD7sy7zwzzlsz7lzzXzyD7wT7zwTtlszVszzXyCD7yD3wSDXlszkw07k0SD7z7k1z07ltzszUzy3yTU"
        B3440_Craft_Title_Graphic := "|<B3440_Craft_Title>*133$54.U0Tzzzzzt00Dzzzzzs00Dzzzzzs7zzzzzzzz7zzzzzzzz7zzzzzzzz7zzUNwzXs7zz01szXs7zy7VszXs7zyDlszXs00wDtszXs00wTtszXs7zwTtszXs7zwTtszXs7zwTtszXs7zwTtszXs7zwTtwzXs7zwTtwzXs7zyDlwTXs7zy7VwC3s00D01y03s00DU1z0XsU"
        B3450_Collision_Title_Graphic := "|<B3450_Collision_Title>*130$47.z0zzzzXls0Tzzz7XU0TzzyD67sTzzwSATszzzswFzlzzzlsXzly0zXl7zzs0z7UTzzVkyD0zzy7swS1zzwTlsw3zzszlls7zzXzXXkDzz7z77UDzyDyCD4TyATwQS8zwQTsswEzlszXlslzXlz7XlUwDksT7XU0Tk0yD7k3zk7wS8"
        B3460_RuneExtract_Title_Graphic := "|<B3460_RuneExtract_Title>*129$65.U7zzzzzzzzy01zzzzzzzzw01zzzzzzzzszVzzzzzzzzlzVzzzzzzzzXzXzzzzzzzz7z77wTA3zkCDyCDsw03y0ATwQTls63sQ8zkszXkz7lw1z3lz7VyD7w00DXyD7wSDs00z7wSDswDU03yDswTls00TXwTlszXk00z7szXlz7Xzlz7lz7XyD7zXy7XyD7wSDz7yDXwSDsyDuDwD3UwTlwD0TwS01szXw08zsS0Xlz7w0s"

      B350_Depot_Title_Graphic := "|<B350_Depot_Title>**50$58.zzy0000003zzw000000000k0000000030000003yTw0000000NU00000001a1zszs3zU6M6tb1kw7UNUE2k1X061a11yD6My86M4TtyBbMkNUFX6Arsn1a1AAzlTzA6M4klz4TskNUH300HU31a1AA01MTA6M4knzxbwkNUH3A04Mn1a1AAMSF3A6M4klrh7skNUH1XwoD31a1A707M046M4kC0skAM"
      B351_Free_Button_Graphic := "|<B351_Free_Button>*200$38.07zzzznzzzzzxzzzzzzTzzzzzrzUw7w5zsyQwQDyTDjTU3brtrsztwQMwTyT0607zbrzbxztxztzTyTDzDrzbtvllztz1z1U"
      B352_Help_Button_Graphic := "|<B352_Help_Button>*200$41.DwzztzyTtzznzwznzzbztzbwzDsnzDUSS0bySSQww00twtvw01nxnrsznU3bjlzb7zDTXzCTySz7yQzwxyDwwyttsTtslnlUznwDbcTzzzzzTzzzzzyzk"
      B353_Request_Button_Graphic := "|<B353_Request_Button>*200$67.0DzzzzzzzzzbXzzzzzzzzzrwzzzzzzzzzvyTzzzzzzzzxzD0z0SzT1y0zbDDCDTjCSQTbjbDbjrDbD07bvbnrvbnbk7ltntvxk1kvts0twxys0y5wwzwySzQzzszCTyTDTiTzyTbbzDbjbDyTDtlnnXnXnrbbww3w1w1w3s4"
      B354_Reward_Button_Graphic := "|<B354_Reward_Button>*200$68.0Dzzzzzzzzz3lzzzzzzzzzlzDzzzzzzzzwTnzzzzzrzzz7ww3brnkD1k1zCQNswtllssTbjbCDSyQyT03nxnfbzbDjk1w0SmNy1nnwTT07hqyAQwz7nnzvRjDbDDlywzy73ntnvwTbjznswyQyT7wttwyT67DnVzD0zDbs9nw0U"

      ; B360_DropZone_Title
      B361_Click_Button_Graphic := "|<B361_Click_Button>*123$51.s0TCDzyDy31tlzzlzXyDDzzyDszstzy7lz7zbCD0CDVzztlkklsDzzCCT6C9zztlXwlXDzzCATy8tzztlXzkDDzzCAzy0tzwtlXzkX7z7CATaA8zstlXsllXyDCCC6D623tls1lss0zCDUyDY"
      BD01_Desert_building_Title_Graphic := "|<BD01_Desert_building_Title>*127$69.01zzzzzzzzzs07zzzzzzzzz7sTzzzzzzzzszlzzzzzzzzz7yDzzzzzzzzszszUDy0zs3w7z7s0TU3y0DUzsy7XswDXkw7z7lyD7lsz7UzwQTllzD7ww7zXXyD7zkzXUzsw01s7y00Q7z7U0DU7k03Uzsw01zUC00Q7z7XzzzVlzzUzkwTzzyC7zw7yDVzyDsszzUz3yDlkyD3ww00zkQD3VwC7U0Dz03w0Tk1w07zy1zk7z0TY"
        WD111_Steal_Button_Graphic := "|<WD111_Steal_Button>*139$45.UDzzzzzUswzzzzwDXXzzzzVyQTzzzwDy0s7k7UzwSAQQQVzXnnbXa1wQyDyQy7XU1s3bwQQ0C0QznXbzXnXyQQzwyQDXXXvbXUMSSCQMQU7ks3k3Y"

    WNC_Coord_Button_Graphic := "|<WNC_Coord_Button>#458@0.67$27.7zzz1zzzyTzzznzsDzTw0Tzz01zzk0Dzy00zzU07zw00zzU07zw00zzU07zw01zzk0Dvy03zTs1zvzszzDzzzszzzy3zzzUTzzwU"
      WNC0_Coord_Title_Graphic := "|<WNC0_Coord_Title>*50$64.zzzzzzzzzz3zzzzzzzzzwDzzzzzzzzzkUDyDzVzATz00TUDw1s0w400s0T03U3007300s060A00w4D1VsM7Uk3s0y4DkUw7UTy7s0z27kz1zsTk7w8T3w7zVz0TkVwDkTq7w1z27kz1y0TU7w8T3w3kVy4DkVwDk623sEy67kS00A03U0MTU001s0C03Vy00UTU1w0T7w03zzUTw3zzw6M"
      WNC1_GoTo_Button_Graphic := "|<WNC1_GoTo_Button>*141$52.w7zzzzzzzU7zzzzzzwSDzzzbzzXwzzzyTzyTlzzztzzlzzUDy0w37zy8Ts7U4TznsztwS3zyDnzbnwDUMzDySDkS1bwztsz1z6TnzbXw7wNzDySDmTlXwztwz8z7DXzbnsksQQTyD37U3s3zsC0T0zkTzly7U"