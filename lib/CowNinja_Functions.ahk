; #####################################################################################
; FUNCTIONS
; #####################################################################################
; 
; find functions: ^[^\h][^\(\r\n\h]+\(
; or: ^([^\h\r\n\(]+\()
; 
; Win_GetInfo(Options := "")
; Win_WaitRegEX(WinTitle, WinText="", Timeout="", ExcludeTitle="", ExcludeText="")
; Mouse_Click(X,Y, Options := "")
; Mouse_Drag(X1, Y1, X2, Y2, Options := "")
; Mouse_Move(X1, Y1, X2, Y2, Options := "")
; Mouse_GetPos(Options := 3)
; Mouse_MoveControl(X, Y, Control="", WinTitle="", WinText="", Options="", ExcludeTitle="", ExcludeText="")
; Search_OCR(Search_OCR_Array, Options := "")
; Search_Captured_Text_OCR(Search_Text_Array, Options := "")
; Search_Pixels(Search_Pixels_Array, Options := "")
; Search_Images(Search_Images_Array, Options := "")
; Text_To_Screen(Text_To_Send, Options := "")
; IsWindowChildOf(aChild, aParent)
; EnumChildFindHwnd(aWnd, lParam)
; EnumChildFindPoint(aWnd, lParam)
; InputBox1(Title, Prompt, Options := "")
; InputBox2(Title, Prompt, o := "")
; RunWaitOne(command)
; RunNoWaitOne(command)
; RunWaitMany(commands)
; GetRandom(p_Input,p_Delim="",p_Omit="")
; MsgBoxGetResult()
; Convert_OCR_Value(RSS_VAR_OLD)
; isEmptyOrEmptyStringsOnly(inputArray)
; 
; #####################################################################################


Global WinTitle
Global WinID
Global WinClass
Global FoundAppTitle
Global FoundAppClass
Global FoundAppID
Global WinControl

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
Win_GetInfo(Options := ""){
	Get_App_ID := DllCall("GetParent", UInt,WinExist("A")), Get_App_ID := !Get_App_ID ? WinExist("A") : Get_App_ID
	
	; Get_App_ID := WinActive(%Win_Title%)
	
	FoundAppID := Get_App_ID
    App_ID := (Options.HasKey("ID")) ? Options.ID : Get_App_ID
	WinGetClass, Get_App_Class, ahk_id %App_ID%
	WinGetTitle, Win_GetInfoTitle, ahk_id %App_ID%
    App_Class := (Options.HasKey("Class")) ? Options.Class : Get_App_Class
    App_Title := (Options.HasKey("Title")) ? Options.Title : Win_GetInfoTitle
	WinGetPos, App_X, App_Y, App_W, App_H, %App_ID%
	
	WinGetClass, Get_App_Class, ahk_id %App_ID%, if !(Get_App_Class = 0), FoundAppClass := Get_App_Class
	WinGetTitle, Win_GetInfoTitle, ahk_id %App_ID%, if !(Win_GetInfoTitle = 0), FoundAppTitle := Win_GetInfoTitle
	Return {Title: Win_GetInfoTitle, ID: Get_App_ID, Class: Get_App_Class, X: App_X, Y: App_Y, W: App_W, H: App_H}
	
	
	; MsgBox, (Initial) Title:"%App_Title%" ID:"%App_ID%" Class:"%App_Class%" X:"%App_X%" Y:"%App_Y%" W:"%App_W%" H:"%App_H%"
	
	Return {X: App_X, Y: App_Y, W: App_W, H: App_H, Class: App_Class, Title: App_Title, ID: App_ID}
}

IsWindowVisible(window_name) {
    ID := WinExist(window_name)

    If( ErrorLevel != 0 ) {
        ; MsgBox, Window %window_name% not found!
        return -1
    }

    If( ID > 0 ) {
        WinGetPos, X, Y, , , ahk_id %ID%
        active_window_id_hwnd := WindowFromPoint(X, Y)

        ; MsgBox, %X%, %Y%, %active_window_id_hwnd%
        If( active_window_id_hwnd = ID ) {
            ; MsgBox, Window %window_name% is visible!
            return 1
        }
        else {
            ; MsgBox, Window %window_name% is NOT visible!
            return 0
        }
    }

    ; MsgBox, Window %window_name% not found!
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
Mouse_Click(X,Y, Options := "") {
	; generate a new random number between %rand_min% and %rand_max%
	Random, rand_wait, %rand_min%, %rand_max%
	Random, rand_pixel, %Min_Pix%, %Max_Pix%
	
	; Win_Control := WinControl

	Win_Control := (Options.HasKey("Control")) ? Options.Control : WinControl
	Win_Title := (Options.HasKey("Title")) ? Options.Title : FoundAppTitle
	Button := (Options.HasKey("Button")) ? Options.Button : "Left"
	Clicks := (Options.HasKey("Clicks")) ? Options.Clicks : "1"
	Timeout := (Options.HasKey("Timeout")) ? Options.Timeout : (rand_wait + (5*Delay_Short))

	; MsgBox, Timeout:"%Timeout%", Clicks:"%Clicks%"

	; MsgBox, 1. Mouse_Click input:(%X%:%Y%) initial:(%X_Pixel%:%Y_Pixel%) Rand_pixel:%rand_pixel% min-max(%Min_Pix%-%Max_Pix%)
	; X++
	; Y++	
	X_Pixel := (X + rand_pixel + X_Pixel_offset)
	Y_Pixel := (Y + rand_pixel + Y_Pixel_offset)
	; SendEvent {Click, %X_Pixel%, %Y_Pixel%} ; Where to click
	; MsgBox, 3. Mouse_Click input:(%X%:%Y%) incremented:(%X_Pixel%:%Y_Pixel%) Rand_pixel:%rand_pixel% min-max(%Min_Pix%-%Max_Pix%)

	; ControlClick, Control-or-Pos, WinTitle, WinText, WhichButton, ClickCount, Options, ExcludeTitle, ExcludeText
	; ControlClick, x%X_Pixel% y%Y_Pixel%, %FoundAppTitle%,,,, Pos NA
	; ControlClick, %Win_Control%, %FoundAppTitle%,, Left, 1, x%X_Pixel% y%Y_Pixel% NA
	; ControlClick, Qt5QWindowIcon, LEWZ001,, Left, 1, x%X_Pixel% y%Y_Pixel% NA

	SetControlDelay -1
	ControlClick, %Win_Control%, %FoundAppTitle%,, %Button%, %Clicks%, x%X_Pixel% y%Y_Pixel% NA
	
	; MsgBox, ControlClick, %Win_Control%, %FoundAppTitle%,, %Button%, %Clicks%, x%X_Pixel% y%Y_Pixel% NA
	
	; %Win_Control% = RenderWindowWindow

	DllCall("Sleep","UInt",Timeout)

	; MsgBox, Mouse_Click input:(%X%:%Y%) math:(%X_Pixel%:%Y_Pixel%) Rand_pixel:%rand_pixel% min-max(%Min_Pix%-%Max_Pix%) Ctr:"%Win_Control%" or "%WinControl%" Title:"%FoundAppTitle%" Button:"%Button%" Clicks:"%Clicks%" Timeout:"%Timeout%"

	; DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))

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

		Gui, Status:add,text,, %Subroutine_Running% Running (%X_Pixel%,%Y_Pixel%)
		Gui, Status:show, x731 y0 w300 h500
	}

	stdout.WriteLine(A_Now " Executing Mouse_Click for FoundAppTitle " FoundAppTitle " Subroutine " Subroutine_Running " at " FoundPictureX "," FoundPictureY " (X,Y_Pixel: " X_Pixel "," Y_Pixel ") (rand_pixel: " rand_pixel ") (X,Y_Pixel_offset:" X_Pixel_offset "," Y_Pixel_offset ")" )

	; stdout.WriteLine(A_Now " Found " image_name " at " FoundPictureX "," FoundPictureY)

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

; example: Mouse_Drag(199, 250, 150, 300, {Wait: 500})
Mouse_Drag(X1, Y1, X2, Y2, Options := "") {
    ClickCount := (Options.HasKey("Clicks")) ? Options.ClickCount : "1"
    ClickDelay := (Options.HasKey("Delay")) ? Options.ClickDelay : "0"
    ClickWait := (Options.HasKey("Wait")) ? Options.ClickWait : "0"
    
    return
}

; example: Mouse_Move(199, 250, 150, 300, {Wait: 500})
Mouse_Move(X1, Y1, X2, Y2, Options := "") {
    ClickCount := (Options.HasKey("Clicks")) ? Options.ClickCount : "1"
    ClickDelay := (Options.HasKey("Delay")) ? Options.ClickDelay : "0"
    ClickWait := (Options.HasKey("Wait")) ? Options.ClickWait : "0"
    
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
Mouse_MoveControl(X, Y, Control="", WinTitle="", WinText="", Options="", ExcludeTitle="", ExcludeText="") {
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
Search_OCR(Search_OCR_Array, Options := "") {
    X1 := (Options.HasKey("X1")) ? Options.X1 : "115"
    Y1 := (Options.HasKey("Y1")) ? Options.Y1 : "30"    
    W := (Options.HasKey("W")) ? Options.W : "560"
    H := (Options.HasKey("H")) ? Options.H : "75"
    X2 := (Options.HasKey("X2")) ? Options.X2 : (X1 + W)
    Y2 := (Options.HasKey("Y2")) ? Options.Y2 : (Y1 + H)
    Timeout := (Options.HasKey("Timeout")) ? Options.Timeout : "0"
    
    return
}

; example: Search_Captured_Text_OCR("Wages", {Pos: [115, 30], Size: [560, 75], Timeout: 8}) 
Search_Captured_Text_OCR(Search_Text_Array, Options := "") {
	if (isEmptyOrEmptyStringsOnly(Search_Text_Array))
	{
		Timeout := 8
		goto Search_Captured_Text_MessageBox
	}
	
	OCR_X := (Options.HasKey("Pos")) ? Options.Pos[1] : "115"
	OCR_Y := (Options.HasKey("Pos")) ? Options.Pos[2] : "30"
	OCR_W := (Options.HasKey("Size")) ? Options.Size[1] : "560"
	OCR_H := (Options.HasKey("Size")) ? Options.Size[2] : "75"
	Timeout := (Options.HasKey("Timeout")) ? Options.Timeout : "8"
	OCR_X1 := OCR_X ; + X_Pixel_offset)
	OCR_Y1 := OCR_Y ; + Y_Pixel_offset)
	OCR_X2 := (OCR_X + OCR_W) ; + X_Pixel_offset)
	OCR_Y2 := (OCR_Y + OCR_H) ; + Y_Pixel_offset)
	OCR_W := OCR_W
	OCR_H := OCR_H
	
	Search_Captured_Text_Begin:
	ClipSaved := ClipboardAll
	; Gosub Capture2Text_CLI
	; Gosub Capture2Text_EXE
	; if !WinActive(%FoundAppTitle%), 
	; WinActivate, %FoundAppTitle%
	
	/*
	is_visible := IsWindowVisible(FoundAppTitle)

	If( is_visible > 0 )
	{
		MsgBox, Window %FoundAppTitle% is visible!
		Win_WaitRegEX(FoundAppTitle)
		Sleep, 1
	}
	else If( is_visible < 0 )
	{
		MsgBox, Window %FoundAppTitle% not found!
		return False
	}
	else 
	{
		MsgBox, Window %FoundAppTitle% is NOT visible!
		Win_WaitRegEX(FoundAppTitle)
	}
	*/
	
	; if !WinActive(%FoundAppTitle%), WinActivate, %FoundAppTitle%
	
	; if WinExist(FoundAppTitle), WinRestore
	Win_WaitRegEX(FoundAppTitle)
	; WinRestore, %FoundAppTitle%
	; PostMessage, 0x112, 0xF120,,, %FoundAppTitle%  ; 0x112 = WM_SYSCOMMAND, 0xF120 = SC_RESTORE
	; WinShow
	Capture_Screen_Text := OCR([OCR_X1, OCR_Y1, OCR_W, OCR_H], "eng")
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

		; DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
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
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))

		; 2. Press the OCR hotkey (Windows Key + Q) to begin an OCR capture.
		; SendEvent, ^!Q
		; Text_To_Screen("^!Q")
		Text_To_Screen("^!Q")
		; Control, EditPaste, ^!Q, Qt5QWindowIcon38, LEWZ001
		; ControlSetText, Qt5QWindowIcon38, ^!Q, LEWZ001
			
		; 3. Move your mouse to resize the blue capture box over the text that you want to OCR. You may hold down the right mouse button and drag to move the entire capture box.
		; SendEvent {Click, Down}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		SendEvent {Click, %OCR_X2%, %OCR_Y2% Left, 1}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		; SendEvent {Click, Up}
		; DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))

		; 4. Press the OCR hotkey again (or left-click or press ENTER) to complete the OCR capture. The OCR'd text will be placed in the clipboard and a popup showing the captured text will appear (the popup may be disabled in the settings).
		; SendEvent, #Q
		; Text_To_Screen("#Q")
		; SendEvent, {Enter}
		; DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
				
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
			Text_To_Screen("^!Q")
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
			
			Gosub, Move_Mouse_Finish
			Return
		}

		Capture2Text_Control:
		{
			Gosub, Move_Mouse_Start
			
			Sub_Name := "Capture2Text_Control"
			Control, EditPaste, ^!Q, Qt5QWindowIcon38, LEWZ001
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
			
			Gosub, Move_Mouse_Finish
			Return
		}

		Capture2Text_ControlSetText:
		{
			Gosub, Move_Mouse_Start
			
			Sub_Name := "Capture2Text_ControlSetText"
			ControlSetText, Qt5QWindowIcon38, ^!Q, LEWZ001
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
			
			Gosub, Move_Mouse_Finish
			Return
		}
		
		Capture2Text_Send_old:
		{
			Gosub, Move_Mouse_Start
			
			Sub_Name := "Capture2Text_Send"			
			Text_To_Screen("{Control Down}{Alt Down}")
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Text_To_Screen("{q}")
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Text_To_Screen("{Alt Up}{Control Up}")
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
			
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
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
			SendEvent {Click, %OCR_X2%, %OCR_Y2%}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
			Gosub Control_Alt_Q
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
			ClipWait, 3
			Capture_Screen_Text := clipboard
			MsgBox, 0, , Sub_Name:%Sub_Name% Capture_Screen_Text:"%Capture_Screen_Text%" ClipBoard:"%ClipBoard%"
			Return
		}
		
		Control_Alt_Q:
		{		
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
			Text_To_Screen("{Control Down}{Alt Down}")
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
			Text_To_Screen("{q}")
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
			Text_To_Screen("{Alt Up}{Control Up}")
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
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
			; DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
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
			Capture_Screen_Text := OCR([OCR_X, OCR_Y, OCR_W, OCR_H], "eng")
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
    
    return
}

; example: Text_To_Screen("UserName")
; example: Text_To_Diag("UserName")
; example: Text_To_CSV("UserName")
; example: Text_To_Log("UserName")
; example: Text_To_GUI("UserName")
; example: Text_To_Status("UserName")

Text_To_Screen(Text_To_Send, Options := "") {
    Timeout := (Options.HasKey("Timeout")) ? Options.Timeout : "0"
	
	ClipSave := Clipboard
	Clipboard := ""
	Clipboard := Text_To_Send
	ClipWait, 3
	ControlSend, ahk_parent, %Text_To_Send%, %FoundAppTitle%
	; ControlSend, ahk_parent, ^v, %FoundAppTitle%
	DllCall("Sleep","UInt",Timeout) ; Sleep, 500
	Clipboard := ClipSave
	ClipSave := ""
	
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


