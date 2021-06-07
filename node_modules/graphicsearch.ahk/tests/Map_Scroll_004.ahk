; This script was created using Pulover's Macro Creator
; www.macrocreator.com

#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Window
SendMode Input
#SingleInstance Force
SetTitleMatchMode 2
DetectHiddenText On
#; WinActivateForce
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1


loop
{
	sleep, 300
}
return

^1::
Macro1:
; WinActivate, MEmu ahk_class Qt5QWindowIcon ahk_exe MEmu.exe ahk_id 0x3821c10 ahk_pid 2928
ControlClick, , MEmu ahk_class Qt5QWindowIcon ahk_exe MEmu.exe ahk_id 0x3821c10 ahk_pid 2928,, Left, 1,  x422 y169 NA
; Sleep, 300

; WinActivate, MEmu ahk_class Qt5QWindowIcon ahk_exe MEmu.exe ahk_id 0x551cbc ahk_pid 14188
ControlClick, , MEmu ahk_class Qt5QWindowIcon ahk_exe MEmu.exe ahk_id 0x551cbc ahk_pid 14188,, Left, 1,  x422 y169 NA
; Sleep, 300

Return

^2::
Macro2:
; WinActivate, MEmu ahk_class Qt5QWindowIcon ahk_exe MEmu.exe ahk_id 0x3821c10 ahk_pid 2928
ControlClick, , MEmu ahk_class Qt5QWindowIcon ahk_exe MEmu.exe ahk_id 0x3821c10 ahk_pid 2928,, Left, 1,  x422 y169 NA
; Sleep, 300
; WinActivate, MEmu ahk_class Qt5QWindowIcon ahk_exe MEmu.exe ahk_id 0x551cbc ahk_pid 14188
ControlClick, , MEmu ahk_class Qt5QWindowIcon ahk_exe MEmu.exe ahk_id 0x551cbc ahk_pid 14188,, Left, 1,  x422 y169 NA
; Sleep, 300

loop, 10
{
	; WinActivate, LEWZ003 ahk_class Qt5QWindowIcon ahk_exe MEmu.exe ahk_id 0x301c4c ahk_pid 2928
	ControlClick, , LEWZ003 ahk_class Qt5QWindowIcon ahk_exe MEmu.exe ahk_id 0x301c4c ahk_pid 2928,, Left, 1,  x307 y529 NA
	; Sleep, 300
	; WinActivate, LEWZ004 ahk_class Qt5QWindowIcon ahk_exe MEmu.exe ahk_id 0x1401b9c ahk_pid 14188
	ControlClick, , LEWZ004 ahk_class Qt5QWindowIcon ahk_exe MEmu.exe ahk_id 0x1401b9c ahk_pid 14188,, Left, 1,  x307 y529 NA
	; Sleep, 300

	Sleep, 500
}

; Pause

Return


^3::ExitApp




/*

ControlClick, %Win_Control%, %FoundAppTitle%,, %Button%, %Clicks%, x%X_Pixel% y%Y_Pixel% NA

!	Alt
Note: Pressing a hotkey which includes Alt may result in extra simulated keystrokes (Ctrl by default). See #MenuMaskKey.
^	Ctrl
+	Shift
*/