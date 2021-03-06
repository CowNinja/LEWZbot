; #####################################################################################
; FUNCTIONS OVERVIEW
; #####################################################################################
;
; find functions: ^[^\h][^\(\r\n\h]+\(
; or: ^([^\h\r\n\(]+\()
;
;	Win_GetInfo(App_Title:="", App_ID:="", App_Class:="", Options := ""){	; Win_GetInfo(Options := ""){
;	IsWindowVisible(App_Title) {
;	WindowFromPoint(x, y)
;	Win_WaitRegEX(WW_Title, WW_Text="", Timeout="", ExcludeTitle="", ExcludeText=""){
;	OLD_Win_WaitRegEX(WW_Title, WW_Text="", Timeout="", ExcludeTitle="", ExcludeText=""){
;	Control_GetInfo(Win_Control, Options := ""){
;	Mouse_Click(X,Y, Options := "") {
;	Key_Menu() {
;	GUI_Update() {
;	Mouse_Drag(X1, Y1, X2, Y2, Options := "") {
;	Mouse_Move(X1, Y1, X2, Y2, Options := "") {
;	Mouse_GetPos(Options := 3) {
;	Mouse_MoveControl(X, Y, Control="", WinTitle="", WinText="", Options="", ExcludeTitle="", ExcludeText="", RelativeTo="Client", TargetType="Mouse") {
;	Search_OCR(OCR_Array, Options := "") {
;	DropFiles(window, files*)
;	Search_Captured_Text_OCR(Search_Text_Array, Options := "") {
;	Search_Pixels(Search_Pixels_Array, Options := "") {
;	Search_Images(Search_Images_Array, Options := "") {
;	Text_To_Log(ByRef Input_Array)
;	Command_To_Screen(Text_To_Send, Options := "") {
;	IsWindowChildOf(aChild, aParent) {
;	EnumChildFindHwnd(aWnd, lParam) {
;	EnumChildFindPoint(aWnd, lParam) {
;	MsgBox(Message := "Press Ok to Continue.", Title := "", Type := 0, B1 := "", B2 := "", B3 := "", Time := "") {
;	InputBox1(Title, Prompt, Options := "") {
;	InputBox2(Title, Prompt, o := "") {
;	RunWaitOne(command) {
;	RunNoWaitOne(command) {
;	RunWaitMany(commands) {
;	RunDependent(target, workingdir:="", options:="", RunWait:=false){
;	GetRandom(p_Input,p_Delim="",p_Omit=""){
;	MsgBoxGetResult() {
;	Convert_OCR_Value(RSS_VAR_OLD) {
;	isEmptyOrEmptyStringsOnly(inputArray) {
;	DateAdd(DateTime, Time, TimeUnits)
;	DateDiff(DateTime1, DateTime2, TimeUnits)
;	FormatTime(YYYYMMDDHH24MISS:="", Format:="")
;	ClipBoard_Save() {
;	ClipBoard_Restore() {
;	Mouse_Save()  {
;	Mouse_Restore() {
;	Window_Save() {
;	Window_Restore() {
;	All_Save() {
;	All_Restore() {
;
; #####################################################################################

; ****************************************************************************
; ****************************************************************************
; allow users to use objects with the function and return the data they want.
; ****************************************************************************
; Examples:
; AppX := Win_GetInfo()
; MsgBox, 0, Win_GetInfo, % " Win_GetInfo " AppX.ID " " AppX.Class " " AppX.Title " " AppX.Ctrl
; or
; MsgBox, 0, Win_GetInfo, % " Win_GetInfo.X " Win_GetInfo().X " Win_GetInfo.Y " Win_GetInfo().Y
; ****************************************************************************
Win_GetInfo(App_Title:="", App_ID:="", App_Class:="", Options := ""){	; Win_GetInfo(Options := ""){
; SetTitleMatchMode, RegEx
	; MsgBox, 1. App_Title:"%App_Title%" FoundAppTitle:"%FoundAppTitle%" Get_App_Title:"%Get_App_Title%`nApp_ID:"%App_ID%" FoundAppID:"%FoundAppID%" Get_App_ID:"%Get_App_ID%"
	
	if (App_Title = FoundAppTitle)
		Get_App_Title := FoundAppTitle
	if (App_ID = FoundAppID)
		Get_App_ID = FoundAppID
	
	; MsgBox, 2. App_Title:"%App_Title%" FoundAppTitle:"%FoundAppTitle%" Get_App_Title:"%Get_App_Title%`nApp_ID:"%App_ID%" FoundAppID:"%FoundAppID%" Get_App_ID:"%Get_App_ID%"
			
	; Goal: to Get App ID
	; Was an App ID passed to function? If So, use it
	
	if !Get_App_ID
		if !Get_App_Title
			if !App_ID
				if !App_Title
					Get_App_ID := DllCall("GetParent", UInt,WinExist("A")), Get_App_ID := !Get_App_ID ? WinExist("A") : Get_App_ID
				Else
					Get_App_ID := Win_WaitRegEX(App_Title).ID
			Else
				Get_App_ID := App_ID
		Else
			Get_App_ID := Win_WaitRegEX(Get_App_Title).ID

	; MsgBox, 3. App_Title:"%App_Title%" FoundAppTitle:"%FoundAppTitle%" Get_App_Title:"%Get_App_Title%`nApp_ID:"%App_ID%" FoundAppID:"%FoundAppID%" Get_App_ID:"%Get_App_ID%"
	
	if !Get_App_ID
		Get_App_ID := DllCall("GetParent", UInt,WinExist("A")), Get_App_ID := !Get_App_ID ? WinExist("A") : Get_App_ID
	
	; MsgBox, 4. App_Title:"%App_Title%" FoundAppTitle:"%FoundAppTitle%" Get_App_Title:"%Get_App_Title%`nApp_ID:"%App_ID%" FoundAppID:"%FoundAppID%" Get_App_ID:"%Get_App_ID%"

	/*
	; old Openening
	if App_Title
		Get_App_ID := Win_WaitRegEX(App_Title).ID
	else if App_ID
		Get_App_ID := App_ID
	else
		Get_App_ID := DllCall("GetParent", UInt,WinExist("A")), Get_App_ID := !Get_App_ID ? WinExist("A") : Get_App_ID
	*/
	
	Get_Details_NOW:
	WinGetTitle, Get_App_Title, ahk_id %Get_App_ID%
	WinGetClass, Get_App_Class, ahk_id %Get_App_ID%
	WinGetPos, App_X, App_Y, App_W, App_H, %Get_App_ID%
	
	; MsgBox, 5. App_Title:"%App_Title%" FoundAppTitle:"%FoundAppTitle%" Get_App_Title:"%Get_App_Title%`nApp_ID:"%App_ID%" FoundAppID:"%FoundAppID%" Get_App_ID:"%Get_App_ID%"

	; if Get_App_Class, FoundAppClass := Get_App_Class
	; if Get_App_Title, FoundAppTitle := Get_App_Title
	; if Get_App_ID, FoundAppID := Get_App_ID

	Return {Title: Get_App_Title, ID: Get_App_ID, Class: Get_App_Class, X: App_X, Y: App_Y, W: App_W, H: App_H}

	; MsgBox, (Initial) Title:"%App_Title%" ID:"%App_ID%" Class:"%App_Class%" X:"%App_X%" Y:"%App_Y%" W:"%App_W%" H:"%App_H%"
}

IsWindowVisible(App_Title) {
	Get_App_ID := WinExist(App_Title)

	If( ErrorLevel != 0 ) {
		; MsgBox, Window %App_Title% not found!
		return -1
	}

	If( Get_App_ID > 0 ) {
		WinGetPos, App_X, App_Y, , , ahk_id %Get_App_ID%
		active_window_id_hwnd := WindowFromPoint(App_X, App_Y)

		; MsgBox, %App_X%, %App_Y%, %active_window_id_hwnd%
		If( active_window_id_hwnd = Get_App_ID ) {
			; MsgBox, Window %App_Title% is visible!
			return 1
		}
		else {
			; MsgBox, Window %App_Title% is NOT visible!
			return 0
		}
	}

	; MsgBox, Window %App_Title% not found!
	return -1
}

WindowFromPoint(x, y)
{
	VarSetCapacity(POINT, 8)
	Numput(x, POINT, 0, "int")
	Numput(y, POINT, 4, "int")
	return DllCall("WindowFromPoint", int64, NumGet(POINT, 0, "int64"))
	Return
}

; ****************************************************************************
; ****************************************************************************
; allow users to use objects with the function and return the data they want.
; ****************************************************************************
; Examples:
; Win_WaitRegEX("LEWZ")
; ****************************************************************************
Win_WaitRegEX(WW_Title="", WW_Text="", Timeout="", ExcludeTitle="", ExcludeText=""){
	SetTitleMatchMode, RegEx
	
	if (!WW_Title && !WW_Text)
	{
		MsgBox, 4, , empty!`nWW_Title:"%WW_Title%"`nWW_Text:"%WW_Text%" (4 Second Timeout & skip), 4
		return
	}
	
	; MsgBox, 1. Begin, Title REGEX:"%WW_Title%"`nTitle Get:"%Win_WaitGetTitle%"`nTitle Found:"%FoundAppTitle%"`nID Get:"%Win_WaitGetID%"`nID Found:"%FoundAppID%"
	; WinWait , WinTitle, WW_Text, Timeout, ExcludeTitle, ExcludeText

	WinWait, %WW_Title%, %WW_Text%, %Timeout%, %ExcludeTitle%, %ExcludeText% ; Waits until the specified window exists.
	if ErrorLevel
	{
		WW_Title := RegExReplace(WW_Title,"[^w]+")
		WinWait, %WW_Title%, %WW_Text%, %Timeout%, %ExcludeTitle%, %ExcludeText% ; Waits until the specified window exists.
		if ErrorLevel
			return 0
	}
	
	Window_Save()

	WinActivate, %WW_Title%, ; If not active, It activates it
	WinWaitActive, %WW_Title% ; Waits until the specified window is active or not active.
	WinGetTitle, Win_WaitGetTitle, A
	Win_WaitGetID := DllCall("GetParent", UInt,WinExist("A")), Win_WaitGetID := !Win_WaitGetID ? WinExist("A") : Win_WaitGetID

	; MsgBox, 2. Middle, Title REGEX:"%WW_Title%"`nTitle Get:"%Win_WaitGetTitle%"`nTitle Found:"%FoundAppTitle%"`nID Get:"%Win_WaitGetID%"`nID Found:"%FoundAppID%"

	if WW_Title is alnum
		if WinActive(%WW_Title%)
		{
			Win_WaitGetID := WinActive(%WW_Title%)
			WinGetTitle, Win_WaitGetTitle, ahk_id %Win_WaitGetID%
			WinActivate, ahk_id %Win_WaitGetID%, ; If not active, It activates it
			WinWaitActive, ahk_id %Win_WaitGetID% ; Waits until the specified window is active or not active.
		}
	
	Window_Restore()

	; MsgBox, 3. Finish, Title REGEX:"%WW_Title%"`nTitle Get:"%Win_WaitGetTitle%"`nTitle Found:"%FoundAppTitle%"`nID Get:"%Win_WaitGetID%"`nID Found:"%FoundAppID%"
	Return {Title: Win_WaitGetTitle, ID: Win_WaitGetID}
}

; ****************************************************************************
OLD_Win_WaitRegEX(WW_Title, WW_Text="", Timeout="", ExcludeTitle="", ExcludeText=""){
	SetTitleMatchMode, RegEx
	MsgBox, 1. Begin, Title(REGEX:"%WW_Title%" Get:"%Win_WaitGetTitle%" Found:"%FoundAppTitle%" ID(Get:"%Win_WaitGetID%" Found:"%FoundAppID%")
	; WinWait , WinTitle, WW_Text, Timeout, ExcludeTitle, ExcludeText
	WinWait, %WW_Title%, %WW_Text%, %Timeout%, %ExcludeTitle%, %ExcludeText% ; Waits until the specified window exists.
	If !WinActive(%WW_Title%) ; Checks if window exists and is currently active (foremost)
		WinActivate, %WW_Title% ; If not active, It activates it
	WinWaitActive, %WW_Title% ; Waits until the specified window is active or not active.
	Win_WaitGetID := WinActive(%WW_Title%), if !(Win_WaitGetID = 0), FoundAppID := Win_WaitGetID
	WinGetTitle, Win_WaitGetTitle, ahk_id %Win_WaitGetID%
	if !(Win_WaitGetTitle = "")
		FoundAppTitle := Win_WaitGetTitle

	MsgBox, 2. Finish, Title(REGEX:"%WW_Title%" Get:"%Win_WaitGetTitle%" Found:"%FoundAppTitle%" ID(Get:"%Win_WaitGetID%" Found:"%FoundAppID%"
	Return {Title: Win_WaitGetTitle, ID: Win_WaitGetID}
}

; ****************************************************************************
; ****************************************************************************
; allow users to use objects with the function and return the data they want.
; ****************************************************************************
; Examples:
; AppX := Control_GetInfo("Qt5QWindowIcon25", FoundAppTitle)
; MsgBox, 0, AppX, % " AppX " AppX.Text " " AppX.Hwnd " " AppX.X " " AppX.Y
; or
; MsgBox, 0, AppX, % " AppX.X " AppX().X " AppX.Y " AppX().Y
; ****************************************************************************
Control_GetInfo(Win_Control, Options := ""){
	App_Title := (Options.HasKey("Title")) ? Options.Title : WinTitle
	Win_ID := (Options.HasKey("ID")) ? Options.ID : DllCall("GetParent", UInt,WinExist(App_Title)), Win_ID := !Win_ID ? WinExist(App_Title) : Win_ID

	ControlGetText, Control_Text, %Win_Control%, ahk_id %Win_ID%
	ControlGet, Control_Hwnd, Hwnd,, %Win_Control%, ahk_id %Win_ID%
	ControlGet, Control_Visible, Visible,, %Win_Control%, ahk_id %Win_ID%
	ControlGet, Control_List, List,, %Win_Control%, ahk_id %Win_ID%
	ControlGetPos, Control_X, Control_Y, Control_Width, Control_Height, %Win_Control%, ahk_id %Win_ID%

	; MsgBox, (Initial) Text:"%Control_Text%" Hwnd:"%Control_Hwnd%" Visible:"%Control_Visible%" X:"%Control_X%" Y:"%Control_Y%" W:"%Control_Width%" H:"%Control_Height%"

	Return {Text: Control_Text, Hwnd: Control_Hwnd, Visible: Control_Visible, List: Control_List, X: Control_X, Y: Control_Y, W: Control_Width, H: Control_Height}
}

; example: Mouse_Click(199, 250, {Clicks: 2, Delay: 50, Wait: 500})
; examples: Mouse_Click(155,299, {Clicks: 2, Timeout: 300})
; Mouse_Click(100,1000, {Clicks: 2, Timeout: 0}) ; Click On Donation Box 1
; Mouse_Click(100,1000, {DownUp: Down, Timeout: 0})
; Mouse_Click(100,1000, {DownUp: Up, Timeout: 0})
Mouse_Click(X,Y, Options := "") {
	; generate a new random number between %rand_min% and %rand_max%
	Random, rand_wait, %rand_min%, %rand_max%
	Random, rand_pixel, %Min_Pix%, %Max_Pix%

	; Win_Control := FoundAppControl

	Win_Control := (Options.HasKey("Control")) ? Options.Control : FoundAppControl
	Win_Title := (Options.HasKey("Title")) ? Options.Title : FoundAppTitle
	Button := (Options.HasKey("Button")) ? Options.Button : "Left"
	Clicks := (Options.HasKey("Clicks")) ? Options.Clicks : "1"
	Timeout := (Options.HasKey("Timeout")) ? Options.Timeout : (3*Delay_Short+0)
	DownUp := (Options.HasKey("DownUp")) ? Options.DownUp : ""
	CoordModeRelativeTo := (Options.HasKey("RelativeTo")) ? Options.RelativeTo : "Client" ; "Window"
	CoordModeTargetType := (Options.HasKey("TargetType")) ? Options.TargetType : "Mouse"

	; CoordMode Mouse, Screen ; Coordinates are relative to the desktop (entire screen).
	; CoordMode Mouse, Relative ; Coordinates are relative to the active window.
	; CoordMode Mouse, Window ; Synonymous with Relative and recommended for clarity.
	; CoordMode Mouse, Client ; Coordinates are relative to the active window's client area, which excludes the window's title bar, menu (if it has a standard one) and borders. Client coordinates are less dependent on OS version and theme.
	CoordMode, %CoordModeTargetType%, %CoordModeRelativeTo%
	; msgbox, CoordMode`, %CoordModeTargetType%`, %CoordModeRelativeTo%

	; MsgBox, Timeout:"%Timeout%", Clicks:"%Clicks%"

	; MsgBox, 1. Mouse_Click input:(%X%:%Y%) initial:(%X_Pixel%:%Y_Pixel%) Rand_pixel:%rand_pixel% min-max(%Min_Pix%-%Max_Pix%)
	; X++
	; Y++
	X_Pixel := (X + rand_pixel + X_Pixel_offset)
	Y_Pixel := (Y + rand_pixel + Y_Pixel_offset)
	; SendEvent {Click, %X_Pixel%, %Y_Pixel%} ; Where to click
	; ControlClick, Control-or-Pos, WinTitle, WinText, WhichButton, ClickCount, Options, ExcludeTitle, ExcludeText
	; ControlClick, x%X_Pixel% y%Y_Pixel%, %FoundAppTitle%,,,, Pos NA
	; ControlClick, %Win_Control%, %FoundAppTitle%,, Left, 1, x%X_Pixel% y%Y_Pixel% NA
	; ControlClick, Qt5QWindowIcon, LEWZ001,, Left, 1, x%X_Pixel% y%Y_Pixel% NA

	SetControlDelay -1
	; if !DownUp
		ControlClick, %Win_Control%, %FoundAppTitle%,, %Button%, %Clicks%, x%X_Pixel% y%Y_Pixel% NA
	; else if (DownUp = "Down")
	; 	ControlClick, %Win_Control%, %FoundAppTitle%,, %Button%, %Clicks%, x%X_Pixel% y%Y_Pixel% NA D
	; else if (DownUp = "Up")
	; 	ControlClick, %Win_Control%, %FoundAppTitle%,, %Button%, %Clicks%, x%X_Pixel% y%Y_Pixel% NA U
		
	DllCall("Sleep","UInt",Timeout)		; DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
	GUI_Update()
	
	; stdout.WriteLine(A_NowUTC " Executing Mouse_Click for FoundAppTitle:""" FoundAppTitle """ Subroutine:""" Subroutine_Running """ at (" X_Pixel "," Y_Pixel ") = Input:(" X "," Y ") + rand_pixel:(" rand_pixel ") + Pixel_offset:(" X_Pixel_offset "," Y_Pixel_offset ")" )
	
	return

	; MsgBox, 3. Mouse_Click input:(%X%:%Y%) incremented:(%X_Pixel%:%Y_Pixel%) Rand_pixel:%rand_pixel% min-max(%Min_Pix%-%Max_Pix%)
	; MsgBox, ControlClick, %Win_Control%, %FoundAppTitle%,, %Button%, %Clicks%, x%X_Pixel% y%Y_Pixel% NA
	; MsgBox, Mouse_Click input:(%X%:%Y%) math:(%X_Pixel%:%Y_Pixel%) Rand_pixel:%rand_pixel% min-max(%Min_Pix%-%Max_Pix%) Ctr:"%Win_Control%" or "%FoundAppControl%" Title:"%FoundAppTitle%" Button:"%Button%" Clicks:"%Clicks%" Timeout:"%Timeout%"
	; stdout.WriteLine(A_NowUTC " Found " image_name " at " FoundPictureX "," FoundPictureY)
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; FileAppend, %A_NowUTC%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NowUTC%`r`n, %AppendCSVFile%
	
	return
}

Key_Menu() {
	Gui, Keys:New, , Keys
	Gui, Keys:Margin, 0, 0
	Gui, Keys:add,text,, F1 Switch App
	Gui, Keys:add,text,, F3 Quick Collect
	Gui, Keys:add,text,, F4 Exit Script
	Gui, Keys:add,text,, F6 Reload Script
	Gui, Keys:add,text,, CTRL+F6 Reload MEmu
	; Gui, Keys:add,text,, F7 Reset_Posit = %Resetting_Posit% ; or (%Resetting_Posit% ? "True" : "False")
	Gui, Keys:add,text,, % "F7 Reset_Posit = " (Resetting_Posit ? "Yes" : "No")
	Gui, Keys:add,text,, F9 Exit Subroutine
	Gui, Keys:add,text,, F10 Switch user
	Gui, Keys:add,text,, % "Pause Script = " (A_IsPaused ? "Yes" : "No")
	Gui, Keys:show, x731 y700 w150 h250

	; ; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; FileAppend, %A_NowUTC%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NowUTC%`r`n, %AppendCSVFile%
	return
}

GUI_Update() {

	if GUI_Count++>13
	{
		Gui, Status:new, , Status
		Gui, Status:Margin, 0, 0
		Gui, Status:add,text,, Account %User_Name%
		if (Subroutine_Running = A_ThisLabel)
			Gui, Status:add,text,, %Subroutine_Running% (%X_Pixel%,%Y_Pixel%)
		Else
			Gui, Status:add,text,, %Subroutine_Running%:%A_ThisLabel% (%X_Pixel%,%Y_Pixel%)
		Gui, Status:show, x731 y0 w350 h500
		GUI_Count := 0
	}

	if (Subroutine_Running = Last_Subroutine_Running)
	{
		; MsgBox, if equal: GUI_Count: %GUI_Count%, Subroutine_Running:%Subroutine_Running%, Last_Subroutine_Running: %Last_Subroutine_Running%
		GUI_Count--
	}
	Else
	{
		; MsgBox, else: GUI_Count: %GUI_Count%, Subroutine_Running:%Subroutine_Running%, Last_Subroutine_Running: %Last_Subroutine_Running%
		Last_Subroutine_Running := Subroutine_Running

		; Gui, Status:add,text,, Click %image_name%
		; Gui, Status:add,text,, Click %X_Pixel%, %Y_Pixel%
		
		if (Subroutine_Running = A_ThisLabel)
			Gui, Status:add,text,, %Subroutine_Running% (%X_Pixel%,%Y_Pixel%)
		Else
			Gui, Status:add,text,, %Subroutine_Running%:%A_ThisLabel% (%X_Pixel%,%Y_Pixel%)
		Gui, Status:show, x731 y0 w350 h500
	}
	return
}

; example: Mouse_Drag(199, 250, 150, 300, {EndMovement: F, SwipeTime: 500})
Mouse_Drag(X1, Y1, X2, Y2, Options := "") {
	Win_Control := (Options.HasKey("Control")) ? Options.Control : FoundAppControl
	Win_Title := (Options.HasKey("Title")) ? Options.Title : FoundAppTitle
	SwipeTime := (Options.HasKey("SwipeTime")) ? Options.SwipeTime : "1000"
	Timeout := (Options.HasKey("Timeout")) ? Options.Timeout : "0"
	EndMovement := (Options.HasKey("EndMovement")) ? Options.EndMovement : True
	CoordModeRelativeTo := (Options.HasKey("RelativeTo")) ? Options.RelativeTo : "Client" ; "Window"
	CoordModeTargetType := (Options.HasKey("TargetType")) ? Options.TargetType : "Mouse"

	; CoordMode Mouse, Screen ; Coordinates are relative to the desktop (entire screen).
	; CoordMode Mouse, Relative ; Coordinates are relative to the active window.
	; CoordMode Mouse, Window ; Synonymous with Relative and recommended for clarity.
	; CoordMode Mouse, Client ; Coordinates are relative to the active window's client area, which excludes the window's title bar, menu (if it has a standard one) and borders. Client coordinates are less dependent on OS version and theme.
	CoordMode, %CoordModeTargetType%, %CoordModeRelativeTo%

	Steps := 16
	X_Delta := (X2 - X1)
	Y_Delta := (Y2 - Y1)
	X_Step := round(X_Delta/Steps)+0 ; celi(number) ; round up, floor(number) ; round down
	Y_Step := round(Y_Delta/Steps)+0 ; celi(number) ; round up, floor(number) ; round down
	Move_X := X1
	Move_Y := Y1

	ControlClick, %Win_Control%, %FoundAppTitle%,,,, x%X1% y%Y1% D NA
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short))
	
	loop, %Steps%
	{
		Move_X += X_Step
		Move_Y += Y_Step
		Mouse_MoveControl(Move_X, Move_Y, Win_Control, Win_Title, "", "L K")
		DllCall("Sleep","UInt",(SwipeTime/Steps))
	}

	ControlClick, %Win_Control%, %FoundAppTitle%,,,, x%X2% y%Y2% U NA
	if !EndMovement
		return
		
	Steps /= 2
	loop, (%Steps%)
	{
		if (A_Index < (Steps/2))
		{
			Move_X += X_Step
			Move_Y += Y_Step
		}	
		if (A_Index >= (Steps/2))
		{
			Move_X -= X_Step
			Move_Y -= Y_Step
		}	
		if (Move_X <= 0)
			Move_X := X2
		if (Move_Y <= 0)
			Move_Y := Y2
		Mouse_MoveControl(Move_X, Move_Y, Win_Control, Win_Title, "", "L K")
		DllCall("Sleep","UInt",(SwipeTime/Steps))
	}

	return
}

; example: Mouse_Move(199, 250, 150, 300, {Wait: 500})
Mouse_Move(X1, Y1, X2, Y2, Options := "") {
	ClickCount := (Options.HasKey("Clicks")) ? Options.ClickCount : "1"
	ClickDelay := (Options.HasKey("Delay")) ? Options.ClickDelay : "0"
	ClickWait := (Options.HasKey("Wait")) ? Options.ClickWait : "0"
	CoordModeRelativeTo := (Options.HasKey("RelativeTo")) ? Options.RelativeTo : "Client" ; "Window"
	CoordModeTargetType := (Options.HasKey("TargetType")) ? Options.TargetType : "Mouse"

	; CoordMode Mouse, Screen ; Coordinates are relative to the desktop (entire screen).
	; CoordMode Mouse, Relative ; Coordinates are relative to the active window.
	; CoordMode Mouse, Window ; Synonymous with Relative and recommended for clarity.
	; CoordMode Mouse, Client ; Coordinates are relative to the active window's client area, which excludes the window's title bar, menu (if it has a standard one) and borders. Client coordinates are less dependent on OS version and theme.
	CoordMode, %CoordModeTargetType%, %CoordModeRelativeTo%

	return
}

; ****************************************************************************
; ****************************************************************************
; allow users to use objects with the function and return the data they want.
; ****************************************************************************
; Examples:
; Data := Mouse_GetPos()
; MsgBox, 0, Mouse_GetPos, % " Mouse_GetPos " Data.X " " Data.Y " " Data.Win " " Data.Ctrl
; or
; MsgBox, 0, Mouse_GetPos, % " Mouse_GetPos.X " Mouse_GetPos().X " Mouse_GetPos.Y " Mouse_GetPos().Y
; ****************************************************************************
Mouse_GetPos(Options := 3) {
	CoordModeRelativeTo := (Options.HasKey("RelativeTo")) ? Options.RelativeTo : "Client" ; "Window"
	CoordModeTargetType := (Options.HasKey("TargetType")) ? Options.TargetType : "Mouse"

	; CoordMode Mouse, Screen ; Coordinates are relative to the desktop (entire screen).
	; CoordMode Mouse, Relative ; Coordinates are relative to the active window.
	; CoordMode Mouse, Window ; Synonymous with Relative and recommended for clarity.
	; CoordMode Mouse, Client ; Coordinates are relative to the active window's client area, which excludes the window's title bar, menu (if it has a standard one) and borders. Client coordinates are less dependent on OS version and theme.
	CoordMode, %CoordModeTargetType%, %CoordModeRelativeTo%

	MouseGetPos, X, Y, Win, Ctrl, % Options
	Return {X: X, Y: Y, Win: Win, Ctrl: Ctrl}
}

; Accepts coords relative to the specified window.
; X and Y MUST be specified, since current actual mouse location is irrelevant.
; Control:
; This can be, ClassNN, the name/text of the control, or a control HWND
; (which must be a child of the target window.)
; If a control HWND is specified, X and Y will be relative to the target
; window, not the child control.
; Options:
; a string of letters (spaces are optional) indicating which buttons("LMR X1 X2")/keys("S C"=shift,control) should be considered pressed.
; K: use actual key state for Shift and Ctrl.
; Return value:
; The hwnd of the control which was sent the mousemove message.
; Pass this to the Control parameter to simulate mouse capture.
; Based on AutoHotkey::script2.cpp::ControlClick()
Mouse_MoveControl(X, Y, Control="", WinTitle="", WinText="", Options="", ExcludeTitle="", ExcludeText="", RelativeTo="Client", TargetType="Mouse") {
	CoordModeRelativeTo := (Options.HasKey("RelativeTo")) ? Options.RelativeTo : "Client" ; "Window"
	CoordModeTargetType := (Options.HasKey("TargetType")) ? Options.TargetType : "Mouse"

	; CoordMode Mouse, Screen ; Coordinates are relative to the desktop (entire screen).
	; CoordMode Mouse, Relative ; Coordinates are relative to the active window.
	; CoordMode Mouse, Window ; Synonymous with Relative and recommended for clarity.
	; CoordMode Mouse, Client ; Coordinates are relative to the active window's client area, which excludes the window's title bar, menu (if it has a standard one) and borders. Client coordinates are less dependent on OS version and theme.
	CoordMode, %CoordModeTargetType%, %CoordModeRelativeTo%

	; MsgBox, 1. WinTitle:"%WinTitle% Control:"%Control%" target_window:"%target_window%" X:"%X%" Y:"%Y%"
	static EnumChildFindPointProc=0
	if !EnumChildFindPointProc
		EnumChildFindPointProc := RegisterCallback("EnumChildFindPoint","Fast")

	if !(target_window := WinExist(WinTitle, WinText, ExcludeTitle, ExcludeText))
		return false
	if Control
	{
		if Control is integer
			Control_is_hwnd := IsWindowChildOf(Control, target_window)

		if Control_is_hwnd
		{
			; If %Control% specifies a control hwnd, send it the mouse move,
			; but use coords relative to the window specified by WinTitle.
			; This can be used to more easily simulate mouse capture.
			control_window := Control
			VarSetCapacity(rect, 16)
			DllCall("GetWindowRect","uint",target_window,"uint",&rect)
			VarSetCapacity(child_rect, 16)
			DllCall("GetWindowRect","uint",control_window,"uint",&child_rect)
			X -= NumGet(child_rect,0,"int") - NumGet(rect,0,"int")
			Y -= NumGet(child_rect,4,"int") - NumGet(rect,4,"int")
		}
		else
			ControlGet, control_window, Hwnd,, %Control%, ahk_id %target_window%
	}
	if (!control_window)
	{
		VarSetCapacity(rect, 16)
		DllCall("GetWindowRect","uint",target_window,"uint",&rect)
		VarSetCapacity(pah, 36, 0)
		NumPut(X + NumGet(rect,0,"int"), pah,0,"int")
		NumPut(Y + NumGet(rect,4,"int"), pah,4,"int")
		DllCall("EnumChildWindows","uint",target_window,"uint",EnumChildFindPointProc,"uint",&pah)
		control_window := NumGet(pah,24) ? NumGet(pah,24) : target_window
		DllCall("ScreenToClient","uint",control_window,"uint",&pah)
		X:=NumGet(pah,0,"int"), Y:=NumGet(pah,4,"int")
	}
	wParam :=  (InStr(Options,"L") ? 0x1 : 0) || (InStr(Options,"M") ? 0x10 : 0) || (InStr(Options,"R") ? 0x2 : 0)
			|| (InStr(Options,"X1") ? 0x20 : 0) || (InStr(Options,"X2") ? 0x40 : 0)
			|| (InStr(Options,"S") ? 0x4 : 0) || (InStr(Options,"C") ? 0x8 : 0)
			|| (InStr(Options,"K") ? (GetKeyState("Shift") ? 0x4:0)|(GetKeyState("Control") ? 0x8:0) : 0)
	PostMessage, 0x200, wParam, (x & 0xFFFF) | ((y & 0xFFFF)<<16),, ahk_id %control_window%
	return control_window
}

; example: Search_OCR("Wages")
; example: Search_OCR("Wages", {X1: 115, Y1: 30, W: 560, H: 75, Timeout: 8})
; example: Search_OCR(ArrayOfText, {X1: 115, Y1: 30, X2: 259, Y2: 60, Timeout: 1})
Search_OCR(OCR_Array, Options := "") {
	X1 := (Options.HasKey("X1")) ? Options.X1 : "115"
	Y1 := (Options.HasKey("Y1")) ? Options.Y1 : "30"
	W := (Options.HasKey("W")) ? Options.W : "560"
	H := (Options.HasKey("H")) ? Options.H : "75"
	X2 := (Options.HasKey("X2")) ? Options.X2 : (X1 + W)
	Y2 := (Options.HasKey("Y2")) ? Options.Y2 : (Y1 + H)
	Timeout := (Options.HasKey("Timeout")) ? Options.Timeout : "0"

	return
}

;window = target window, standard AHK window syntax works eg: ahk_id hwnd or just WinTitle
;files = list of files to be dropped
DropFiles(window, files*)
{
	for k,v in files
		memRequired+=StrLen(v)+1
	hGlobal := DllCall("GlobalAlloc", "uint", 0x42, "ptr", memRequired+21)
	dropfiles := DllCall("GlobalLock", "ptr", hGlobal)
	NumPut(offset := 20, dropfiles+0, 0, "uint")
	for k,v in files
		StrPut(v, dropfiles+offset, "utf-8"), offset+=StrLen(v)+1
	DllCall("GlobalUnlock", "ptr", hGlobal)
	PostMessage, 0x233, hGlobal, 0,, %window%
	if ErrorLevel
		DllCall("GlobalFree", "ptr", hGlobal)
}

; example: Search_Captured_Text_OCR(["Wages"], {Pos: [115, 30], Size: [560, 75], Timeout: 8})
Search_Captured_Text_OCR(Search_Text_Array, Options := "") {
	if (isEmptyOrEmptyStringsOnly(Search_Text_Array))
	{
		Timeout := 8
		goto Search_Captured_Text_MessageBox
	}

	Win_Control := (Options.HasKey("Control")) ? Options.Control : FoundAppControl
	Win_Title := (Options.HasKey("Title")) ? Options.Title : FoundAppTitle
	OCR_X1 := (Options.HasKey("Pos")) ? Options.Pos[1] : "200" ; "185" ; "115"
	OCR_Y1 := (Options.HasKey("Pos")) ? Options.Pos[2] : "40" ; "54" ; "30"
	OCR_W := (Options.HasKey("Size")) ? Options.Size[1] : "300" ; "450"	;  "560"
	OCR_H := (Options.HasKey("Size")) ? Options.Size[2] : "40" ; "28" ; "75"
	OCR_X2 := (OCR_X1 + OCR_W ) ; + X_Pixel_offset)
	OCR_Y2 := (OCR_Y1 + OCR_H ) ; + Y_Pixel_offset)
	Timeout := (Options.HasKey("Timeout")) ? Options.Timeout : 0 ; "8"

	Search_Captured_Text_Begin:
	; WinRestore, %FoundAppTitle%
	; PostMessage, 0x112, 0xF120,,, %FoundAppTitle%  ; 0x112 = WM_SYSCOMMAND, 0xF120 = SC_RESTORE
	; WinShow
	; if !WinActive(%FoundAppTitle%), WinActivate, %FoundAppTitle%
	; if WinExist(FoundAppTitle), WinRestore
	; ControlFocus, %FoundAppControl%, %FoundAppTitle%
	; if !IsWindowVisible(App_Title)
	;	Win_WaitRegEX(FoundAppTitle)

	/*
	is_visible := IsWindowVisible(FoundAppTitle)
	
	If( is_visible > 0 )
	{
		; MsgBox, Window %FoundAppTitle% is visible!
		; Win_WaitRegEX(FoundAppTitle)
		Sleep, 0
	}
	else If( is_visible < 0 )
	{
		; MsgBox, Window %FoundAppTitle% not found!
		return False
	}
	else
	{
		; MsgBox, Window %FoundAppTitle% is NOT visible!
		Win_WaitRegEX(FoundAppTitle)
	}
	*/

	; ClipBoard_Save()
	; Gosub Capture2Text_CLI
	; Gosub Capture2Text_EXE
	Capture_Screen_Text := OCR([OCR_X1, OCR_Y1, OCR_W, OCR_H], "eng")
	; ClipBoard_Restore()
	
	For index, value in Search_Text_Array
	{
		; MsgBox, %Subroutine_Running% (%OCR_X1%,%OCR_Y1%,%OCR_W%,%OCR_H%) index:"%index%"`nSearch:"%value%" `nFound:"%Capture_Screen_Text%"`nWin_Control:"%Win_Control%" FoundAppControl:"%FoundAppControl%" FoundAppTitle:"%FoundAppTitle%"
		if !( value == "" )
			If (RegExMatch(Capture_Screen_Text,value))
				Return {Found: True, Value: value, Text: Capture_Screen_Text} ; return 1
	}
	Goto Search_Captured_Text_END

	Search_Captured_Text_END:

	if (Timeout = 0)
		Return {Found: False, Value: False, Text: Capture_Screen_Text} ; return 0
		

	Search_Captured_Text_MessageBox:
	MsgBox, 4, , "%Search_Captured_Text%" not detected`, try again? (%Timeout% Second Timeout & skip), %Timeout%
	vRet := MsgBoxGetResult()
	if (vRet = "Timeout") || if (vRet = "No")
		Return {Found: False, Value: False, Text: Capture_Screen_Text} ; return 0
	if (vRet = "Yes")
		goto Search_Captured_Text_Begin

	; FileAppend, %A_NowUTC%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NowUTC%`r`n, %AppendCSVFile%
	Return {Found: False, Value: False, Text: Capture_Screen_Text} ; return 0
	
	/*
	; old Search captured text
	For index, value in Search_Text_Array
	{
		; MsgBox, (%OCR_X1%,%OCR_Y1%) (%OCR_W%,%OCR_H%) index:%index% value:%value% Capture_Screen_Text:%Capture_Screen_Text%
		if !( value == "" )
		{
			; MsgBox, Found index:%index% value:%value% Capture_Screen_Text:%Capture_Screen_Text%
			If (RegExMatch(Capture_Screen_Text,value))
				return 1
		}
		; else
			; MsgBox, NOTFound index:%index% value:%value% Capture_Screen_Text:%Capture_Screen_Text%
	}
	*/

	Capture2Text_CLI:
	{
		Capture2TextRUN := Capture2TextPATH . Capture2TextCLI
		Capture_Screen_Text := Clipboard := ""
		; Capture2Text_Coords := """" . OCR_X1 . " " . OCR_Y1 . " " . OCR_X2 . " " . OCR_Y2 . """"
		Capture2Text_Coords := OCR_X1 . " " . OCR_Y1 . " " . OCR_X2 . " " . OCR_Y2
		Run, %Capture2TextRUN% --screen-rect "%Capture2Text_Coords%" --clipboard
		ClipWait, 3
		Capture_Screen_Text := Clipboard
		return

		Process, Exist, %Capture2TextCLI% ; check to see if running
		If (ErrorLevel != 0) ; If is running, close
			Process, Close, %ErrorLevel%

		; full_command := "%Capture2TextRUN% --screen-rect %Capture2Text_Coords% --clipboard"
		full_command := Capture2TextRUN . " --screen-rect " . Capture2Text_Coords . "  --clipboard"
		; full_command := Capture2TextRUN . " --screen-rect " . Capture2Text_Coords

		Capture_Screen_Text := % RunWaitOne(full_command)
		; RunWait, %comspec% /c %full_command%, , hide
		; msgbox, 1. %ErrorLevel%: Capture_Screen_Text:"%Capture_Screen_Text%" Clipboard:"%Clipboard%"

		; DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
		Capture_Screen_Text := Clipboard

		; msgbox, 2. %ErrorLevel%: Capture_Screen_Text:"%Capture_Screen_Text%" Clipboard:"%Clipboard%"

		; Capture_Screen_Text := RunWaitOne(full_command)
		; msgbox, 2. Capture_Screen_Text:"%Capture_Screen_Text%" Clipboard:"%Clipboard%"
		; Capture_Screen_Text := Clipboard

		; MsgBox, runwait, %comspec% /c %full_command%
		return
	}

	Capture2Text_EXE:
	{
		Capture2TextRUN := Capture2TextPATH . Capture2TextEXE
		Capture_Screen_Text :=
		Process, Exist, %Capture2TextEXE% ; check to see if running
		If (ErrorLevel = 0) ; If not running
			RunWaitOne(Capture2TextRUN)

		Clipboard := ""
		; Sleep, 500
		Click, %OCR_X1%, %OCR_Y1%, 0
		; Sleep, 50

		Send, {LControl Down}{LAlt Down}{q}{LAlt Up}{LControl Up}
		; Sleep, 50

		Click, %OCR_X2%, %OCR_Y2%, 0
		Sleep, 100

		Send, {LControl Down}{LAlt Down}{q}{LAlt Up}{LControl Up}
		ClipWait, 3

		; MsgBox, 0, , %Clipboard%`n(%OCR_X1%,%OCR_Y1%) to (%OCR_X2%,%OCR_Y2%)
		Capture_Screen_Text := clipboard
		return
	}

	; Goto Search_Captured_Text_END

}

; example: Search_Pixels("OxFf4B2C", {X1: 115, Y1: 30, W: 560, H: 75, Timeout: 8})
; example: Search_Pixels(ArrayOfColors, {X1: 115, Y1: 30, X2: 259, Y2: 60, Timeout: 1})
Search_Pixels(Search_Pixels_Array, Options := "") {
	X1 := (Options.HasKey("X1")) ? Options.X1 : Client_Area_X1
	Y1 := (Options.HasKey("Y1")) ? Options.Y1 : Client_Area_W1
	W := (Options.HasKey("W")) ? Options.W : Client_Area_W
	H := (Options.HasKey("H")) ? Options.H : Client_Area_H
	X2 := (Options.HasKey("X2")) ? Options.X2 : Client_Area_X2
	Y2 := (Options.HasKey("Y2")) ? Options.Y2 : Client_Area_Y2
	Timeout := (Options.HasKey("Timeout")) ? Options.Timeout : "0"
	CoordModeRelativeTo := (Options.HasKey("RelativeTo")) ? Options.RelativeTo : "Client" ; "Window"
	CoordModeTargetType := (Options.HasKey("TargetType")) ? Options.TargetType : "Pixel"

	; CoordMode Pixel, Screen ; Coordinates are relative to the desktop (entire screen).
	; CoordMode Pixel, Relative ; Coordinates are relative to the active window.
	; CoordMode Pixel, Window ; Synonymous with Relative and recommended for clarity.
	; CoordMode Pixel, Client ; Coordinates are relative to the active window's client area, which excludes the window's title bar, menu (if it has a standard one) and borders. Client coordinates are less dependent on OS version and theme.
	CoordMode, %CoordModeTargetType%, %CoordModeRelativeTo%

	return
}

; example: Search_Images("OK_Button.jpg", {X1: 115, Y1: 30, W: 560, H: 75, Timeout: 8})
; example: Search_Images(ArrayOfImages, {X1: 115, Y1: 30, X2: 259, Y2: 60, Timeout: 1})
Search_Images(Search_Images_Array, Options := "") {
	X1 := (Options.HasKey("X1")) ? Options.X1 : Client_Area_X1
	Y1 := (Options.HasKey("Y1")) ? Options.Y1 : Client_Area_W1
	W := (Options.HasKey("W")) ? Options.W : Client_Area_W
	H := (Options.HasKey("H")) ? Options.H : Client_Area_H
	X2 := (Options.HasKey("X2")) ? Options.X2 : Client_Area_X2
	Y2 := (Options.HasKey("Y2")) ? Options.Y2 : Client_Area_Y2
	Timeout := (Options.HasKey("Timeout")) ? Options.Timeout : "0"
	CoordModeRelativeTo := (Options.HasKey("RelativeTo")) ? Options.RelativeTo : "Client" ; "Window"
	CoordModeTargetType := (Options.HasKey("TargetType")) ? Options.TargetType : "Pixel"

	; CoordMode Pixel, Screen ; Coordinates are relative to the desktop (entire screen).
	; CoordMode Pixel, Relative ; Coordinates are relative to the active window.
	; CoordMode Pixel, Window ; Synonymous with Relative and recommended for clarity.
	; CoordMode Pixel, Client ; Coordinates are relative to the active window's client area, which excludes the window's title bar, menu (if it has a standard one) and borders. Client coordinates are less dependent on OS version and theme.
	CoordMode, %CoordModeTargetType%, %CoordModeRelativeTo%

	return
}

; example: Command_To_Screen("UserName")
; example: Text_To_Diag("UserName")
; example: Text_To_CSV("UserName")
; example: Text_To_Log("UserName")
; example: Text_To_GUI("UserName")
; example: Text_To_Status("UserName")

; Example: Text_To_Log([FoundAppTitle,FoundAppClass,FoundAppControl,FoundAppProcess])

Text_To_Log(ByRef Input_Array)
{
	Output1 := Output2 := A_NowUTC ","
	For VAR,Val in Input_Array
	{
		if Val
			VAR_NAME := %Val%
		if VAR_NAME
			Output1 .= %VAR_NAME% . ","
			
			
		Output1 .= VAR . "," . %VAR% . "," . Val . "," . %Val% . ","
		Output2 .= &VAR . "," . &%VAR% . "," . &Val . "," . &%Val% . ","
		
		
		VAR_Contents2 := Val[A_Index] ; Val%A_Index%
		; Output1 .= VAR_NAME . ",""" . VAR_Contents1 . ""","
		; Output2 .= VAL_NAME . ",""" . VAR_Contents2 . ""","
		MsgBox, %A_Index%. VAR:Val"%VAR%:%Val%"`nVAR:Val"&%VAR%:&%Val%"`nNAME:"%VAR_NAME%"`nContents:"%VAR_Contents1%"`n1:%Output1%`n2:%Output2%
	}
	stdout.WriteLine("Output1," Output1)
	stdout.WriteLine("Output2," Output2)
	return
}


Command_To_Screen(Text_To_Send, Options := "") {
	Timeout := (Options.HasKey("Timeout")) ? Options.Timeout : "0"
	Win_Control := (Options.HasKey("Control")) ? Options.Control : FoundAppControl	; "ahk_parent"
	Win_Title := (Options.HasKey("Title")) ? Options.Title : FoundAppTitle
	
	ControlSend, %Win_Control%, %Text_To_Send%, %Win_Title%

	/*
	If (RegExMatch(Text_To_Send,"^[{}\!\^]+"))
	{
		ControlSend, %Win_Control%, %Text_To_Send%, %Win_Title%
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long))
		; MsgBox, ControlSend, %Win_Control%, %Text_To_Send%, %Win_Title%
	} Else {
		ClipBoard_Save()
		; ClipSave := Clipboard, Clipboard := ""
		Clipboard := Text_To_Send
		ClipWait, 3
		ControlSend, %Win_Control%, ^v, %Win_Title%
		ClipBoard_Restore()
		; Clipboard := ClipSave, ClipSave := ""
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long))
		; MsgBox, ControlSend, %Win_Control%, ^v, %Win_Title%
	}
	*/
	; Timeout += (StrLen(Text_To_Send) * 1+Delay_Micro)
	; DllCall("Sleep","UInt",Timeout+1) ; Sleep, 500
	return
}

Text_To_Screen(Text_To_Send, Options := "") {
	Timeout := (Options.HasKey("Timeout")) ? Options.Timeout : "0"
	Win_Control := (Options.HasKey("Control")) ? Options.Control : FoundAppControl	; "ahk_parent"
	Win_Title := (Options.HasKey("Title")) ? Options.Title : FoundAppTitle
	
	ClipBoard_Save()
	; ClipSave := Clipboard, Clipboard := ""
	Clipboard := Text_To_Send
	ClipWait, 3
	ControlSend, %Win_Control%, ^v, %Win_Title%
	ClipBoard_Restore()
	; Clipboard := ClipSave, ClipSave := ""
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long))
	; MsgBox, ControlSend, %Win_Control%, ^v, %Win_Title%

	; Timeout += (StrLen(Text_To_Send) * 1+Delay_Micro)
	; DllCall("Sleep","UInt",Timeout+1) ; Sleep, 500
	return
}

IsWindowChildOf(aChild, aParent) {
	static EnumChildFindHwndProc=0
	if !EnumChildFindHwndProc
		EnumChildFindHwndProc := RegisterCallback("EnumChildFindHwnd","Fast")
	VarSetCapacity(lParam,8,0), NumPut(aChild,lParam,0)
	DllCall("EnumChildWindows","uint",aParent,"uint",EnumChildFindHwndProc,"uint",&lParam)
	return NumGet(lParam,4)
}

EnumChildFindHwnd(aWnd, lParam) {
	if (aWnd = NumGet(lParam+0))
	{
		NumPut(1, lParam+4)
		return false
	}
	return true
}

; Ported from AutoHotkey::script2.cpp::EnumChildFindPoint()
EnumChildFindPoint(aWnd, lParam) {
	if !DllCall("IsWindowVisible","uint",aWnd)
		return true
	VarSetCapacity(rect, 16)
	if !DllCall("GetWindowRect","uint",aWnd,"uint",&rect)
		return true
	pt_x:=NumGet(lParam+0,0,"int"), pt_y:=NumGet(lParam+0,4,"int")
	rect_left:=NumGet(rect,0,"int"), rect_right:=NumGet(rect,8,"int")
	rect_top:=NumGet(rect,4,"int"), rect_bottom:=NumGet(rect,12,"int")
	if (pt_x >= rect_left && pt_x <= rect_right && pt_y >= rect_top && pt_y <= rect_bottom)
	{
		center_x := rect_left + (rect_right - rect_left) / 2
		center_y := rect_top + (rect_bottom - rect_top) / 2
		distance := Sqrt((pt_x-center_x)**2 + (pt_y-center_y)**2)
		update_it := !NumGet(lParam+24)
		if (!update_it)
		{
			rect_found_left:=NumGet(lParam+8,0,"int"), rect_found_right:=NumGet(lParam+8,8,"int")
			rect_found_top:=NumGet(lParam+8,4,"int"), rect_found_bottom:=NumGet(lParam+8,12,"int")
			if (rect_left >= rect_found_left && rect_right <= rect_found_right
				&& rect_top >= rect_found_top && rect_bottom <= rect_found_bottom)
				update_it := true
			else if (distance < NumGet(lParam+28,0,"double")
				&& (rect_found_left < rect_left || rect_found_right > rect_right
				 || rect_found_top < rect_top || rect_found_bottom > rect_bottom))
				 update_it := true
		}
		if (update_it)
		{
			NumPut(aWnd, lParam+24)
			DllCall("RtlMoveMemory","uint",lParam+8,"uint",&rect,"uint",16)
			NumPut(distance, lParam+28, 0, "double")
		}
	}
	return true
}

/*
Parameters:
		Message		- This parameter sets the Message of the message box.
			If Ommited 		- Can be blank to allow for a "pause" of the script by saying
							"Press Ok to Continue." Which forces a sleep on the script until the user has clicked a button.

		Title		- This parameter sets the Title of the message box.
			If Ommited		- Will set the title of the message box to be the script's name, or A_ScriptName

		Type			- This parameter sets the type of message box, 0 or just "Ok," 1 for "Ok" and "Cancel," so on and so forth
			If Ommited		- Will default to be 0 or just one button, "Ok."

		B1			- This parameter sets the first button's text in the message box.
			If Ommited		- Will Default to: "Ok"

		B2			- This parameter sets the second button text in the message box.
			If Ommited		- Will Default to: "Cancel"

		B3			- This parameter sets the third button text in the message box.
			If Ommited		- Will Default to: "Close"

		Time			- This parameter sets the timeout of the message box.
						- Allowing the script to continue if the user doesn't respond in time.
						- Returns ErrorLevel if the timeout reaches its time.
Example: MsgBox("Need Help?", "THE Question", 3, "&Yes", "&Definitely", "&Absolutely", 3)
Example: MsgBox("Would you like to place a shield? (Esc) to cancel", "Peace Shield", 3, "&3Day", "&24hour", "&8hour", 3)
*/
MsgBox(Message := "Press Ok to Continue.", Title := "", Type := 0, B1 := "", B2 := "", B3 := "", Time := "") {
	If (Title = "")
		Title := A_ScriptName
	If (B1 != "") || (B2 != "") || (B3 != "")
		SetTimer, ChangeButtonNames, 10
	MsgBox, % Type, % Title, % Message, % Time
	Return

	ChangeButtonNames:
		IfWinNotExist, %Title%
			Return
		SetTimer, ChangeButtonNames, off
		WinActivate, % Title
		ControlSetText, Button1, % (B1 = "") ? "Ok" : B1, % Title
		Try ControlSetText, Button2, % (B2 = "") ? "Cancel" : B2, % Title
		Try ControlSetText, Button3, % (B3 = "") ? "Close" : B3, % Title
	Return
}


; ****************************************************************************
; ****************************************************************************
; Function Parameters-Return Values
; ****************************************************************************
; examples:
; InputBox1("Title", "User Prompt", {Hide: False|True, Size: [600, 300], Pos: [700, 1000], Timeout: 10, Default: "Type here"})
; or
; MsgBox, 0, password, % "user_password " InputBox1("InputBox1.1"`, "Please input your password."`, {Hide:True,Size:[300,200],Pos:[700,1000],Timeout:10,Default:"Type here"})
; MsgBox, 0, password, user_password %user_password%
; or
; user_password := InputBox1("InputBox1.2", "Please input your password.", {Hide: False, Size: [600, 300], Pos: [700, 1000], Timeout: 10, Default: "password"})
; MsgBox, 0, password, user_password %user_password%
; ****************************************************************************
InputBox1(Title, Prompt, Options := "") {
	HIDE := (Options.HasKey("Hide") && Options.Hide = True) ? "HIDE" : ""
	Width := (Options.HasKey("Size")) ? Options.Size[1] : ""
	Height := (Options.HasKey("Size")) ? Options.Size[2] : ""
	X := (Options.HasKey("Pos")) ? Options.Pos[1] : ""
	Y := (Options.HasKey("Pos")) ? Options.Pos[2] : ""
	Locale := (Options.HasKey("Locale")) ? Options.Locale : ""
	Timeout := (Options.HasKey("Timeout")) ? Options.Timeout : ""
	Default := (Options.HasKey("Default")) ? Options.Default : ""
	InputBox, Out, % Title, % Prompt, % HIDE, % Width, % Height, % X, % Y, , % Timeout, % Default
	Return Out
}

; ****************************************************************************
; ****************************************************************************
; Function Parameters-Return Values - more Straightforward!
; ****************************************************************************
; example:
; InputBox2("Title", "User Prompt", {Input:"Show|Hide", Width:300, Height:150, x:700, y:1000, Timeout: 10, Default:"Type here"})
; or
; user_password := InputBox2("InputBox2.1", "Please input your password.", {Input:"Show", Width:300, Height:150, x:700, y:1000, Timeout: 10, Default:"Type here"})
; MsgBox, 0, password, user_password %user_password%
; ****************************************************************************
InputBox2(Title, Prompt, o := "") {
	InputBox, Out, % Title, % Prompt, % o["Input"], % o["Width"], % o["Height"], % o["X"], % o["Y"], , % o["Timeout"], % o["Default"]
	Return Out
}

RunWaitOne(command) {
	; WshShell object: http://msdn.microsoft.com/en-us/library/aew9yb99
	shell := ComObjCreate("WScript.Shell")
	; Execute a single command via cmd.exe
	exec := shell.Exec(ComSpec " /C " command)
	; Read and return the command's output
	return exec.StdOut.ReadAll()
}

RunNoWaitOne(command) {
	Run, %command%
	return
}

RunWaitMany(commands) {
	shell := ComObjCreate("WScript.Shell")
	; Open cmd.exe with echoing of commands disabled
	exec := shell.Exec(ComSpec " /Q /K echo off")
	; Send the commands to execute, separated by newline
	exec.StdIn.WriteLine(commands "`nexit")  ; Always exit at the end!
	; Read and return the output of all commands
	return exec.StdOut.ReadAll()
}

;Garbage Collector For Script Child Processes, All Of Which Are Killed If Script Exists For Any Reason...
RunDependent(target, workingdir:="", options:="", RunWait:=false){
	Try{
		If !RunWait
			Run, % target, % workingdir, % options, cPid
		Else
			RunWait, % target, % workingdir, % options, cPid
	}Catch
		Return
	sPid := DllCall("GetCurrentProcessId"), q := Chr(0x22)	;q = quote char
	If !A_IsCompiled{
		childMonitor := "Process Exist," sPid . "`nWhile ErrorLevel" . "`n{" . "`nsleep 100" . "`nProcess Exist," cPid . "`nIf !ErrorLevel" . "`nBreak" . "`nProcess Exist," sPid . "`n}" . "`nProcess Close," cPid
		,shell := ComObjCreate("WScript.Shell"),exec := shell.Exec("AutoHotkey.exe /ErrorStdOut *"),exec.StdIn.Write(childMonitor),exec.StdIn.Close()
	}Else{
		_exit := Comspec " /q /c for /L %n in (1,0,10) do (timeout /t 1 1>NUL && (tasklist /FI " q "PID eq "
		. sPid q " 2>NUL | find /I /N " q sPid  q " 1>NUL || TASKKILL /PID "
		. cPid " /F 2>NUL) & (tasklist /FI " q "PID eq " cPid q " 2>NUL | find /I /N " q cPid q " 1>NUL || exit))"
		Run % _exit,,Hide
	}
	Return cPid
}

GetRandom(p_Input,p_Delim="",p_Omit=""){
	StringSplit, loc_Array, p_Input, %p_Delim%, %p_Omit%
	If ( loc_Array0 < 2 )
		Return loc_Array1
	Random, loc_Rand, 1, %loc_Array0%
	Return loc_Array%loc_Rand%
}

MsgBoxGetResult() {
	Loop, Parse, % "Timeout,OK,Cancel,Yes,No,Abort,Ignore,Retry,Continue,TryAgain", % ","
		IfMsgBox, % vResult := A_LoopField
			break
	return vResult
}

; ****************************************************************************
; ****************************************************************************
; Converts Compact-Short numbers into Numeric Format, i.e. "100.5M" to "100,500,000"
; ****************************************************************************
; Examples:
; Convert_OCR_Value(Captures_RSS_Value)
; Convert_OCR_Value("100.5M")
; ****************************************************************************
Convert_OCR_Value(RSS_VAR_OLD) {
	RSS_VAR_OLD := % RegExReplace(RSS_VAR_OLD,"[^\d\.MKG]+")
	RSS_VAR_NEW := % RegExReplace(RSS_VAR_OLD,"[^\d\.]+")
	; MsgBox, BEGIN: RSS_VAR_OLD:%RSS_VAR_OLD% RSS_VAR_NEW:%RSS_VAR_NEW%

	If (RegExMatch(RSS_VAR_OLD,"[\d\.]+K"))
		RSS_VAR_NEW := (RSS_VAR_NEW * 1000)
	else If (RegExMatch(RSS_VAR_OLD,"[\d\.]+M"))
		RSS_VAR_NEW := (RSS_VAR_NEW * 1000000)
	else If (RegExMatch(RSS_VAR_OLD,"[\d\.]+G"))
		RSS_VAR_NEW := (RSS_VAR_NEW * 1000000000)
	else
		RSS_VAR_NEW := RSS_VAR_OLD

	; SetFormat Integer, %RSS_VAR_NEW%
	RSS_VAR_NEW := Format("{:u}",RSS_VAR_NEW)
	; MsgBox, END 1: RSS_VAR_OLD:%RSS_VAR_OLD% RSS_VAR_NEW:%RSS_VAR_NEW%

	; RSS_VAR_NEW := """" . RSS_VAR_NEW . """"

	; MsgBox, END 2: RSS_VAR_OLD:%RSS_VAR_OLD% RSS_VAR_NEW:%RSS_VAR_NEW%

	return RSS_VAR_NEW
}

Convert_Value(RSS_VAR_OLD) {
	RSS_VAR_OLD := % RegExReplace(RSS_VAR_OLD,"[^\d\.MKG]+")
	RSS_VAR_NEW := % RegExReplace(RSS_VAR_OLD,"[^\d\.]+")
	; MsgBox, BEGIN: RSS_VAR_OLD:%RSS_VAR_OLD% RSS_VAR_NEW:%RSS_VAR_NEW%
	; RSS_VAR_OLD := Format("{:.1f}",RSS_VAR_OLD)
	; RSS_VAR_NEW := Format("{:.1f}",RSS_VAR_NEW)

	if (StrLen(RSS_VAR_OLD) > 9)
		RSS_VAR_NEW := Format("{:.1f}",(RSS_VAR_OLD / 1000000000)) . "G"
	else if (StrLen(RSS_VAR_OLD) > 6)
		RSS_VAR_NEW := Format("{:.1f}",(RSS_VAR_OLD / 1000000)) . "M"
	else if (StrLen(RSS_VAR_OLD) > 3)
		RSS_VAR_NEW := Format("{:.1f}",(RSS_VAR_OLD / 1000)) . "K"
	else
		RSS_VAR_NEW := RSS_VAR_OLD

	; SetFormat Integer, %RSS_VAR_NEW%
	; RSS_VAR_NEW := Format("{:.1f}",RSS_VAR_NEW)
	; MsgBox, END 1: RSS_VAR_OLD:%RSS_VAR_OLD% RSS_VAR_NEW:%RSS_VAR_NEW%

	; RSS_VAR_NEW := """" . RSS_VAR_NEW . """"

	; MsgBox, END 2: RSS_VAR_OLD:%RSS_VAR_OLD% RSS_VAR_NEW:%RSS_VAR_NEW%

	return RSS_VAR_NEW
}

isEmptyOrEmptyStringsOnly(inputArray) {
	for index, value in inputArray
	{
		if !(value == "")
		{
			return false ; one of the values is not an empty string therefore the array is not empty or empty strings only
		}
	}
	return true ; all the values have passed the test or no values where inside the array
}

;commands as functions (AHK v2 functions for AHK v1) - AutoHotkey Community
;https://autohotkey.com/boards/viewtopic.php?f=37&t=29689

DateAdd(DateTime, Time, TimeUnits)
{
	EnvAdd, DateTime, % Time, % TimeUnits
	return DateTime
}
DateDiff(DateTime1, DateTime2, TimeUnits)
{
	EnvSub, DateTime1, % DateTime2, % TimeUnits
	return DateTime1
}
FormatTime(YYYYMMDDHH24MISS:="", Format:="")
{
	local OutputVar
	FormatTime, OutputVar, % YYYYMMDDHH24MISS, % Format
	return OutputVar
}

; Examples: 
; ClipBoard_Save(), ClipBoard_Restore()
; Mouse_Save(), Mouse_Restore()
; Window_Save(), Window_Restore()
; All_Save(), All_Restore()

ClipBoard_Save() {
	; Save clipboard contents:
	Global ClipSaved
	ClipSaved := ClipboardAll	; Save everything on the clipboard (such as pictures and formatting)
	Clipboard := ""				; Free the memory in case the clipboard was very large.
	return
}

ClipBoard_Restore() {
	; restore clipboard contents:
	Global ClipSaved
	Clipboard := ClipSaved   ; Restore the original clipboard. Note the use of Clipboard (not ClipboardAll).
	ClipWait, 3
	ClipSaved := ""   ; Free the memory in case the clipboard was very large.
	return
}

Mouse_Save()  {
	; Save mouse cursor position:
	Global SavedMouseX, SavedMouseY
	CoordMode, Mouse, screen					; relative to screen not window
	MouseGetPos, SavedMouseX, SavedMouseY		; Save initial position of mouse
	return
}

Mouse_Restore() {
	Global SavedMouseX, SavedMouseY
	; restore mouse cursor position :
	CoordMode, Mouse, screen					; relative to screen not window
	MouseMove, SavedMouseX, SavedMouseY, 10		; Restore original mouse position
	return
}

Window_Save() {
	Global SavedWinId
	; Global SavedWinIdFull
	; Save active window:
	WinGet, SavedWinId, ID, A					; Save current active window
	; SavedWinIdFull := "ahk_id " . SavedWinId
	return
}

Window_Restore() {
	Global SavedWinId
	; Global SavedWinIdFull
	; restore active window:
	if !WinActive("ahk_id " . SavedWinId), WinActivate ahk_id %SavedWinId%				; Restore original window
	return
}

All_Save() {
	ClipBoard_Save()
	Mouse_Save()
	Window_Save()			; Restore original window
	return
}

All_Restore() {
	ClipBoard_Restore()			;
	Mouse_Restore()				; Restore original mouse position
	Window_Restore()			; Restore original window
	return
}

Array_Gui(Array, Parent="") {                                                        	;-- shows your array as an interactive TreeView

		/*    	DESCRIPTION of function Array_Gui()
        	-------------------------------------------------------------------------------------------------------------------
			Description  	:	show your array as an interactive TreeView
			Link              	:	https://autohotkey.com/boards/viewtopic.php?f=6&t=35124&p=162012#p162012
			Author         	:	GeekDude
			Date             	:	28 Jul 2017, 09:43
			AHK-Version	:	AHK-V1, AHK_L
			License         	:
			Syntax          	:
			Parameter(s)	:
			Return value	:
			Remark(s)    	:
			Dependencies	:	none
			KeyWords    	:	array, gui, debug, treeview
        	-------------------------------------------------------------------------------------------------------------------
	*/

	/*    	EXAMPLE(s)

			Array_Gui({"Apples":["Red", "Crunchy", "Lumpy"], "Oranges":["Orange", "Squishy", "Spherical"]})

	*/

	if !Parent
	{
		Gui, +HwndDefault
		Gui, New, +HwndGuiArray +LabelGuiArray +Resize
		Gui, Margin, 5, 5
		Gui, Add, TreeView, w300 h200

		Item := TV_Add("Array", 0, "+Expand")
		Array_Gui(Array, Item)

		Gui, Show,, GuiArray
		Gui, %Default%:Default

		WinWait, ahk_id%GuiArray%
		WinWaitClose, ahk_id%GuiArray%
		return
	}

	For Key, Value in Array
	{
		Item := TV_Add(Key, Parent)
		if (IsObject(Value))
			Array_Gui(Value, Item)
		else
			TV_Add(Value, Item)
	}
	return

	GuiArrayClose:
	Gui, Destroy
	return

	GuiArraySize:
	GuiControl, Move, SysTreeView321, % "w" A_GuiWidth - 10 " h" A_GuiHeight - 10
	return
} ;</13.05.000011>

;-------------------------------------------------------------------------------
StrJoin(arr, byref del) { ; join the array with delimiters and return a string
;-------------------------------------------------------------------------------
    Result := ""
    for each, val in arr
        Result .= val del
    return RTrim(Result, del)
}