<<<<<<< Updated upstream
; #####################################################################################
; FUNCTIONS
; #####################################################################################
;
; find functions: ^[^\h][^\(\r\n\h]+\(
; or: ^([^\h\r\n\(]+\()
;
;	Win_GetInfo(App_Title:="", App_ID:="", App_Class:="", Options := ""){	; Win_GetInfo(Options := ""){
;	IsWindowVisible(App_Title) {
;	WindowFromPoint(x, y)
;	Win_WaitRegEX(Win_WaitRegEX_Title, WinText="", Timeout="", ExcludeTitle="", ExcludeText=""){
;	OLD_Win_WaitRegEX(Win_WaitRegEX_Title, WinText="", Timeout="", ExcludeTitle="", ExcludeText=""){
;	Control_GetInfo(Win_Control, Options := ""){
;	Mouse_Click(X,Y, Options := "") {
;	Mouse_Drag(X1, Y1, X2, Y2, Options := "") {
;	Mouse_Move(X1, Y1, X2, Y2, Options := "") {
;	Mouse_GetPos(Options := 3) {
;	Mouse_MoveControl(X, Y, Control="", WinTitle="", WinText="", Options="", ExcludeTitle="", ExcludeText="", RelativeTo="Client", TargetType="Mouse") {
;	Search_OCR(OCR_Array, Options := "") {
;	DropFiles(window, files*)
;	Search_Captured_Text_OCR(Search_Text_Array, Options := "") {
;	Search_Pixels(Search_Pixels_Array, Options := "") {
;	Search_Images(Search_Images_Array, Options := "") {
;	Text_To_Screen(Text_To_Send, Options := "") {
;	IsWindowChildOf(aChild, aParent) {
;	EnumChildFindHwnd(aWnd, lParam) {
;	EnumChildFindPoint(aWnd, lParam) {
;	InputBox1(Title, Prompt, Options := "") {
;	InputBox2(Title, Prompt, o := "") {
;	RunWaitOne(command) {
;	RunNoWaitOne(command) {
;	RunWaitMany(commands) {
;	GetRandom(p_Input,p_Delim="",p_Omit=""){
;	MsgBoxGetResult() {
;	Convert_OCR_Value(RSS_VAR_OLD) {
;	isEmptyOrEmptyStringsOnly(inputArray) {
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
Win_WaitRegEX(Win_WaitRegEX_Title, WinText="", Timeout="", ExcludeTitle="", ExcludeText=""){
	SetTitleMatchMode, RegEx
	; MsgBox, 1. Begin, Title REGEX:"%Win_WaitRegEX_Title%"`nTitle Get:"%Win_WaitGetTitle%"`nTitle Found:"%FoundAppTitle%"`nID Get:"%Win_WaitGetID%"`nID Found:"%FoundAppID%"
	; WinWait , WinTitle, WinText, Timeout, ExcludeTitle, ExcludeText

	WinWait, %Win_WaitRegEX_Title%, %WinText%, %Timeout%, %ExcludeTitle%, %ExcludeText% ; Waits until the specified window exists.
	if ErrorLevel
	{
		Win_WaitRegEX_Title := RegExReplace(Win_WaitRegEX_Title,"[^w]+")
		WinWait, %Win_WaitRegEX_Title%, %WinText%, %Timeout%, %ExcludeTitle%, %ExcludeText% ; Waits until the specified window exists.
		if ErrorLevel
			return 0
	}
	
	Window_Save()

	WinActivate, %Win_WaitRegEX_Title%, ; If not active, It activates it
	WinWaitActive, %Win_WaitRegEX_Title% ; Waits until the specified window is active or not active.
	WinGetTitle, Win_WaitGetTitle, A
	Win_WaitGetID := DllCall("GetParent", UInt,WinExist("A")), Win_WaitGetID := !Win_WaitGetID ? WinExist("A") : Win_WaitGetID

	; MsgBox, 2. Middle, Title REGEX:"%Win_WaitRegEX_Title%"`nTitle Get:"%Win_WaitGetTitle%"`nTitle Found:"%FoundAppTitle%"`nID Get:"%Win_WaitGetID%"`nID Found:"%FoundAppID%"

	if WinActive(%Win_WaitRegEX_Title%)
	{
		Win_WaitGetID := WinActive(%Win_WaitRegEX_Title%)
		WinGetTitle, Win_WaitGetTitle, ahk_id %Win_WaitGetID%
		WinActivate, ahk_id %Win_WaitGetID%, ; If not active, It activates it
		WinWaitActive, ahk_id %Win_WaitGetID% ; Waits until the specified window is active or not active.
	}
	
	Window_Restore()

	; MsgBox, 3. Finish, Title REGEX:"%Win_WaitRegEX_Title%"`nTitle Get:"%Win_WaitGetTitle%"`nTitle Found:"%FoundAppTitle%"`nID Get:"%Win_WaitGetID%"`nID Found:"%FoundAppID%"
	Return {Title: Win_WaitGetTitle, ID: Win_WaitGetID}
}

; ****************************************************************************
OLD_Win_WaitRegEX(Win_WaitRegEX_Title, WinText="", Timeout="", ExcludeTitle="", ExcludeText=""){
	SetTitleMatchMode, RegEx
	MsgBox, 1. Begin, Title(REGEX:"%Win_WaitRegEX_Title%" Get:"%Win_WaitGetTitle%" Found:"%FoundAppTitle%" ID(Get:"%Win_WaitGetID%" Found:"%FoundAppID%")
	; WinWait , WinTitle, WinText, Timeout, ExcludeTitle, ExcludeText
	WinWait, %Win_WaitRegEX_Title%, %WinText%, %Timeout%, %ExcludeTitle%, %ExcludeText% ; Waits until the specified window exists.
	If !WinActive(%Win_WaitRegEX_Title%) ; Checks if window exists and is currently active (foremost)
		WinActivate, %Win_WaitRegEX_Title% ; If not active, It activates it
	WinWaitActive, %Win_WaitRegEX_Title% ; Waits until the specified window is active or not active.
	Win_WaitGetID := WinActive(%Win_WaitRegEX_Title%), if !(Win_WaitGetID = 0), FoundAppID := Win_WaitGetID
	WinGetTitle, Win_WaitGetTitle, ahk_id %Win_WaitGetID%
	if !(Win_WaitGetTitle = "")
		FoundAppTitle := Win_WaitGetTitle

	MsgBox, 2. Finish, Title(REGEX:"%Win_WaitRegEX_Title%" Get:"%Win_WaitGetTitle%" Found:"%FoundAppTitle%" ID(Get:"%Win_WaitGetID%" Found:"%FoundAppID%"
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
	Timeout := (Options.HasKey("Timeout")) ? Options.Timeout : (rand_wait + (1*Delay_Short))
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
	
	stdout.WriteLine(A_Now " Executing Mouse_Click for FoundAppTitle " FoundAppTitle " Subroutine " Subroutine_Running " at " FoundPictureX "," FoundPictureY " (X,Y_Pixel: " X_Pixel "," Y_Pixel ") (rand_pixel: " rand_pixel ") (X,Y_Pixel_offset:" X_Pixel_offset "," Y_Pixel_offset ")" )
	
	return

	; MsgBox, 3. Mouse_Click input:(%X%:%Y%) incremented:(%X_Pixel%:%Y_Pixel%) Rand_pixel:%rand_pixel% min-max(%Min_Pix%-%Max_Pix%)
	; MsgBox, ControlClick, %Win_Control%, %FoundAppTitle%,, %Button%, %Clicks%, x%X_Pixel% y%Y_Pixel% NA
	; MsgBox, Mouse_Click input:(%X%:%Y%) math:(%X_Pixel%:%Y_Pixel%) Rand_pixel:%rand_pixel% min-max(%Min_Pix%-%Max_Pix%) Ctr:"%Win_Control%" or "%FoundAppControl%" Title:"%FoundAppTitle%" Button:"%Button%" Clicks:"%Clicks%" Timeout:"%Timeout%"
	; stdout.WriteLine(A_Now " Found " image_name " at " FoundPictureX "," FoundPictureY)
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	
	return
}

Key_Menu() {
	Gui, Keys:New, , Keys
	Gui, Keys:Margin, 0, 0
	Gui, Keys:add,text,, F1 Switch App
	Gui, Keys:add,text,, F3 Quick Collect
	Gui, Keys:add,text,, F4 Exit Script
	Gui, Keys:add,text,, F5 Reload MEmu
	Gui, Keys:add,text,, F6 Reload Script
	; Gui, Keys:add,text,, F7 Reset_Posit = %Resetting_Posit% ; or (%Resetting_Posit% ? "True" : "False")
	Gui, Keys:add,text,, % "F7 Reset_Posit = " (Resetting_Posit ? "Yes" : "No")
	Gui, Keys:add,text,, % "Pause Script = " (A_IsPaused ? "Yes" : "No")
	Gui, Keys:show, x731 y700 w150 h250

	; ; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

GUI_Update() {

	if GUI_Count++>13
	{
		Gui, Status:new, , Status
		Gui, Status:Margin, 0, 0
		Gui, Status:add,text,, Account %User_Name%
		if (Subroutine_Running = A_ThisLabel)
			Gui, Status:add,text,, Routine: %Subroutine_Running%
		Else
			Gui, Status:add,text,, Routine: %Subroutine_Running%:%A_ThisLabel%
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
			Gui, Status:add,text,, Routine: %Subroutine_Running% (%X_Pixel%,%Y_Pixel%)
		Else
			Gui, Status:add,text,, Routine: %Subroutine_Running%:%A_ThisLabel% (%X_Pixel%,%Y_Pixel%)
		Gui, Status:show, x731 y0 w350 h500
	}
	return
}

; example: Mouse_Drag(199, 250, 150, 300, {EndMovement: F, SwipeTime: 500})
Mouse_Drag(X1, Y1, X2, Y2, Options := "") {
	Win_Control := (Options.HasKey("Control")) ? Options.Control : FoundAppControl
	Win_Title := (Options.HasKey("Title")) ? Options.Title : FoundAppTitle
	SwipeTime := (Options.HasKey("SwipeTime")) ? Options.SwipeTime : "10"
	Timeout := (Options.HasKey("Timeout")) ? Options.Timeout : "0"
	EndMovement := (Options.HasKey("EndMovement")) ? Options.EndMovement : True
	CoordModeRelativeTo := (Options.HasKey("RelativeTo")) ? Options.RelativeTo : "Client" ; "Window"
	CoordModeTargetType := (Options.HasKey("TargetType")) ? Options.TargetType : "Mouse"

	; CoordMode Mouse, Screen ; Coordinates are relative to the desktop (entire screen).
	; CoordMode Mouse, Relative ; Coordinates are relative to the active window.
	; CoordMode Mouse, Window ; Synonymous with Relative and recommended for clarity.
	; CoordMode Mouse, Client ; Coordinates are relative to the active window's client area, which excludes the window's title bar, menu (if it has a standard one) and borders. Client coordinates are less dependent on OS version and theme.
	CoordMode, %CoordModeTargetType%, %CoordModeRelativeTo%

	X_Delta := (X2 - X1)
	Y_Delta := (Y2 - Y1)
	Move_X := X1
	Move_Y := Y1
	Steps := 16
	; FileAppend, %A_NOW%`,Down`,Move_X:`,%Move_X%`,Move_Y:`,%Move_Y%`,X1:`,%X1%`,Y1:`,%Y1%`,X2:`,%X2%`,Y2:`,%Y2%`n, %AppendCSVFile%

	/*
	ControlClick, %Win_Control%, %FoundAppTitle%,,,, x%X1% y%Y1% D NA
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long))
	ControlClick, %Win_Control%, %FoundAppTitle%,,,, x%X2% y%Y2% U NA
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long))
	MsgBox, Done
	*/

	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short))
	ControlClick, %Win_Control%, %FoundAppTitle%,,,, x%X1% y%Y1% D NA
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short))
	;Mouse_Click(X1,Y1, {DownUp: Down, Timeout: 0})
	loop, %Steps%
	{
		Move_X := Round(X1 + A_Index * (X_Delta/Steps))+0
		Move_Y := Round(Y1 + A_Index * (Y_Delta/Steps))+0
		; Mouse_MoveControl(Move_X, Move_Y, Win_Control, Win_Title)
		; Mouse_MoveControl(x, y, %Win_Control%, "ahk_id " %WinID%, "", "L K")
		Mouse_MoveControl(Move_X, Move_Y, Win_Control, Win_Title, "", "L K")
		DllCall("Sleep","UInt",(SwipeTime/Steps))
		; FileAppend, %A_NOW%`,Move`,Move_X:`,%Move_X%`,Move_Y:`,%Move_Y%`,X1:`,%X1%`,Y1:`,%Y1%`,X2:`,%X2%`,Y2:`,%Y2%`n, %AppendCSVFile%
	}
	

	; FileAppend, %A_NOW%`,UPup`,Move_X:`,%Move_X%`,Move_Y:`,%Move_Y%`,X1:`,%X1%`,Y1:`,%Y1%`,X2:`,%X2%`,Y2:`,%Y2%`n, %AppendCSVFile%
	; DllCall("Sleep","UInt",SwipeTime)
	ControlClick, %Win_Control%, %FoundAppTitle%,,,, x%X2% y%Y2% U NA
	if !EndMovement
		return
		
	;Mouse_Click(X2,Y2, {DownUp: Up, Timeout: 0})
	Steps /= 2
	loop, (%Steps%)
	{
		Move_X := Round(X2 - A_Index * (X_Delta/X_Delta))+0
		Move_Y := Round(Y2 - A_Index * (Y_Delta/Y_Delta))+0
		if (Move_X = 0)
			Move_X := X2
		if (Move_Y = 0)
			Move_Y := Y2
		; Mouse_MoveControl(Move_X, Move_Y, Win_Control, Win_Title)
		; Mouse_MoveControl(x, y, %Win_Control%, "ahk_id " %WinID%, "", "L K")
		Mouse_MoveControl(Move_X, Move_Y, Win_Control, Win_Title, "", "L K")
		DllCall("Sleep","UInt",(SwipeTime/Steps))
		; FileAppend, %A_NOW%`,Move`,Move_X:`,%Move_X%`,Move_Y:`,%Move_Y%`,X1:`,%X1%`,Y1:`,%Y1%`,X2:`,%X2%`,Y2:`,%Y2%`n, %AppendCSVFile%
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
	OCR_X1 := (Options.HasKey("Pos")) ? Options.Pos[1] : "125" ; "115"
	OCR_Y1 := (Options.HasKey("Pos")) ? Options.Pos[2] : "35" ; "30"
	OCR_W := (Options.HasKey("Size")) ? Options.Size[1] : "370" ; "450"	;  "560"
	OCR_H := (Options.HasKey("Size")) ? Options.Size[2] : "70" ; "75"
	OCR_X2 := (OCR_X1 + OCR_W ) ; + X_Pixel_offset)
	OCR_Y2 := (OCR_Y1 + OCR_H ) ; + Y_Pixel_offset)
	Timeout := (Options.HasKey("Timeout")) ? Options.Timeout : "8"

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

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
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
	X1 := (Options.HasKey("X1")) ? Options.X1 : GameArea_X1
	Y1 := (Options.HasKey("Y1")) ? Options.Y1 : GameArea_W1
	W := (Options.HasKey("W")) ? Options.W : GameArea_W
	H := (Options.HasKey("H")) ? Options.H : GameArea_H
	X2 := (Options.HasKey("X2")) ? Options.X2 : GameArea_X2
	Y2 := (Options.HasKey("Y2")) ? Options.Y2 : GameArea_Y2
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
	X1 := (Options.HasKey("X1")) ? Options.X1 : GameArea_X1
	Y1 := (Options.HasKey("Y1")) ? Options.Y1 : GameArea_W1
	W := (Options.HasKey("W")) ? Options.W : GameArea_W
	H := (Options.HasKey("H")) ? Options.H : GameArea_H
	X2 := (Options.HasKey("X2")) ? Options.X2 : GameArea_X2
	Y2 := (Options.HasKey("Y2")) ? Options.Y2 : GameArea_Y2
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

; example: Text_To_Screen("UserName")
; example: Text_To_Diag("UserName")
; example: Text_To_CSV("UserName")
; example: Text_To_Log("UserName")
; example: Text_To_GUI("UserName")
; example: Text_To_Status("UserName")

; Example: Text_To_Log([FoundAppTitle,FoundAppClass,FoundAppControl,FoundAppProcess])

Text_To_Log(ByRef Input_Array)
{
	Output1 := Output2 := A_Now ","
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


Text_To_Screen(Text_To_Send, Options := "") {
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
	Timeout += (StrLen(Text_To_Send) * 1+Delay_Micro)
	DllCall("Sleep","UInt",Timeout+1) ; Sleep, 500
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

	RSS_VAR_NEW := """" . RSS_VAR_NEW . """"

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
=======

Convert_OCR_Value(RSS_VAR_OLD)
{
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

	RSS_VAR_NEW := """" . RSS_VAR_NEW . """"

	; MsgBox, END 2: RSS_VAR_OLD:%RSS_VAR_OLD% RSS_VAR_NEW:%RSS_VAR_NEW%

	return RSS_VAR_NEW

}

isEmptyOrEmptyStringsOnly(inputArray)
{
	for index, value in inputArray
	{
		if !(value == "")
		{
			return false ; one of the values is not an empty string therefore the array is not empty or empty strings only
		}
	}
	return true ; all the values have passed the test or no values where inside the array
}

; example: Search_Captured_Text_OCR("Wages", {Pos: [115, 30], Size: [560, 75], Timeout: 8})
Search_Captured_Text_OCR(Search_Text_Array, Options := "") ; long version
{
	if (isEmptyOrEmptyStringsOnly(Search_Text_Array))
	{
		Timeout := 8
		goto Search_Captured_Text_MessageBox
	}

	OCR_Capture_X := (Options.HasKey("Pos")) ? Options.Pos[1] : "115"
	OCR_Capture_Y := (Options.HasKey("Pos")) ? Options.Pos[2] : "30"
	OCR_Capture_W := (Options.HasKey("Size")) ? Options.Size[1] : "560"
	OCR_Capture_H := (Options.HasKey("Size")) ? Options.Size[2] : "75"
	Timeout := (Options.HasKey("Timeout")) ? Options.Timeout : "8"
	OCR_X1 := OCR_Capture_X
	OCR_Y1 := OCR_Capture_Y
	OCR_X2 := (OCR_Capture_X + OCR_Capture_W)
	OCR_Y2 := (OCR_Capture_Y + OCR_Capture_H)

	Search_Captured_Text_Begin:
	ClipSaved := ClipboardAll
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; gosub Capture2Text_CLI
	; gosub Capture2Text_EXE
	Capture_Screen_Text := OCR([OCR_Capture_X, OCR_Capture_Y, OCR_Capture_W, OCR_Capture_H], "eng")
	For index, value in Search_Text_Array
	{
		; MsgBox, index:%index% value:%value% Capture_Screen_Text:%Capture_Screen_Text%
		if !( value == "" )
		{
			; MsgBox, Found index:%index% value:%value% Capture_Screen_Text:%Capture_Screen_Text%
			If (RegExMatch(Capture_Screen_Text,value))
				return 1
		}
		; else
			; MsgBox, NOTFound index:%index% value:%value% Capture_Screen_Text:%Capture_Screen_Text%
	}
	Goto Search_Captured_Text_END

	Capture2Text_CLI:
	{
		Capture2TextRUN := Capture2TextPATH . Capture2TextCLI
		Capture_Screen_Text := Clipboard := ""
		Capture2Text_Coords := """" . OCR_X1 . " " . OCR_Y1 . " " . OCR_X2 . " " . OCR_Y2 . """"
		Process, Exist, %Capture2TextCLI% ; check to see if running
		If (ErrorLevel != 0) ; If is running, close
			Process, Close, %ErrorLevel%

		; full_command := "%Capture2TextRUN% --screen-rect %Capture2Text_Coords% --clipboard"
		full_command := Capture2TextRUN . " --screen-rect " . Capture2Text_Coords . "  --clipboard"
		; full_command := Capture2TextRUN . " --screen-rect " . Capture2Text_Coords

		Capture_Screen_Text := % RunWaitOne(full_command)
		; RunWait, %comspec% /c %full_command%, , hide
		; msgbox, 1. %ErrorLevel%: Capture_Screen_Text:"%Capture_Screen_Text%" Clipboard:"%Clipboard%"

		; DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short))
		Capture_Screen_Text := Clipboard

		; msgbox, 2. %ErrorLevel%: Capture_Screen_Text:"%Capture_Screen_Text%" Clipboard:"%Clipboard%"

		; Capture_Screen_Text := RunWaitOne(full_command)
		; msgbox, 2. Capture_Screen_Text:"%Capture_Screen_Text%" Clipboard:"%Clipboard%"
		; Capture_Screen_Text := Clipboard

		; MsgBox, runwait, %comspec% /c %full_command%
		return
	}

	Capture2Text_EXE_old:
	{
		Capture2TextRUN := Capture2TextPATH . Capture2TextEXE
		Capture_Screen_Text :=
		Process, Exist, %Capture2TextEXE% ; check to see if running
		If (ErrorLevel = 0) ; If not running
			RunNoWaitOne(Capture2TextRUN)

		; MsgBox, ErrorLevel:%ErrorLevel% RunNoWaitOne(%Capture2TextRUN%)

		; 1. Position your mouse pointer at the top-left corner of the text that you want to OCR.
		SendEvent {Click, %OCR_X1%, %OCR_Y1%, 0}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro))

		; 2. Press the OCR hotkey (Windows Key + Q) to begin an OCR capture.
		; SendEvent, ^!Q
		; SendInput, ^!Q
		ControlSend, Qt5QWindowIcon38, ^!Q, LEWZ001
		; Control, EditPaste, ^!Q, Qt5QWindowIcon38, LEWZ001
		; ControlSetText, Qt5QWindowIcon38, ^!Q, LEWZ001

		; 3. Move your mouse to resize the blue capture box over the text that you want to OCR. You may hold down the right mouse button and drag to move the entire capture box.
		; SendEvent {Click, Down}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short))
		SendEvent {Click, %OCR_X2%, %OCR_Y2% Left, 1}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short))
		; SendEvent {Click, Up}
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro))

		; 4. Press the OCR hotkey again (or left-click or press ENTER) to complete the OCR capture. The OCR'd text will be placed in the clipboard and a popup showing the captured text will appear (the popup may be disabled in the settings).
		; SendEvent, #Q
		; SendInput, #Q
		; SendEvent, {Enter}
		; DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short))

		Capture_Screen_Text := %Clipboard%
		; msgbox, 1. Capture_Screen_Text:"%Capture_Screen_Text%" Clipboard:"%Clipboard%"
		return
	}

	Capture2Text_EXE:
	{
		Capture2TextRUN := Capture2TextPATH . Capture2TextEXE
		Process, Exist, %Capture2TextEXE% ; check to see if running
		If (ErrorLevel = 0) ; If not running
		{
			Run, %Capture2TextRUN%,,, PID
			; RunNoWaitOne(Capture2TextRUN)
			WinWait, ahk_pid %PID%  ; Wait for it to appear.
		}


		; Gosub Capture2Text_ControlSend
		; Gosub Capture2Text_Control
		; Gosub Capture2Text_ControlSetText
		Gosub Capture2Text_Send
		return

		Capture2Text_ControlSend:
		{
			Gosub, Move_Mouse_Start

			Sub_Name := "Capture2Text_ControlSend"
			ControlSend, Qt5QWindowIcon38, ^!Q, LEWZ001
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium))

			Gosub, Move_Mouse_Finish
			Return
		}

		Capture2Text_Control:
		{
			Gosub, Move_Mouse_Start

			Sub_Name := "Capture2Text_Control"
			Control, EditPaste, ^!Q, Qt5QWindowIcon38, LEWZ001
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium))

			Gosub, Move_Mouse_Finish
			Return
		}

		Capture2Text_ControlSetText:
		{
			Gosub, Move_Mouse_Start

			Sub_Name := "Capture2Text_ControlSetText"
			ControlSetText, Qt5QWindowIcon38, ^!Q, LEWZ001
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium))

			Gosub, Move_Mouse_Finish
			Return
		}

		Capture2Text_Send_old:
		{
			Gosub, Move_Mouse_Start

			Sub_Name := "Capture2Text_Send"
			Send, {Control Down}{Alt Down}
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro))
			Send, {q}
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro))
			Send, {Alt Up}{Control Up}
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium))

			Gosub, Move_Mouse_Finish
			Return
		}

		Capture2Text_Send:
		{
			Sub_Name := "Capture2Text_Send"
			Capture_Screen_Text :=
			clipboard := ""
			; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			MsgBox, 0, , (%OCR_X1%:%OCR_Y1%) to (%OCR_X2%:%OCR_Y2%)
			SendEvent {Click, %OCR_X1%, %OCR_Y1%, 0}

			Gosub Control_Alt_Q
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short))
			SendEvent {Click, %OCR_X2%, %OCR_Y2%)
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short))
			Gosub Control_Alt_Q
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium))
			ClipWait, 3
			Capture_Screen_Text := clipboard
			MsgBox, 0, , Sub_Name:%Sub_Name% Capture_Screen_Text:"%Capture_Screen_Text%" ClipBoard:"%ClipBoard%"
			Return
		}

		Control_Alt_Q:
		{
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long))
			SendInput, {Control Down}{Alt Down}
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short))
			SendInput, {q}
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short))
			SendInput, {Alt Up}{Control Up}
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long))
			Return
		}

		Move_Mouse_Start:
		{
			Capture_Screen_Text :=
			clipboard := ""
			WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			SendEvent {Click, %OCR_X1%, %OCR_Y1%, 0}
			Return
		}

		Move_Mouse_Finish:
		{
			; Click, %OCR_X2%, %OCR_Y2% Left, 1
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long))
			ClipWait, 3
			Capture_Screen_Text := clipboard
			MsgBox, 0, , Sub_Name:%Sub_Name% Capture_Screen_Text:"%Capture_Screen_Text%" ClipBoard:"%ClipBoard%"
			; Click, %OCR_X1%, %OCR_Y1%, 0
			Return
		}
		return
	}


	Search_Captured_Text_Begin_old:
	For index, value in Search_Text_Array
	{
		; MsgBox, index:%index% value:%value% Capture_Screen_Text:%Capture_Screen_Text%
		if !(value == "")
		{
			WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			Capture_Screen_Text := OCR([OCR_Capture_X, OCR_Capture_Y, OCR_Capture_W, OCR_Capture_H], "eng")
			; MsgBox, index:%index% value:%value% Capture_Screen_Text:%Capture_Screen_Text%
			If (RegExMatch(Capture_Screen_Text,value))
				return 1
		}
	}
	Goto Search_Captured_Text_END

	Search_Captured_Text_END:
	Clipboard := ClipSaved
	ClipSaved := ""

	if (Timeout = 0)
		return 0

	Search_Captured_Text_MessageBox:
	MsgBox, 4, , %Search_Captured_Text% not detected`, try again? (%Timeout% Second Timeout & skip), %Timeout%
	vRet := MsgBoxGetResult()
	if (vRet = "Timeout") || if (vRet = "No")
		return 0
	if (vRet = "Yes")
		goto Search_Captured_Text_Begin

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return 0
}

GetRandom(p_Input,p_Delim="",p_Omit="")
{
	StringSplit, loc_Array, p_Input, %p_Delim%, %p_Omit%
	If ( loc_Array0 < 2 )
		Return loc_Array1
	Random, loc_Rand, 1, %loc_Array0%
	Return loc_Array%loc_Rand%
}

MsgBoxGetResult()
{
	Loop, Parse, % "Timeout,OK,Cancel,Yes,No,Abort,Ignore,Retry,Continue,TryAgain", % ","
		IfMsgBox, % vResult := A_LoopField
			break
	return vResult
}

RunWaitOne(command)
{
    ; WshShell object: http://msdn.microsoft.com/en-us/library/aew9yb99
    shell := ComObjCreate("WScript.Shell")
    ; Execute a single command via cmd.exe
    exec := shell.Exec(ComSpec " /C " command)
    ; Read and return the command's output
    return exec.StdOut.ReadAll()
}

RunNoWaitOne(command)
{
    Run, %command%
    return
}

RunWaitMany(commands)
{
    shell := ComObjCreate("WScript.Shell")
    ; Open cmd.exe with echoing of commands disabled
    exec := shell.Exec(ComSpec " /Q /K echo off")
    ; Send the commands to execute, separated by newline
    exec.StdIn.WriteLine(commands "`nexit")  ; Always exit at the end!
    ; Read and return the output of all commands
    return exec.StdOut.ReadAll()
}

