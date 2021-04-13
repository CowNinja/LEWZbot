- This is the current version of the code I'm presently running on my PC, which interacts with [MEMUplay android emulator](https://www.memuplay.com/download.html) running on a Windows PC. It reads in-game text using [Vis2](https://github.com/iseahound/Vis2) tesseract OCR to decide whether or not certain items have been loaded, and taps predefined coordinates accordingly.
- I would like to rewrite the code such that with each set of account credentials, the main program initiates separate child processes to connect to separate remote VM (Virtual Machines) using [adb Platform Tools](https://developer.android.com/studio/releases/platform-tools) commands, and each child process spawned would specifically execute the desired subroutines for each account. That's why I want to use many Android VM (Virtual Machines) running LEWZ simultaneously to rewrite the app to effectively manage an infinite number of accounts. The only limit will be the amount at any given time of Android virtual devices running.

## Goals (for proposed multithread idea):
- Ability to run and control multiple Android VM (Virtual Machines) concurrently via adb (Android debug bridge) over network.
  - Flowchart of Main_Program ideas (DRAFT):

![LEWZbot Main program FlowChart][]

[LEWZbot Main program FlowChart]: /Diagrams/LEWZbot_Main_Program.jpg "LEWZbot Main program FlowChart"

  - pseudo code outlining the idea in broad strokes:
```
; load list of account credentials into accounts_array
; load list of Android VM (Virtual Machine) ip and ports into VM_Array

for account in accounts_array ; loop through account
{
  credentials := {name:account[0], username:account[1], password:account[2], PIN:account[3]}
  Use_Available_VM(credentials)
}

Use_Available_VM(credentials)
{
  for VM in VM_Array : loop through VM_Array and find one that's not being used
    if (VM[0] = False) or if (VM.In_Use = False)
    {
      VM_Details := {In_Use:VM[0], name:VM[1], ip:VM[2], port:VM[3]}
      break loop
    }
  ; launch separate program thread using VM_Details and credentials
  run Threaded_Routine_Execution.ahk VM_Details credentials
  VM.In_Use = True ; Mark selected VM as in-use
  return VM_Details ; IP and port number of used virtual machine
}
```
  - Flowchart of Child_Process ideas (DRAFT):

![LEWZbot_Child_Process][]

[LEWZbot_Child_Process]: /Diagrams/LEWZbot_Child_Process.jpg "LEWZbot_Child_Process"

  - pseudo code outlining the idea in broad strokes:
```
Threaded_Routine_Execution.ahk
{
  log into retrieved account using available VM_Details
  Execute routines
  ; when finished notify main process that VM is available for another account
  VM_Details.In_Use = False
}
```
  - Flowchart of ScreenCap and OCR ideas (DRAFT):

![LEWZbot_ScreenCap_and_OCR][]

[LEWZbot_ScreenCap_and_OCR]: /Diagrams/LEWZbot_ScreenCap_and_OCR.jpg "LEWZbot_ScreenCap_and_OCR"

  - Flowchart of Go_Back_to_Home_Screen ideas (DRAFT):

![LEWZbot_Go_Back_to_Home_Screen][]

[LEWZbot_Go_Back_to_Home_Screen]: /Diagrams/LEWZbot_Go_Back_to_Home_Screen.jpg "LEWZbot_Go_Back_to_Home_Screen"

  - Flowchart of Quit_LEWZ and Launch_Lewz ideas (DRAFT):

![LEWZbot_Quit_LEWZ_and_Launch_Lewz][]

[LEWZbot_Quit_LEWZ_and_Launch_Lewz]: /Diagrams/LEWZbot_Quit_LEWZ_and_Launch_Lewz.jpg "LEWZbot_Quit_LEWZ_and_Launch_Lewz"

## Code to Flowchart progress:

### Main functions/subroutines imported from [LEWZbot_Script.ahk](LEWZbot_Script.ahk):
- [X] Launch_Lewz
- [X] Quit_LEWZ
- [ ] Reset_Posit
- [X] Go_Back_To_Home_Screen
- [ ] Switch_Account
- [ ] Login_Password_PIN_Enter()
- [ ] BruteForcePIN

### position Dependant subroutines:
- [ ] Peace_Shield
- [ ] Collect_Collisions
- [ ] Collect_Equipment_Crafting
- [ ] Collect_Recruits
- [ ] Collect_Runes
- [ ] Collect_Cafeteria
- [ ] Depot_Rewards
- [ ] Collect_Chips_Underground
- [ ] Adventure_Missions
- [ ] Train_Daily_Requirement
- [ ] Activity_Center_Wonder
- [ ] Golden_Chest

### NOT position Dependant subroutines:
- [ ] Speaker_Help
- [ ] Drop_Zone
- [ ] Benefits_Center
- [ ] Speaker_Help
- [ ] Active_Skill
- [ ] Donate_Tech
- [ ] VIP_Shop
- [ ] Mail_Collection
- [ ] Alliance_Boss
- [ ] Gather_Resources
- [ ] Reserve_Factory
- [ ] Desert_Oasis
- [ ] Gather_On_Base_RSS
- [ ] Alliance_Wages
- [ ] Get_Inventory
- [ ] Get_User_Info
- [ ] Get_User_Location
- [ ] Send_Mail_To_Boss
- [ ] Send_Message_In_Chat
- [ ] Base_Search_World_Map
- [ ] Get_Window_Geometry
- [ ] Check_Window_Geometry
- [ ] Collect_Red_Envelopes
- [ ] Refresh_LogFiles

### Additional functions imported from [CowNinja_Functions.ahk](lib/CowNinja_Functions.ahk):
- [ ] Win_GetInfo(App_Title:="", App_ID:="", App_Class:="", Options := "")
- [ ] IsWindowVisible(App_Title)
- [ ] WindowFromPoint(x, y)
- [ ] Win_WaitRegEX(Win_WaitRegEX_Title, WinText="", Timeout="", ExcludeTitle="", ExcludeText="")
- [ ] OLD_Win_WaitRegEX(Win_WaitRegEX_Title, WinText="", Timeout="", ExcludeTitle="", ExcludeText="")
- [ ] Control_GetInfo(Win_Control, Options := "")
- [ ] Mouse_Click(X,Y, Options := "")
- [ ] Key_Menu()
- [ ] GUI_Update()
- [ ] Mouse_Drag(X1, Y1, X2, Y2, Options := "")
- [ ] Mouse_Move(X1, Y1, X2, Y2, Options := "")
- [ ] Mouse_GetPos(Options := 3)
- [ ] Mouse_MoveControl(X, Y, Control="", WinTitle="", WinText="", Options="", ExcludeTitle="", ExcludeText="", RelativeTo="Client", TargetType="Mouse")
- [ ] Search_OCR(OCR_Array, Options := "")
- [ ] DropFiles(window, files*)
- [X] Search_Captured_Text_OCR(Search_Text_Array, Options := "")
- [ ] Search_Pixels(Search_Pixels_Array, Options := "")
- [ ] Search_Images(Search_Images_Array, Options := "")
- [ ] Text_To_Log(ByRef Input_Array)
- [ ] Text_To_Screen(Text_To_Send, Options := "")
- [ ] IsWindowChildOf(aChild, aParent)
- [ ] EnumChildFindHwnd(aWnd, lParam)
- [ ] EnumChildFindPoint(aWnd, lParam)
- [ ] MsgBox(Message := "Press Ok to Continue.", Title := "", Type := 0, B1 := "", B2 := "", B3 := "", Time := "")
- [ ] InputBox1(Title, Prompt, Options := "")
- [ ] InputBox2(Title, Prompt, o := "")
- [ ] RunWaitOne(command)
- [ ] RunNoWaitOne(command)
- [ ] RunWaitMany(commands)
- [ ] GetRandom(p_Input,p_Delim="",p_Omit="")
- [ ] MsgBoxGetResult()
- [ ] Convert_OCR_Value(RSS_VAR_OLD)
- [ ] isEmptyOrEmptyStringsOnly(inputArray)
- [ ] DateAdd(DateTime, Time, TimeUnits)
- [ ] DateDiff(DateTime1, DateTime2, TimeUnits)
- [ ] FormatTime(YYYYMMDDHH24MISS:="", Format:="")
- [ ] ClipBoard_Save()
- [ ] ClipBoard_Restore()
- [ ] Mouse_Save()
- [ ] Mouse_Restore()
- [ ] Window_Save()
- [ ] Window_Restore()
- [ ] All_Save()
- [ ] All_Restore()

## Real world examples:
### example of adb Commands used to connect to android device over network:
#### Connect to Android virtual machine via ADB over Network:
On the computer, start adb in tcpip mode: 
Command: `adb tcpip <port>` 
Example: `adb tcpip 5555`
#### Connect to your android device over network: 
Command: `adb connect <ip address of android phone>:<port>` 
Example: `adb connect 10.0.0.212:5555`

### [Android Tesseract OCR](https://github.com/yushulx/android-tesseract-ocr) how to implement a simple Android OCR application with Tesseract-OCR.
![image](http://www.codepool.biz/wp-content/uploads/2014/12/do_ocr_select.png)

### [adb-screenshot.sh](https://gist.github.com/hkurokawa/75b44564cc1491b5f4a2) A shell script to take a screen shot of the android device, resize it and copy to clipboard · GitHub
```
## This script is for taking a screen shot of an Android device.
## If possible, it tries to resize the image file and then copy to the clipboard.
##
## Note the script generates screenshot_yyyyMMddHHmmss.png and screenshot_yyyyMMddHHmmss_s.png
## under /sdcard on the device (you can specify another location with '-t' option)
## and copies it to the current working directory.
## 
## The script passes unrecognized arguments to adb command, which means you can specify "-e" or "-d"
## to select which device to take a screenshot of.
```

### [How to capture the screen as fast as possible through adb? - Stack Overflow](https://stackoverflow.com/questions/13984017/how-to-capture-the-screen-as-fast-as-possible-through-adb/27098784#27098784)
```
adb shell screencap /sdcard/mytmp/rock.raw
adb pull /sdcard/mytmp/rock.raw
adb shell rm /sdcard/mytmp/rock.raw

// remove the header
tail -c +13 rock.raw > rock.rgba

// extract width height and pixelformat:
hexdump -e '/4 "%d"' -s 0 -n 4 rock.raw
hexdump -e '/4 "%d"' -s 4 -n 4 rock.raw
hexdump -e '/4 "%d"' -s 8 -n 4 rock.raw

convert -size 480x800 -depth 8 rock.rgba rock.png
```

### Remotely control VM (Virtual Machines) running Android and push ADB shell commands via IP:
#### example by [james2doyle](https://gist.github.com/james2doyle): Use adb to swipe and take screenshots. Then use tesseract to OCR the images [abd-screen-ocr.sh](https://gist.github.com/james2doyle/69aed02241ab6cc4d2bdb4d818c19f27)
```
#!/usr/bin/env bash

# make sure to start your screen at the top
# 21 was the number of swipes to get to the bottom of my page
for i in `seq 1 21`;
do
  adb exec-out screencap -p > "screen$i.png"
  sleep 1
  # scroll "1300" each time
  adb shell input swipe 0 1300 300 300
  sleep 1
done

# then, OCR those images
for FILE in *.png
do
  tesseract $FILE stdout >> output.txt
done
```
#### example by [haideralipunjabi](https://github.com/haideralipunjabi) of running ADB over Network using python and solving Sudoku puzzles: [sudoku_automate](https://github.com/haideralipunjabi/sudoku_automate)
```
if __name__ == "__main__":
    # Connect the device using ADB
    device = adb.connect_device()
    # Take Screenshot of the screen and save it in screen.png
    adb.take_screenshot(device)
    image = Image.open('screen.png')
    image = process_image(image)        # Process the image for OCR
    org_grid = get_grid_from_image(image)      # Convert the Image to 2D list using OCR / Pytesseract
    solved_grid = deepcopy(org_grid)        # Deepcopy is used to prevent the function from modifying the original sudoku game
    solve_sudoku(solved_grid)
    automate_game(org_grid, solved_grid)        # Input the solved game into your device
```

## Current program checkList (current Windows version):
 [ ] parse out tap coordinates and turn them into variable arrays.
```
; existing code
Mouse_Click(290,405) ; Tap on base
Mouse_Click(359,487) ; Tap On City Buffs
Mouse_Click(302,235) ; Tap on Peace shield

; resulting in changes
Set_Tap_Coordinats:
{
   Tap_base := ["290","405"]
   Tap_CityBuffs := ["359","487"]
   Tap_Peace_Shield := ["302","235"]
}

Open_Peace_Shield:
{
   Mouse_Click(Tap_base)
   Mouse_Click(Tap_CityBuffs)
   Mouse_Click(Tap_Peace_Shield)
}
```
 [ ] Detect RenderWindow control dimensions inside MEMUplay.
   - Partially imlemented using 'Win_WaitRegEX()' function contained in [CowNinja_Functions.ahk](lib/CowNinja_Functions.ahk):
```
	global FoundAppClass := "Qt5QWindowIcon"
	global FoundAppControl := "Qt5QWindowIcon19" ; static set of which control is RenderWindow
	LEWZApp := Win_WaitRegEX(NewTitle)
	global FoundAppTitle := LEWZApp.title
	global FoundAppClass := LEWZApp.Class
	global FoundAppProcess := byref FoundAppControl
	global FoundAppID := LEWZApp.ID

	NewTitle := RegExReplace(FoundAppTitle,"[^A-Za-z0-9]+")
	WinSetTitle, %NewTitle%
```
   - Would like to implement using 'Control_GetInfo()' function as 'Control' and 'ClassNN' can change based on configuration of MEMUplay:
```
; AppX := Control_GetInfo("Qt5QWindowIcon", FoundAppTitle)
MsgBox, 0, AppX, % " AppX " AppX.Text " " AppX.Hwnd " " AppX.X " " AppX.Y
; or
MsgBox, 0, AppX, % " AppX.X " AppX().X " AppX.Y " AppX().Y
```

 [ ] Bilinear Interpolation For Data On A Rectangular Grid for stored coordinates to correspond to detected resolution changes, for example:
```
; Tap coordinates based on a fixed resolution
StoredApp_Width
StoredApp_Height
StoredTap_X
StoredTap_Y

; Get App_Window Height and Width
CurrentApp_Width
CurrentApp_Height
CurrentTap_X
CurrentTap_Y

; Calculate coordinate interpolation based on the new cursor position '(CurrentTap_X,CurrentTap_Y)', the stored position '(StoredTap_X,StoredTap_Y)',
; old window size '(StoredApp_Width,StoredApp_Height)', and the new window size '(CurrentApp_Width,CurrentApp_Height)'.
CurrentTap_X := ((StoredTap_X / StoredApp_Width) * CurrentApp_Width)
CurrentTap_Y := ((StoredTap_Y / StoredApp_Height) * CurrentApp_Height)
```

## Current Settings (current Windows version):
1. I've constrained the Android Client MEMUplay to run at a set resolution for now:
   - the size of the app window is defined in [LEWZ_SetDefaults.ahk](lib/LEWZ_SetDefaults.ahk):
```
; Define desired window position and size
Global App_Win_X := 0
Global App_Win_Y := 0
Global App_WinWidth := 730
Global App_WinHeight := 1249

; actual Game Area within MEMUplay:
; ClassNN: Qt5QWindowIcon19
; Text: RenderWindowWindow
; Client: x: 1 y: 32 w: 689 h: 1216
```
   - formatting the size and location of the window is implemented in [CowNinja_Functions.ahk](lib/CowNinja_Functions.ahk):
```
Check_Window_Geometry:
WinMove, %FoundAppTitle%, , App_Win_X, App_Win_Y, App_WinWidth, App_WinHeight ; Move the window preset coords
```
2. Account Credentials (Title,email,password,PIN are stored in seperated by commas) are retrieved from [LEWZ_User_Logins.ini](LEWZ_User_Logins.ini.example) in AHK directory and all account credentials are loaded into an array during execution of [LEWZ_SetDefaults.ahk](lib/LEWZ_SetDefaults.ahk).  :
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
   - [LEWZbot_Script.ahk](LEWZbot_Script.ahk) loads each set of account credentials and assigns corresponding values to global variables before moving to subroutines execution as follows:
```
; Switch User
For User,Val in User_Logins
{
	; Populate account variables from next keyed array item
	global User_Name := User
	global User_Email := Val[1]
	global User_Pass := Val[2]
	global User_PIN := Val[3]
```

## Notes:
- x and y coordinates are determined using OCR screen reader, when a found a text matches stored text strings in an array, then tap coordinates are calculated.
- 19FEB21 - Finally took the time to reprogram and fix my shielding routine, which calculates and auto shields Thursday 1900 through Sunday 1900.. the delays are due to reading the screen, converting via OCR to text, and responding accordingly. I haven't implemented multi-threading yet, which will enable concurrently running multiple instances simultaneously.
- 13FEB21 - my routines rely on specific sequences of events that I've figured out, calculated, and timed.. there are countermeasures in-game code to detect messing with the proprietary game data.. so it's very touchy

## Issues:
1. sometimes clicking on underground will result in the "welcome to level 20 underground area" dialog.. so I just have to develop the script to recognize the text on the screen and tap accordingly..

## More info:

### Tools Used:
1. [AutoHotkey](https://www.autohotkey.com/) in windows to interact with MEMUplay Android client. AutoHotKey is a free, open-source scripting language for Windows that allows users to easily create small to complex scripts for all kinds of tasks such as form fillers, auto-clicking, macros, etc.
   - [Vis2](https://github.com/iseahound/Vis2) Simple OCR using Tesseract by [iseahound](https://github.com/iseahound)
2. [MEMUplay android client](https://www.memuplay.com/download.html) runs android in a virtual machine where games are loaded and played using AutoHotKey script.
3. adb (Android debug bridge) will be utilized to remotely control Android VM (Virtual Machines) and is included in [Android SDK Platform Tools](https://developer.android.com/studio/releases/platform-tools).
4. [Notepad++](https://notepad-plus-plus.org/downloads/) is a free (as in “free speech” and also as in “free beer”) source code editor and Notepad replacement that supports several languages. Running in the MS Windows environment.
   - [Notepad++ for AutoHotkey](https://github.com/jNizM/ahk_notepad-plus-plus) formats AHK files in Notepad++.
5. [DrawExpress](https://drawexpress.com/) is a fast gesture-recognition diagram application. With DrawExpress, you can draw diagrams and flowcharts in a simple and intuitive way. 

### AutoHotKey
1. Great AutoHotkey technical source with example code [renenyffenegger AutoHotKey notes](https://renenyffenegger.ch/notes/tools/autohotkey/index)
2. Learn more about AutoHotkey: [The Magic of AutoHotkey, The Sharat's](https://sharats.me/posts/the-magic-of-autohotkey/)
3. [AutoHotkey Expression Examples: "" %% () and all that](https://daviddeley.com/autohotkey/xprxmp/autohotkey_expression_examples.htm), because I can never get them right, so I made this. These are all working examples.

### Code Examples:
1. [Connecting to Android Device with ADB over WiFi made (a little) easy](https://medium.com/@amanshuraikwar.in/connecting-to-android-device-with-adb-over-wifi-made-a-little-easy-39439d69b86b)
2. Article and step by step instructions for Python implementation of automatic Sudoku solving program: [Automating Android Games with Python & Pytesseract: Sudoku](https://blog.haideralipunjabi.com/posts/automating-android-game-with-python-pytesseract-sudoku/), by Haider Ali Punjabi, Level Up Coding.
