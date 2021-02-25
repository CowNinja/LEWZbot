## Prerequisites:
1. You must be running MEMUplay android client:
   - https://www.memuplay.com/download.html
2. SDK Platform Tools (for adb functions)
   - https://developer.android.com/studio/releases/platform-tools

## Settings:
1. I've constrained the Android Client MEMUplay to run at a set resolution for now:
   - the size of the app window is defined in `LEWZ_SetDefaults.ahk`
```
; Define desired window position and size    
Global App_Win_X := 0
Global App_Win_Y := 0
Global App_WinWidth := 730
Global App_WinHeight := 1249
```
   - formatting the size and location of the window is executed in `CowNinja_Functions.ahk`
```
Check_Window_Geometry:
WinMove, %FoundAppTitle%, , App_Win_X, App_Win_Y, App_WinWidth, App_WinHeight ; Move the window preset coords
```
2. Account details are retrieved from LEWZ_User_Logins.ini in AHK directory and loaded into an array:
   - account credentials are loaded from file in `LEWZ_SetDefaults.ahk`
```
; load User Logins
User_Logins := {}
Loop, Read, LEWZ_User_Logins.ini
{
row := StrSplit(A_LoopReadLine, ",")
user := row[1]
row.RemoveAt(1)
User_Logins[user] := row
}
```

## Notes:
1. Since I run the Android inside an emulator, I have to use tesseract OCR screen recognition which reads the screen, extrapolates the text and figures out if a particular menu item has loaded or not and then it taps. I use the home screen as a point of reference, because you can hit back a million times and as soon as quit dialogue is displayed, it terminates the go back to home screen routine.
2. x and y coordinates are determined using ocr screen reader, when a found a text matches storex text strings in array, then tap coordinates are calculated.
3. 19FEB21 - Finally took the time to reprogram and fix my shielding routine, which calculates and auto shields Thursday 1900 through Sunday 1900.. the delays are due to reading the screen, converting via ocr to text and responding accordingly. I haven't implemented multi threading yet, which will enable concurrently running multiple instances simultaneously.
4. 13FEB21 - my routines rely on specific sequences of events that I've figured out, calculated and timed.. there are countermeasures in game code to detect messing with the proprietary game data.. so it's very touchy

## Goals:
1. Ability to run and control multiple Android virtual machines concurrently via ADB over network.
   - Connect to Android virtual machine via ADB over Network:
On computer, start adb in tcpip mode: 
Command: `adb tcpip <port>`
Example: `adb tcpip 5555`

   - Connect to your android device over network: 
Command: `adb connect <ip address of android phone>:<port>`
Example: `adb connect 10.0.0.212:5555`

2. Remotely control virtual machines running Android and push ADB shell commands via IP:
   - Use adb to swipe and take screenshots. Then use tesseract to OCR the images:
     - https://gist.github.com/james2doyle/69aed02241ab6cc4d2bdb4d818c19f27 

## Issues:
1. sometimes clicking on underground will result in the "welcome to level 20 underground area" dialog.. so I just have to develop the script to recognize the text on the screen and tap accordingly..

## Links:
2. Connecting  to Android Device with ADB over WiFi made (a little) easy:  https://medium.com/@amanshuraikwar.in/connecting-to-android-device-with-adb-over-wifi-made-a-little-easy-39439d69b86b


