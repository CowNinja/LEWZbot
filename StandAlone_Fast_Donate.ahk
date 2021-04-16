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

; global App_Title := "(OLD_03_LEWZ)"
;global App_Title := "(LEWZ001)"
;global App_Title := "(LEWZ002)"
global App_Title := "(LEWZ003)"
global App_Control := "Qt5QWindowIcon19"
	
; F3::
; Macro1:
Loop
{
    Loop, 2
        Tap(420,970)

    Loop, 2
        Tap(250,970)
		
    Loop, 2
    {
        Tap(100,970)
        Tap(340,750)
    }
}

MsgBox, 3, Continue, Countinue donating?, 10
Return

Tap(x,y)
{
	ControlClick, %App_Control%, %App_Title%,, Left, 1,  x%x% y%y% NA
	Sleep, 30
	return
}


F4::ExitApp

Pause::Pause