; examples: Mouse_Click(155,299, {Clicks: 2, Timeout: 300})
; Mouse_Click(100,1000, {Clicks: 2, Timeout: 0}) ; Click On Donation Box 1
Mouse_Click(X,Y, Options := "")
{
	; generate a new random number between %rand_min% and %rand_max%
	Random, rand_wait, %rand_min%, %rand_max%

	Clicks := (Options.HasKey("Clicks")) ? Options.Clicks : "1"
	Timeout := (Options.HasKey("Timeout")) ? Options.Timeout : ((rand_wait + 5*Delay_Short))
	; ; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; MsgBox, Timeout:"%Timeout%", Clicks:"%Clicks%"

	Random, rand_pixel, %Min_Pix%, %Max_Pix%
	; MsgBox, 1. Mouse_Click input:(%X%:%Y%) initial:(%X_Pixel%:%Y_Pixel%) Rand_pixel:%rand_pixel% min-max(%Min_Pix%-%Max_Pix%)
	X_Pixel := (X + rand_pixel + X_Pixel_offset)
	Y_Pixel := (Y + rand_pixel + Y_Pixel_offset)
	; SendEvent {Click, %X_Pixel%, %Y_Pixel%} ; Where to click
	; MsgBox, 3. Mouse_Click input:(%X%:%Y%) incremented:(%X_Pixel%:%Y_Pixel%) Rand_pixel:%rand_pixel% min-max(%Min_Pix%-%Max_Pix%)

	; ControlClick, Control-or-Pos, WinTitle, WinText, WhichButton, ClickCount, Options, ExcludeTitle, ExcludeText
	; ControlClick, x%X_Pixel% y%Y_Pixel%, %FoundAppTitle%,,,, Pos NA
	; ControlClick, Qt5QWindowIcon25, %FoundAppTitle%,, Left, 1, x%X_Pixel% y%Y_Pixel% NA
	; ControlClick, Qt5QWindowIcon25, LEWZ001,,,, x%X_Pixel% y%Y_Pixel% NA

	; ; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	SetControlDelay -1
	ControlClick, Qt5QWindowIcon25, %FoundAppTitle%,,,%Clicks%, x%X_Pixel% y%Y_Pixel% NA
	; ControlClick,, %FoundAppTitle%,,,%Clicks%, x%X_Pixel% y%Y_Pixel% NA
	DllCall("Sleep","UInt",Timeout)

	; MsgBox, Mouse_Click input:(%X%:%Y%) math:(%X_Pixel%:%Y_Pixel%) Rand_pixel:%rand_pixel% min-max(%Min_Pix%-%Max_Pix%) Clicks:"%Clicks%" Timeout:"%Timeout%"

	; DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short))

	if GUI_Count++>13
	{
		Gui, Status:new, , Status
		Gui, Status:Margin, 0, 0
		Gui, Status:add,text,, Account %User_Name%
		Gui, Status:add,text,, Routine: %Routine_Running%
		Gui, Status:show, x731 y0 w300 h500
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

		Gui, Status:add,text,, %Subroutine_Running% Running
		Gui, Status:show, x731 y0 w300 h500
	}

	stdout.WriteLine(A_Now " Executing Mouse_Click for FoundAppTitle " FoundAppTitle " Subroutine " Subroutine_Running " at " FoundPictureX "," FoundPictureY " (X,Y_Pixel: " X_Pixel "," Y_Pixel ") (rand_pixel: " rand_pixel ") (X,Y_Pixel_offset:" X_Pixel_offset "," Y_Pixel_offset ")" )

	; stdout.WriteLine(A_Now " Found " image_name " at " FoundPictureX "," FoundPictureY)

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
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
InputBox1(Title, Prompt, Options := "") ; long version
{
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
InputBox2(Title, Prompt, o := "")
{
	InputBox, Out, % Title, % Prompt, % o["Input"], % o["Width"], % o["Height"], % o["X"], % o["Y"], , % o["Timeout"], % o["Default"]
	Return Out
}

; ****************************************************************************
; ****************************************************************************
; allow users to use objects with the function and return the data they want.
; ****************************************************************************
; Examples:
; Data := MouseGetPos()
; MsgBox, 0, MouseGetPos, % " MouseGetPos " Data.X " " Data.Y " " Data.Win " " Data.Ctrl
; or
; MsgBox, 0, MouseGetPos, % " MouseGetPos.X " MouseGetPos().X " MouseGetPos.Y " MouseGetPos().Y
; ****************************************************************************
MouseGetPos(Options := 3)
{
	MouseGetPos, X, Y, Win, Ctrl, % Options
	Return {X: X, Y: Y, Win: Win, Ctrl: Ctrl}
}
>>>>>>> Stashed changes
