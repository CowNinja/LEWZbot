## Tools Used:
1. [AutoHotkey](https://www.autohotkey.com/) in windows to interact with MEMUplay Android client. AutoHotKey is a free, open-source scripting language for Windows that allows users to easily create small to complex scripts for all kinds of tasks such as: form fillers, auto-clicking, macros, etc.
2. AutoHotKey script interacts with [MEMUplay android client](https://www.memuplay.com/download.html).
3. adb (Android debug bridge) will be utilized to remotely control Android virtual machines and is included in [Android SDK Platform Tools](https://developer.android.com/studio/releases/platform-tools).
4. Simple OCR using Tesseract [iseahound](https://github.com/iseahound)/[Vis2](https://github.com/iseahound/Vis2)

## Settings:
1. I've constrained the Android Client MEMUplay to run at a set resolution for now:
   - the size of the app window is defined in [LEWZ_SetDefaults.ahk](lib/LEWZ_SetDefaults.ahk):
```
; Define desired window position and size    
Global App_Win_X := 0
Global App_Win_Y := 0
Global App_WinWidth := 730
Global App_WinHeight := 1249
```
   - formatting the size and location of the window is implemented in [CowNinja_Functions.ahk](lib/CowNinja_Functions.ahk):
```
Check_Window_Geometry:
WinMove, %FoundAppTitle%, , App_Win_X, App_Win_Y, App_WinWidth, App_WinHeight ; Move the window preset coords
```
2. Account details are retrieved from LEWZ_User_Logins.ini in AHK directory and loaded into an array:
   - all account credentials are loaded from file in [LEWZ_SetDefaults.ahk](lib/LEWZ_SetDefaults.ahk):
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
   - example by [james2doyle](https://gist.github.com/james2doyle): Use adb to swipe and take screenshots. Then use tesseract to OCR the images [abd-screen-ocr.sh](https://gist.github.com/james2doyle/69aed02241ab6cc4d2bdb4d818c19f27)
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
   - example of running ADB over Network using python and solving Sudoku puzzles by [haideralipunjabi](https://github.com/haideralipunjabi)/[sudoku_automate](https://github.com/haideralipunjabi/sudoku_automate)
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

## Issues:
1. sometimes clicking on underground will result in the "welcome to level 20 underground area" dialog.. so I just have to develop the script to recognize the text on the screen and tap accordingly..

## More info:
1. [Connecting to Android Device with ADB over WiFi made (a little) easy](https://medium.com/@amanshuraikwar.in/connecting-to-android-device-with-adb-over-wifi-made-a-little-easy-39439d69b86b)
2. Great AutoHotkey technical source with example code[renenyffenegger AutoHotKey notes](https://renenyffenegger.ch/notes/tools/autohotkey/index)
3. Learn more about AutoHotkey: [The Magic of AutoHotkey, The Sharat's](https://sharats.me/posts/the-magic-of-autohotkey/)
4. Article and step by step instructions for Python implementation of automatic Sudoku solving program: [Automating Android Games with Python & Pytesseract: Sudoku | by Haider Ali Punjabi | Level Up Coding](https://blog.haideralipunjabi.com/posts/automating-android-game-with-python-pytesseract-sudoku/)
   - GitHub repository: 
