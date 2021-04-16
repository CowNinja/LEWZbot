; #NoEnv Recommended for performance and compatibility with future AutoHotkey releases, it disables environment variables.
; #Warn ; Enable warnings to assist with detecting common errors.
; default #MaxHotkeysPerInterval along with #HotkeyInterval will stop your script by showing message boxes if you have some kind of rapid autofire loop in it.
; ListLines and #KeyHistory are functions used to "log your keys". Disable them as they're only useful for debugging purposes.
; Setting an higher priority to a Windows program is supposed to improve its performance. Use AboveNormal/A. If you feel like it's making things worse, comment or remove this line.
; The default SetBatchLines value makes your script sleep 10 milliseconds every line. Make it -1 to not sleep (but remember to include at least one Sleep in your loops, if any!)
; Even though SendInput ignores SetKeyDelay, SetMouseDelay and SetDefaultMouseSpeed, having these delays at -1 improves SendEvent's speed just in case SendInput is not available and falls back to SendEvent.
; SetWinDelay and SetControlDelay may affect performance depending on the script.
; SendInput is the fastest send method. SendEvent (the default one) is 2nd place, SendPlay a far 3rd place (it's the most compatible one though). SendInput does not obey to SetKeyDelay, SetMouseDelay, SetDefaultMouseSpeed; there is no delay between keystrokes in that mode.

;OPTIMIZATIONS START
; #NoTrayIcon				; if you don't want a tray icon for this AutoHotkey program.
#SingleInstance force	; Skips the dialog box and replaces the old instance automatically
#NoEnv					; Recommended for performance and compatibility with future AutoHotkey releases.
						; disables environment variables
; #WinActivateForce
#Warn All, Off
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory 0
ListLines Off	; Omits subsequently-executed lines from the history.
; ListLines On	; Includes subsequently-executed lines in the history. This is the starting default for all scripts.
Process, Priority, , H
SetBatchLines, -1
SetKeyDelay, -1, 20 ; -1 ; default
SetMouseDelay, -1 ; -1 ; default
SetDefaultMouseSpeed, 0 ; 3 ; 0 ; Move the mouse SPEED.
SetWinDelay, -1 ; -1 ; default
SetControlDelay, -1 ; -1 ; default
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
;OPTIMIZATIONS END

EnvGet, USER_PROFILE, USERPROFILE
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
; SetWorkingDir, %USER_PROFILE%\Desktop\MEmu
; SetWorkingDir "C:\Users\CowNi\Desktop\MEmu"

#include <Vis2>
#include lib\CowNinja_Functions.ahk
; used inside some other script to run the function inside the main script:
SetTitleMatchMode 2
DetectHiddenWindows On
; Subroutine_Running := "Login_Password_PIN_Find"

/*
Search_Captured_Text := ["Enter","login","password"]
PIN_X := 190
PIN_Y := 250
PIN_W := 300
PIN_H := 50
OCR_PIN := Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [PIN_X, PIN_Y], Size: [PIN_W, PIN_H]})
*/
	
; Is PIN text present on Screen?
;	If true, return true
; 	If False, return False
loop
{
	if WinExist("LEWZbot_Script.ahk ahk_class AutoHotkey")
	{
		OCR_PIN := Search_Captured_Text_OCR(["Enter","login","password"], {Pos: [190, 250], Size: [300, 50]})
		if OCR_PIN.Found
			PostMessage, 0x5555, 1, 1  ; The message is sent to the "last found window" due to WinExist() above. if PIN text found
		Else
			PostMessage, 0x5555 ; The message is sent to the "last found window" due to WinExist() above. if PIN text NOT found
	}
}
DetectHiddenWindows Off  ; Must not be turned off until after PostMessage.