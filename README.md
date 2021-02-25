Prerequisits:
1. You must be running MEMUplay android client:
	https://www.memuplay.com/download.html
	
Settings:
1. I've constrained the Android Client MEMUplay to run at a set resolution for now:
; LEWZ_SetDefaults.ahk
	; Define desired window position and size	
	Global App_Win_X := 0
	Global App_Win_Y := 0
	Global App_WinWidth := 730
	Global App_WinHeight := 1249
	
; CowNinja_Functions.ahk
Check_Window_Geometry:
	WinMove, %FoundAppTitle%, , App_Win_X, App_Win_Y, App_WinWidth, App_WinHeight ; Move the window preset coords

2. Account details are retrieved from LEWZ_User_Logins.ini in AHK directory and loaded into an array:
; LEWZ_SetDefaults.ahk
; load User Logins
User_Logins := {}
Loop, Read, LEWZ_User_Logins.ini
{
	row := StrSplit(A_LoopReadLine, ",")
	user := row[1]
	row.RemoveAt(1)
	User_Logins[user] := row
}

Notes:
Since I run the Android inside an emulator, I have to use tesseract OCR screen recognition which reads the screen, extrapolates the text and figures out if a particular menu item has loaded or not and then it taps. I use the home screen as a point of reference, because you can hit back a million times and as soon as quit dialogue is displayed, it terminates the go back to home screen routine.

x and y coordinates are determined using ocr screen reader, when a found a text matches storex text strings in array, then tap coordinates are calculated.

19FEB21 - Finally took the time to reprogram and fix my shielding routine, which calculates and auto shields Thursday 1900 through Sunday 1900.. the delays are due to reading the screen, converting via ocr to text and responding accordingly. I haven't implemented multi threading yet, which will enable concurrently running multiple instances simultaneously.

13FEB21 - my routines rely on specific sequences of events that I've figured out, calculated and timed.. there are countermeasures in game code to detect messing with the proprietary game data.. so it's very touchy

Goals:
1. Eventually I want to remotely control multiple virtual machines running Android and push ADB shell commands via IP.
A. On computer, start adb in tcpip mode:
Command: adb tcpip <port>
Example: adb tcpip 5555
B. Connect to your android device over network:
Command: adb connect <ip address of android phone>:<port> 
Example: adb connect 10.0.0.212:5555
2. Use adb to swipe and take screenshots. Then use tesseract to OCR the images:
https://gist.github.com/james2doyle/69aed02241ab6cc4d2bdb4d818c19f27

Issues:
- sometimes clicking on underground will result in the "welcome to level 20 underground area" dialog.. so I just have to develop the script to recognize the text on the screen and tapped accordingly..
