; This script was created using Pulover's Macro Creator
; www.macrocreator.com

#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Window
SendMode Input
#SingleInstance Force
SetTitleMatchMode 2
DetectHiddenText On
#WinActivateForce
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1

PID001 := 14404
Title001 := "LEWZ003"
PID002 := 6436
Title002 := "LEWZ004"

loop
{
	sleep, 300
}
return

Recorder_Click:
{		
	ControlClick, , MEmu ahk_pid %PID001%,, Left, 1,  x422 y169 NA
	ControlClick, , MEmu ahk_pid %PID002%,, Left, 1,  x422 y169 NA
	return
}

Map_Click:
{
	ControlClick, , %Title001% ahk_pid %PID001%,, Left, 1,  x307 y529 NA
	ControlClick, , %Title002% ahk_pid %PID002%,, Left, 1,  x307 y529 NA
	return
}

F1::
Macro1:
	gosub Recorder_Click
Return

F2::
Macro2:
	gosub Recorder_Click
	
	loop, 10
	{
		gosub Map_Click
		Sleep, 100
	}
Return


F4::ExitApp




/*

ControlClick, %Win_Control%, %FoundAppTitle%,, %Button%, %Clicks%, x%X_Pixel% y%Y_Pixel% NA
Mouse_Drag(200, 350, 332, 350, {EndMovement: F, SwipeTime: 100})


Mouse_Drag(555,455,50,700, {EndMovement: F, SwipeTime: 500})

!	Alt
Note: Pressing a hotkey which includes Alt may result in extra simulated keystrokes (Ctrl by default). See #MenuMaskKey.
^	Ctrl
+	Shift
*/

; example: Mouse_Click(199, 250, {Clicks: 2, Delay: 50, Wait: 500})
; examples: Mouse_Click(155,299, {Clicks: 2, Timeout: 300})
; Mouse_Click(100,1000, {Clicks: 2, Timeout: 0}) ; Click On Donation Box 1
; Mouse_Click(100,1000, {Title: LEWZ003}) ; Click On Donation Box 1
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
	; GUI_Update()
	
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