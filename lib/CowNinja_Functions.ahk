
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

	OCR_X := (Options.HasKey("Pos")) ? Options.Pos[1] : "115"
	OCR_Y := (Options.HasKey("Pos")) ? Options.Pos[2] : "30"
	OCR_W := (Options.HasKey("Size")) ? Options.Size[1] : "560"
	OCR_H := (Options.HasKey("Size")) ? Options.Size[2] : "75"
	Timeout := (Options.HasKey("Timeout")) ? Options.Timeout : "8"
	OCR_X1 := OCR_X
	OCR_Y1 := OCR_Y
	OCR_X2 := (OCR_X + OCR_W)
	OCR_Y2 := (OCR_Y + OCR_H)

	Search_Captured_Text_Begin:
	ClipSaved := ClipboardAll
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; gosub Capture2Text_CLI
	; gosub Capture2Text_EXE
	Capture_Screen_Text := OCR([OCR_X, OCR_Y, OCR_W, OCR_H], "eng")
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
	; ControlClick, Qt5QWindowIcon19, %FoundAppTitle%,, Left, 1, x%X_Pixel% y%Y_Pixel% NA
	; ControlClick, Qt5QWindowIcon19, LEWZ001,,,, x%X_Pixel% y%Y_Pixel% NA

	; ; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	SetControlDelay -1
	ControlClick, Qt5QWindowIcon19, %FoundAppTitle%,,,%Clicks%, x%X_Pixel% y%Y_Pixel% NA
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
