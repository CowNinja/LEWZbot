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
#include lib\LEWZ_SetDefaults.ahk
#Include %A_ScriptDir%\node_modules
#Include graphicsearch.ahk\export.ahk
; #Include %A_ScriptDir%\node_modules\json.ahk\export.ahk
; #Include json.ahk\export.ahk
#Include unit-testing.ahk\export.ahk

; #include lib\WindowListMenu_mod_004.ahk
; #include lib\LEWZ_Functions.ahk
; #include lib\LEWZ_Functions_1057_mod_002.ahk
; #include <Gdip_All>
; #include <SnapOCR>

; ********** Main program begins here **********
; MsgBox, Found: %FoundAppTitle%, Pause (pause/resume) F4 (Exit)
; If WinExist("MEmu") or WinExist("MEmu") or WinExist("MEmu.exe") or WinExist("MEmu.exe")
while WinExist(FoundAppTitle)
{
	Gosub Elivate_program
	; If WinExist(FoundAppTitle)
	main_program:
	loop
	{
		; ([Subroutine_Running,A_ThisLabel,FoundAppTitle,FoundAppClass,FoundAppControl,FoundAppProcess])
		; stdout.WriteLine(A_NowUTC ",Main_loop," image_name ",Main_Loop_Counter:," Main_Loop_Counter ",Restart_Loops:," Restart_Loops ",Reset_App_Yes:," Reset_App_Yes)
		; if !WinActive(FoundAppTitle), WinActivate, %FoundAppTitle% ; WinActivate ; Automatically uses the window found above.

		; MouseMove UpperX+(WinWidth/2), UpperY+(WinHeight/2)

		; Generate Random time interval to add to all delays and pauses
		Random, rand_wait, %rand_min%, %rand_max%
		Key_Menu() ; display/update keyboard shortcut menu
		; Process_Menu()

		; Switch User
		; For User,Val in User_Logins
		for User,Val in Base_Array
		{
			; Gosub Get_Window_Geometry
			Gosub Check_Window_Geometry
			; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

			; ([FoundAppTitle,FoundAppClass,FoundAppControl,FoundAppProcess])

			; Populate account variables from next keyed array item
			global User_Name := Base_Array[User].User_Name_new
			global User_Email := Base_Array[User].User_Email
			global User_Pass := Base_Array[User].User_Pass
			global User_PIN := Base_Array[User].User_PIN
			
			/*
			global Current_User_Name := Base_Array[User]
			global Current_User_Email := Val[2]
			global Current_User_Pass := Val[3]
			global Current_User_PIN := Val[4]
			
			Current_User := Base_Array[User]			
			global Current_User_Name := Current_User.User_Name_new
			global Current_User_Email := Current_User.User_Email
			global Current_User_Pass := Current_User.User_Pass
			global Current_User_PIN := Current_User.User_PIN
			
			MsgBox, % Current_User.User_Name_new
			. "`n " Current_User.User_Name_old
			. "`n " Current_User.User_Email
			. "`n " Current_User.User_Pass
			. "`n " Current_User.User_PIN
			*/

			; Generate and combine text for account selection pop-up box
			Output := "User: " User_Name " has: "
			Output .= "Email: " User_Email " "
			; Output .= "Password: " User_Pass " "
			; Output .= "PIN: " User_PIN
			
			; Gosub Switch_Account
			; OR
			{
				MsgBox, 3, , Login to %Output% ? (3 second Timeout & auto),3 ; 5
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") || if (vRet = "Timeout")
					Gosub Switch_Account
				else if (vRet = "No")
					goto END_of_user_loop
			}

			; Login_Password_PIN_BruteForce()
			; loop, 2
			if !Go_Back_To_Home_Screen()
				Reload_LEWZ()

			; ***************************************
			; Main DEBUG and event Variables - START
			; ***************************************
			global Pause_Script := False ; Pause_Script := True
			CSB_Event := False ; True ; True if CSB Event is going on
			Desert_Event := True ; False ; True ; True if Desert Event is going on
			; if CSB_Event ; || if Desert_Event
			At_War := False ; if set to True, peace shield will be enabled
			; ***************************************
			; Main DEBUG and event Variables - END
			; ***************************************

			; MsgBox, 4, , Enable Pause? (8 Second Timeout & skip), 5 ; 8
			; vRet := MsgBoxGetResult()
			; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
			; Pause_Script := True
				
			if Pause_Script	
			{
				MsgBox, 4, Pause script, Pause script? (5 Second Timeout & skip), 5 ; 5
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
					MsgBox, 0, Pause, Press OK to resume (No Timeout)
			}

			; Extract current UTC hour
			Current_Hour_UTC := FormatTime(A_NowUTC, "HH")
			Current_Day_UTC := FormatTime(A_NowUTC, "dddd")
			Peace_Shield_Needed := False

			; Figure out the day and time to determine if shield is needed
			; If time is within 24 hours of killing event, Peace_Shield_Needed variable = True
			if (Current_Day_UTC = "Friday") ; || (Current_Day_UTC = "Saturday") || (Current_Day_UTC = "Sunday"))
				Peace_Shield_Needed := True
			if At_War
				Peace_Shield_Needed := True
				
			; ###############################
			; ###############################
			; Peace_Shield_Needed := False
			; ###############################
			; ###############################

			; Figure out time of day for which subroutines will run
			if (Current_Hour_UTC >= 16 && Current_Hour_UTC < 24)
				Routine := "End_Of_Day"
			else if (Current_Hour_UTC >= 24 || Current_Hour_UTC <= 8)
				Routine := "New_Day"
			else
				Routine := "Fast"

			; if (Routine = "New_Day") ; || if (Routine = "Fast") ; || if (Routine = "End_Of_Day")

			; Default defined routine
			Routine_Set_Routine:
			{
				Routine_Running := Routine

				; ******************************************
				; DEBUG / Troubleshooting block - BEGIN
				; add/remove or uncomment routines to check them
				; ******************************************
				; Gosub Speaker_Help
				; gosub Adventure_Missions
				; gosub Alliance_Boss_Feed
				; gosub Speaker_Help
				; gosub Active_Skill
				; gosub Alliance_Wages
				
				; gosub Speaker_Help
				; gosub Benefits_Center
				/*
				gosub Speaker_Help
				MsgBox, 0, Pause, Press OK to end (No Timeout)
				Go_Back_To_Home_Screen()
				gosub Alliance_Wages
				gosub Active_Skill
				gosub Speaker_Help
				; Go_Back_To_Home_Screen()
				gosub Gather_Resources
				goto END_of_user_loop
				*/
				
				; Goto_Coordinates(591,64)
				; Goto_Coordinates()
				
				; Login_Password_PIN_BruteForce()
				; gosub Check_Window_Geometry
				; gosub Collect_Cafeteria
				; gosub Collect_Chips_Underground
				; gosub Collect_Collisions
				; gosub Collect_Equipment_Crafting
				; gosub Collect_Recruits
				; gosub Collect_Red_Envelopes
				; gosub Collect_Runes
				; gosub Depot_Rewards
				; gosub Desert_Oasis
				; gosub Desert_Wonder
				; gosub Donate_Tech
				; gosub Drop_Zone
				; gosub Game_Start_popups
				; gosub Gather_On_Base_RSS
				; gosub Gather_Resources
				; gosub Get_Inventory
				; gosub Get_User_Info
				; gosub Get_User_Location
				; gosub Golden_Chest
				; gosub Mail_Collection
				; gosub Peace_Shield
				
				; gosub Golden_Chest
				; Gosub Speaker_Help
				; gosub Benefits_Center
				; gosub Active_Skill
				; Gosub Speaker_Help
				; gosub Reserve_Factory
				; Gosub Speaker_Help
				
				; gosub Send_Mail_To_Boss
				; gosub Send_Message_In_Chat
				; gosub Speaker_Help
				; gosub Switch_Account
				; gosub VIP_Shop
				; Reset_Posit()
				; Reload_MEmu()
				; Reload_LEWZ()
				; Launch_LEWZ()
				; Go_Back_To_Home_Screen()
				; Login_Password_PIN_Enter()
				; Login_Password_PIN_Find()
				; Login_Password_PIN_Taps()
				; Activity_Center_Open()
				; Enter_Coordinates_From_Home()
				; Enter_Coordinates_From_World()
				; Enter_Coordinates_Open_Check()
				; Check_For_Zombie_Popup()
				; Select_App()
				; Key_Menu()
				/*
				gosub Benefits_Center
				gosub Active_Skill
				MsgBox, 0, Pause, Press OK to end (No Timeout)
				goto END_of_user_loop
				*/
				; ******************************************
				; DEBUG / Troubleshooting block - END
				; ******************************************
				; goto DEBUG_SKIP

				; ****************************
				; ** Position dependant **
				; ****************************
				if Peace_Shield_Needed
					Gosub Peace_Shield
				; Reset_Posit()
				
				Gosub Collect_Collisions
				Gosub Collect_Recruits
				Gosub Collect_Equipment_Crafting
				Gosub Collect_Runes
				Gosub Collect_Cafeteria
				Gosub Depot_Rewards
				; if (Routine = "New_Day") || if (Routine = "End_Of_Day")
				;	Gosub Golden_Chest
				Gosub Speaker_Help
				; if (Routine = "New_Day") || if (Routine = "End_Of_Day")
					Gosub Drop_Zone

				; ****************************
				; ** Not position dependant **
				; ****************************
				/*
				if CSB_Event ; || if Desert_Event
					if !(Current_Hour_UTC = 00 && A_Min <= 30)
						Gosub Reserve_Factory
				*/
				Gosub Active_Skill
				; Gosub Donate_tech
				Gosub Speaker_Help

				; if (Routine = "New_Day")
				{
					Gosub VIP_Shop
					Gosub Benefits_Center
					Gosub Alliance_Boss_Feed
				}
				Gosub Speaker_Help
				; if (Routine = "End_Of_Day")
				{
					Gosub Mail_Collection
					Gosub Alliance_Wages
				}
				
				; *************************
				; DEBUG_SKIP:
				; *************************
				

				if Desert_Event
					Gosub Desert_Oasis
					
				; Gosub Gather_Resources

				if Desert_Event
					if ((Current_Day_UTC = "Saturday") || (Current_Day_UTC = "Sunday")) ; if ((Current_Day_UTC = "Friday") || 
						if ((Routine = "New_Day") || (Routine = "End_Of_Day"))
							Gosub Desert_Wonder
				Gosub Speaker_Help
				; Gosub Collect_Red_Envelopes
				; if !Desert_Event
				;	Gosub Gather_On_Base_RSS
					
				
				if ((Current_Day_UTC = "Monday") || (Current_Day_UTC = "Tuesday") || (Current_Day_UTC = "Wednesday")) 
					gosub Gather_Resources

				Message_To_The_Boss := User_Name . " " . Routine . " Routine,"
				; if (Routine = "New_Day") || if (Routine = "End_Of_Day")
				; Reset_Posit()
				Gosub Get_User_Location	
					Gosub Collect_Recruits
					Gosub Collect_Runes
				Gosub Get_User_Info
				Gosub Get_Inventory
				Gosub Send_Mail_To_Boss
				; Gosub Send_Message_In_Chat

				if Pause_Script	
				{
					MsgBox, 4, Pause script, Pause before switching accounts? (5 Second Timeout & skip), 5 ; 5
					vRet := MsgBoxGetResult()
					if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
						MsgBox, 0, Pause, Press OK to resume (No Timeout)
				}

				goto END_of_user_loop
			}

			; removed bulk of subroutines, to ease readability, no longer needed
			Special_Routine:
			New_Day_Game_Reset:
			Fast_Routine:
			End_Of_Day_Routine:
			FULL_Q_and_A_Routine:
			goto END_of_user_loop
			
			F10::
				; A_Index++
				Continue
				Gosub Switch_Account
			return			

			END_of_user_loop:
		}

		; start new log files
		Gosub Refresh_LogFiles
		; relaunch LEWZ
		; Reload_LEWZ()
		; Launch_Lewz()
		gosub Reload_Script
		if !Go_Back_To_Home_Screen()
			Reload_LEWZ()
	}
}
if !WinExist(FoundAppTitle)
	return
else
{
	; WinActivate ; The above IfWinNotExist also set the last found window for us.
	WinMove, WinMove_X, WinMove_Y ; Move it to a new position.
	return
}
MsgBox, Unexpected exit

;
Reload_LEWZ()
{
	Gosub Reload_LEWZ_Kill
	Gosub Reload_LEWZ_Launch
	Gosub Account_Loading
	if !Go_Back_To_Home_Screen()
		return 1
	Else
		return 0
}

	Reload_LEWZ_Kill:
	{
		Gui, Status:new, , Status
		Gui, Status:Margin, 0, 0
		Gui, Status:add,text,, LEWZ Shutdown...
		Gui, Status:show, x731 y0 w300 h500
		GUI_Count++
		; loop, 2
		{
			; RunNoWaitOne("""C:\Program Files\Microvirt\MEmu\adb.exe"" shell am force-stop com.longtech.lastwars.gp")
			RunWaitOne("""C:\Program Files\Microvirt\MEmu\adb.exe"" shell am force-stop com.longtech.lastwars.gp")
			DllCall("Sleep","UInt",(1*Delay_Long+0))
		}
		; DllCall("Sleep","UInt",(4*Delay_Long+0))
		return
	}

	Reload_LEWZ_Launch:
	{		
		Gui, Status:add,text,, LEWZ Startup...
		Gui, Status:show, x731 y0 w300 h500
		GUI_Count++
		; loop, 2
		{
			; RunNoWaitOne("""C:\Program Files\Microvirt\MEmu\adb.exe"" connect 127.0.0.1:21513")
			RunWaitOne("""C:\Program Files\Microvirt\MEmu\adb.exe"" connect 127.0.0.1:21513")
			; RunNoWaitOne("""C:\Program Files\Microvirt\MEmu\adb.exe"" shell monkey -p com.longtech.lastwars.gp -v 500")
			RunWaitOne("""C:\Program Files\Microvirt\MEmu\adb.exe"" shell monkey -p com.longtech.lastwars.gp -v 500")
			; DllCall("Sleep","UInt",(3*Delay_Long+0))
		}
		; DllCall("Sleep","UInt",(4*Delay_Long+0))
		return
	}


; Reload_MEmu() <--> Launch_LEWZ() <--> Go_Back_To_Home_Screen()

; Reload_MEmu() calls Launch_LEWZ() and NOT Go_Back_To_Home_Screen()
Reload_MEmu()
{
	Subroutine_Running := "Reload_MEmu"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	
	MEmu_Instance := "MEmu_1" ; MEmu_1 MEmu_2
	
	Reload_MEmu_START:
	gosub Reload_MEmu_Kill
	; gosub Reload_MEmu_Launch
		
	Loop, 10
	{
		gosub Reload_MEmu_Launch
		; DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
		loop, 3
		{
			if Launch_LEWZ()
			{
				Gui, Status:add,text,, MEmu finished Loaded!!
				Gui, Status:show, x731 y0 w300 h500
				GUI_Count++
				Gosub Elivate_program
				return 1
			}
			Else
				gosub Reload_MEmu_Launch
		}

		Gui, Status:add,text,, Reoading MEmu %A_Index%
		Gui, Status:show, x731 y0 w300 h500
		GUI_Count++
				
		gosub Reload_MEmu_Kill
		; gosub Reload_MEmu_Launch
	}
	Gui, Status:add,text,, MEmu NOT Loaded!
	Gui, Status:show, x731 y0 w300 h500
	GUI_Count++
	goto Reload_MEmu_START
	return 0
}	
	
	Reload_MEmu_Kill:
	{
		Gui, Status:new, , Status
		Gui, Status:Margin, 0, 0
		Gui, Status:add,text,, MEmu VM Shutdown...
		Gui, Status:show, x731 y0 w300 h500
		GUI_Count++
		loop, 2
		{
			RunNoWaitOne("""C:\Program Files\Microvirt\MEmu\MEmuConsole.exe"" ShutdownVm " . MEmu_Instance)
			DllCall("Sleep","UInt",(3*Delay_Long+0))
		}
		DllCall("Sleep","UInt",(4*Delay_Long+0))
		return
	}

	Reload_MEmu_Launch:
	{		
		Gui, Status:add,text,, MEmu VM Startup...
		Gui, Status:show, x731 y0 w300 h500
		GUI_Count++
		loop, 2
		{
			RunNoWaitOne("""C:\Program Files\Microvirt\MEmu\MEmuConsole.exe"" " . MEmu_Instance)
			DllCall("Sleep","UInt",(3*Delay_Long+0))
		}
		DllCall("Sleep","UInt",(4*Delay_Long+0))
		return
	}

; Launch_LEWZ() calls Go_Back_To_Home_Screen() and NOT Reload_MEmu()
; Launch LEWZ app from android main screen
Launch_LEWZ()
{
	Subroutine_Running := "Launch_LEWZ"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; Gui, Status:new, , Status
	; Gui, Status:Margin, 0, 0
	; Gui, Status:add,text,, LEWZ loading...
	; Gui, Status:show, x%MsgWinMove_X% y0 w300 h500
	; Gui, Status:show, x731 y0 w300 h500

	Launch_LEWZ_Click_Icon:
	Select_App()
	Gosub Check_Window_Geometry
	
	oIcon_LEWZSearch := new graphicsearch()	
	loop, 60
	{
		resultIcon_LEWZ := oIcon_LEWZSearch.search(011_Icon_LEWZ_Graphic, optionsObjCoords)
		if (resultIcon_LEWZ)
		{
			loop, % resultIcon_LEWZ.Count()
			{
				Click_X := resultIcon_LEWZ[A_Index].x
				Click_Y := resultIcon_LEWZ[A_Index].y
				Gui, Status:add,text,, LEWZ icon found #%A_Index% (%Click_X%,%Click_Y%)
				Mouse_Click(Click_X,Click_Y, {Clicks: 3,Timeout: (Delay_Medium+0)}) ; Tap LEWZ ICON
				Gui, Status:show, x731 y0 w300 h500
				GUI_Count++
				Icon_Found := True ; Goto Launch_LEWZ_Continue
				break
			}
		}
		Else
			DllCall("Sleep","UInt",(1*Delay_Short+0))
			
		Login_Password_PIN_Enter()
	}
	if Icon_Found
		Goto Launch_LEWZ_Continue
	Else
		return 0

	Launch_LEWZ_Continue:
	
	gosub Account_Loading
	
	if Go_Back_To_Home_Screen()
	{
		Gui, Status:add,text,, LEWZ Loaded!!
		Gui, Status:show, x731 y0 w300 h500
		GUI_Count++
		return 1
	}
	Else
	{
		Gui, Status:add,text,, Loading LEWZ %A_Index%
		Gui, Status:show, x731 y0 w300 h500
		GUI_Count++
	}
	Gui, Status:add,text,, LEWZ NOT Loaded!
	Gui, Status:show, x731 y0 w300 h500
	GUI_Count++
	return 0
}

; Go_Back_To_Home_Screen() simple return a true or false value,
; if Quit dialog is detected after hitting the back button
; Go_Back_To_Home_Screen() calls neither Launch_LEWZ() NOR NOT Reload_MEmu()
; Go back until "Quit" dialog pop-ups, then make sure dialog goes away
Go_Back_To_Home_Screen()
{
	; Subroutine_Running := "Go_Back_To_Home_Screen"
	; stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Go back

	loop, 3
	{
		Command_To_Screen("{F5}")
		DllCall("Sleep","UInt",(2*Delay_Short+0))
	}
	DllCall("Sleep","UInt",(1*Delay_Short+0))

	Go_Back_To_Home_Screen_OCR_Quit:
	oGoBackSearch := new graphicsearch()	
	oRebuildSearch := new graphicsearch()	
	loop, 50
	{
		resultGoBack := oGoBackSearch.search(021_Quit_Title_Graphic, optionsObjCoords)
		if (resultGoBack)
			goto Go_Back_To_Home_Screen_OCR_NOT_Quit ; return 1
			
		resultRebuild := oRebuildSearch.search(023_Rebuild_Button_Graphic, optionsObjCoords)
		if (resultRebuild)
			Mouse_Click(resultRebuild[1].x,resultRebuild[1].y, {Timeout: (2*Delay_Long+0)}) ; Tap "Rebuild" and wait
				
		Command_To_Screen("{F5}")
		DllCall("Sleep","UInt",(3*Delay_Short+0))
		; DllCall("Sleep","UInt",(3*Delay_Micro+0))
		; DllCall("Sleep","UInt",(5*Delay_Micro+0))
		Gosub Check_Window_Geometry	
	}
	; goto Reload_LEWZ_routine	; Gosub Reload_LEWZ_routine
	return 0

	Go_Back_To_Home_Screen_OCR_NOT_Quit:
	loop, 10
	{
		resultGoBack := oGoBackSearch.search(021_Quit_Title_Graphic, optionsObjCoords)
		if !(resultGoBack)
			return 1 ; goto Go_Back_To_Home_Screen_OCR_NOT_Quit

		Command_To_Screen("{F5}")
		DllCall("Sleep","UInt",(3*Delay_Short+0))
		; DllCall("Sleep","UInt",(3*Delay_Micro+0))
		; DllCall("Sleep","UInt",(5*Delay_Micro+0))
		Gosub Check_Window_Geometry
	}
	; goto Reload_LEWZ_routine	; Gosub Reload_LEWZ_routine
	return 0
}

; Clear in-game splash pages
Game_Start_popups:
{
	Subroutine_Running := "Game_Start_popups"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Clear first pop-up by pressing back
	Command_To_Screen("{F5}")
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(256,979, {Timeout: (1*Delay_Long+0)}) ; Check No More Prompts Today On Today'S Hot Sale

	Mouse_Click(630,322, {Timeout: (1*Delay_Long+0)}) ; Tap X On Today'S Hot Sale

	; Mouse_Click(379,736) ; Collect Cafeteria

	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return
}

; reset position by going to world screen and back home, returns TRUE is successful, FALSE if unsuccessful
Reset_Posit()
{
	Subroutine_Running := "Reset_Posit"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; go back x times

	; Go_Back_Home_Delay_Long := True
	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()

	; Tap World/home button x times ; Mouse_Click(76,1200, {Timeout: (6*Delay_Long+0)}) ; Tap World/home button
	oWorldSearch := new graphicsearch()
	; loop, 2
	{
		resultWorld := oWorldSearch.search(821_World_Button_Graphic, optionsObjCoords)
		if (resultWorld)	
		{
			Mouse_Click(resultWorld[1].x,resultWorld[1].y, {Timeout: (3*Delay_Short+0)})
			loop, 40
			{
				resultWorld := oWorldSearch.search(822_Home_Button_Graphic, optionsObjCoords)
				if (resultWorld)
				{
					Mouse_Click(resultWorld[1].x,resultWorld[1].y, {Timeout: (3*Delay_Short+0)})
					goto, Reset_Posit_END
				}
				Else
					DllCall("Sleep","UInt",(1*Delay_Short+0))
			}
		}
		Else
			DllCall("Sleep","UInt",(1*Delay_Short+0))
	}
	return 0
	
	Reset_Posit_END:
	; Go_Back_Home_Delay_Long := True
	if !Go_Back_To_Home_Screen()
	 	Reload_LEWZ()
	return 1
}


; Login to account using stored credentials
Switch_Account:
{
	Subroutine_Running := "Switch_Account"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	Gui, Status:add,text,, ********************************
	Gui, Status:add,text,, Switching to %User_Name%
	; Gui, Status:show, x%MsgWinMove_X% y0 w300 h500
	Gui, Status:show, x731 y0 w300 h500
	loop, 2
		GUI_Count++

	Switch_Account_START:
	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	Mouse_Click(50,70, {Clicks: 1,Timeout: (1*Delay_Medium+0)}) ; Tap Commander Info
	
	; check if any graphic was found
	oAccountSearch := new graphicsearch()	
	oLoginSearch := new graphicsearch()			
	allQueries_Account := 1A_Settings_Button_Graphic 1A1_Account_Button_Graphic 1A12_Switch_Button_Graphic 1A123_WarZ_Button_Graphic 1A1232_OtherAccount_Button_Graphic
	allQueries_Login := 1A1234_Email_Box_Button_Graphic 1A1235_PW_Box_Button_Graphic 1A1237_UseEmailLog_Button_Graphic
	loop, 3
	{
		Mouse_Click(600,1200, {Timeout: (3*Delay_Short+0)}) ; "Settings" Button 
		Mouse_Click(100, 330, {Timeout: (3*Delay_Short+0)}) ; "Account" Button
		Mouse_Click(330, 880, {Timeout: (3*Delay_Short+0)}) ; "Switch" Button
		Mouse_Click(315, 720, {Timeout: (3*Delay_Short+0)}) ; "WarZ" Button
		Mouse_Click(480,1150, {Timeout: (3*Delay_Short+0)}) ; "Other Account" button
		
		loop, 7
		{
			resultLogin := oLoginSearch.search(allQueries_Login, optionsObjCoords)
			if (resultLogin)
				goto Switch_Account_Dialog
				
			resultObj := oAccountSearch.search(allQueries_Account, optionsObjCoords)
			if (resultObj)
				Mouse_Click(resultObj[1].x,resultObj[1].y, {Timeout: (2*Delay_Short+0)})
			
			if Search_Captured_Text_OCR(["Yes"], {Pos: [315, 860], Size: [60, 35]}).Found
			{
				MsgBox, 4, Yes Dialog, Press OK to resume (No Timeout)
				Mouse_Click(340,870, {Timeout: (2*Delay_Short+0)}) ; Tap Yes	
			}
		}
		/*
			Mouse_Click(600,1200, {Timeout: 0}) ; "Settings" Button
			Mouse_Click(480,1150, {Timeout: 0}) ; "Other Account" button
			DllCall("Sleep","UInt",(1*Delay_Short+0))
		*/
	}
	goto Switch_Account_START

	Switch_Account_Dialog:
	oEmailSearch := new graphicsearch()	
	oPWSearch := new graphicsearch()
	loop, 5
	{
		resultEmail := oEmailSearch.search(1A1234_Email_Box_Button_Graphic, optionsObjCoords)
		resultPW := oPWSearch.search(1A1235_PW_Box_Button_Graphic, optionsObjCoords)
		
		if (resultEmail)
			Gosub Switch_Account_User_Email
		Else if (resultPW)
			Gosub Switch_Account_User_Password
		Else
			goto Switch_Account_Next
		
		DllCall("Sleep","UInt",(1*Delay_Medium+0))
	}
	goto Switch_Account_START

	Switch_Account_User_Email:
	{
		loop, 2
			Mouse_Click(220,382, {Timeout: (1*Delay_Short+0)}) ; Tap inside Email Text Box
		DllCall("Sleep","UInt",(3*Delay_Short+0))

		Text_To_Screen(User_Email)
		DllCall("Sleep","UInt",(1*Delay_Short+0))
		; DllCall("Sleep","UInt",(4*Delay_Short+0))
		Command_To_Screen("{Enter}")
		; DllCall("Sleep","UInt",(3*Delay_Short+0))
		return
	}

	Switch_Account_User_Password:
	{
		loop, 2
			Mouse_Click(209,527, {Timeout: (1*Delay_Short+0)}) ; Tap inside Email Text Box
		DllCall("Sleep","UInt",(3*Delay_Short+0))

		Text_To_Screen(User_Pass)
		DllCall("Sleep","UInt",(1*Delay_Short+0))
		; DllCall("Sleep","UInt",(4*Delay_Short+0))
		Command_To_Screen("{Enter}")
		; DllCall("Sleep","UInt",(3*Delay_Short+0))
		return
	}

	Switch_Account_Next:
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Mouse_Click(455,739, {Clicks: 2,Timeout: (1*Delay_Short+0)}) ; Tap Use your email to log in
	
	Gosub Account_Loading
	
	; Switch_Account_END:
	; Login_Password_PIN_Enter()

	return
}

Account_Loading:
{
	oGraphicSearch := new graphicsearch()	
	Last_Game_Loading := "0"
	loop, 10
	{
		resultObj := oGraphicSearch.search(1A12371_OK_Button_Graphic, optionsObjCoords)
		if (resultObj)
			Mouse_Click(resultObj[1].x,resultObj[1].y, {Timeout: (1*Delay_Short+0)}) ; Tap "OK"
		
		if Search_Captured_Text_OCR(["Yes"], {Pos: [315, 860], Size: [60, 35]}).Found
		{
			MsgBox, 4, Yes Dialog, Press OK to resume (No Timeout)
			Mouse_Click(340,870, {Timeout: (2*Delay_Short+0)}) ; Tap Yes	
		}
	}

	loop, 60 ; 20
	{
		resultObj := oGraphicSearch.search(1A12371_OK_Button_Graphic, optionsObjCoords)
		if (resultObj)
			Mouse_Click(resultObj[1].x,resultObj[1].y, {Timeout: (1*Delay_Short+0)}) ; Tap "OK"
		
		/*
		if Search_Captured_Text_OCR(["Yes"], {Pos: [315, 860], Size: [60, 35]}).Found
		{
			MsgBox, 4, Yes Dialog, Press OK to resume (No Timeout)
			Mouse_Click(340,870, {Timeout: (1*Delay_Short+0)}) ; Tap Yes	
		}
		*/

		Login_Password_PIN_Enter()
		
		/*
		AccountLoading := Search_Captured_Text_OCR(["0","1","2","3","4","5","6","7","8","9","%"], {Pos: [319, 1067], Size: [54, 25]})
		while (AccountLoading.Found)
		{
			Game_Loading_RAW := RegExReplace(AccountLoading.Text,"[^\d]")
			RegExMatch(Game_Loading_RAW, "\d\d",Game_Loading)
			if (Game_Loading > Last_Game_Loading)
			{
				Gui, Status:new, , Status
				Gui, Status:Margin, 0, 0
				Gui, Status:add,text,, Account %User_Name%
				GUI_Count := 0
				Gui, Status:add,text,, Account Loading %Game_Loading%`%
				Gui, Status:show, x731 y0 w300 h500
				GUI_Count++
				; Last_Game_Loading = Game_Loading_RAW
				Last_Game_Loading = Game_Loading
			}
			AccountLoading := Search_Captured_Text_OCR(["0","1","2","3","4","5","6","7","8","9","%"], {Pos: [319, 1067], Size: [54, 25]})
		}
		*/
		
		AccountLoading := Search_Captured_Text_OCR(["Anniversary","Arms","Benefit","Celebrat","Center","Deal","Dio","Doomsday","element","Festival","Hot","Hunter","Invest","Iron","Master","Mutation","New","Officer","Online","Pack","Racer","Reynolds","Sale","Supply","Wall","Weekly"], {Pos: [200, 40], Size: [300, 42]})
		
		if (AccountLoading.Found)
		{
			Gui, Status:add,text,, % " loops:" A_Index " Text:""" AccountLoading.Text """"
			Gui, Status:show, x731 y0 w300 h500
			GUI_Count++
			; MsgBox, 0, Text Found, % " index: " A_Index "`nText found: """ AccountLoading.Text """ (No Timeout)"
			break
		}
	}

	; Login_Password_PIN_BruteForce()

	Switch_Account_PIN:
	if Login_Password_PIN_Find() ; if Text_Found
		MsgBox, 4, User PIN failed, user PIN: %User_PIN% did not work for Account %User_Name%`nEnter PIN manually, Press OK to resume (No Timeout)
	return
}


; Login_Password_PIN_Find() <--> Login_Password_PIN_Taps
; Login_Password_PIN_BruteForce() <--> Login_Password_PIN_Taps

; Login_Password_PIN_Find() returns true if PIN text found, OR false if PIN text not found
Login_Password_PIN_Enter() ; FMR Enter_Login_Password_PIN:
{
	; loop, 10
	{
		if Login_Password_PIN_Find() ; if Text_Found
		{
			Login_Password_PIN_Taps()
			; Runwait, taskkill /im ChildProcess_ChildProcess_Login_Password_PIN_Find.ahk /f
			return 1 ; true if PIN text found
		}
	}
	; Runwait, taskkill /im ChildProcess_ChildProcess_Login_Password_PIN_Find.ahk /f
	return 0 ; false if PIN text not found	
}

Login_Password_PIN_Find()
{
	; Subroutine_Running := "Login_Password_PIN_Find"
	; stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	
	; Text_Found := True
	; RunDependent("ChildProcess_ChildProcess_Login_Password_PIN_Find.ahk")
	; return	
	
	; Is PIN text present on Screen?
	;	If true, continue
	; 	If False, return 0
	
	oGraphicSearch := new graphicsearch()	
	resultObj := oGraphicSearch.search(1A123730_EnterPIN_Title_Graphic, optionsObjCoords)
	if (resultObj)
	{
		; Gui, Status:add,text,, PIN prompt: TRUE
		; Gui, Status:show, x731 y0 w300 h500
		; GUI_Count++
		return 1 ; true if PIN text found
	}
	Else
	{
		; Gui, Status:add,text,, PIN prompt: FALSE
		; Gui, Status:show, x731 y0 w300 h500
		; GUI_Count++
		Text_Found := False
		return 0 ; false if PIN text not found
	}

	
}

Login_Password_PIN_Taps() ; FMR Enter_Login_PIN_Dialog:
{
	; tap backspace X times
	loop, 6
		Mouse_Click(560, 1190, {Timeout: 20}) ; (1*Delay_Pico+0)}) ; Tap backspace
		; Mouse_Click(465, 1164, {Timeout: (1*Delay_Pico+0)}) ; Tap backspace
		; old Mouse_Click(577,1213, {Timeout: (1*Delay_Pico+0)}) ; Tap backspace
	DllCall("Sleep","UInt",(1*Delay_Pico+0))

	; Split PIN and tap each corrsponding number
	Enter_User_PIN := StrSplit(User_PIN)
	Loop % Enter_User_PIN.MaxIndex()
	{
		; DllCall("Sleep","UInt",(1*Delay_Pico+0))

		if Enter_User_PIN[A_Index] = "1"
			Mouse_Click(120,920,  {Timeout: 0}) ; Tap 1
		if Enter_User_PIN[A_Index] = "2"
			Mouse_Click(340,920,  {Timeout: 0}) ; Tap 2
		if Enter_User_PIN[A_Index] = "3"
			Mouse_Click(560,920,  {Timeout: 0}) ; Tap 3
		if Enter_User_PIN[A_Index] = "4"
			Mouse_Click(120,1000, {Timeout: 0}) ; Tap 4
		if Enter_User_PIN[A_Index] = "5"
			Mouse_Click(340,1000, {Timeout: 0}) ; Tap 5
		if Enter_User_PIN[A_Index] = "6"
			Mouse_Click(560,1000, {Timeout: 0}) ; Tap 6
		if Enter_User_PIN[A_Index] = "7"
			Mouse_Click(120,1100, {Timeout: 0}) ; Tap 7
		if Enter_User_PIN[A_Index] = "8"
			Mouse_Click(340,1100, {Timeout: 0}) ; Tap 8
		if Enter_User_PIN[A_Index] = "9"
			Mouse_Click(560,1100, {Timeout: 0}) ; Tap 9
		if Enter_User_PIN[A_Index] = "0"
			Mouse_Click(340,1190, {Timeout: 0}) ; Tap 0
	}
	; DllCall("Sleep","UInt",(3*Delay_Micro+0))
	

	loop, 6
		Mouse_Click(560, 1190, {Timeout: 20}) ; (1*Delay_Pico+0)}) ; Tap backspace
		
	return
}

Login_Password_PIN_BruteForce(User_PIN_INIT := "468000", Check_After_Loops := "100", Reload_After_Loops := "5000") ; FMR BruteForcePIN:
{
	Subroutine_Running := "BruteForce PIN " . User_PIN
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	if Login_Password_PIN_Find()
		loop, 1000000
		{
			User_PIN := (User_PIN_INIT + A_Index)

			loop, 5
			{
				if StrLen(User_PIN) > 6
					User_PIN := "000000"
				if StrLen(User_PIN) < 6
					User_PIN := "0" . User_PIN
				if StrLen(User_PIN) = 6
					break
			}
		
			Login_Password_PIN_Taps() ; Login_Password_PIN_Find
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
			
			; if (Mod(A_Index, %Check_After_Loops%) == 0) ; if !Text_Found
			if (Mod(A_Index, Check_After_Loops) == 0) ; if !Text_Found
			{
				if Login_Password_PIN_Find()
				{
					if (Mod(A_Index, Reload_After_Loops) == 0) ; if !Text_Found
					{
						loop, 2
							gosub Reload_LEWZ_Kill
						loop, 2
							gosub Reload_LEWZ_Launch
						
						loop, 500
						{	
							; loop, 6
								Mouse_Click(560, 1190, {Timeout: 20}) ; (1*Delay_Pico+0)}) ; Tap backspace
							if Login_Password_PIN_Find()
								break
							DllCall("Sleep","UInt",(1*Delay_Short+0))
						}
					}
				}
				Else
				{
					loop, 20
					{
						
						; loop, 6
							Mouse_Click(560, 1190, {Timeout: 20}) ; (1*Delay_Pico+0)}) ; Tap backspace
						if Login_Password_PIN_Find()
							goto Resume_BruteForce
					}
					
						
					PIN_Start := (User_PIN - Check_After_Loops)
					stdout.WriteLine(A_NowUTC ",Found," Text_Found ",User_Email," User_Email ",Check_After_Loops," Check_After_Loops ",PIN," User_PIN )
					MsgBox, 3, , % " PIN discovered for account:" User_Email "`nbetween: " PIN_Start " and " User_PIN " (10 second Timeout & auto)" ; 0
						vRet := MsgBoxGetResult()
						if (vRet = "Yes")
							break
						if (vRet = "No")
							goto Resume_BruteForce	

					; if Go_Back_To_Home_Screen()
					;	break
					
					gosub Reload_LEWZ_Kill
					gosub Reload_LEWZ_Launch
										
					Resume_BruteForce:
				}
			}
				
			
			Gui, Status:add,text,, Trying %User_PIN%
			Gui, Status:show, x731 y0 w300 h500
			GUI_Count := GUI_Count + 0.5

		}
	return
}

Peace_Shield:
{
	Subroutine_Running := "Peace_Shield"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )

	Shield_Open_Base:
	Shield_Found_3Day := False
	Shield_Found_24hour := False
	Shield_Found_8hour := False
	oTitleSearch := new graphicsearch()	
	oButtonSearch := new graphicsearch()	
	Loop, 2
	{
		Mouse_Click(265,392, {Timeout: (Delay_Long+0)})  ; Tap Base
		; Mouse_Click(348,499, {Timeout: (Delay_Long+0)})  ; Tap City buffs

		loop, 3
		{	
			resultButton := oButtonSearch.search(B224_CityBuffs_Button_Graphic, optionsObjCoords)
			if (resultButton)
				Mouse_Click(resultButton[1].x,resultButton[1].y, {Timeout: (Delay_Long+0)})  ; Tap City buffs
				
			resultTitle := oTitleSearch.search(B2240_CityBuffs_Title_Graphic, optionsObjCoords)
			if (resultTitle)
				Goto, Shield_Search_Buttons
		}
		if !Reset_Posit()
			Reload_LEWZ()
	}
	; MsgBox, Shield_Open_Base Failed
	goto Peace_Shield_END

	Goto, Shield_Open_Base
	
	Shield_Search_Buttons:	
	oGraphicSearch := new graphicsearch()
	loop, 20
	{
		resultObj := oGraphicSearch.search(B2241_Shield_Button_Graphic, optionsObjCoords)
		if (resultObj)
		{
			Mouse_Click(resultObj[1].x,resultObj[1].y) ; Click to open shield menu
			Goto Shield_Search_Title
		}
		Else
			DllCall("Sleep","UInt",(1*Delay_Short+0))
	}
	; MsgBox, Shield_Search_Buttons Failed
	goto Peace_Shield_END
	
	Shield_Search_Title:
	; Check for shield title banner
	loop, 20
	{
		oGraphicSearch := new graphicsearch()			
		resultObj := oGraphicSearch.search(B22410_Shield_Title_Graphic, optionsObjCoords)
		if (resultObj)
			Goto Shield_Search_Ends
		Else
			DllCall("Sleep","UInt",(1*Delay_Short+0))
	}
	; MsgBox, Shield_Search_Title Failed
	goto Peace_Shield_END

	Shield_Search_Ends:
	; Check for shield title banner
	;	is duration of time left on shield displayed (Shield_Ends_Capture.Found)? if so,
	;		Shield_Ends := (Shield_Ends_Capture.Text)

	; Shield_Ends_Capture := Search_Captured_Text_OCR(["Ends"], {Pos: [171, 126], Size: [238, 36]})
	Shield_Ends_Capture := Search_Captured_Text_OCR(["Ends"], {Pos: [205, 135], Size: [195, 26]})
	
	if (Shield_Ends_Capture)
	{
		Shield_Ends := (Shield_Ends_Capture.Text)
		Goto, Shield_Already_Active
	}
	Else
		Goto, Activate_Shield
			
	; MsgBox, Shield_Search_Title Failed
	goto Peace_Shield_END

	Shield_Already_Active:
	{
		; Set Shield variables to zero
		Shield_DD := Shield_HH := Shield_MM := Shield_SS := 0
		
		; Remove spaces
		Shield_Ends := RegExReplace(Shield_Ends,"\s+")

		; If Shield_Ends leads with days, Extract days only into (Shield_DD)
		if RegExMatch(Shield_Ends,"\d+d",Shield_Days)
			RegExMatch(Shield_Days,"\d+",Shield_DD)
			
		; if shiled length is greater than, or equal to, 1 day, skip the rest.
		if (Shield_DD >= 1)
			goto Peace_Shield_END
			
		; RegExMatch(Shield_Ends,"(\d\d)\:*\d\d\:*\d\d",Shield_HH)
		; RegExMatch(Shield_Ends,"\d\d\:*(\d\d)\:*\d\d",Shield_MM)
		; RegExMatch(Shield_Ends,"\d\d\:*\d\d\:*(\d\d)",Shield_SS)
		
		; MsgBox, % "1. Shield_Ends:" Shield_Ends "`nShield Duration D:" Shield_DD " hh:" Shield_HH " mm:" Shield_MM " ss:" Shield_SS "`nA_NowUTC:" A_NowUTC "`nShield_NOW_Plus_Duration:" Shield_NOW_Plus_Duration
		
		; extract Hours, Minutes and Days till shield expires
		if RegExMatch(Shield_Ends,"\d\d\:\d\d\:\d\d",Shield_HHMMSS)
		{
			Shield_HHMMSS := RegExReplace(Shield_HHMMSS,"[^\d\:]")
			Shield_HHMMSS_Array := StrSplit(Shield_HHMMSS, ":")
			Shield_HH := Shield_HHMMSS_Array[1]
			Shield_MM := Shield_HHMMSS_Array[2]
			Shield_SS := Shield_HHMMSS_Array[3]
		}
		
		; MsgBox, % "2. Shield_Ends:" Shield_Ends "`nShield Duration D:" Shield_DD " hh:mm:ss:" Shield_HH ":" Shield_MM ":" Shield_SS "`nA_NowUTC:" A_NowUTC "`nShield_NOW_Plus_Duration:" Shield_NOW_Plus_Duration

		; Format Shield_Ends expiration as YYYYMMDDHH24MISS format
		Shield_Length := "000000" . Shield_DD . Shield_HH . "24" . Shield_MM . Shield_SS
		; Format current time as as YYYYMMDDHH24MISS format
		; Shield_NOW_Plus_Duration := FormatTime(A_NowUTC, "YYYYMMDDHH24MISS")
		Shield_NOW_Plus_Duration := A_NowUTC

		; add expiration date and time to present date and time
		EnvAdd, Shield_NOW_Plus_Duration, %Shield_DD%, dd
		EnvAdd, Shield_NOW_Plus_Duration, %Shield_HH%, HH
		EnvAdd, Shield_NOW_Plus_Duration, %Shield_MM%, mm
		EnvAdd, Shield_NOW_Plus_Duration, %Shield_SS%, ss
				
		; MsgBox, % "3. Shield_Ends:" Shield_Ends "`nShield Duration D:" Shield_DD " hh:mm:ss:" Shield_HH ":" Shield_MM ":" Shield_SS "`nA_NowUTC:" A_NowUTC "`nShield_NOW_Plus_Duration:" Shield_NOW_Plus_Duration
		
		/*
		Shield_Expires_Day := Shield_NOW_Plus_Duration
		Shield_Expires_HH := Shield_NOW_Plus_Duration
		Shield_Expires_MM := Shield_NOW_Plus_Duration
		
		Shield_Expires_Day := FormatTime(Shield_Expires_Day, "dddd")
		Shield_Expires_HH := FormatTime(Shield_Expires_HH, "hh")
		Shield_Expires_MM := FormatTime(Shield_Expires_MM, "mm")
		*/
		
		FormatTime, Shield_Expires_Day, %Shield_NOW_Plus_Duration%, dddd
		FormatTime, Shield_Expires_HH, %Shield_NOW_Plus_Duration%, HH
		FormatTime, Shield_Expires_MM, %Shield_NOW_Plus_Duration%, mm
		; Shield_Expires_DateTime := FormatTime(Shield_NOW_Plus_Duration)
				
		; MsgBox, % "4. Shield_Ends:" Shield_Ends "`nShield Duration Shield_Expires_Day:" Shield_Expires_Day " Shield_Expires_HH:" Shield_Expires_HH " Shield_Expires_MM:" Shield_Expires_MM "`nA_NowUTC:" A_NowUTC "`nShield_NOW_Plus_Duration:" Shield_NOW_Plus_Duration
		
		if (Shield_NOW_Plus_Duration = A_NowUTC)
			Shield_Expires_DateTime := "Shield is Expired"
		Else
			Shield_Expires_DateTime := "Shield expires on " . Shield_Expires_Day . " @ " Shield_Expires_HH ":" Shield_Expires_MM

		if (At_War && (Shield_DD <= 1)) ||  if (Shield_Expires_Day = "Thursday") || if (Shield_Expires_Day = "Friday") || if (Shield_Expires_Day = "Saturday") || if ((Shield_Expires_Day = "Sunday") && (Shield_Expires_HH <= 19))
		{
			MsgBox, 4, , %Shield_Expires_DateTime%`, recommend 3Day shield (5 sec Timeout & auto),5 ; 5
			vRet := MsgBoxGetResult()
			if (vRet = "Yes") || if (vRet = "Timeout") ; || if (vRet = "No")
			Goto, Shield_for_3Day
		}
		else if Pause_Script
		{
			MsgBox, 4, , %Shield_Expires_DateTime%`, No shield needed.`nPlace shield anyway? (5 sec Timeout & auto),5 ; 5
			vRet := MsgBoxGetResult()
			if (vRet = "Yes")
				goto Activate_Shield
			else if (vRet = "No") || if (vRet = "Timeout")
				goto Peace_Shield_END
		}
		Else
			goto Peace_Shield_END
	}
	
	if Pause_Script	
	{
		MsgBox, 4, , Shield Already Active`, %Capture_Screen_Text%`,  Select new shield anyway? (5 second Timeout & skip),5 ; 5
		vRet := MsgBoxGetResult()
		if (vRet = "Yes")
			goto Activate_Shield
		else if (vRet = "No") || if (vRet = "Timeout")
			goto Peace_Shield_END
	}
	Else
		goto Peace_Shield_END
	
	Activate_Shield:
	; Mouse_Click(Click_X,Click_Y, {Timeout: (Delay_Medium+0)}) ; Click first box to enable shield

	; change button text: "Yes" to "3Day", "No" to "24hour", and "Cancel" to "8hour"
	MsgBox("Would you like to place a shield?`n(Esc) to cancel`n(10 second Timeout & skip)`,10", "Peace Shield", 3, "&3Day", "&24hour", "&8hour", 5)
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") || if (vRet = "Timeout") ; 3Day
		goto Shield_for_3Day
	else if (vRet = "No") ; 24hour
		goto Shield_for_24hour
	else if (vRet = "Cancel") ; 8hour
		goto Shield_for_8hour
	else
		goto Peace_Shield_END

	Shield_for_3Day:
	{
		Shield_Found_3Day := True
		Mouse_Click(590,310, {Timeout: (Delay_Medium+0)})  ; Tap Get & use 3-Day Peace Shield
		Goto, Shield_Purchase
	}
	Goto, Shield_Not_Selected

	Shield_for_24hour:
	{
		Shield_Found_24hour := True
		Mouse_Click(590,458, {Timeout: (Delay_Medium+0)})  ; Tap Get & use 24-Hour Peace Shield
		Goto, Shield_Purchase
	}
	Goto, Shield_Not_Selected

	Shield_for_8hour:
	{
		Shield_Found_8hour := True
		Mouse_Click(590,610, {Timeout: (Delay_Medium+0)})  ; Tap Get & use 8-Hour Peace Shield
		Goto, Shield_Purchase
	}
	Goto, Shield_Not_Selected

	Shield_Not_Selected:
	MsgBox, 4, , Shield not selected:"%Capture_Screen_Text%"`, Try again? (5 second Timeout & skip),5 ; 5
	vRet := MsgBoxGetResult()
	if (vRet = "Yes")
		Goto, Shield_Open_Base
	else if (vRet = "No") || if (vRet = "Timeout")
		Goto, Peace_Shield_END

	Shield_Purchase:
	; DllCall("Sleep","UInt",(1*Delay_Short+0))

	 ; Tap "Get & Use" or "OK" button, to confirm buying shield
	oGraphicSearch := new graphicsearch()	
	Shield_Buttons := B22412_GetUse_Button_Graphic B22413_Replace_OK_Button_Graphic 
	loop, 20
	{
		resultObj := oGraphicSearch.search(Shield_Buttons, optionsObjCoords)
		if (resultObj)
			Mouse_Click(resultObj[1].x,resultObj[1].y, {Timeout: (Delay_Medium+0)})
		Else
			DllCall("Sleep","UInt",(1*Delay_Short+0))
	}
	; MsgBox, Shield_Purchase Failed
	goto Peace_Shield_END

	Peace_Shield_END:
	if Pause_Script	
	{
		MsgBox, 4, Pause script, Pause script? (5 Second Timeout & skip), 5 ; 5
		vRet := MsgBoxGetResult()
		if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
			MsgBox, 0, Pause, Press OK to resume (No Timeout)
	}

	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()

	return
}

; collect collisions
Collect_Collisions:
{
	Subroutine_Running := "Collect_Collisions"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	loop, 2
	{
		Mouse_Click(430,280, {Timeout: (1*Delay_Long+0)}) ; Tap Command Center
		Mouse_Click(515,375) ; Tap Collision
			
		oGraphicSearch := new graphicsearch()	
		loop, 10
		{
			resultObj := oGraphicSearch.search(B3450_Collision_Title_Graphic, optionsObjCoords)
			if (resultObj)
				goto Collect_Collisions_Found
			Else
				DllCall("Sleep","UInt",(1*Delay_Short+0))
		}			
		if !Go_Back_To_Home_Screen()
			Reload_LEWZ()
	}
	goto Collect_Collisions_END
	Collect_Collisions_Found:
	{
		Mouse_Click(180,1130, {Timeout: (1*Delay_Medium+0)}) ; Tap Collide
		goto Collect_Collisions_END
		Loop, 3
			Mouse_Click(450,1180, {Timeout: (Delay_Short+0)}) ; Tap "OK"
	}

	Collect_Collisions_END:
	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	;loop, 2
		Mouse_Click(430,280, {Timeout: (1*Delay_Medium+0)}) ; Tap Command Center
	Mouse_Click(540,367, {Timeout: (1*Delay_Medium+0)}) ; Tap Collide ; Mouse_Click(540,400) ; Tap Collide
	loop, 2
		Mouse_Click(180,1130, {Timeout: (Delay_Medium+0)}) ; Tap Collide
	DllCall("Sleep","UInt",(1*Delay_Medium+0))
	Mouse_Click(450,1180, {Timeout: (Delay_Medium+0)}) ; Tap "OK"
	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return
}

; collect Equipment Crafting
Collect_Equipment_Crafting:
{
	Subroutine_Running := "Collect_Equipment_Crafting"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	loop, 2
	{
		Mouse_Click(430,280, {Timeout: (1*Delay_Long+0)}) ; Tap Command Center
		Mouse_Click(430,390) ; Tap Craft
			
		oGraphicSearch := new graphicsearch()	
		loop, 10
		{
			resultObj := oGraphicSearch.search(B3440_Craft_Title_Graphic, optionsObjCoords)
			if (resultObj)
				goto Collect_Equipment_Found
			Else
				DllCall("Sleep","UInt",(1*Delay_Short+0))
		}			
		if !Go_Back_To_Home_Screen()
			Reload_LEWZ()
	}
	goto Collect_Equipment_END
	Collect_Equipment_Found:
	{
		Mouse_Click(180,1180, {Timeout: (Delay_Medium+0)}) ; Tap Craft or Recruit or Extract
		DllCall("Sleep","UInt",(1*Delay_Medium+0))
		goto Collect_Equipment_END
		Loop, 3
			Mouse_Click(450,1180, {Timeout: (Delay_Short+0)}) ; Tap "OK"
	}

	Collect_Equipment_END:
	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	;loop, 2
		Mouse_Click(430,280, {Timeout: (1*Delay_Medium+0)}) ; Tap Command Center
	Mouse_Click(475,389, {Timeout: (1*Delay_Medium+0)}) ; Tap craft
	loop, 2
		Mouse_Click(180,1180, {Timeout: (Delay_Medium+0)}) ; Tap Craft or Recruit or Extract
	DllCall("Sleep","UInt",(1*Delay_Medium+0))
	Mouse_Click(450,1180, {Timeout: (Delay_Medium+0)}) ; Tap "OK"
	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return
}

; Collect Recruits
Collect_Recruits:
{
	Subroutine_Running := "Collect_Recruits"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	loop, 2
	{
		Mouse_Click(430,280, {Timeout: (1*Delay_Long+0)}) ; Tap Command Center
		Mouse_Click(350,375) ; Tap Recruit
			
		oGraphicSearch := new graphicsearch()	
		loop, 10
		{
			resultObj := oGraphicSearch.search(B3430_Recruit_Title_Graphic, optionsObjCoords)
			if (resultObj)
				goto Collect_Recruits_Found
			Else
				DllCall("Sleep","UInt",(1*Delay_Short+0))
		}			
		if !Go_Back_To_Home_Screen()
			Reload_LEWZ()
	}
	goto Collect_Recruits_END
	Collect_Recruits_Found:
	{
		Mouse_Click(160,1180, {Timeout: (1*Delay_Medium+0)}) ; Tap Recruit 1 times
		goto Collect_Recruits_END
		Loop, 3
			Mouse_Click(450,1180, {Timeout: (Delay_Short+0)}) ; Tap "OK"
	}

	Collect_Recruits_END:
	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	;loop, 2
		Mouse_Click(430,280, {Timeout: (1*Delay_Long+0)}) ; Tap Command Center
	Mouse_Click(430,280, {Timeout: (1*Delay_Medium+0)}) ; Tap Recruit ; Mouse_Click(200,1160) ; Tap Recruit
	loop, 3
		Mouse_Click(180,1180, {Timeout: (Delay_Medium+0)}) ; Tap Craft or Recruit or Extract
	; Mouse_Click(460,1180) ; Tap "OK"
	loop, 3
		Mouse_Click(460,1180, {Timeout: (Delay_Medium+0)}) ; Tap "OK"
	; DllCall("Sleep","UInt",(1*Delay_Medium+0))
	Mouse_Click(450,1180, {Timeout: (Delay_Medium+0)}) ; Tap "OK"
	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return
}

; Collect Runes
Collect_Runes:
{
	Subroutine_Running := "Collect_Runes"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	loop, 2
	{
		Mouse_Click(430,280, {Timeout: (1*Delay_Long+0)}) ; Tap Command Center
		Mouse_Click(570,340) ; Rune Extraction
			
		oGraphicSearch := new graphicsearch()	
		loop, 10
		{
			resultObj := oGraphicSearch.search(B3460_RuneExtract_Title_Graphic, optionsObjCoords)
			if (resultObj)
				goto Collect_Runes_Found
			Else
				DllCall("Sleep","UInt",(1*Delay_Short+0))
		}			
		if !Go_Back_To_Home_Screen()
			Reload_LEWZ()
	}
	goto Collect_Runes_END
	Collect_Runes_Found:
	{
		Mouse_Click(180,1180, {Timeout: (1*Delay_Medium+0)}) ; Tap Craft or Recruit or Extract
		goto Collect_Runes_END
		Loop, 3
			Mouse_Click(450,1180, {Timeout: (Delay_Short+0)}) ; Tap "OK"
	}

	Collect_Runes_END:
	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return
}

Collect_Red_Envelopes:
{
	Subroutine_Running := "Collect_Red_Envelopes"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	loop, 3
	{

		Mouse_Click(316,1122, {Timeout: (1*Delay_Long+0)}) ; Tap on Chat Bar

		Mouse_Click(33,62, {Timeout: (1*Delay_Medium+0)}) ; Tap back Button

		Mouse_Click(289,165, {Timeout: (1*Delay_Medium+0)}) ; Tap on first Chat Room "Alliance"

		Mouse_Click(227,1215, {Timeout: (1*Delay_Medium+0)}) ; Tap in Message Box

		; Shake phone
		Command_To_Screen("!{F2}")
		DllCall("Sleep","UInt",(1*Delay_Long+0))

		; Gosub Get_Window_Geometry
		Gosub Check_Window_Geometry

		Mouse_Click(33,62, {Timeout: (1*Delay_Medium+0)}) ; Tap back Button

		if !Go_Back_To_Home_Screen()
			Reload_LEWZ()
	}
	return
}

Activity_Center_Open()
{
	oGraphicSearch := new graphicsearch()
	loop, 3
	{
		loop, 3
		{
			if !Go_Back_To_Home_Screen()
				Reload_LEWZ()
			; Mouse_Drag(200, 350, 332, 350, {EndMovement: T, SwipeTime: 500})
			Mouse_Drag(200, 350, 332, 350, {EndMovement: F, SwipeTime: 500})
			; Mouse_Drag(110, 536, 262, 537, {EndMovement: T, SwipeTime: 500})
			Mouse_Click(137,580) ; Tap activity center
			
			; Mouse_Drag(82, 536, 335, 536, {EndMovement: T, SwipeTime: 500})
			; Mouse_Click(180,600) ; Tap Activity Center

			Loop, 50
			{
				resultObj := oGraphicSearch.search(910_ActivityCtr_Title_Graphic, optionsObjCoords)
				if (resultObj)
					return 1
				Else
					DllCall("Sleep","UInt",(1*Delay_Short+0))
			}
		}
		Reset_Posit()
	}
	return 0
}

Desert_Wonder:
{
	if !Activity_Center_Open()
		goto Desert_Wonder_END

	Desert_Wonder_Continue:
	oGraphicSearch := new graphicsearch()	
	loop, 3
	{
		loop, 50
		{
			resultObj := oGraphicSearch.search(917_DesertWonder_Button_Graphic, optionsObjCoords)
			if (resultObj)
			{
				Mouse_Click(resultObj[1].x,resultObj[1].y) ; Tap Desert Wonder
				goto Desert_Wonder_Continue_Tab
			}
			Else
				DllCall("Sleep","UInt",(1*Delay_Short+0))
		}
		Mouse_Drag(350, 900, 350, 500, {EndMovement: T, SwipeTime: 500})
	}
	goto Desert_Wonder_END

	Desert_Wonder_Continue_Tab:
	; MsgBox, 0, , Capture_Screen_Text:"%Capture_Screen_Text%"`nSearch_Text_Array:"%Search_Text_Array%"

	; Find single occurence of image, return true or false	
	oGraphicSearch := new graphicsearch()
	Loop, 50
	{
		resultObj := oGraphicSearch.search(9170_DesertWonder_Title_Graphic, optionsObjCoords)
		if (resultObj)
			goto Desert_Wonder_Continue_Claim
		Else
			DllCall("Sleep","UInt",(1*Delay_Short+0))
	}
	goto Desert_Wonder_END

	Desert_Wonder_Continue_Claim:
	; MsgBox, 0, , Capture_Screen_Text:"%Capture_Screen_Text%"`nSearch_Text_Array:"%Search_Text_Array%"
	Mouse_Click(259, 144, {Timeout: (2*Delay_Long+0)}) ; Tap Activity Tab
	
	loop, 2
	{
		gosub Wonder_Reward_Boxes
		gosub Receive_Rewards
	}
	goto Desert_Wonder_END
	
	Wonder_Reward_Boxes:
	Min_X := 240
	Max_X := 640
	Min_Y := 600
	Max_Y := 600
	Click_X_Delta := 200
	Click_Y_Delta := 0
	Click_X := Min_X
	Click_Y := Min_Y
	Loop, 6
	{
		Mouse_Click(Click_X,Click_Y, {Timeout: (1*Delay_Short+0)}) ; Tap Wonder reward boxes
		Mouse_Click(330,1000, {Timeout: (1*Delay_Short+0)}) ; Tap Collect Rewards
		loop, 2
			Mouse_Click(330,70, {Clicks: 2,Timeout: (1*Delay_Medium+0)})
		if ((Click_X <= Max_X) && (Click_X >= Min_X))
			Click_X += Click_X_Delta
		else
			Click_X := Min_X
	}
	return
	
	Receive_Rewards:
	Min_X := 600
	Max_X := 600
	Min_Y := 800
	Max_Y := 1130
	Click_X_Delta := 0
	Click_Y_Delta := 165
	Click_X := Min_X
	Click_Y := Min_Y
	Loop, 6
	{
		Mouse_Click(Click_X,Click_Y, {Timeout: (1*Delay_Short+0)}) ; Tap "Receive Rewards"
		Mouse_Click(330,1000, {Timeout: (1*Delay_Short+0)}) ; Tap Collect Rewards
		loop, 2
			Mouse_Click(330,70, {Clicks: 2,Timeout: (1*Delay_Medium+0)})
		if ((Click_Y <= Max_Y) && (Click_Y >= Min_Y))
			Click_Y += Click_Y_Delta
		else
			Click_Y := Min_Y
	}
	return
	
	Desert_Wonder_END:
	; MsgBox, 0, Pause, All rewards claimed? Press OK to return home (No Timeout)
	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()

	return
}

Benefits_Center:
{
	Subroutine_Running := "Benefits_Center"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Subroutines_Text_Array := {Claim_Buttons : [9221_Claim_Button_Graphic, True]
	, Claim_Buttons : [9222_Claim_Button_Graphic, True]
	, Daily_Signin : [923_DailySignin_Button_Graphic, True]
	, Monthly_Package_Collect : [924_MonthlyPackage_Button_Graphic, True]
	, Monthly_Signin : [9251_MonthlySignin_Button_Graphic, True]
	, Monthly_Signin : [9252_MonthlySignin_Button_Graphic, True]
	, Select_Reward : [926_SelectReward_Button_Graphic, True]
	, Selection_Chest : [9271_SelectionChest_Button_Graphic, True]
	, Selection_Chest : [9272_SelectionChest_Button_Graphic, True]
	, Single_Cumulation : [928_SingleCumulation_Button_Graphic, True]
	, Battle_Honor_Collect : [921_BattleHonor_Button_Graphic, True]
	, Warrior_Trial : [929_WarriorTrial_Button_Graphic, True]}

	loop, 2
		Mouse_Click(625,310, {Timeout: (1*Delay_Micro+0)}) ; Tap Benefits Center
		; Mouse_Click(625,310) ; Tap Benefits Center
	; DllCall("Sleep","UInt",(1*Delay_Long+0)) ; wait for Benefits Center to load
	Gosub Benefits_Center_Reload
	
	loop, 10
	{
		; loop, 2
			Gosub Benefits_Check_Tabs_New
		gosub Swipe_Right
	}
	
	Go_Back_To_Home_Screen()
	loop, 2
		Mouse_Click(625,310, {Timeout: (1*Delay_Micro+0)}) ; Tap Benefits Center
	Gosub Benefits_Center_Reload
	Gosub Benefits_Check_Tabs_New

	Goto Benefits_Center_END

	Swipe_Right:
	{
		; Benefits Center Swipe Right One position
		; Mouse_Drag(580, 187, 116, 187, {EndMovement: T, SwipeTime: 500})
		; Mouse_Drag(580, 187, 90, 187, {EndMovement: T, SwipeTime: 500})
		; Mouse_Drag(500, 187, 120, 187, {EndMovement: T, SwipeTime: 500})
		Mouse_Drag(500, 187, 300, 187, {EndMovement: T, SwipeTime: 300}) ; 324 is half
		; Mouse_Drag(500, 187, 300, 187, {EndMovement: T, SwipeTime: 500}) ; 324 is half
		; DllCall("Sleep","UInt",(1*Delay_Medium+0))
	}
	return

	Benefits_Center_Reload:
	Subroutine_Running := "Benefits_Center_Reload"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	oGraphicSearch := new graphicsearch()	
	loop, 5
	{
		loop, 20
		{
			; Find single occurence of image, return true or false
			resultObj := oGraphicSearch.search(920_Benefits_Title_Graphic, optionsObjCoords)
			if (resultObj)
				return
			Else
				DllCall("Sleep","UInt",(1*Delay_Micro+0))
		}

		; Gosub Get_Window_Geometry
		Gosub Check_Window_Geometry
		if !Go_Back_To_Home_Screen()
			Reload_LEWZ()
		loop, 4
			Mouse_Click(625,310, {Timeout: (1*Delay_Micro+0)}) ; Tap Benefits Center
		; DllCall("Sleep","UInt",(4*Delay_Long+0))
		
		loop, 60
		{
			; Find single occurence of image, return true or false
			resultObj := oGraphicSearch.search(920_Benefits_Title_Graphic, optionsObjCoords)
			if (resultObj)
				return
			Else
				DllCall("Sleep","UInt",(1*Delay_Micro+0))
		}
	}
	return

	Benefits_Center_END:
	Go_Back_To_Home_Screen()
		; Reload_LEWZ()
	return
	
	Benefits_Check_Tabs_New:
	{
		Subroutine_Running := "Benefits_Check_Tabs_New"
		stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
		
		; Gosub Claim_Buttons
		
		oGraphicSearch := new graphicsearch()	
		For Subroutine,Query in Subroutines_Text_Array
		{
			; GraphicSearch_Query := Query[1]
			; Run_Routine := (byref Query[2])
			Gosub Claim_Buttons

			If (Query[2]) ; if Query is true, check for it
			{
				resultObj := oGraphicSearch.search(Query[1], optionsObjCoords)
				if (resultObj)
				{
					loop, 2
						Mouse_Click(resultObj[1].x,resultObj[1].y, {Timeout: (1*Delay_Micro+0)}) ; Tap found Heading
					
					DllCall("Sleep","UInt",(3*Delay_Medium+0)) ; wait for tab to load
					if IsLabel(Subroutine)
						Gosub %Subroutine%
					if (Subroutine != "Claim_Buttons")
						Query[2] := False
					Gosub Benefits_Center_Reload
				}
			}
		}
		return
	}

	Select_Reward:
	{
		Subroutine_Running := "Select_Reward"
		stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )

		Mouse_Click(644,512, {Timeout: (1*Delay_Short+0)}) ; Select Reward - Drop Down Menu

		; Mouse_Click(570,696, {Timeout: (1*Delay_Short+0)}) ; Select Reward - Select Tech
		Mouse_Click(570, 936, {Timeout: (1*Delay_Short+0)}) ; Select Reward - Select Other
		; Mouse_Click(570,602, {Timeout: (1*Delay_Short+0)}) ; Select Reward - Select Desert

		Mouse_Click(565,995, {Timeout: (1*Delay_Short+0)}) ; Claim VIP points
		; Mouse_Click(343,750, {Timeout: (1*Delay_Short+0)}) ; Claim Strengthening also silver medals

		Mouse_Click(320,70, {Timeout: (1*Delay_Short+0)}) ; Tap top title bar
		; Mouse_Click(379,1172, {Timeout: (1*Delay_Short+0)}) ; Tap Outside Congrats Popup

		return
	}

	Monthly_Package_Collect:
	{
		Subroutine_Running := "Monthly_Package_Collect"
		stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )

		Mouse_Click(500,1200) ; Tap Claim

		loop, 12
				Mouse_Click(320,70, {Timeout: (1*Delay_Micro+0)}) ; Tap top title bar

		return
	}

	Warrior_Trial:
	{
		Subroutine_Running := "Warrior_Trial_Collect"
		stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
		; Mouse_Click(500,1200) ; Tap Claim

		Mouse_Click(560,1220, {Timeout: (3*Delay_Short+0)}) ; Select redeem steel
		Mouse_Click(366,680, {Timeout: (3*Delay_Short+0)}) ; Select max redeem slide bar
		Mouse_Click(336,780, {Timeout: (3*Delay_Short+0)}) ; Select Exchange button

		Mouse_Click(560,975, {Timeout: (3*Delay_Short+0)}) ; Select redeem silver medals
		Mouse_Click(366,680, {Timeout: (3*Delay_Short+0)}) ; Select max redeem slide bar
		Mouse_Click(336,780, {Timeout: (3*Delay_Short+0)}) ; Select Exchange button

		loop, 12
				Mouse_Click(320,70, {Timeout: (1*Delay_Micro+0)}) ; Tap top title bar

		return
	}

	Single_Cumulation:
	{
		Subroutine_Running := "Single_Cumulation"
		stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )

		Mouse_Click(560,550) ; Tap Claim

		loop, 12
				Mouse_Click(320,70, {Timeout: (1*Delay_Micro+0)}) ; Tap top title bar

		return
	}

	Claim_Buttons:
	{
		Subroutine_Running := "Claim_Buttons"
		stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount ) 

		ClaimButtons := 9221_Claim_Button_Graphic 9222_Claim_Button_Graphic 
		oUse_ButtonSearch := new graphicsearch()
		loop, 2 ; 5
		{
			resultUse_Button := oUse_ButtonSearch.search(ClaimButtons, optionsObjCoords)
			if (resultUse_Button)
			{
				loop, % resultUse_Button.Count()
				{
					Mouse_Click(resultUse_Button[A_Index].x,resultUse_Button[A_Index].y, {Timeout: (1*Delay_Medium+0)}) ; Tap "Claim" button			
					loop, 3
						Mouse_Click(320,70, {Timeout: (1*Delay_Micro+0)}) ; Tap top title bar
				}
			}
			; Else
			;	DllCall("Sleep","UInt",(1*Delay_Short+0))
		}
		return
	}

	Daily_Signin:
	{
		Subroutine_Running := "Daily_Signin"
		stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
		Mouse_Click(103,553, {Timeout: (2*Delay_Short+0)}) ; Daily Sign-In Click Day 1
		Mouse_Click(343,560, {Timeout: (2*Delay_Short+0)}) ; Daily Sign-In Click Day 2
		Mouse_Click(560,550, {Timeout: (2*Delay_Short+0)}) ; Select B Reward
		Mouse_Click(560,550, {Timeout: (2*Delay_Short+0)}) ; Select B Reward
		Mouse_Click(343,1125, {Timeout: (2*Delay_Short+0)}) ; Tap "OK"
		Mouse_Click(330,1230, {Timeout: (2*Delay_Short+0)}) ; Tap Bottom Middle
		Mouse_Click(560,550, {Timeout: (2*Delay_Short+0)}) ; Daily Sign-In Click Day 3
		Mouse_Click(560,550, {Timeout: (2*Delay_Short+0)}) ; Select B Reward
		Mouse_Click(343,1125, {Timeout: (2*Delay_Short+0)}) ; Tap "OK"
		Mouse_Click(330,1230, {Timeout: (2*Delay_Short+0)}) ; Tap Bottom Middle
		Mouse_Click(556,819, {Timeout: (2*Delay_Short+0)}) ; Daily Sign-In Click Day 4
		Mouse_Click(330,1230, {Timeout: (2*Delay_Short+0)}) ; Tap Bottom Middle
		Mouse_Click(334,819, {Timeout: (2*Delay_Short+0)}) ; Daily Sign-In Click Day 5
		Mouse_Click(330,1230, {Timeout: (2*Delay_Short+0)}) ; Tap Bottom Middle
		Mouse_Click(109,809, {Timeout: (2*Delay_Short+0)}) ; Daily Sign-In Click Day 6
		Mouse_Click(330,1230, {Timeout: (2*Delay_Short+0)}) ; Tap Bottom Middle
		Mouse_Click(330,1035, {Timeout: (2*Delay_Short+0)}) ; Daily Sign-In Click Day 7
		Mouse_Click(560,550, {Timeout: (2*Delay_Short+0)}) ; Select B Reward
		Mouse_Click(343,1125, {Timeout: (2*Delay_Short+0)}) ; Tap "OK"
		loop, 12
			Mouse_Click(320,70, {Timeout: (1*Delay_Micro+0)}) ; Tap top title bar
		loop, 7
			Mouse_Click(320,70, {Timeout: (1*Delay_Short+0)}) ; Tap top title bar

		return
	}

	Monthly_Signin:
	{
		Subroutine_Running := "Monthly_Signin"
		stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
		; Claim Monthly
		loop, 2
			Mouse_Click(342,1215, {Timeout: (2*Delay_Short+0)}) ; Tap collect Monthly Signin

		Mouse_Click(153,323, {Timeout: (2*Delay_Short+0)}) ; Claim 5 Days
		Gosub Collect_and_Clear

		Mouse_Click(266,323, {Timeout: (2*Delay_Short+0)}) ; Claim 10 Days
		Gosub Collect_and_Clear

		Mouse_Click(380,323, {Timeout: (2*Delay_Short+0)}) ; Claim 15 Days
		Gosub Collect_and_Clear

		Mouse_Click(505,323, {Timeout: (2*Delay_Short+0)}) ; Claim 20 Days
		Gosub Collect_and_Clear

		Mouse_Click(633,323, {Timeout: (2*Delay_Short+0)}) ; Claim 25 Days
		Gosub Collect_and_Clear

		return
	}

	Collect_and_Clear:
	{
		Mouse_Click(340,1000, {Timeout: (2*Delay_Short+0)}) ; Tap Collect Button
		Mouse_Click(340,40, {Timeout: (2*Delay_Short+0)}) ; 1215) ; Tap to Clear

		return
	}

	Selection_Chest:
	{
		Subroutine_Running := "Selection_Chest"
		stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )

		Mouse_Click(87,430, {Timeout: (8*Delay_Short+0)}) ; Tap Free Chest
		Mouse_Click(52,682, {Timeout: (2*Delay_Short+0)}) ; Select 1,000 Diamonds
		Mouse_Click(517,680, {Timeout: (2*Delay_Short+0)}) ; Select Silver Medal

		; Swipe Up X times
		loop, 2
			Mouse_Drag(300, 1030, 300, 650, {EndMovement: F, SwipeTime: 300})

		DllCall("Sleep","UInt",(1*Delay_Long+0))

		Mouse_Click(205,770, {Timeout: (2*Delay_Short+0)}) ; Select 1,000 Vip Points X 10
		Mouse_Click(520,960, {Timeout: (2*Delay_Short+0)}) ; Select 500K Strength Abilities Exp

		Mouse_Click(60,960) ; Select Super Officer
		; DllCall("Sleep","UInt",(1*Delay_Short+0))

		loop, 2
			Mouse_Click(349,1207, {Timeout: (1*Delay_Short+0)}) ; Tap Collect

		return
	}

	Battle_Honor_Collect:
	Subroutine_Running := "Battle_Honor_Collect"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	{
		; loop, 4
		{
			Gosub Battle_Honor_Click
			Gosub Battle_Honor_Click
			Gosub Battle_Honor_Swipe
		}
		Gosub Battle_Honor_Click
		goto Battle_Honor_END
		return

		Battle_Honor_Click:
		{
			Mouse_Click(260,636, {Clicks: 2,Timeout: (2*Delay_Short+0)}) ; Tap Battle Honor 01
			Mouse_Click(260,800, {Clicks: 2,Timeout: (2*Delay_Short+0)}) ; Tap Battle Honor 03
			Mouse_Click(260,963, {Clicks: 2,Timeout: (2*Delay_Short+0)}) ; Tap Battle Honor 05
			Mouse_Click(260,1126, {Clicks: 2,Timeout: (2*Delay_Short+0)}) ; Tap Battle Honor 07
			Mouse_Click(260,720, {Clicks: 2,Timeout: (2*Delay_Short+0)}) ; Tap Battle Honor 02
			Mouse_Click(260,883, {Clicks: 2,Timeout: (2*Delay_Short+0)}) ; Tap Battle Honor 04
			Mouse_Click(260,1050, {Clicks: 2,Timeout: (2*Delay_Short+0)}) ; Tap Battle Honor 06
			Mouse_Click(260,1202, {Clicks: 2,Timeout: (2*Delay_Short+0)}) ; Tap Battle Honor 08
			return
		}

		Battle_Honor_Swipe:
		{
			Mouse_Drag(350, 1203, 360, 609, {EndMovement: T, SwipeTime: 500})
			Return
		}

		Battle_Honor_END:
		return
	}
}

; Tap Speaker/help
Speaker_Help:
{
	Subroutine_Running := "Speaker_Help"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; if !Go_Back_To_Home_Screen()
		; Reload_LEWZ()

	loop, 2
		Mouse_Click(630,1033, {Timeout: (1*Delay_Medium+0)}) ; Tap speaker/help

	oGraphicSearch := new graphicsearch()
	loop, 2
	{
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		resultObj := oGraphicSearch.search(71_Speaker_Claim_Button_Graphic, optionsObjCoords)
		if (resultObj)
		{
			Mouse_Click(resultObj[1].x,resultObj[1].y)
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
			break
		}
		Else
		{
			Mouse_Click(630,1033, {Timeout: (1*Delay_Medium+0)}) ; Tap speaker/help
		}
	}
	
	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return
}

Drop_Zone:
{
	Subroutine_Running := "Drop_Zone"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(285,200) ; Tap On Drop Zone
	; DllCall("Sleep","UInt", (2*Delay_Long+0))
	loop, 20
		Mouse_Click(410,1050, {Clicks: 2,Timeout: (3*Delay_Short+0)}) ; Get Steel X Times
	oGraphicSearch := new graphicsearch()
	
	B361_Click_Button := B3611_Click_Button B3612_Click_Button
		
	loop, 20 ; 50
	{
		resultObj := oGraphicSearch.search(B361_Click_Button_Graphic, optionsObjCoords)
		if (resultObj)
			loop, 5
				Mouse_Click(410,1050, {Clicks: 2,Timeout: (2*Delay_Short+0)}) ; Get Steel X Times
		Else
			DllCall("Sleep","UInt",(1*Delay_Short+0))
	}

	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return
}

Adventure_Missions:
{
	Subroutine_Running := "Adventure_Missions"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return
}

Collect_Cafeteria:
{
	Subroutine_Running := "Collect_Cafeteria"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(379,736, {Timeout: (1*Delay_Long+0)}) ; Collect Cafeteria

	; if !Go_Back_To_Home_Screen()
		; Reload_LEWZ()
	return
}

Active_Skill:
{
	Subroutine_Running := "Active_Skill"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	
	OfficerSkills := 8331_Instructor_Title_Graphic 8332_Magic_Title_Graphic 8333_WildHarvest_Title_Graphic 8341_Bumper_Title_Graphic 8351_AbilityRsrch_Title_Graphic 8352_FirstRiches_Title_Graphic 8353_FullofStrength_Title_Graphic 8354_Promotion_Title_Graphic 8355_SkillfulWork_Title_Graphic 8356_SpecTrain_Title_Graphic 

	Mouse_Click(195,1195) ; Tap Activate Skills
	; DllCall("Sleep","UInt",(rand_wait + 3*Delay_Medium+0))

	Gosub Active_Skill_Reload
	loop, 2
		Mouse_Click(215,425, {Timeout: (1*Delay_Micro+0)}) ; Active Skill tab #2 - Officer
	Gosub Active_Skill_Click_Button
	
	/*
	loop, 2
		Mouse_Click(340,425, {Timeout: (1*Delay_Micro+0)}) ; Active Skill tab #3 - Combat
	Gosub Active_Skill_Click_Button
	*/

	loop, 2
		Mouse_Click(470,425, {Timeout: (1*Delay_Micro+0)}) ; Active Skill tab #4 - Develop
	Gosub Active_Skill_Click_Button

	loop, 2
		Mouse_Click(600,425, {Timeout: (1*Delay_Micro+0)}) ; Active Skill tab #5 - Support
	Gosub Active_Skill_Click_Button
	
	goto Active_Skill_END
	
	Active_Skill_Click_Button:
	DllCall("Sleep","UInt",(1*Delay_Long+0))
	oUse_ButtonSearch := new graphicsearch()
	loop, 5
	{
		resultUse_Button := oUse_ButtonSearch.search(832_Green_Use_Button_Graphic, optionsObjCoords)
		if (resultUse_Button)
		{
			sortedUse_Button := oUse_ButtonSearch.resultSort(resultUse_Button)
			Reverse_Index := sortedUse_Button.Count()
			loop, % sortedUse_Button.Count()
			{	
				Mouse_Click(sortedUse_Button[Reverse_Index].x,sortedUse_Button[Reverse_Index].y, {Timeout: (6*Delay_Short+0)}) ; (3*Delay_Short+0)})
				gosub Active_Skill_Titles
				Mouse_Click(350,350, {Timeout: (1*Delay_Micro+0)}) ; Tap Active skill title bar
				Gosub Active_Skill_Reload
				Reverse_Index--
			}
			return
		}
		DllCall("Sleep","UInt",(1*Delay_Micro+0))
		Gosub Active_Skill_Reload
	}
	return
	
	Active_Skill_Titles:
	{
		; DllCall("Sleep","UInt",(4*Delay_Short+0))
		oTitlesSearch := new graphicsearch()
		loop, 20
		{
			resultTitles := oTitlesSearch.search(831_Blue_Use_Button_Graphic, optionsObjCoords)
			if (resultTitles)
				Goto Active_Skill_Titles_Continue ; break
			Else
				DllCall("Sleep","UInt",(1*Delay_Micro+0))
		}
		Gosub Active_Skill_Reload
		return
		
		Active_Skill_Titles_Continue:
		oTitlesSearch := new graphicsearch()
		resultTitles := oTitlesSearch.search(OfficerSkills, optionsObjCoords)
		if (resultTitles)
			Mouse_Click(340,780, {Timeout: (1*Delay_Medium+0)}) ; Tap Blue "Use" button

		Mouse_Click(350,350, {Timeout: (1*Delay_Micro+0)}) ; Tap Active skill title bar

		Gosub Active_Skill_Reload
		return
	}

	Active_Skill_Reload:
	
	ActiveSkill_Title_Graphics := 8301_ActiveSkill_Title_Graphic 8302_ActiveSkill_Title_Graphic
	loop, 2
	{
		; check to see if active skill is properly displayed x times
		
		oSkill_TitleSearch := new graphicsearch()
		loop, 20
		{
			resultSkill_Title := oSkill_TitleSearch.search(ActiveSkill_Title_Graphics, optionsObjCoords)
			if (resultSkill_Title)
			{
				Mouse_Click(resultSkill_Title[1].x,resultSkill_Title[1].y, {Timeout: 0}) ; (1*Delay_Short+0)})
				return
			}
			Else
				DllCall("Sleep","UInt",(1*Delay_Short+0))
		}

		; Gosub Get_Window_Geometry
		Gosub Check_Window_Geometry
		if !Go_Back_To_Home_Screen()
			Reload_LEWZ()
		Mouse_Click(195,1195) ; Tap Activate Skills
		; DllCall("Sleep","UInt",(rand_wait + 3*Delay_Medium+0))
	}
	return

	Active_Skill_END:
	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return

}

Collect_Chips_Underground:
{
	Subroutine_Running := "Collect_Chips_Underground"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; Tap underground
	; Tap Misslie Silo
	; Tap underground Construsction Center
	; Hit F5 for back button
	; Swipe from lower right to upper left
	; Tap on each Chip Plant
	; Hit F5 for back button

	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return
}

; upgrade and ask for factory help during csb
Reserve_Factory:
{
	Subroutine_Running := "Reserve_Factory"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; if !Go_Back_To_Home_Screen()
		; Reload_LEWZ()

	; *******************************
	; Collect Reserve supplies
	; *******************************
	Build_Button := 8744_BuildGray_Button_Graphic 8745_BuildBlue_Button_Graphic
	FactoryWorld_Graphic := 8746_FactoryWorld_Button_Graphic 8747_FactoryWorld_Button_Graphic

	Gosub Alliance_Help_Open

	if Pause_Script
		MsgBox, 0, Pause, Press OK to resume (No Timeout)

	Mouse_Click(110,340, {Timeout: (6*Delay_Long+0)}) ; Tap Reserve Factory Icon

	loop, 4
	{
		Mouse_Click(344,590, {Timeout: (4*Delay_Short+0)}) ; Tap Reserve Factory On World Map
	}
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

	; *******************************
	; Upgrade, Add Energy, Use, Etc, X Times
	; *******************************
	Loop, 3
	{
		Gosub Alliance_Help_Open

		Mouse_Click(119,336, {Timeout: (1*Delay_Long+0)}) ; Tap Reserve Factory Icon

		Mouse_Click(240,613, {Timeout: (1*Delay_Long+0)}) ; Tap Info Menu On Reserve Factory On World Map

		; Mouse_Click(324,797) ; Tap Upgrade, Add Energy, Use, Etc, X Times
		loop, 10
		{
			Mouse_Click(324,797, {Timeout: (1*Delay_Short+0)}) ; Tap Upgrade, Add Energy, Use, Etc, X Times
		}
		Mouse_Click(320,70, {Timeout: (1*Delay_Medium+0)}) ; Tap top title bar
		Mouse_Click(320,70, {Timeout: (1*Delay_Medium+0)}) ; Tap top title bar

		Mouse_Click(33,62) ; Tap back Button
		; Command_To_Screen("{F5}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	; *******************************
	; Instant Help and Request Help
	; *******************************

	Gosub Alliance_Help_Open

	loop, 2
	{
		Mouse_Click(320,405, {Timeout: (Delay_Long+0)}) ; Tap Instant Help
		Mouse_Click(510,415, {Timeout: (Delay_Medium+0)}) ; Tap Request Help
	}

	; Go_Back_Home_Delay_Long := True
	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return

	Alliance_Help_Open:
	oGraphicSearch := new graphicsearch()
	{
		loop, 2
		{
			Mouse_Click(610,1200, {Timeout: (2*Delay_Long+0)}) ; Tap Alliance Menu
			; oGraphicSearch := new graphicsearch()
					
			Loop, 40
			{
				resultObj := oGraphicSearch.search(870_AllianceMenu_Title_Graphic, optionsObjCoords)
				if (resultObj)
					break
				Else
					DllCall("Sleep","UInt",(1*Delay_Short+0))
			}
				
			oGraphicSearch := new graphicsearch()
			Loop, 40
			{
				resultObj := oGraphicSearch.search(874_Help_Button_Graphic, optionsObjCoords)
				if (resultObj)
				{
					Mouse_Click(resultObj[1].x,resultObj[1].y) ; Mouse_Click(355,825) ; Tap Alliance Help
					goto Alliance_Help_Continue
				}
				Else
					DllCall("Sleep","UInt",(1*Delay_Short+0))
			}
			if !Go_Back_To_Home_Screen()
				Reload_LEWZ()
		}
		return
		; MsgBox, 0, Pause, Loop done. Press OK to resume (No Timeout)

		Alliance_Help_Continue:
		; Mouse_Click(355,825, {Timeout: (1*Delay_Medium+0)}) ; Tap Alliance Help
		DllCall("Sleep","UInt",(1*Delay_Medium+0))		
		; DllCall("Sleep","UInt",(1*Delay_Long+0))

		Mouse_Click(480,140, {Timeout: (1*Delay_Medium+0)}) ; Tap Reserve Factory Help Tab	
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		
		; 8741_Build_Button_Graphic, Build button in help menu, indicating factory is not built
		oGraphicSearch := new graphicsearch()
		Loop, 10
		{
			resultObj := oGraphicSearch.search(8741_Build_Button_Graphic, optionsObjCoords)
			if (resultObj)
			{
				return ;  skip build factory
				Mouse_Click(resultObj[1].x,resultObj[1].y) ; Mouse_Click(350,400) ; Tap "Go Build."
				gosub Reserve_Factory_Build
				goto Alliance_Help_Open ; break
			}
			Else
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}

		return
	}
	
	Reserve_Factory_Build:
	{		
		oBuildIcon := new graphicsearch()
		oBuildBuild := new graphicsearch()
		Build_Yes := 8742_BuildIcon_Button_Graphic 8743_BuildBuild_Button_Graphic
		; 8742_BuildIcon_Button_Graphic, build Icon on world map
		; 8743_BuildBuild_Button_Graphic, Green build button on Build menu
		loop, 10
		{
			loop, 20
			{
				resultBuildIcon := oBuildIcon.search(8742_BuildIcon_Button_Graphic, optionsObjCoords)
				if (resultBuildIcon)
				{
					Mouse_Click(resultBuildIcon[1].x,resultBuildIcon[1].y, {Timeout: (1*Delay_Long+0)}) ;
					
					resultBuildBuild := oBuildBuild.search(8743_BuildBuild_Button_Graphic, optionsObjCoords)
					if (resultBuildBuild)
					{
						Mouse_Click(resultBuildBuild[1].x,resultBuildBuild[1].y, {Timeout: (1*Delay_Long+0)}) ;
						goto Reserve_Factory_Build_Next ; break
					}
				}
			}
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
			Mouse_Click(344,590, {Timeout: (1*Delay_Long+0)}) ; Tap Reserve Factory On World Map
		}
		
		Reserve_Factory_Build_Next:
		; 8744_BuildGray_Button_Graphic, Build button is gray, space obstructed	
		; 8745_BuildBlue_Button_Graphic, Build button is blue, space not obstructed 
			; tap button, if button still visible, reposition and try again
		; 8746_FactoryWorld_Button_Graphic, Factory graphic on world map (unselected)
		; 8747_FactoryWorld_Button_Graphic, Factory graphic on world map (selected)
			; drag factory left, and tap build
		loop, 30
		{
			oBuild_Button := new graphicsearch()
			oFactoryWorld := new graphicsearch()
			resultBuild_Button := oBuild_Button.search(Build_Button, optionsObjCoords)
			if (resultBuild_Button)
			{
				Mouse_Click(resultBuild_Button[1].x,resultBuild_Button[1].y, {Timeout: (1*Delay_Medium+0)}) ;
				; Mouse_Click(resultBuild_Button[1].x,resultBuild_Button[1].y) ;
				
				; if button still visible, reposition and try again
				; oBuild_Button := new graphicsearch()
				resultBuild_Button := oBuild_Button.search(Build_Button, optionsObjCoords)
				if (resultBuild_Button)
				{
					resultoFactoryWorld := oFactoryWorld.search(FactoryWorld_Graphic, optionsObjCoords)
					if (resultoFactoryWorld)
					{
						Drag_X1 := resultoFactoryWorld[1].x
						Drag_X2 := (Drag_X1 - 200)
						Drag_Y := resultoFactoryWorld[1].y
						Mouse_Drag(Drag_X1, Drag_Y, Drag_X2, Drag_Y, {EndMovement: F, SwipeTime: 1000})
						; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
					}
				}
				Else
				{
					; return
					DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
					; MsgBox, 0, Pause, loop %A_Index% Build_Button not found 01. Press OK to resume (No Timeout)
				}
			}
			Else
			{
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
				; MsgBox, 0, Pause, loop %A_Index% Build_Button not found 02. Press OK to resume (No Timeout)
			}
		}
		return
	}

}

; open alliance technology menu and tap donate until time > 4 hours
Donate_Tech:
{
	Subroutine_Running := "Donate_tech"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )

	loop, 3
	{
		Gosub Donate_Tech_Control_Desk_Expand
		loop, 3
		{
			Gosub Click_Top_Tech
			if Search_Captured_Text_OCR(["Technology"]).Found
				goto Donate_Tech_Open_NEXT ; Donate_Tech_Open
		}
		if !Go_Back_To_Home_Screen()
			Reload_LEWZ()
	}
	goto Donations_OVER

	Donate_Tech_Open:
	Search_Captured_Text := ["Rank","Ran"]
	OCR_X := 70
	OCR_Y := 215
	OCR_W := 60
	OCR_H := 40
	loop, 4
	{
		Gosub Click_Top_Tech
		goto Donate_Tech_Open_NEXT
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H]}).Found
			goto Donate_Tech_Open_NEXT
	}

	Donate_Tech_Open_NEXT:
	Gosub Click_Top_Tech
	global Tech_Click_Initial := 350
	global Tech_Click_Inc := 140
	global Tech_Click_Y := Tech_Click_Initial

	Collapse_X := 100
	Collapse_Y := 240
	Collapse_Delta = 60
	/*
	loop, 4
	{
		Gosub Donate_Tech_Find_And_Click
		Mouse_Click(Collapse_X,Collapse_Y) ; Tap To expand previous Rank Tech
		Collapse_Y += Collapse_Delta
	}
	Goto Donations_OVER

	; Mouse_Click(469,350) ; Tap Tech #1 Y = 275-375 / Rank #2 Y = 340-440 / #3 405-505 RankDelta = 65 (deltaY = 140)
	; Mouse_Click(469,240) ; Rank 01 - 30, 222-259 = 240
	; Mouse_Click(469,300) ; Rank 02 - 30, 280-322 = 300
	; Mouse_Click(469,360) ; Rank 03 - 30, 343-386 = 360
	; Mouse_Click(469,420) ; Rank 04 - 30, 407-451 = 420
	*/

	Donate_Tech_Find_And_Click:
	loop, 4
	{
		Tech_Click_Y := Tech_Click_Initial
		Outer_Loop_Donation:
		loop, 7
		{
			Subroutine_Running := "Donate_tech #" . Round(1+(Tech_Click_Y - Tech_Click_Initial)/Tech_Click_Inc, 0)
			stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )

			Inner_Loop_Donation:
			; loop, 2
			{
				Mouse_Click(469,Tech_Click_Y, {Timeout: (1*Delay_Long+0)}) ; select tech

				OCR_Donate_04 := Search_Captured_Text_OCR(["04:"], {Pos: [295, 730], Size: [50, 30]})
				; OCR_Donate_imm := Search_Captured_Text_OCR(["immediately"], {Pos: [140, 642], Size: [169, 42]})
				OCR_Donate_Buy := Search_Captured_Text_OCR(["Buy"], {Pos: [70, 820], Size: [55, 35]})

				if (OCR_Donate_04.Found)
					Goto Donations_OVER ; Goto Outer_Loop_Donation_Break ; Break Outer_Loop_Donation
				else if (OCR_Donate_Buy.Found)
				{
					loop, 22
					{
						Loop, 2
							Mouse_Click(420,1000, {Timeout: (1*Delay_Micro+0)}) ; Tap On Donation Box 3
							
						Loop, 2
							Mouse_Click(260,1000, {Timeout: (1*Delay_Micro+0)}) ; Tap On Donation Box 2
							
						Loop, 2
							Mouse_Click(100,1000, {Timeout: (1*Delay_Micro+0)}) ; Tap On Donation Box 1
							
					}
					DllCall("Sleep","UInt",(2*Delay_Long+0))
					if (OCR_Donate_04.Found)
						Goto Donations_OVER ; Goto Outer_Loop_Donation_Break ; Break Outer_Loop_Donation
				}
				; else if (OCR_Donate_imm.Found)
				; 	return ; Goto Outer_Loop_Donation_Break ; Break Outer_Loop_Donation

				/*
				VAR1 := % "1. F:""" OCR_Donate_04.Found """ V:""" OCR_Donate_04.Value """ T:""" RegExReplace(OCR_Donate_04.Text,"[\r\n]+") """"
				; VAR2 := % "2. F:""" OCR_Donate_imm.Found """ V:""" OCR_Donate_imm.Value """ T:""" RegExReplace(OCR_Donate_imm.Text,"[\r\n]+") """"
				VAR3 := % "3. F:""" OCR_Donate_Buy.Found """ V:""" OCR_Donate_Buy.Value """ T:""" RegExReplace(OCR_Donate_Buy.Text,"[\r\n]+") """"

				; VAR1 := RegExReplace(VAR1,"[\r\n]+")
				; VAR2 := RegExReplace(VAR2,"[\r\n]+")
				; VAR3 := RegExReplace(VAR3,"[\r\n]+")
				MsgBox, 0, OCR return, % "Was value (F)ound? Using what (V)alue? Found (T)ext:`n" VAR1 "`n" VAR2 "`n" VAR5 ; 3
				*/
			}
				; Gosub Click_Top_Tech

				if Pause_Script
					MsgBox, 0, Pause, Press OK to resume (No Timeout)

				Inner_Loop_Donation_Break:
				Tech_Click_Y += Tech_Click_Inc
				Gosub Click_Top_Tech
		}
		Outer_Loop_Donation_Break:
		Gosub Click_Top_Tech
		; return
		Mouse_Click(Collapse_X,Collapse_Y) ; Tap To expand previous Rank Tech
		Collapse_Y += Collapse_Delta
	}

	Donate_Tech_Control_Desk_Expand:
	{
		loop, 2
			Mouse_Click(7,637, {Timeout: (1*Delay_Long+0)}) ; Tap to Expand Control Desk
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		loop, 2
			Mouse_Drag(326, 405, 326, 957, {EndMovement: F, SwipeTime: 500})
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		Mouse_Click(469,960, {Timeout: 0}) ; Tap Goto Alliance Donation
		Mouse_Click(469,1005, {Timeout: 0}) ; Tap Goto Alliance Donation (Alt button) ; 476, 1001
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		
		return
	}

	Donate_Tech_Collapse_Tech_Short:
	{
		Min_Y := 225 ; 215
		Max_Y := 395 ; 455 ; Rank 1: 215, 2: 275, 3: 335, 4: 395, 5: 455, 6: 515
		Min_X := Max_X := OCR_X := Click_X := 70 ; 66
		OCR_Y := Min_Y
		OCR_W := 75 ; 100
		OCR_H := 40 ; 50
		Click_Y := (OCR_Y + 25)
		OCR_Y_Delta := 60

		while (OCR_Y <= Max_Y)
		{
			Capture_Screen_Text := OCR([OCR_X, OCR_Y, OCR_W, OCR_H], "eng")
			Capture_Screen_Text := RegExReplace(Capture_Screen_Text,"[\r\n\h]+")

			If (RegExMatch(Capture_Screen_Text,"Ran"))
				goto Donate_Tech_Collapse_Tech_Next
			If (RegExMatch(Capture_Screen_Text,"Needed"))
				goto Donate_Tech_Collapse_Tech_END
			If (RegExMatch(Capture_Screen_Text,""))
				goto Donate_Tech_Collapse_Tech_END

			goto Donate_Tech_Collapse_Tech_Next

			Donate_Tech_Collapse_Tech_END:
			if (Click_Y >= Min_Y)
				Click_Y -= OCR_Y_Delta
			Tech_Click_Initial := (Click_Y + 110)
			Mouse_Click(Click_X,Click_Y, {Timeout: (1*Delay_Long+0)}) ; Tap To expand previous Rank Tech
			; Gosub Donate_Tech_Find_And_Click
			return

			Donate_Tech_Collapse_Tech_Next:
			{
				Tech_Click_Initial := (Click_Y + 110)
				Mouse_Click(Click_X,Click_Y, {Timeout: (1*Delay_Long+0)}) ; Tap To Collapse Rank Tech
			}

			if (OCR_Y >= Max_Y)
				break

			if (OCR_Y < Max_Y)
				OCR_Y += OCR_Y_Delta

			Click_Y := (OCR_Y + 25)
			Gosub Click_Top_Tech
			DllCall("Sleep","UInt",(1*Delay_Medium+0))
			Capture_Screen_Text := ""

		}
		return
	}

	Click_Top_Tech:
	loop, 3
		Mouse_Click(340,70, {Timeout: (1*Delay_Short+0)}) ; Tap header
	return

	Donations_OVER:
	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return
}

Depot_Rewards:
{
	Subroutine_Running := "Depot_Rewards"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )

	; set variables 
	oGraphicSearch := new graphicsearch()
	loop, 3
	{
		Mouse_Click(140,662, {Timeout: (1*Delay_Long+0)}) ; Tap depot
		Mouse_Click(250,722, {Timeout: (1*Delay_Long+0)}) ; Tap Alliance Treasures
		loop, 20
		{
			resultObj := oGraphicSearch.search(B350_Depot_Title_Graphic, optionsObjCoords)
			if (resultObj)
				goto Continue_Depot_Treasures
			Else
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}
		Go_Back_To_Home_Screen()
	}
	goto Depot_Rewards_END

	Continue_Depot_Treasures:	
	gosub Find_Rewards_FREE

	Mouse_Click(340,150) ; Tap Tab 2 My Treasures
	gosub Find_Rewards_ALL

	Mouse_Click(570,150) ; Tap Tab 3 Help_List
	gosub Find_Rewards_ALL

	Depot_Rewards_END:
	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return

	Find_Rewards_FREE:
	oGraphicSearch := new graphicsearch()			
	; check if Free graphic is found
	loop, 10
	{
		resultObj := oGraphicSearch.search(B351_Free_Button_Graphic, optionsObjCoords)
		if (resultObj)
		{
			Mouse_Click(resultObj[1].x,resultObj[1].y, {Timeout: 0})
			break
		}
		Else
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}
	return

	Find_Rewards_ALL:
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	; check if any graphic was found
	oButtonsSearch := new graphicsearch()
	allQueries_Depot := B352_Help_Button_Graphic B353_Request_Button_Graphic B354_Reward_Button_Graphic
	loop, 20
	{
		resultButtons := oButtonsSearch.search(allQueries_Depot, optionsObjCoords)
		if (resultButtons)
		{
			sorted_Buttons := oButtonsSearch.resultSort(resultButtons)
			loop, % sorted_Buttons.Count()
			{
				Mouse_Click(sorted_Buttons[A_Index].x, sorted_Buttons[A_Index].y, {Timeout: (1*Delay_Medium+0)})
				Mouse_Click(320,70, {Timeout: (1*Delay_Medium+0)}) ; Tap top title bar
			}
			Break
		}
		Else
			DllCall("Sleep","UInt",(1*Delay_Short+0))
	}
	return
}

VIP_Shop:
{
	Subroutine_Running := "VIP_Shop"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; set variables 
	oGraphicSearch := new graphicsearch()
	loop, 5
	{
		Mouse_Click(156,90, {Timeout: (1*Delay_Long+0)}) ; Tap VIP Shop
		loop, 20
		{
			resultObj := oGraphicSearch.search(30_VIP_Title_Graphic, optionsObjCoords)
			if (resultObj)
				goto Continue_VIP_Shop
			Else
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}
		Go_Back_To_Home_Screen()
	}
	goto VIP_Shop_END

	Continue_VIP_Shop:
	; Button01 := 225, 575 ; (delta X:80, Y:100)
	; Button02 := 560, 575 ; (delta X:80, Y:100)
	; Button03 := 225, 745 ; (delta X:80, Y:100)
	; Button04 := 560, 745 ; (delta X:80, Y:100)

	Gosub VIP_Shop_Click_Button

	VIP_Shop_END:
	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return

	VIP_Shop_Click_Button:
	Search_Captured_Text := ["VIP Raffle"] ; ,"Basic Transport"]
	OCR_X := 480 ; delta 145-480 = 335
	OCR_Y := 815 ; delta 145-480 = 170
	OCR_W := 200
	OCR_H := 80
	Click_X := (OCR_Y + 80)
	Click_Y := (OCR_Y + 100)
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	loop, 6
	{
		; Looking for VIP items that match list
		if !Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H]}).Found
			goto VIP_Shop_Click_Button_Next

		VIP_Shop_Click_Found_Item:
		Mouse_Click(Click_X,Click_Y, {Timeout: (4*Delay_Short+0)}) ; Tap VIP item to purchase
		Mouse_Click(350,890, {Timeout: (4*Delay_Short+0)}) ; confirm purchase
		Mouse_Click(320,70, {Timeout: (3*Delay_Medium+0)}) ; Tap top title bar
		; Mouse_Click(350,1150, {Timeout: (3*Delay_Medium+0)}) ; Tap Outside Rewards Box

		VIP_Shop_Click_Button_Next:
		if (OCR_X >= 480)
			OCR_X := 145
		else
		{
			OCR_X := 480
			if (OCR_Y <= 475)
				OCR_Y := 815
			else
				OCR_Y -= 170
		}

		Click_X := (OCR_X + 80)
		Click_Y := (OCR_Y + 100)
	}
	return
}

Mail_Collection:
{
	Subroutine_Running := "Mail_Collection"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )

	Mouse_Click(500,1200) ; Tap Mail Icon
	Gosub Mail_Collection_Open

	Mouse_Click(200,272) ; Tap Alliance
	Gosub Mark_All_As_Read

	Mouse_Click(200,545) ; Tap Last Empire - War Z Studios
	Gosub Mark_All_As_Read

	Mouse_Click(200,633) ; Tap System
	Gosub Mark_All_As_Read

	Mouse_Click(200,760) ; Tap reports 01 - RSS gathering
	Gosub Mark_All_As_Read

	Mouse_Click(200,860) ; Tap reports 02 - Zombies
	Gosub Mark_All_As_Read

	Mouse_Click(200,960) ; Tap reports 03 - Missile attack
	Gosub Mark_All_As_Read

	Mouse_Click(200,1060) ; Tap reports 04 - Transport
	Gosub Mark_All_As_Read

	Mouse_Click(200,1160) ; Tap reports 05 - Other
	Gosub Mark_All_As_Read

	Mouse_Click(200,445, {Timeout: (1*Delay_Long+0)}) ; Tap Activities
	
	Mouse_Click(200,170) ; Tap Activities - SPAR (Single Player Arms Race)
	Gosub Mark_All_As_Read

	Mouse_Click(200,257) ; Tap Activities - AAR (Alliance Arms Race)
	Gosub Mark_All_As_Read

	Mouse_Click(200,360) ; Tap Activities - CSB (Cross-State Battle)
	Gosub Mark_All_As_Read

	Mouse_Click(200,445) ; Tap Activities - Desert Conflict
	Gosub Mark_All_As_Read

	Mouse_Click(200,540) ; Tap Activities - Other Event Mail
	Gosub Mark_All_As_Read

	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return
	
	Mark_All_As_Read_new:
	{
		DllCall("Sleep","UInt",(1*Delay_Long+0))
		Subroutine_Running := "Mark_All_As_Read"
		
		Mouse_Click(350,1200, {Timeout: (1*Delay_Medium+0)}) ; Tap "MARK AS READ"
		Mouse_Click(200,700, {Timeout: (1*Delay_Long+0)}) ; Tap "CONFIRM"
		Loop, 2
			Mouse_Click(340,70, {Timeout: (2*Delay_Short+0)}) ; Tap header to clear message
		gosub Mail_Collection_Open
		return
	}

	Mark_All_As_Read:
	{
		DllCall("Sleep","UInt",(1*Delay_Medium+0))
		Subroutine_Running := "Mark_All_As_Read"
		
		oMARK_READSearch := new graphicsearch()
		oCONFIRMSearch := new graphicsearch()
		loop, 8
		{			
			resultMARK_READ := oMARK_READSearch.search(8602_Read_Mark_Button_Graphic, optionsObjCoords)
			if (resultMARK_READ)
			{
				Mouse_Click(resultMARK_READ[1].x,resultMARK_READ[1].y, {Timeout: (Delay_Long+0)})
				loop, 8
				{
					resultCONFIRM := oCONFIRMSearch.search(8601_Read_Confirm_Button_Graphic, optionsObjCoords)
					if (resultCONFIRM)
					{
						Mouse_Click(resultCONFIRM[1].x,resultCONFIRM[1].y, {Timeout: (Delay_Long+0)})
						Break
					}
					Else
						DllCall("Sleep","UInt",(1*Delay_Short+0))
				}
				Break
			}
			Else
				DllCall("Sleep","UInt",(1*Delay_Short+0))
		}
		
		Loop, 2
			Mouse_Click(340,70, {Timeout: (3*Delay_Short+0)}) ; Tap header to clear message
		gosub Mail_Collection_Open
		return
	}	
	
	Mail_Collection_Open:
	Subroutine_Running := "Mail_Collection_Open"	
	oMail_TitleSearch := new graphicsearch()
	loop, 2
	{
		; check to see if 860_Mail_Title_Graphic is loaded
		
		loop, 3
		{
			loop, 8
			{
				resultMail_Title := oMail_TitleSearch.search(860_Mail_Title_Graphic, optionsObjCoords)
				if (resultMail_Title)
					return
				Else
					DllCall("Sleep","UInt",(1*Delay_Short+0))
			}
			Mouse_Click(50,60, {Timeout: (1*Delay_Medium+0)}) ; Tap Message back
		}

		; Gosub Get_Window_Geometry
		Gosub Check_Window_Geometry
		if !Go_Back_To_Home_Screen()
			Reload_LEWZ()
		Mouse_Click(500,1200, {Timeout: (1*Delay_Medium+0)}) ; Tap Mail Icon
	}
	return
}

/*
Open_Menu_Alliance(SubMenu := "")
{	
	; Alliance_Menu_Open:= False
	; Alliance_Menu_Open:= False
	; Tap alliance menu
	; Loop, Alliance_Menu_Open? (T/F)
	;	If Alliance_Menu_Open
	;		break
	; SubMenu VAR blank? return Success
	; 
	; Else,
	; Search for SubMenu text
	; 	Success? true or false
	; click and search heading for SubMenu
	
	{
		loop, 2
		{
			Mouse_Click(610,1200, {Timeout: (2*Delay_Long+0)}) ; Tap Alliance Menu
			loop, 4
				if Search_Captured_Text_OCR(["Alliance"]).Found
					Menu_Open_Success

			; Alliance_Menu_01 := OCR([150, 480, 216, 33], "eng")
			; Alliance_Menu_02 := OCR([150, 590, 216, 33], "eng")
			; Alliance_Menu_03 := OCR([150, 705, 216, 33], "eng")
			; Alliance_Menu_04 := OCR([150, 815, 216, 33], "eng")
			; Alliance_Menu_05 := OCR([150, 925, 216, 33], "eng")
			; Alliance_Menu_06 := OCR([150, 1040, 216, 33], "eng")

			Min_Y := 480
			Max_Y := 1040
			Min_X := Max_X := OCR_X := Click_X := 150
			OCR_Y := Min_Y
			OCR_W := 216
			OCR_H := 33
			OCR_Y_Delta := 110

			loop, 6
			{
				Alliance_Menu := Search_Captured_Text_OCR(["Alliance Help"], {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H]})
				; Capture_Screen_Text := OCR([OCR_X, OCR_Y, OCR_W, OCR_H], "eng")
				; MsgBox, % A_Index ". (" OCR_X "," OCR_Y ") " Alliance_Menu.Text
				if Alliance_Menu.Found
				{
					; MsgBox, % A_Index ". (" OCR_X "," OCR_Y ") " Alliance_Menu.Text
					Mouse_Click(OCR_X,OCR_Y) ; Tap To open Alliance Help
					goto Alliance_Help_Continue ; break
				}
				OCR_Y += OCR_Y_Delta
				if (OCR_Y > Max_Y)
					OCR_Y := Min_Y
			}
			if !Go_Back_To_Home_Screen()
				Reload_LEWZ()
		}
}
*/

Alliance_Boss_Feed:
{
	Subroutine_Running := "Alliance_Boss"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; if !Go_Back_To_Home_Screen()
		; Reload_LEWZ()

		Mouse_Click(605,1212) ; Tap Alliance Menu
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		oGraphicSearch := new graphicsearch()
		
		loop, 2
		{		
			Loop, 40
			{
				resultObj := oGraphicSearch.search(870_AllianceMenu_Title_Graphic, optionsObjCoords)
				if (resultObj)
				{
					; Swipe up
					loop, 2
						Mouse_Drag(345, 1100, 409, 196, {EndMovement: F, SwipeTime: 500})
					DllCall("Sleep","UInt",(1*Delay_Long+0))
					break
				}
				Else
					DllCall("Sleep","UInt",(1*Delay_Short+0))
			}
			
			loop, 20
			{
				resultObj := oGraphicSearch.search(878_Boss_Button_Graphic, optionsObjCoords)
				if (resultObj)
				{
					Mouse_Click(resultObj[1].x,resultObj[1].y, {Timeout: (1*Delay_Long+0)}) ; Tap Alliance Boss button
					goto Found_Alliance_Boss_Menu
				}
				Else
					DllCall("Sleep","UInt",(1*Delay_Short+0))
			}
			if !Go_Back_To_Home_Screen()
				Reload_LEWZ()
			Mouse_Click(605,1212) ; Tap Alliance Menu
		}
		goto Alliance_Boss_END

		Found_Alliance_Boss_Menu:
		Mouse_Click(525,1186, {Timeout: (1*Delay_Long+0)}) ; Tap Feed Boss
		Mouse_Click(340,780) ; Tap Confirm Feed Boss

		Alliance_Boss_END:
		if !Go_Back_To_Home_Screen()
			Reload_LEWZ()
		return
}

Alliance_Wages:
{
	Subroutine_Running := "Alliance_Wages"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; if !Go_Back_To_Home_Screen()
		; Reload_LEWZ()

	Goto Alliance_Menu_Wages

	Control_Desk_Alliance_Wages:
	{

		Mouse_Click(27,612, {Timeout: (1*Delay_Long+0)}) ; Tap to Expand Control Desk

		; Swipe Down (linear)
		loop, 2
			Mouse_Drag(326, 405, 326, 957, {EndMovement: F, SwipeTime: 500})

		DllCall("Sleep","UInt",(1*Delay_Long+0))

		Loop, 2
			Mouse_Click(470,960) ; Tap Goto Alliance Wages

		Goto Alliance_Wages_Continue
	}

	Alliance_Menu_Wages:
	{
		Mouse_Click(605,1212, {Timeout: (1*Delay_Long+0)}) ; Tap Alliance Menu
		oGraphicSearch := new graphicsearch()
		
		Wages_Button_Graphics := 8751_Wages_Button_Graphic 8752_Wages_Button_Graphic
		
		loop, 2
		{
			loop, 20
			{
				resultObj := oGraphicSearch.search(Wages_Button_Graphics, optionsObjCoords)
				if (resultObj)
				{
					Mouse_Click(resultObj[1].x,resultObj[1].y) ; Tap Alliance Wages button
					goto Found_Alliance_Wages_Menu
				}
				Else
					DllCall("Sleep","UInt",(1*Delay_Short+0))
			}
			if !Go_Back_To_Home_Screen()
				Reload_LEWZ()
			Mouse_Click(605,1212, {Timeout: (1*Delay_Long+0)}) ; Tap Alliance Menu
		}
		goto Alliance_Wages_END

		Found_Alliance_Wages_Menu:
		Gosub Alliance_Wages_Continue

		Alliance_Wages_END:
		if !Go_Back_To_Home_Screen()
			Reload_LEWZ()
		return
	}

	Alliance_Wages_Continue:
	DllCall("Sleep","UInt",(2*Delay_Long+0))

	; Alliance Wages - Active (TAB 1)
	Alliance_Wages_Active_TAB_1:
	{
		; Gosub Click_Through_Wage_Tabs
		Gosub Click_Points_Boxes
		; DllCall("Sleep","UInt",(1*Delay_Medium+0))

		goto Alliance_Wages_Active_TAB_2

		TRY_MORE_01_Alliance_Wages_Active_TAB_1:
		Gosub Click_Through_Wage_Tabs
		; Swipe Right
		loop, 5
			Mouse_Drag(216, 647, 624, 647, {EndMovement: F, SwipeTime: 500})

		DllCall("Sleep","UInt",(3*Delay_Short+0))
		Gosub Click_Points_Boxes
		DllCall("Sleep","UInt",(3*Delay_Short+0))

		; MsgBox, 4, , Retry? (8 Second Timeout & skip), 5 ; 8
		; vRet := MsgBoxGetResult()
		; if (vRet = "No")
		; goto Alliance_Wages_Active_TAB_2

		TRY_MORE_02_Alliance_Wages_Active_TAB_1:
		Gosub Click_Through_Wage_Tabs
		; Swipe Left
		loop, 5
			Mouse_Drag(624, 647, 216, 647, {EndMovement: F, SwipeTime: 500})

		DllCall("Sleep","UInt",(3*Delay_Short+0))
		Gosub Click_Points_Boxes
		DllCall("Sleep","UInt",(3*Delay_Short+0))
	}

	; Alliance Wages - Active (TAB 2)
	Alliance_Wages_Active_TAB_2:
	{
		Mouse_Click(335,390, {Timeout: (1*Delay_Medium+0)}) ; Tap Alliance Wages - Attendance (TAB 2)

		loop, 3
			Mouse_Click(134,725, {Timeout: (1*Delay_Short+0)}) ; Tap Attendance 1

		; loop, 3
			; Mouse_Click(134,725, {Timeout: (1*Delay_Short+0)}) ; Tap Attendance 1

		loop, 3
			Mouse_Click(280,730, {Timeout: (1*Delay_Short+0)}) ; Tap Attendance 30

		; loop, 3
			; Mouse_Click(280,730, {Timeout: (1*Delay_Short+0)}) ; Tap Attendance 30

		loop, 3
			Mouse_Click(615,726, {Timeout: (1*Delay_Short+0)}) ; Tap Attendance 50

		; loop, 3
			; Mouse_Click(615,726, {Timeout: (1*Delay_Short+0)}) ; Tap Attendance 50
	}

	; Alliance Wages - Active (TAB 3)
	Alliance_Wages_Active_TAB_3:
	{
		loop, 2
			Mouse_Click(562,390, {Timeout: (1*Delay_Medium+0)}) ; Tap Alliance Wages - Contribution (TAB 3)

		loop, 3
			Mouse_Click(140,726, {Timeout: (1*Delay_Short+0)}) ; Tap Alliance Contribution Box 1

		loop, 3
			Mouse_Click(275,726, {Timeout: (1*Delay_Short+0)}) ; Tap Alliance Contribution Box 2
			
		loop, 3
			Mouse_Click(410,726, {Timeout: (1*Delay_Short+0)}) ; Tap Alliance Contribution Box 3

		loop, 3
			Mouse_Click(622,726, {Timeout: (1*Delay_Short+0)}) ; Tap Alliance Contribution Box 4
	}
	return

	Click_Through_Wage_Tabs:
	{
		Mouse_Click(335,390, {Timeout: (1*Delay_Short+0)}) ; Tap Alliance Wages - Attendance (TAB 2)

		Mouse_Click(562,390, {Timeout: (1*Delay_Short+0)}) ; Tap Alliance Wages - Contribution (TAB 3)

		Mouse_Click(112,390, {Timeout: (1*Delay_Short+0)}) ; Tap Alliance Wages - Active (TAB 1)

		return
	}

	Click_Points_Boxes:
	{
		; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
		Mouse_Click(40,650, {Timeout: (1*Delay_Micro+0)}) ; Tap Points Box 30
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(100,650, {Timeout: (1*Delay_Micro+0)}) ; Tap Points Box 30
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(160,650, {Timeout: (1*Delay_Micro+0)}) ; Tap Points Box 70
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(220,650, {Timeout: (1*Delay_Micro+0)}) ; Tap Points Box 70
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(280,650, {Timeout: (1*Delay_Micro+0)}) ; Tap Points Box 120
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(340,650, {Timeout: (1*Delay_Micro+0)}) ; Tap Points Box 120
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(400,650, {Timeout: (1*Delay_Micro+0)}) ; Tap Points Box 180
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(460,650, {Timeout: (1*Delay_Micro+0)}) ; Tap Points Box 180
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(520,650, {Timeout: (1*Delay_Micro+0)}) ; Tap Points Box 260
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(580,650, {Timeout: (1*Delay_Micro+0)}) ; Tap Points Box 260
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(640,650, {Timeout: (1*Delay_Micro+0)}) ; Tap Points Box 340
		Gosub Click_Collect_Daily_Rewards_Chest

		return
	}

	Click_Collect_Daily_Rewards_Chest:
	{
		; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

		Mouse_Click(352,982, {Timeout: (1*Delay_Short+0)}) ; Tap Collect Daily Rewards Chest

		Mouse_Click(320,70, {Timeout: (1*Delay_Short+0)}) ; Tap top title bar
		; Mouse_Click(366,175, {Timeout: (1*Delay_Micro+0)}) ; Tap Outside Chest

		return
	}

}

Train_Daily_Requirement:
{
	Subroutine_Running := "Train_Daily_Requirement"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; if !Go_Back_To_Home_Screen()
		; Reload_LEWZ()

	Reset_Posit()
	DllCall("Sleep","UInt",(2*Delay_Long+0))

	; Zoom out
	loop, 10
	{
		Command_To_Screen("{F2}")
		DllCall("Sleep","UInt",(1*Delay_Medium+0))
	}

	loop, 2
	{

		Mouse_Click(474,1186, {Timeout: (2*Delay_Long+0)}) ; Tap Mail

		Mouse_Click(50,60, {Timeout: (2*Delay_Long+0)}) ; Tap Message back
		; Mouse_Click(630,75, {Timeout: (2*Delay_Long+0)}) ; Tap Message back

		; Zoom out
		loop, 10
		{
			Command_To_Screen("{F2}")
			DllCall("Sleep","UInt",(1*Delay_Medium+0))
		}
	}

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; Zoom out
	loop, 10
	{
		Command_To_Screen("{F2}") ; 2}
		DllCall("Sleep","UInt",(1*Delay_Medium+0))
	}

	; Swipe Right
	; Mouse_Click(250,650) ; Swipe Right
	; DllCall("Sleep","UInt",(1*Delay_Short+0))
	; Click, 400, 650, 0
	; DllCall("Sleep","UInt",(1*Delay_Short+0))
	; Click, 475, 650, 0
	; DllCall("Sleep","UInt",(3*Delay_Short+0))
	; Click, 512, 650, 0
	; DllCall("Sleep","UInt",(3*Delay_Short+0))
	; Click, 530, 650, 0
	; DllCall("Sleep","UInt",(1*Delay_Medium+0))
	; Click, 550, 650 Left, Up

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Tap Vehicle Factory
	; Mouse_Click(393,985); Tap Vehicle Factory
	loop, 2
	{
		Mouse_Click(390,940) ; Tap Vehicle Factory
		Gosub Click_Middle_Screen
		DllCall("Sleep","UInt",(1*Delay_Long+0))
	}
	; Tap Train Button
	Mouse_Click(530,964, {Timeout: (1*Delay_Long+0)}) ; Mouse_Click(530,986)
	Gosub Training_Number

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; Mouse_Click(183,852) ; Tap Warrior Camp
	loop, 2
	{
		Mouse_Click(220,845) ; Tap Warrior Camp
		Gosub Click_Middle_Screen
		DllCall("Sleep","UInt",(1*Delay_Long+0))
	}
	; Tap Train Button
	Mouse_Click(354,879, {Timeout: (1*Delay_Long+0)}) ; Tap Train Button
	; Mouse_Click(324,872, {Timeout: (1*Delay_Long+0)}) ; Tap Train Button
	Gosub Training_Number

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; Mouse_Click(63,770) ; Tap Shooter Camp
	loop, 2
	{
		Mouse_Click(100,800) ; Tap Shooter Camp
		Gosub Click_Middle_Screen
		DllCall("Sleep","UInt",(1*Delay_Long+0))
	}
	; Tap Train Button
	Mouse_Click(240,850, {Timeout: (1*Delay_Long+0)}) ; Tap Train Button
	; Mouse_Click(270,833, {Timeout: (1*Delay_Long+0)}) ; Tap Train Button
	Gosub Training_Number

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; Mouse_Click(10,730) ; Tap Biochemical Center
	loop, 2
		{
		Mouse_Click(10,717) ; Tap Biochemical Center
		Gosub Click_Middle_Screen
		DllCall("Sleep","UInt",(1*Delay_Long+0))
	}
	; Tap Train Button
	Mouse_Click(250,755, {Timeout: (1*Delay_Long+0)}) ; Mouse_Click(275,732)
	Gosub Training_Number
	return

	Training_Number:
	{
		; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

		Mouse_Click(550,1100, {Timeout: (1*Delay_Medium+0)}) ; Tap Troop Number Box

		loop, 8
		{
			Command_To_Screen("{Backspace}")
			DllCall("Sleep","UInt",(3*Delay_Short+0))
		}
		Command_To_Screen("{3}")
		DllCall("Sleep","UInt",(3*Delay_Short+0))
		Command_To_Screen("{0}")
		DllCall("Sleep","UInt",(3*Delay_Short+0))
		Command_To_Screen("{0}")
		DllCall("Sleep","UInt",(3*Delay_Short+0))
		Command_To_Screen("{Enter}")
		DllCall("Sleep","UInt",(3*Delay_Short+0))

		Mouse_Click(509,1189) ; Tap Train Now

		if !Go_Back_To_Home_Screen()
			Reload_LEWZ()

		return
	}
}

Gather_Resources:
{
	Subroutine_Running := "Gather_Resources"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; if !Go_Back_To_Home_Screen()
		; Reload_LEWZ()

	Mouse_Click(76,1200, {Timeout: (8*Delay_Long+0)}) ; Tap World/home button

	Gather_Fuel:
	Subroutine_Running := "Gather_Fuel"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; Tap search button x times
	loop, 2
	{
		Mouse_Click(627,1069, {Timeout: (1*Delay_Short+0)}) ; Mouse_Click(627,1034)
	}
	DllCall("Sleep","UInt",(1*Delay_Medium+0))

	; Swipe right x times
	loop, 2
		Mouse_Drag(100, 990, 600, 990, {EndMovement: F, SwipeTime: 500})

	DllCall("Sleep","UInt",(1*Delay_Long+0))
	; MsgBox, 4, , Gather Oil Well? (8 Second Timeout & skip), 5 ; 8
	; vRet := MsgBoxGetResult()
	; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
	;	{
			Mouse_Click(407,974) ; Tap Oil Well
			Gosub Search_And_Deploy_Resources
			; DllCall("Sleep","UInt",(1*Delay_Long+0))
	;	}

	Gather_Farm:
	Subroutine_Running := "Gather_Farm"
	; stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; MsgBox, 4, , Gather Farm? (8 Second Timeout & skip), 5 ; 8
	; vRet := MsgBoxGetResult()
	; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
	;	{
			Mouse_Click(547,970) ; Tap Farm
			Gosub Search_And_Deploy_Resources
			; DllCall("Sleep","UInt",(1*Delay_Long+0))
	;	}

	Gather_Steel:
	Subroutine_Running := "Gather_Steel"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; Tap search button x times
	loop, 2
	{
		Mouse_Click(627,1069, {Timeout: (1*Delay_Short+0)}) ; Mouse_Click(627,1034)
	}
	DllCall("Sleep","UInt",(1*Delay_Medium+0))

	; Swipe left x times
	loop, 2
		Mouse_Drag(600, 990, 100, 990, {EndMovement: F, SwipeTime: 500})

	DllCall("Sleep","UInt",(1*Delay_Long+0))

	; MsgBox, 4, , Gather Steel Mill? (8 Second Timeout & skip), 5 ; 8
	; vRet := MsgBoxGetResult()
	; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
	;	{
			Mouse_Click(124,983) ; Tap Steel Mill
			Gosub Search_And_Deploy_Resources
			; DllCall("Sleep","UInt",(1*Delay_Long+0))
	;	}

	Gather_Alloy:
	Subroutine_Running := "Gather_Alloy"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; Swipe left x times
	loop, 2
		Mouse_Drag(600, 990, 100, 990, {EndMovement: F, SwipeTime: 500})

	DllCall("Sleep","UInt",(1*Delay_Long+0))
	; MsgBox, 4, , Gather Alloy Mine? (8 Second Timeout & skip), 5 ; 8
	; vRet := MsgBoxGetResult()
	; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
	;	{
			Mouse_Click(270,970) ; Tap Alloy Mine
			Gosub Search_And_Deploy_Resources
			; DllCall("Sleep","UInt",(1*Delay_Long+0))
	;	}

	; MsgBox, 4, , Gather more? (10 Second Timeout & skip), 15 ; 0
	; vRet := MsgBoxGetResult()
	; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
	;	Gosub Gather_Fuel

	End_Gathering:

	; Go_Back_Home_Delay_Long := True
	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return

	Search_And_Deploy_Resources:
	{
		Mouse_Click(637,1112, {Timeout: (1*Delay_Medium+0)}) ; Mouse_Click(637,1112) ; Tap Level Box
		if Desert_Event
			Command_To_Screen("{8}")
		Else
			Command_To_Screen("{6}")
		DllCall("Sleep","UInt",(3*Delay_Short+0))
		Command_To_Screen("{Enter}")
		DllCall("Sleep","UInt",(3*Delay_Short+0))

		Mouse_Click(346,1200, {Timeout: (3*Delay_Medium+0)}) ; Tap Search Button

		Mouse_Click(440,640, {Timeout: (3*Delay_Medium+0)}) ; Tap Gather Button

		/*
		Select_Gather_Officers:
		{
			Mouse_Click(525,437, {Timeout: (1*Delay_Micro+0)}) ; Tap Officer 5
			Mouse_Click(319,350, {Timeout: (1*Delay_Micro+0)}) ; Tap Above Officer In Case Already Marching

			Mouse_Click(407,434, {Timeout: (1*Delay_Micro+0)}) ; Tap Officer 4
			Mouse_Click(319,350, {Timeout: (1*Delay_Micro+0)}) ; Tap Above Officer In Case Already Marching

			Mouse_Click(300,435, {Timeout: (1*Delay_Micro+0)}) ; Tap Officer 3
			Mouse_Click(319,350, {Timeout: (1*Delay_Micro+0)}) ; Tap Above Officer In Case Already Marching

			Mouse_Click(180,440, {Timeout: (1*Delay_Micro+0)}) ; Tap Officer 2
			Mouse_Click(319,350, {Timeout: (1*Delay_Micro+0)}) ; Tap Above Officer In Case Already Marching

			Mouse_Click(54,436, {Timeout: (1*Delay_Micro+0)}) ; Tap Officer 1
			Mouse_Click(319,350, {Timeout: (1*Delay_Micro+0)}) ; Tap Above Officer In Case Already Marching
		}
		*/
		; DllCall("Sleep","UInt",(1*Delay_Long+0))

		Mouse_Click(480,1186, {Timeout: (1*Delay_Long+0)}) ; Tap March

		; Mouse_Click(54,965) ; Tap Do Not Remind Me Again
		; DllCall("Sleep","UInt",(1*Delay_Long+0))

		; Mouse_Click(560,1020, {Timeout: (1*Delay_Medium+0)}) ; Tap Deploy

		; Tap search button x times
		loop, 2
		{
			Mouse_Click(627,1069, {Timeout: (1*Delay_Short+0)}) ; Mouse_Click(627,1034)
		}
		DllCall("Sleep","UInt",(1*Delay_Medium+0))
		return
	}
}

Desert_Oasis:
{
	Subroutine_Running := "Desert_Oasis"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )

	loop, 3
		if Enter_Coordinates_From_Home()
		{
			gosub Desert_Oasis_Enter_Coordinates_Next
			break
		}

	goto END_Stealing

	Desert_Oasis_Enter_Coordinates_Next:
	Subroutine_Running := "Desert_Oasis_Enter_Coordinates_Next"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	{
		Goto_Coordinates()
		Mouse_Click(340,680, {Timeout: (2*Delay_Long+0)}) ; Tap on Holy Tower
		Mouse_Click(440,680, {Timeout: (1*Delay_Long+0)}) ; Tap Holy Tower Steal button

		/*
		Desert_Oasis_Coordinates_Text := ["Steal"]
		OCR_X := 315
		OCR_Y := 1190
		OCR_W := 55
		OCR_H := 30
		*/
		
		oGraphicSearch := new graphicsearch()	
		loop, 2
		{
			loop, 40
			{
				resultObj := oGraphicSearch.search(WD111_Steal_Button_Graphic, optionsObjCoords)
				if (resultObj)
					Goto Desert_Oasis_Stealing_Found
				Else
					DllCall("Sleep","UInt",(1*Delay_Short+0))
			}
			
			if Search_Captured_Text_OCR(["Steal"], {Pos: [315, 1190], Size: [55, 30]}).Found
				Goto Desert_Oasis_Stealing_Found

			Mouse_Click(590,690, {Timeout: (1*Delay_Long+0)}) ; Tap Close Steal dialog if open
			if !Enter_Coordinates_From_World()
				return
		}
		return ; goto END_Stealing

		Desert_Oasis_Stealing_Found:
		Mouse_Click(340,1200, {Timeout: (5*Delay_Long+0)}) ; Tap Steal
		return ; goto END_Stealing
	}

	END_Stealing:

	if Pause_Script
		MsgBox, 0, Pause, Press OK to resume (No Timeout)

	; Go_Back_Home_Delay_Long := True
	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return
}

Goto_Coordinates(GotoCoordinates_X := "", GotoCoordinates_Y := "")
{
	Subroutine_Running := "GotoCoordinates_"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )

	loop, 3
		if Enter_Coordinates_From_Home()
		{
			gosub GotoCoordinates_Next
			break
		}

	goto Goto_Coordinates_END

	GotoCoordinates_Next:
	Subroutine_Running := "GotoCoordinates_Next"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	{
		; Mouse_Click(242,526) ; Tap inside X Coordinate Text box
		; DllCall("Sleep","UInt",(1*Delay_Medium+0))

		; Default_NW_Tower Coordinates X: 595-596 Y: 599-600 (595,599) steal: 439, 681
		; Default_NE_Tower Coordinates X: 599-600 Y: 595-596 (599,595) steal: 441, 681
		; Default_SW_Tower Coordinates X: 599-600 Y: 604-605 (599,604) steal: 447, 678
		; Default_SE_Tower Coordinates X: 604-605 Y: 599-600 (604,599) steal: 440, 680
		
		; if ((GotoCoordinates_X := "") || (GotoCoordinates_Y := ""))
		if (GotoCoordinates_X && GotoCoordinates_Y)
			goto GotoCoordinates_GOTO
		Else
		{
			; if none selected, auto Steal from:
			; goto Default_NW_Tower
			; goto Default_NE_Tower
			; goto Default_SW_Tower
			goto Default_SE_Tower
			; goto Goto_Coordinates_END
		}

		Default_NW_Tower:
		{
			GotoCoordinates_X := "595"
			GotoCoordinates_Y := "599"
			goto GotoCoordinates_GOTO
		}

		Default_NE_Tower:
		{
			GotoCoordinates_X := "599"
			GotoCoordinates_Y := "595"
			goto GotoCoordinates_GOTO
		}

		Default_SW_Tower:
		{
			GotoCoordinates_X := "599"
			GotoCoordinates_Y := "604"
			goto GotoCoordinates_GOTO
		}

		Default_SE_Tower:
		{
			GotoCoordinates_X := "604"
			GotoCoordinates_Y := "599"
			goto GotoCoordinates_GOTO
		}

		; if none selected, auto go to
		{
			GotoCoordinates_X := "599"
			GotoCoordinates_Y := "595"
			goto GotoCoordinates_GOTO
		}

		return ; goto Goto_Coordinates_END

		GotoCoordinates_GOTO:
		Subroutine_Running := "GotoCoordinates_GOTO"
		stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
		; Default_NW_Tower Coordinates X: 595-596 Y: 599-600 (595,599) steal: 439, 681
		; Default_NE_Tower Coordinates X: 599-600 Y: 595-596 (599,595) steal: 441, 681
		; Default_SW_Tower Coordinates X: 599-600 Y: 604-605 (599,604) steal: 447, 678
		; Default_SE_Tower Coordinates X: 604-605 Y: 599-600 (604,599) steal: 440, 680
		; MsgBox, 4, Coordinates, Are GotoCoordinates_X`,Y %GotoCoordinates_X% %GotoCoordinates_X% Correct? (8 Second Timeout & auto),5 ; 8
			
		loop, 2
		{
			Mouse_Click(242,526, {Timeout: (3*Delay_Short+0)}) ; Tap inside X Coordinate Text box
		}
		DllCall("Sleep","UInt",(3*Delay_Short+0))
		Command_To_Screen("{Raw}" . GotoCoordinates_X)
		DllCall("Sleep","UInt",(3*Delay_Short+0))
		Command_To_Screen("{Enter}")
		DllCall("Sleep","UInt",(1*Delay_Medium+0))

		loop, 2
		{
			Mouse_Click(484,530, {Timeout: (3*Delay_Short+0)}) ; Tap inside Y Coordinate Text box
		}
		DllCall("Sleep","UInt",(3*Delay_Short+0))
		Command_To_Screen("{Raw}" . GotoCoordinates_Y)
		DllCall("Sleep","UInt",(3*Delay_Short+0))
		Command_To_Screen("{Enter}")
		DllCall("Sleep","UInt",(1*Delay_Medium+0))
		
		if Pause_Script
		{
			MsgBox, 4, , Go to %GotoCoordinates_X%:%GotoCoordinates_Y%? (5 Second Timeout & skip), 5 ; 8
			vRet := MsgBoxGetResult()
			if (vRet = "No")
				MsgBox, 0, Pause, Enter correct coordinates and tap ""Go to""`n(Press OK to resume`, No Timeout)
		}
		
		Mouse_Click(340,620, {Timeout: (3*Delay_Long+0)}) ; Tap Go to Coordinates
		return ; goto Goto_Coordinates_END
	}

	Goto_Coordinates_END:

	if Pause_Script
		MsgBox, 0, Pause, Press OK to resume (No Timeout)

	; Go_Back_Home_Delay_Long := True
	; if !Go_Back_To_Home_Screen()
	;	Reload_LEWZ()
	return
}

; Functions to handle opening coordinates panel
Enter_Coordinates_From_Home()
{
	Subroutine_Running := "Enter_Coordinates_From_Home"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	Mouse_Click(73,1207, {Timeout: (3*Delay_Long+0)}) ; Tap on World Button

	loop, 2
		if Enter_Coordinates_From_World()
			return 1

	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return 0
}

Enter_Coordinates_From_World()
{
	Subroutine_Running := "Enter_Coordinates_From_World"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; Mouse_Click(337,1000, {Timeout: (1*Delay_Long+0)}) ; Tap on Enter Coordinates Button
	Mouse_Click(223,1041, {Timeout: (1*Delay_Long+0)}) ; Tap on Enter Coordinates Button
	
	
	; (Mouse_Click\([^\,\)]+\,[^\,\)]+)[\)\h]+([^\r\n]+)[\r\n\h]+DllCall[^\r\n]+rand_wait[\h\+]+([^\r\n\)]+)[\)]+
	; \1\, {Timeout\: \(\3\)} \2

	loop, 2
		if Enter_Coordinates_Open_Check()
			return 1

	Gosub Check_Window_Geometry
	return 0
}

Enter_Coordinates_Open_Check()
{
	Subroutine_Running := "Enter_Coordinates_Open_Check"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	loop, 5
		if Search_Captured_Text_OCR(["Enter","coordinates"], {Pos: [237, 303], Size: [220, 40]}).Found
			return 1
	return 0
}

; Gather available Fuel, Food, Steel and alloy RSS from base farms
Gather_On_Base_RSS:
{
	Subroutine_Running := "Gather_On_Base_RSS"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; if !Go_Back_To_Home_Screen()
		; Reload_LEWZ()
		
	Gosub Gather_On_Base_ALL
	
	END_Gather_Base_RSS:
	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return
	
	Gather_On_Base_ALL:
	oGraphicSearch := new graphicsearch()
	{
		Swipe_Up_Left_RSS:
		loop, 5
		{
			Mouse_Drag(560, 930, 50, 330, {EndMovement: F, SwipeTime: 200})
			DllCall("Sleep","UInt",(1*Delay_Short+0))
		}
		
		Mouse_Click(160,282) ; Plot # 31
		Gosub Gather_On_Base_NEXT
		Mouse_Click(485,510) ; Plot # 44
		Gosub Gather_On_Base_NEXT
		Mouse_Click(239,233) ; Plot # 32
		Gosub Gather_On_Base_NEXT
		Mouse_Click(445,583) ; Plot # 45
		Gosub Gather_On_Base_NEXT
		Mouse_Click(250,337) ; Plot # 33
		Gosub Gather_On_Base_NEXT
		Mouse_Click(292,509) ; Plot # 46
		Gosub Gather_On_Base_NEXT
		Mouse_Click(330,280) ; Plot # 34
		Gosub Gather_On_Base_NEXT
		Mouse_Click(305,587) ; Plot # 48
		Gosub Gather_On_Base_NEXT
		Mouse_Click(350,374) ; Plot # 35
		Gosub Gather_On_Base_NEXT
		Mouse_Click(396,553) ; Plot # 49
		Gosub Gather_On_Base_NEXT
		Mouse_Click(397,453) ; Plot # 47
		Gosub Gather_On_Base_NEXT
		Mouse_Click(405,653) ; Plot # 50
		Gosub Gather_On_Base_NEXT
		Mouse_Click(137,817) ; Plot # 40
		Gosub Gather_On_Base_NEXT

		loop, 2
			Mouse_Click(36,760) ; Plot # 39 - screen moves
		DllCall("Sleep","UInt",(1*Delay_Long+0))
		Gosub Gather_On_Base_NEXT
		loop, 2
			Mouse_Click(29,726) ; Plot # 37 - screen moves
		DllCall("Sleep","UInt",(1*Delay_Long+0))
		Gosub Gather_On_Base_NEXT
		Mouse_Click(130,827) ; Plot # 38
		Gosub Gather_On_Base_NEXT
		loop, 2
			Mouse_Click(40,770) ; Plot # 36 - screen moves
		DllCall("Sleep","UInt",(1*Delay_Long+0))

		Mouse_Click(367,542) ; Plot # 43
		Gosub Gather_On_Base_NEXT
		Mouse_Click(272,493) ; Plot # 41
		Gosub Gather_On_Base_NEXT
		Mouse_Click(380,462) ; Plot # 42
		Gosub Gather_On_Base_NEXT

		Mouse_Drag(147, 854, 330, 649, {EndMovement: T, SwipeTime: 500})
		Mouse_Click(167,412) ; Plot # 26
		Gosub Gather_On_Base_NEXT
		Mouse_Click(273,354) ; Plot # 27
		Gosub Gather_On_Base_NEXT
		Mouse_Click(360,293) ; Plot # 28
		Gosub Gather_On_Base_NEXT
		Mouse_Click(307,424) ; Plot # 29
		Gosub Gather_On_Base_NEXT
		Mouse_Click(400,376) ; Plot # 30
		Gosub Gather_On_Base_NEXT

		loop, 2
			Mouse_Click(110,600) ; Plot # 24 - screen moves
		DllCall("Sleep","UInt",(1*Delay_Long+0))
		Gosub Gather_On_Base_NEXT
		loop, 2
			Mouse_Click(34,540) ; Plot # 22 - screen moves
		DllCall("Sleep","UInt",(1*Delay_Long+0))
		Gosub Gather_On_Base_NEXT
		Mouse_Click(160,680) ; Plot # 25
		Gosub Gather_On_Base_NEXT
		loop, 2
			Mouse_Click(110,644) ; Plot # 23 - screen moves
		DllCall("Sleep","UInt",(1*Delay_Long+0))
		Gosub Gather_On_Base_NEXT
		loop, 2
			Mouse_Click(70,593) ; Plot # 21 - screen moves
		DllCall("Sleep","UInt",(1*Delay_Long+0))
		Gosub Gather_On_Base_NEXT

		Mouse_Click(167,826) ; Plot # 19
		Gosub Gather_On_Base_NEXT
		loop, 2
			Mouse_Click(86,770) ; Plot # 17 - screen moves
		DllCall("Sleep","UInt",(1*Delay_Long+0))
		Gosub Gather_On_Base_NEXT
		Mouse_Click(310,780) ; Plot # 20
		Gosub Gather_On_Base_NEXT
		Mouse_Click(202,710) ; Plot # 18
		Gosub Gather_On_Base_NEXT
		Mouse_Click(117,675) ; Plot # 16
		Gosub Gather_On_Base_NEXT
	}
	return
	
	Gather_On_Base_NEXT:
	{
		Mouse_Click(530,1033, {Timeout: (3*Delay_Short+0)}) ; Tap next to speaker
		resultObj := oGraphicSearch.search(BD01_Desert_building_Title_Graphic, optionsObjCoords)
		if (resultObj)
			Exit ; break ; Goto END_Gather_Base_RSS
		return
	}
	
}

; Claim Golden_Chest items
Golden_Chest:
{
	Subroutine_Running := "Golden_Chest"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; if !Go_Back_To_Home_Screen()
		; Reload_LEWZ()

	if !Activity_Center_Open()
		goto Golden_Chest_END

	oGraphicSearch := new graphicsearch()	
	loop, 5
	{
		loop, 10
		{
			resultObj := oGraphicSearch.search(91A_GoldenChest_Button_Graphic, optionsObjCoords)
			if (resultObj)
			{
				Mouse_Click(resultObj[1].x,resultObj[1].y) ; Tap Desert Wonder
				goto Golden_Chest_Continue_Tab
			}
			Else
				DllCall("Sleep","UInt",(1*Delay_Short+0))
		}
		Mouse_Drag(350, 800, 350, 600, {EndMovement: T, SwipeTime: 500})
	}
	goto Golden_Chest_END

	Golden_Chest_Continue_Tab:
	; MsgBox, 0, , Capture_Screen_Text:"%Capture_Screen_Text%"`nSearch_Text_Array:"%Search_Text_Array%"

	; Find single occurence of image, return true or false	
	oGraphicSearch := new graphicsearch()
	Loop, 50
	{
		resultObj := oGraphicSearch.search(91A0_GoldenChest_Title_Graphic, optionsObjCoords)
		if (resultObj)
			goto Golden_Chest_Next
		Else
			DllCall("Sleep","UInt",(1*Delay_Short+0))
	}
	goto Golden_Chest_END

	Golden_Chest_Next:
	; loop, 500
	; {
	;	Mouse_Click(100,475, {Timeout: 0}) ; Tap Bronze tab
		Gosub Golden_Chest_Open_for_free_button
		Mouse_Click(350,475, {Timeout: 0}) ; Tap Silver tab
		Gosub Golden_Chest_Open_for_free_button
	; }

	Mouse_Click(633,600, {Timeout: (1*Delay_Long+0)}) ; Tap rankings
	Mouse_Click(157,367, {Timeout: (2*Delay_Short+0)}) ; Tap Open box
	Mouse_Click(330,1000, {Timeout: (2*Delay_Short+0)}) ; Tap Collect Rewards

	Golden_Chest_END:
	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return
	
	Golden_Chest_Open_for_free_button:
	; Find single occurence of image, return true or false	
	oGraphicSearch := new graphicsearch()
	Loop, 10
	{
		resultObj := oGraphicSearch.search(91A1_Free_title_Graphic, optionsObjCoords)
		if (resultObj)
		{
			loop, % resultObj.Count()
				Mouse_Click(resultObj[A_Index].x,resultObj[A_Index].y, {Timeout: (1*Delay_Medium+0)})
			; Mouse_Click(125, 1200, {Timeout: (1*Delay_Long+0)}) ; Tap "Open for free" button
			loop, 4
				Mouse_Click(320,70, {Timeout: (3*Delay_Short+0)}) ; Tap top title bar
			break
		}
		Else
			loop, 2
				Mouse_Click(320,70, {Timeout: (1*Delay_Short+0)}) ; Tap top title bar
	}
	return
}

; Send in-game message to "BOSS" with retrieved info
Send_Mail_To_Boss:
{
	Subroutine_Running := "Send_Mail_To_Boss"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; FormatTime, DateString,, yyyy-MM-dd
	; FormatTime, TimeString,, HH:mm
	; FormatTime, LogDateTimeString,, yyyy-MM-dd HH:mm:ss
	FormatTime, LogDateTimeString,, yyyy-MM-dd @ HHmm
	FormatTime, DayOfWeek,, ddd
	CSVout.WriteLine(LogDateTimeString "," Message_To_The_Boss)
	FormatTime, TimeString_Message, R
	; Message_To_The_Boss .= DayOfWeek . ", " . LogDateTimeString

	; MsgBox, before: %Message_To_The_Boss%

	; Message_To_The_Boss := RegExReplace(Message_To_The_Boss,"[\r\n ]+"," ")
	/*
	Message_To_The_Boss_01 := % Base_Array[User].User_Name_Captured
	. " (" . Base_Array[User].User_City_Location_XY . ")"
	. " {#}" . Base_Array[User].User_Found_State
	. " [" . Base_Array[User].User_Found_Alliance . "]"
	. " " .  Base_Array[User].User_VIP
	Message_To_The_Boss_02 := "Power: " . Convert_Value(Base_Array[User].User_Power)
	. " Diamonds: " . Convert_Value(Base_Array[User].User_Diamonds)
	Message_To_The_Boss_03 := "Fuel: " . Convert_Value(Base_Array[User].Available_Fuel)
	. " {+} " . Convert_Value(Base_Array[User].Inventory_Fuel) . " = " . Convert_Value(Base_Array[User].Available_Fuel + Base_Array[User].Inventory_Fuel)
	Message_To_The_Boss_04 := "Food: " . Convert_Value(Base_Array[User].Available_Food)
	. " {+} " . Convert_Value(Base_Array[User].Inventory_Food) . " = " . Convert_Value(Base_Array[User].Available_Food + Base_Array[User].Inventory_Food)
	Message_To_The_Boss_05 := "Steel: " . Convert_Value(Base_Array[User].Available_Steel)
	. " {+} " . Convert_Value(Base_Array[User].Inventory_Steel) . " = " . Convert_Value(Base_Array[User].Available_Steel + Base_Array[User].Inventory_Steel)
	Message_To_The_Boss_06 := "Alloy: " . Convert_Value(Base_Array[User].Available_Alloy)
	. " {+} " . Convert_Value(Base_Array[User].Inventory_Alloy) . " = " . Convert_Value(Base_Array[User].Available_Alloy + Base_Array[User].Inventory_Alloy)
	Message_To_The_Boss_07 := DayOfWeek . ", " . LogDateTimeString
	*/

	Power_Total := Convert_Value(Base_Array[User].User_Power)
	Diamonds_Total := Convert_Value(Base_Array[User].User_Diamonds)
	
	Fuel_Available := Convert_Value(Base_Array[User].Available_Fuel)
	Fuel_Inventory := Convert_Value(Base_Array[User].Inventory_Fuel)
	Fuel_Total  := Convert_Value(Base_Array[User].Available_Fuel + Base_Array[User].Inventory_Fuel)
	
	Food_Available := Convert_Value(Base_Array[User].Available_Food)
	Food_Inventory := Convert_Value(Base_Array[User].Inventory_Food)
	Food_Total  := Convert_Value(Base_Array[User].Available_Food + Base_Array[User].Inventory_Food)
	
	Steel_Available := Convert_Value(Base_Array[User].Available_Steel)
	Steel_Inventory := Convert_Value(Base_Array[User].Inventory_Steel)
	Steel_Total := Convert_Value(Base_Array[User].Available_Steel + Base_Array[User].Inventory_Steel)
	
	Alloy_Available := Convert_Value(Base_Array[User].Available_Alloy)
	Alloy_Inventory := Convert_Value(Base_Array[User].Inventory_Alloy)
	Alloy_Total := Convert_Value(Base_Array[User].Available_Alloy + Base_Array[User].Inventory_Alloy)
	
	/*
	Message_To_The_Boss_01 := % "O:" . Fuel_Total . " F:" . Food_Total . " S:" . Steel_Total . " A:" . Alloy_Total
	. " PWR:" . Power_Total	. " $" . Diamonds_Total . " " .  Base_Array[User].User_VIP
	. "`n(" . Base_Array[User].User_Found_Alliance . ")"	
	*/
	
	Message_To_The_Boss_01 := % Fuel_Total . " " . Food_Total . " " . Steel_Total . " " . Alloy_Total
	. " PWR:" . Power_Total	. " $" . Diamonds_Total . " " .  Base_Array[User].User_VIP
	. " " . Base_Array[User].User_City_Location_XY	
	. "`n(" . Base_Array[User].User_Found_Alliance . ")"
	. Base_Array[User].User_Name_Captured
	. "#" . Base_Array[User].User_Found_State
	. "`n" . "Fuel: " . Fuel_Available . " + " . Fuel_Inventory . " = " . Fuel_Total
	. "`n" . "Food: " . Food_Available . " + " . Food_Inventory . " = " . Food_Total
	. "`n" . "Steel: " . Steel_Available . " + " . Steel_Inventory . " = " . Steel_Total
	. "`n" . "Alloy: " . Alloy_Available . " + " . Alloy_Inventory . " = " . Alloy_Total
	. "`nTime: " . DayOfWeek . ", " . LogDateTimeString

	; MsgBox, After: %Message_To_The_Boss%

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; if !Go_Back_To_Home_Screen()
		; Reload_LEWZ()

	Open_Mail:

	Mouse_Click(492,1202) ; Tap mail
	Gosub Send_Mail_Open

	Compose_Message:
	Mouse_Click(636,55, {Timeout: (7*Delay_Short+0)}) ; Tap new Message
	Mouse_Click(500,173, {Timeout: (3*Delay_Short+0)}) ; Tap User Name Text Box
	Text_To_Screen(Boss_User_name) ; Type user name to send message to
	; DllCall("Sleep","UInt",(1*Delay_Medium+0))
	Mouse_Click(433,327, {Timeout: (3*Delay_Short+0)}) ; Tap Message text body
	Text_To_Screen(Message_To_The_Boss_01) ; Type Message to user
	DllCall("Sleep","UInt",(1*Delay_Medium+0))
	/*
	Command_To_Screen("{Enter}")
	DllCall("Sleep","UInt",(3*Delay_Short+0))
	Text_To_Screen(Message_To_The_Boss_02) ; Type Message to user
	DllCall("Sleep","UInt",(3*Delay_Short+0))
	Command_To_Screen("{Enter}")
	DllCall("Sleep","UInt",(3*Delay_Short+0))
	Text_To_Screen(Message_To_The_Boss_03) ; Type Message to user
	DllCall("Sleep","UInt",(3*Delay_Short+0))
	Command_To_Screen("{Enter}")
	DllCall("Sleep","UInt",(3*Delay_Short+0))
	Text_To_Screen(Message_To_The_Boss_04) ; Type Message to user
	DllCall("Sleep","UInt",(3*Delay_Short+0))
	Command_To_Screen("{Enter}")
	DllCall("Sleep","UInt",(3*Delay_Short+0))
	Text_To_Screen(Message_To_The_Boss_05) ; Type Message to user
	DllCall("Sleep","UInt",(3*Delay_Short+0))
	Command_To_Screen("{Enter}")
	DllCall("Sleep","UInt",(3*Delay_Short+0))
	Text_To_Screen(Message_To_The_Boss_06) ; Type Message to user
	DllCall("Sleep","UInt",(3*Delay_Short+0))
	Command_To_Screen("{Enter}")
	DllCall("Sleep","UInt",(3*Delay_Short+0))
	Text_To_Screen(Message_To_The_Boss_07) ; Type Message to user
	DllCall("Sleep","UInt",(1*Delay_Long+0))
	*/

	; MsgBox, 0, Pause, Press OK to resume (No Timeout)

	Mouse_Click(352,1174, {Timeout: (1*Delay_Medium+0)}) ; Tap Send button

	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return
	
	Send_Mail_Open:
	Subroutine_Running := "Send_Mail_Open"
	
	oMail_TitleSearch := new graphicsearch()
	loop, 2
	{
		; check to see if 860_Mail_Title_Graphic is loaded
		
		loop, 2
		{
			loop, 10
			{
				resultMail_Title := oMail_TitleSearch.search(860_Mail_Title_Graphic, optionsObjCoords)
				if (resultMail_Title)
					return
				Else
					DllCall("Sleep","UInt",(1*Delay_Short+0))
			}
			Mouse_Click(50,60) ; Tap Message back
		}

		; Gosub Get_Window_Geometry
		Gosub Check_Window_Geometry
		if !Go_Back_To_Home_Screen()
			Reload_LEWZ()
		Mouse_Click(500,1200) ; Tap Mail Icon
	}
	return
	
}

; Send message via in-game chat interface
Send_Message_In_Chat:
{
	Subroutine_Running := "Send_Message_In_Chat"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(316,1122, {Timeout: (1*Delay_Long+0)}) ; Tap on Chat Bar

	Mouse_Click(33,62, {Timeout: (1*Delay_Long+0)}) ; Tap back Button

	Mouse_Click(229,389, {Timeout: (1*Delay_Long+0)}) ; Tap on third Chat Room "Hack Root"

	Mouse_Click(227,1215, {Timeout: (1*Delay_Medium+0)}) ; Tap in Message Box

	Chat_Message = % GetRandom(Chat_Message_List,"`n","`r")

	; MsgBox, SendInput
	; Mouse_Click(227,1215) ; Tap in Message Box
	; DllCall("Sleep","UInt",(1*Delay_Medium+0))
	; Text_To_Screen(Chat_Message) ; Type message to send
	; Mouse_Click(227,1215) ; Tap in Message Box
	; DllCall("Sleep","UInt",(5*Delay_Long+0))
	; Mouse_Click(650,1213) ; Tap Send
	; DllCall("Sleep","UInt",(1*Delay_Long+0))

	; MsgBox, SendRaw
	Mouse_Click(227,1215, {Timeout: (3*Delay_Short+0)}) ; Tap in Message Box
	SendRaw, %Chat_Message% ; Type message to send
	; Mouse_Click(227,1215, {Timeout: (1*Delay_Medium+0)}) ; Tap in Message Box
	Mouse_Click(650,1213, {Timeout: (1*Delay_Medium+0)}) ; Tap Send

	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return
}

; OCR capture available and stored RSS levels
Get_Inventory:
{
	Subroutine_Running := "Get_Inventory"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(169,40, {Timeout: (1*Delay_Long+0)}) ; Tap Fuel on upper menu bar
	Available_Food := OCR([244, 132, 90, 25], "eng") ; capture Available Food number
	Available_Steel := OCR([414, 132, 90, 25], "eng") ; capture Available Steel number
	Available_Alloy := OCR([584, 132, 90, 25], "eng") ; capture Available Alloy number
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

	Mouse_Click(95,140, {Timeout: (7*Delay_Short+0)}) ; Tap Fuel tab
	Inventory_Fuel := OCR([187, 185, 320, 30], "eng") ; capture Reserve Fuel number
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

	Mouse_Click(249,140, {Timeout: (7*Delay_Short+0)}) ; Tap Food tab
	Inventory_Food := OCR([187, 185, 320, 30], "eng") ; capture Reserve Food number
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

	Mouse_Click(442,136, {Timeout: (7*Delay_Short+0)}) ; Tap Steel tab
	Inventory_Steel := OCR([187, 185, 320, 30], "eng") ; capture Reserve Steel number
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

	Mouse_Click(594,140, {Timeout: (7*Delay_Short+0)}) ; Tap Alloy tab
	Inventory_Alloy := OCR([187, 185, 320, 30], "eng") ; capture Reserve Alloy number
	Available_Fuel := OCR([70, 132, 90, 25], "eng") ; capture Available Fuel number
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

	; Available_Fuel := trim(Available_Fuel)
	; Available_Food := trim(Available_Food)
	; Available_Steel := trim(Available_Steel)
	; Available_Alloy := trim(Available_Alloy)
	; Inventory_Fuel := trim(Inventory_Fuel)
	; Inventory_Food := trim(Inventory_Food)
	; Inventory_Steel := trim(Inventory_Steel)
	; Inventory_Alloy := trim(Inventory_Alloy)

	; remove text from captured variables
	/*
	Inventory_Fuel := StrReplace(Inventory_Fuel, "Total item inventory:", "")
	Inventory_Food := StrReplace(Inventory_Food, "Total item inventory:", "")
	Inventory_Steel := StrReplace(Inventory_Steel, "Total item inventory:", "")
	Inventory_Alloy := StrReplace(Inventory_Alloy, "Total item inventory:", "")
	Available_Fuel := % RegExReplace(Available_Fuel,"[^\d\.MKG]+")
	Available_Food := % RegExReplace(Available_Food,"[^\d\.MKG]+")
	Available_Steel := % RegExReplace(Available_Steel,"[^\d\.MKG]+")
	Available_Alloy := % RegExReplace(Available_Alloy,"[^\d\.MKG]+")
	Inventory_Fuel := % RegExReplace(Inventory_Fuel,"[^\d\.MKG]+")
	Inventory_Food := % RegExReplace(Inventory_Food,"[^\d\.MKG]+")
	Inventory_Steel := % RegExReplace(Inventory_Steel,"[^\d\.MKG]+")
	Inventory_Alloy := % RegExReplace(Inventory_Alloy,"[^\d\.MKG]+")
	*/

	Available_Fuel := % Convert_OCR_Value(Available_Fuel)
	Available_Food := % Convert_OCR_Value(Available_Food)
	Available_Steel := % Convert_OCR_Value(Available_Steel)
	Available_Alloy := % Convert_OCR_Value(Available_Alloy)
	Inventory_Fuel := % Convert_OCR_Value(Inventory_Fuel)
	Inventory_Food := % Convert_OCR_Value(Inventory_Food)
	Inventory_Steel := % Convert_OCR_Value(Inventory_Steel)
	Inventory_Alloy := % Convert_OCR_Value(Inventory_Alloy)
	
	Base_Array[User].Available_Fuel :=   Convert_OCR_Value(Available_Fuel)
	Base_Array[User].Available_Food :=   Convert_OCR_Value(Available_Food)
	Base_Array[User].Available_Steel :=  Convert_OCR_Value(Available_Steel)
	Base_Array[User].Available_Alloy :=  Convert_OCR_Value(Available_Alloy)
	Base_Array[User].Inventory_Fuel :=   Convert_OCR_Value(Inventory_Fuel)
	Base_Array[User].Inventory_Food :=   Convert_OCR_Value(Inventory_Food)
	Base_Array[User].Inventory_Steel :=  Convert_OCR_Value(Inventory_Steel)
	Base_Array[User].Inventory_Alloy :=  Convert_OCR_Value(Inventory_Alloy)
	
	; Array_Gui(Base_Array)

	; CSV entry
	Message_To_The_Boss .= "Fuel:`," . Available_Fuel . "`," . Inventory_Fuel
	. "`,Food:`," . Available_Food . "`," . Inventory_Food
	. "`,Steel:`," . Available_Steel . "`," . Inventory_Steel
	. "`,Alloy:`," . Available_Alloy . "`," . Inventory_Alloy . "`,"
	/*
	Message_To_The_Boss .= "Fuel:," . Available_Fuel . "," . Inventory_Fuel
	. ",Food:," . Available_Food . "," . Inventory_Food
	. ",Steel:," . Available_Steel . "," . Inventory_Steel
	. ",Alloy:," . Available_Alloy . "," . Inventory_Alloy . ","

	; MsgBox, 0, ,
	; (LTrim
	; Fuel: %Available_Fuel% + %Inventory_Fuel%
	; Food: %Available_Food% + %Inventory_Food%
	; Steel: %Available_Steel% + %Inventory_Steel%
	; Alloy: %Available_Alloy% + %Inventory_Alloy%
	; )

	; Message_To_The_Boss .= "Fuel: " . Available_Fuel . " += " . Inventory_Fuel
	; . ", Food: " . Available_Food . " += " . Inventory_Food
	; . ", Steel: " . Available_Steel . " += " . Inventory_Steel
	; . ", Alloy: " . Available_Alloy . " += " . Inventory_Alloy . ", "

	; Message_To_The_Boss .= "
	; (
	; Fuel: " Available_Fuel " + " Inventory_Fuel "
	; Food: " Available_Food " + " Inventory_Food "
	; Steel: " Available_Steel " + " Inventory_Steel "
	; Alloy: " Available_Alloy " + " Inventory_Alloy "
	; )"
	*/

	; MsgBox, %Message_To_The_Boss%

	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return
}

; OCR capture User info like VIP level, combat power, alliance and state
Get_User_Info:
{
	Subroutine_Running := "Get_User_Info"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(47,80, {Timeout: (1*Delay_Long+0)}) ; Tap commander info on upper menu bar
	; Mouse_Click(47,80, {Timeout: (1*Delay_Medium+0)}) ; Tap commander info on upper menu bar

	/*
	loop, 20
	{
		Commander_Title := Search_Captured_Text_OCR(["Commander","Info"])
		if (Commander_Title.Found)
		{
			; MsgBox, % "Loop:" A_Index  " Commander_Title:""" Commander_Title.Text """"
			break
		}
	}
	*/

	; capture text from commander info screen
	; DllCall("Sleep","UInt",(7*Delay_Short+0))
	User_Name_Captured := OCR([205, 187, 180, 22], "eng")
	User_State_Alliance := OCR([290, 154, 220, 23], "eng")
	User_VIP := OCR([183, 151, 116, 24], "eng")
	User_Power := OCR([480, 366, 142, 24], "eng")

	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	; MsgBox, % "1. before trim " User_Name_Captured ", " User_State_Alliance ", " User_VIP ", " User_Power
	; MsgBox, % User_Name_Captured ", " User_State_Alliance ", " User_VIP ", " User_Power

	; Extract User_Found_Alliance from User_State_Alliance
	RegExMatch(User_State_Alliance, "`[[A-Za-z]+`]" , User_Found_Alliance)
	User_Found_Alliance := % RegExReplace(User_Found_Alliance,"[^A-Za-z0-9 ]+")

	; Extract User_Found_State from User_State_Alliance
	RegExMatch(User_State_Alliance, "\d\d\d" , User_Found_State)

	; Clean up User_VIP
	User_VIP := % RegExReplace(User_VIP,"[^A-Za-z0-9]+")
	; User_VIP := StrReplace(User_VIP, " ", "")
	User_VIP := StrReplace(User_VIP, "VIF", "VIP")
	User_VIP := StrReplace(User_VIP, "VIPS", "VIP9")

	; Clean up User_Power
	; User_Power := StrReplace(User_Power, ", ", "")
	; User_Power := % RegExReplace(User_Power,"[^0-9]+")

	User_Power := % Convert_OCR_Value(User_Power)

	; MsgBox, % "User_State_Alliance:" User_State_Alliance " and User_Found_Alliance: " User_Found_Alliance " User_Found_State: " User_Found_State

	; User_Name_Captured := trim(User_Name_Captured)
	; User_VIP := trim(User_VIP)
	; User_State_Alliance := trim(User_State_Alliance)
	; User_Power := trim(User_Power)
	; MsgBox, % "2. after trim " User_Name_Captured ", " User_State_Alliance ", " User_VIP ", " User_Power

	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()

	; User_Diamonds := OCR([590, 90, 96, 30], "eng")
	User_Diamonds := OCR([594, 98, 93, 19], "eng")
	User_Diamonds := % Convert_OCR_Value(User_Diamonds)

	Message_To_The_Boss .= User_Name_Captured
	. "`,Alliance:`," . User_Found_Alliance
	. "`,State:`," . User_Found_State
	. "`,VIP:`," . User_VIP
	. "`,Power:`," . User_Power . "`,"
	. "`,Diamonds:`," . User_Diamonds . "`,"
	
	
	; Base_Array[User] := {User_Name_Captured : User_Name_Captured, User_State_Alliance: User_State_Alliance, User_VIP: User_VIP, User_Power: User_Power, User_Diamonds: User_Diamonds}
	
	Base_Array[User].User_Name_Captured := User_Name_Captured
	Base_Array[User].User_Found_State := User_Found_State
	Base_Array[User].User_Found_Alliance := User_Found_Alliance
	Base_Array[User].User_VIP := User_VIP
	Base_Array[User].User_Power := User_Power
	Base_Array[User].User_Diamonds := User_Diamonds
	
	
	; Array_Gui(Base_Array)
	; MsgBox, Message_To_The_Boss: %Message_To_The_Boss%
	return
}

; OCR capture Map coordinates of base
Get_User_Location:
{
	Subroutine_Running := "Get_User_Location"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(76,1200, {Timeout: (3*Delay_Long+0)}) ; Tap World/home button

	loop, 5
	{
		Mouse_Click(347,600, {Timeout: (1*Delay_Long+0)}) ; Tap My City on World Map
		; User_City_Location := OCR([300, 664, 120, 43], "eng")
		User_City_Location := OCR([298, 660, 100, 34], "eng")
		; User_City_Location := Trim(User_City_Location)
		; User_City_Location := % RegExMatch(User_City_Location,"X:\d+[^\d]*Y:\d+[^\d]*", User_City_Location_XY)
		if (RegExMatch(User_City_Location,"X:\d+[^\d]*Y:\d+[^\d]*", User_City_Location_XY))
		{
			User_City_Location_XY := % RegExReplace(User_City_Location_XY,"[^0-9,]+")
			User_City_Location_XY := StrReplace(User_City_Location_XY, ",", ":")
			; if !(User_City_Location_XY = "")
				break
		}
	}
	; MsgBox, % "User_City_Location: " . User_City_Location . " User_City_Location_XY: " . User_City_Location_XY

	Message_To_The_Boss .= "Location:`,""(" . User_City_Location_XY . ")""`,"
	
	Base_Array[User].User_City_Location_XY := User_City_Location_XY

	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	; User_City_Location := OCR([304, 663, 85, 22], "eng")
	; User_City_Location_Array := StrSplit(User_City_Location, "`,","XY: ") ; Omits X, Y, : and space.

	; MsgBox, % "1. before split X`,Y:" User_City_Location " 2. after split X:Y" User_City_Location_Array[1] ":" User_City_Location_Array[2]
	; Message_To_The_Boss .= "Location:`,""" . User_City_Location_Array[1] . ":" . User_City_Location_Array[2] . """`,"

	; Go_Back_Home_Delay_Long := True
	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return
}

/*
; Search for bases in world map, NINJA style
Base_Search_World_Map:
{
	Subroutine_Running := "Base_Search_World_Map"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Gosub Initialize_Variables
	Check_For_Zombie_Popup()
	Gosub Maximize_Viewing_Area
	; Gosub Enter_Search_Coordinates

	loop
	{
		Gosub Search_List_Of_Colors
		Gosub Swipe_LL_To_UR
	}
	return

	Initialize_Variables:
	{
		; App_WinWidth := 730
		; App_WinHeight := 1249
		; first area X = 4-562, Y = 144-657
		X1 := 150
		Y1 := 264
		X2 := App_WinWidth - (App_WinWidth - 484)
		Y2 := App_WinHeight - (App_WinHeight - 468)
		PixelSearch_UpperX1 := (UpperX + X1) ; initialize upper left X coord of PixelSearch area
		PixelSearch_UpperY1 := (UpperY + Y1) ; initialize upper left Y coord of PixelSearch area
		PixelSearch_LowerX1 := (LowerX - X2) ; initialize lower right X coord of PixelSearch area
		PixelSearch_LowerY1 := (LowerY - Y2) ; initialize lower right Y coord of PixelSearch area

		; second area X = 90-654 Y = 657-934
		X1 := 200
		Y1 := 468
		X2 := App_WinWidth - (App_WinWidth - 610)
		Y2 := App_WinHeight - (App_WinHeight - 930)
		PixelSearch_UpperX2 := (UpperX + X1) ; initialize upper left X coord of PixelSearch area
		PixelSearch_UpperY2 := (UpperY + Y1) ; initialize upper left Y coord of PixelSearch area
		PixelSearch_LowerX2 := (LowerX - X2) ; initialize lower right X coord of PixelSearch area
		PixelSearch_LowerY2 := (LowerY - Y2) ; initialize lower right Y coord of PixelSearch area

		; Global Base_Color := "0x1D1D1D"
		PixelSearch_Variation := 0
		PixelSearch_Mode := "Fast"
		Map_X := "{Raw}560"
		Map_Y := "{Raw}578"
		return
	}

	Enter_Search_Coordinates:
	{
		; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
		Mouse_Click(220,1000, {Timeout: (3*Delay_Short+0)}) ; Tap Map Coordinate button
		; Mouse_Click(189,870, {Timeout: (3*Delay_Short+0)}) ; Tap Map Coordinate button

		Mouse_Click(200,530, {Timeout: (2*Delay_Short+0)}) ; Tap inside X coordinate Box
		Text_To_Screen(Map_X)
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
		Command_To_Screen("{Enter}")
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
		Mouse_Click(449,530, {Timeout: (2*Delay_Short+0)}) ; Tap inside Y coordinate Box
		Text_To_Screen(Map_Y)
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
		Command_To_Screen("{Enter}")
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
		; Mouse_Click(196,467) ; Tap Go To Coordinates1
		Mouse_Click(350,620, {Timeout: (2*Delay_Short+0)}) ; Tap Go To Coordinates2

		return
	}

	Maximize_Viewing_Area:
	{
		; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
		PixelSearch, Px, Py, 599, 595, 657, 623, 0xFFFFFF, PixelSearch_Variation, Fast
		if ErrorLevel
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		else
		{
			Mouse_Click(Px,Py, {Timeout: (1*Delay_Medium+0)}) ; Tap to shrink activity bar
		}
		return
	}

	Swipe_LL_To_UR:
		Mouse_Drag(112, 897, 497, 703, {EndMovement: F, SwipeTime: 500})
		return

	Search_Base_Pictures:
	{
		For Base,Val in Base_Colors
		{
			Base_Picture := Base

			; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			ImageSearch, FoundPictureX, FoundPictureY, %PixelSearch_UpperX1%, %PixelSearch_UpperY1%, %PixelSearch_LowerX1%, %PixelSearch_LowerY1%, *145 *Trans0xF0F0F0 %Base_Picture%
			if !ErrorLevel ; (ErrorLevel = 0)
			{
				stdout.WriteLine(A_NowUTC ",A," Base_Picture " was found at X"FoundPictureX " Y" FoundPictureY )
				Mouse_Click(FoundPictureX,FoundPictureY, {Timeout: (1*Delay_Medium+0)}) ; Tap Found Base
				MsgBox, 1 ErrorLevel: %ErrorLevel% - A %Base_Picture% found at X%FoundPictureX% Y%FoundPictureY%.
			}

			; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			ImageSearch, FoundPictureX, FoundPictureY, %PixelSearch_UpperX2%, %PixelSearch_UpperY2%, %PixelSearch_LowerX2%, %PixelSearch_LowerY2%, *145 *Trans0xF0F0F0 %Base_Picture%
			if !ErrorLevel ; (ErrorLevel = 0)
			{
				stdout.WriteLine(A_NowUTC ",A," Base_Picture " was found at X"FoundPictureX " Y" FoundPictureY )
				Mouse_Click(FoundPictureX,FoundPictureY, {Timeout: (1*Delay_Medium+0)}) ; Tap Found Base
				MsgBox, 2 ErrorLevel: %ErrorLevel% - A %Base_Picture% found at X%FoundPictureX% Y%FoundPictureY%.
			}

			; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			ImageSearch, FoundPictureX, FoundPictureY, %PixelSearch_UpperX1%, %PixelSearch_UpperY1%, %PixelSearch_LowerX1%, %PixelSearch_LowerY1%, *145 *Trans0xFFFFFF %Base_Picture%
			if !ErrorLevel ; (ErrorLevel = 0)
			{
				stdout.WriteLine(A_NowUTC ",A," Base_Picture " was found at X"FoundPictureX " Y" FoundPictureY )
				Mouse_Click(FoundPictureX,FoundPictureY, {Timeout: (1*Delay_Medium+0)}) ; Tap Found Base
				MsgBox, 3 ErrorLevel: %ErrorLevel% - A %Base_Picture% found at X%FoundPictureX% Y%FoundPictureY%.
			}

			; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			ImageSearch, FoundPictureX, FoundPictureY, %PixelSearch_UpperX2%, %PixelSearch_UpperY2%, %PixelSearch_LowerX2%, %PixelSearch_LowerY2%, *145 *Trans0xFFFFFF %Base_Picture%
			if !ErrorLevel ; (ErrorLevel = 0)
			{
				stdout.WriteLine(A_NowUTC ",A," Base_Picture " was found at X"FoundPictureX " Y" FoundPictureY )
				Mouse_Click(FoundPictureX,FoundPictureY, {Timeout: (1*Delay_Medium+0)}) ; Tap Found Base
				MsgBox, 4 ErrorLevel: %ErrorLevel% - A %Base_Picture% found at X%FoundPictureX% Y%FoundPictureY%.
			}
		}
			MsgBox, Search Completed
			; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
		return
	}

	Search_List_Of_Colors:
	{
		; MsgBox, (%PixelSearch_UpperX1% < %PixelSearch_LowerX1%) && (%PixelSearch_UpperX2% < %PixelSearch_LowerX2%))
		For Base,Val in Base_Colors
		{
			Base_Level := Base
			Base_Color := Val[1]
			Gosub Initialize_Variables

			Resume_Pixel_Search:
			; Check_For_Zombie_Popup()

			; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			PixelSearch, Px, Py, %PixelSearch_UpperX1%, %PixelSearch_UpperY1%, %PixelSearch_LowerX1%, %PixelSearch_LowerY1%, %Base_Color%, PixelSearch_Variation, %PixelSearch_Mode%
			if ErrorLevel
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			else
				goto Get_Base_Info

			; MsgBox, 1. X1 %X1% Y1 %Y1% X2 %X2% Y2 %Y2% PixelSearch_UpperX1 %PixelSearch_UpperX1% PixelSearch_UpperY1 %PixelSearch_UpperY1% PixelSearch_LowerX1 %PixelSearch_LowerX1% PixelSearch_LowerY1 %PixelSearch_LowerY1%

			PixelSearch, Px, Py, %PixelSearch_UpperX2%, %PixelSearch_UpperY2%, %PixelSearch_LowerX2%, %PixelSearch_LowerY2%, %Base_Color%, PixelSearch_Variation, %PixelSearch_Mode%
			if ErrorLevel
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			else
				goto Get_Base_Info

			; MsgBox, 2. X1 %X1% Y1 %Y1% X2 %X2% Y2 %Y2% PixelSearch_UpperX2 %PixelSearch_UpperX2% PixelSearch_UpperY2 %PixelSearch_UpperY2% PixelSearch_LowerX2 %PixelSearch_LowerX2% PixelSearch_LowerY2 %PixelSearch_LowerY2%

			Goto End_Of_Color_Search

			Get_Base_Info:
			{
				global OCR_X := (Px - 40)
				global OCR_Y := (Py - 10)
				global OCR_W := 132
				global OCR_H := 60

				; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
				; Found_City_Info1 := OCR([OCR_X, OCR_Y, OCR_W, OCR_H], "eng")
				; Found_City_Info1 := % RegExReplace(Found_City_Info1,"[\r\n\h]+")
				; Found_City_Info1 := trim(Found_City_Info1)

				; msgBox, 1. Base_Color: %Base_Color% Found_City_Info1: %Found_City_Info1%

				; MsgBox, 1. OCR X,Y %OCR_X%,%OCR_Y% Px,Py: %Px%,%Py% Found_City_Info1: %Found_City_Info1%

				Mouse_Click(Px,Py, {Timeout: (1*Delay_Medium+0)}) ; Tap on potential city

				; if Check_For_Zombie_Popup() ; check for rover zombie popup
				; goto Next_Coord_Search

				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
				Found_City_Info2 := OCR([OCR_X, OCR_Y, OCR_W, OCR_H], "eng")
				Found_City_Info2 := % RegExReplace(Found_City_Info2,"[\r\n\h]+")
				Found_City_Info2 := trim(Found_City_Info2)

				if RegExMatch(Found_City_Info2,"Garisoning")
					goto Next_Coord_Search
				if RegExMatch(Found_City_Info2,"Gather")
					goto Next_Coord_Search
				if RegExMatch(Found_City_Info2,"ReserveFactory")
					goto Next_Coord_Search
				if RegExMatch(Found_City_Info2, "\d+km")
					goto Next_Coord_Search
				if (Found_City_Info2 = Last_City_Info_Found)
					goto Next_Coord_Search

				MsgBox, 2. OCR X,Y %OCR_X%,%OCR_Y% Px,Py: %Px%,%Py% Base_Color: %Base_Color% Found_City_Info2: %Found_City_Info2%

				; msgBox, 2. Base_Color: %Base_Color% Found_City_Info2: %Found_City_Info1%

				RegExMatch(Found_City_Info2,"X:\d+[^\d]*Y:\d+[^\d]*", Found_City_Location)
				Found_City_Name2 := StrReplace(Found_City_Info2, Found_City_Location, "")

				if (Found_City_Name2 = Last_City_Loc_Found) ; if name same as before, skip
					goto Next_Coord_Search

				Found_City_Location := % RegExReplace(Found_City_Location,"[^0-9,]+")
				Found_City_Location := StrReplace(Found_City_Location, ",", ":")
				; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

				stdout.WriteLine(A_NowUTC ",Found_City_Info1," Found_City_Info1 " Found_City_Info2," Found_City_Info2 ",Found_City_Name," Found_City_Name ",Found_City_Location," Found_City_Location ",")

				if (Found_City_Location = "") ; if location blank, skip
					goto Next_Coord_Search
				if (Found_City_Location = Last_City_Loc_Found) ; if location same as before, skip
					goto Next_Coord_Search

				MsgBox, ErrorLevel: %ErrorLevel% - A %Base_Level% color within %PixelSearch_Variation% shades of %Base_Color%, pixel:%Px%,%Py% and coords (%Found_City_Location%) Found_City_Name2: %Found_City_Name2% 1: "%Found_City_Info1%" 2: "%Found_City_Info2%"

				Last_City_Info_Found := Found_City_Info2
				Last_City_Name_Found := Found_City_Name2
				Last_City_Loc_Found := Found_City_Location

				stdout.WriteLine(A_NowUTC ",Found_City_Info," Found_City_Info ",Found_City_Name," Found_City_Name ",Found_City_Location," Found_City_Location ",")

				Next_CoGraphicSearch:
				; goto End_Of_Color_Search

				if (PixelSearch_UpperX1 < Px)
					if (Px < PixelSearch_LowerX1)
					{
						PixelSearch_UpperX1 := (%Px% + 1)
						goto Resume_Pixel_Search
					}

				if (PixelSearch_UpperX2 < Px)
					if (Px < PixelSearch_LowerX2)
					{
						PixelSearch_UpperX2 := (%Px% + 1)
						goto Resume_Pixel_Search
					}

				; if (PixelSearch_UpperY1 < Py)
				; PixelSearch_UpperY1 := (Py + 1)
				; if (PixelSearch_UpperY2 < Py)
				; PixelSearch_UpperY2 := (Py + 1)
			}
			End_Of_Color_Search:
			; Mouse_Click(550,1037) ; Tap next to speaker
			; Check_For_Zombie_Popup()
		}
		return
	}

	; Go_Back_Home_Delay_Long := True
	if !Go_Back_To_Home_Screen()
		Reload_LEWZ()
	return
}

; Function to clear zombie pop-up messages
Check_For_Zombie_Popup()
{
	Gosub Check_Window_Geometry
	; Red Attack button
	; 210, 887 to 473, 938 - red 0x830D01 Attack zombie button
	; 162, 838 to 523, 890 - red 0x720D06 attack rover button
	; 162, 838 to 523, 938 - red 0x720D06 attack combined button
	X1 := 162
	Y1 := 838
	X2 := App_WinWidth - (App_WinWidth - 523)
	Y2 := App_WinHeight -(App_WinHeight - 938)
	Attack_UpperX := (UpperX + X1) ; initialize upper left X coord of PixelSearch area
	Attack_UpperY := (UpperY + Y1) ; initialize upper left Y coord of PixelSearch area
	Attack_LowerX := (LowerX - X2) ; initialize lower right X coord of PixelSearch area
	Attack_LowerY := (LowerY - Y2) ; initialize lower right Y coord of PixelSearch area

	; MsgBox, X1 %X1% Y1 %Y1% X2 %X2% Y2 %Y2% Attack_UpperX %Attack_UpperX% Attack_UpperY %Attack_UpperY% Attack_LowerX %Attack_LowerX% Attack_LowerY %Attack_LowerY%

	Attack_Color := "0x4e1610" ; 25
	; Attack_Color := "0x810f09"
	; Attack_Color := "0x381410"
	; Attack_Color := "0xbc140e"
	; Attack_Color := "0x970D03"
	Attack_Variation := 25

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; if Rover or zombie pop-up, click next to speaker
	PixelSearch, Px, Py, %Attack_UpperX%, %Attack_UpperY%, %Attack_LowerX%, %Attack_LowerY%, %Attack_Color%, Attack_Variation, Fast
	if ErrorLevel
	{
		; MsgBox, No Zombie or Rover return 5 ; 0
		return 0
	}
	else
	{
		Mouse_Click(550,1037) ; Tap next to speaker
		; Command_To_Screen("{Esc}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		; MsgBox, Zombie or Rover return 5 ; 1
		return 1
	}
	return
}
*/

; Elivate MEMU processes
Elivate_program:
{
	Subroutine_Running := "Elivate_program"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; ([Subroutine_Running,A_ThisLabel])

	; stdout.WriteLine(A_NowUTC ",Elivate_program, " image_name " Main_Loop_Counter: " Main_Loop_Counter " Restart_Loops: " Restart_Loops " Reset_App_Yes: " Reset_App_Yes)

	; PERC := Chr(37)
	; wmic process where "Name like '%PERC%MEmu%PERC%' OR Name like '%PERC%MEmu%PERC%'" CALL setpriority "above normal"
	; wmic process where "Name like '`%MEmu`%' OR Name like '`%MEmu`%'" CALL setpriority "above normal"
	; wmic process where "Name like '`%MEmu`%' OR Name like '`%MEmu`%'" CALL setpriority 128
	commands=
	(join&
	wmic process where "Name like '`%MEmu`%' OR Name like '`%MEmu`%'" CALL setpriority 128
	)
	; runwait, %comspec% /c %commands%

	; stdout.WriteLine(A_NowUTC ", commands, " commands ", result: ," RunWaitOne(commands))
	; WinMinimize ; Minimize the window found by WinWait.
	RunNoWaitOne(commands)
	; RunWaitOne(commands)
	; run .\tools\Time_Sync.bat
	; exitapp
	; Win_WaitRegEX("AutoHotkey")

	; return

	; cmdLine := Win_WaitRegEX("AutoHotkey")
	; Gosub Minimize_Cmd
	cmdLine := Win_GetInfo("AutoHotkey")
	Gosub Minimize_Cmd
	return

	Minimize_Cmd:
	cmdID := cmdLine.ID
	cmdClass := "ConsoleWindowClass"
	cmdEXE := "AutoHotkey`.exe"

	loop, 10
	{
		if WinExist("ahk_class " . cmdClass) ; ahk_class ConsoleWindowClass ; if !ErrorLevel
		{
			WinWait, ahk_class %cmdClass%, , 0
			if !ErrorLevel
			{
				WinMinimize ; Minimize the window found by WinWait.
				break
			}
		}
		if WinExist("ahk_exe " . cmdEXE) ; ahk_exe AutoHotkey.exe ; if !ErrorLevel
		{
			WinWait, ahk_exe %cmdEXE%, , 0
			if !ErrorLevel
			{
				WinMinimize ; Minimize the window found by WinWait.
				break
			}
		}
		if WinExist("ahk_id " . cmdID) ; ahk_id 0x64f14dc ; if !ErrorLevel
		{
			WinWait, ahk_id %cmdID%, , 0
			if !ErrorLevel
			{
				WinMinimize ; Minimize the window found by WinWait.
				break
			}
		}
	}
	return
}

; Elivate MEMU processes
Elivate_program_old:
{
	/*
	C:\Program Files\AutoHotkey\AutoHotkey.exe
	ahk_class ConsoleWindowClass
	ahk_exe AutoHotkey.exe
	ahk_id 0x64f14dc
	ahk_pid 16120

	cmdTitle := "C`:`\Program Files`\AutoHotkey`\AutoHotkey`.exe"
	cmdClass := "ConsoleWindowClass"
	cmdEXE := "AutoHotkey`.exe"
	cmdID := "0x64f14dc"
	cmdPID := "16120"
	; MsgBox, 1. Title:"%cmdTitle%"`nClass:"%cmdClass%`nEXE:"%cmdEXE%"`nID:"%cmdID%"`nPID:"%cmdPID%"

	; cmdTitle := cmdClass := cmdEXE := cmdID := cmdPID := ""

	Function := "Win_WaitRegEX"
	cmdLine := Win_WaitRegEX("AutoHotkey")
	cmdTitle := cmdLine.Title
	cmdID := cmdLine.ID
	; MsgBox, 2. Title:"%cmdTitle%"`nClass:"%cmdClass%`nEXE:"%cmdEXE%"`nID:"%cmdID%"`nPID:"%cmdPID%"
	Gosub Minimize_loop

	cmdTitle := "C`:`\Program Files`\AutoHotkey`\AutoHotkey`.exe"
	cmdClass := "ConsoleWindowClass"
	cmdEXE := "AutoHotkey`.exe"
	cmdID := "0x64f14dc"
	cmdPID := "16120"

	Function := "Win_GetInfo"
	cmdLine := Win_GetInfo("AutoHotkey")
	cmdX := cmdLine.X
	cmdY := cmdLine.Y
	cmdW := cmdLine.W
	cmdH := cmdLine.H
	cmdClass := cmdLine.Class
	cmdTitle := cmdLine.Title
	cmdID := cmdLine.ID
	; MsgBox, 3. Title:"%cmdTitle%"`nClass:"%cmdClass%`nEXE:"%cmdEXE%"`nID:"%cmdID%"`nPID:"%cmdPID%"
	Gosub Minimize_loop

	return

	Minimize_loop:
	loop, 2
	{
		if WinExist(cmdTitle) ; C:\Program Files\AutoHotkey\AutoHotkey.exe ; if !ErrorLevel
		{
			WinWait, %cmdTitle%, , 0
			WinMinimize ; Minimize the window found by WinWait.
			DllCall("Sleep","UInt",(rand_wait + 3*Delay_Long+0))
			WinRestore
			; MsgBox, WinWait cmdTitle:%cmdTitle% ; C:\Program Files\AutoHotkey\AutoHotkey.exe
			WinMinimize ; Minimize the window found by WinWait.
			FileAppend, "%A_NowUTC%"`,"Function"`,"%Function%"`,"WinWait cmdTitle"`,"%cmdTitle%"`n, %AppendCSVFile%
			;break
		}
		if WinExist("ahk_class " . cmdClass) ; ahk_class ConsoleWindowClass ; if !ErrorLevel
		{
			WinWait, ahk_class %cmdClass%, , 0
			WinMinimize ; Minimize the window found by WinWait.
			DllCall("Sleep","UInt",(rand_wait + 3*Delay_Long+0))
			WinRestore
			; MsgBox, WinWait "ahk_class " %cmdClass% ; ahk_class ConsoleWindowClass
			FileAppend, "%A_NowUTC%"`,"Function"`,"%Function%"`,"WinWait cmdClass"`,"%cmdClass%"`n, %AppendCSVFile%
			;break
		}
		if WinExist("ahk_exe " . cmdEXE) ; ahk_exe AutoHotkey.exe ; if !ErrorLevel
		{
			WinWait, ahk_exe %cmdEXE%, , 0
			WinMinimize ; Minimize the window found by WinWait.
			DllCall("Sleep","UInt",(rand_wait + 3*Delay_Long+0))
			WinRestore
			; MsgBox, WinWait "ahk_exe " %cmdEXE% ; ahk_exe AutoHotkey.exe
			FileAppend, "%A_NowUTC%"`,"Function"`,"%Function%"`,"WinWait cmdEXE"`,"%cmdEXE%"`n, %AppendCSVFile%
			;break
		}
		if WinExist("ahk_id " . cmdID) ; ahk_id 0x64f14dc ; if !ErrorLevel
		{
			WinWait, ahk_id %cmdID%, , 0
			WinMinimize ; Minimize the window found by WinWait.
			DllCall("Sleep","UInt",(rand_wait + 3*Delay_Long+0))
			WinRestore
			; MsgBox, WinWait "ahk_id " %cmdID% ; ahk_id 0x64f14dc
			FileAppend, "%A_NowUTC%"`,"Function"`,"%Function%"`,"WinWait cmdID"`,"%cmdID%"`n, %AppendCSVFile%
			;break
		}
		if WinExist("ahk_pid " . cmdPID) ; ahk_pid 16120 ; if !ErrorLevel
		{
			WinWait, ahk_pid %cmdPID%, , 0
			WinMinimize ; Minimize the window found by WinWait.
			DllCall("Sleep","UInt",(rand_wait + 3*Delay_Long+0))
			WinRestore
			; MsgBox, WinWait "ahk_pid " %cmdPID% ; ahk_pid 16125 ; 0
			FileAppend, "%A_NowUTC%"`,"Function"`,"%Function%"`,"WinWait cmdPID"`,"%cmdPID%"`n, %AppendCSVFile%
			;break
		}
	{
	; MsgBox, 4. Title:"%cmdTitle%"`nClass:"%cmdClass%`nEXE:"%cmdEXE%"`nID:"%cmdID%"`nPID:"%cmdPID%"
	*/

	return

	/*
	App_Title_Text := "AutoHotkey"
	cmdAppX := Win_WaitRegEX(App_Title_Text)
	cmdWindowTitle := cmdAppX.title
	cmdWindowID := cmdAppX.ID
	; MsgBox, 1. cmdWindowTitle:"%cmdWindowTitle%" cmdWindowID:"%cmdWindowID%"

	if !(cmdWindowTitle = 0) || if !(cmdWindowTitle = "")
		WinMinimize, Select %cmdWindowTitle%
	if !(cmdWindowID = 0) || if !(cmdWindowID = "")
		WinMinimize, ahk_id %cmdWindowID%

	; MsgBox, 1. cmdWindowTitle:"%cmdWindowTitle%" cmdWindowID:"%cmdWindowID%"
	; WinMinimize, %cmdWindow%
	*/

	/*
	loop, 1000
	{
		WinWait, %cmdWindow%, , 0
		if !ErrorLevel
		{
			WinMinimize ; Minimize the window found by WinWait.
			MsgBox, if !ErrorLevel
			break
		}
		If WinExist(cmdWindow)
		{
			WinActivate
			WinMinimize ; , %cmdWindow%
			MsgBox, If WinExist(cmdWindow)
			break
		}
	}
	*/

	; MsgBox, ; WinActivate, %FoundAppTitle%
	; WinActivate, %FoundAppTitle%
	return
}

; Find out size of app window
Get_Window_Geometry:
{
	Subroutine_Running := "Get_Window_Geometry"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; if !WinActive(FoundAppTitle), WinActivate, %FoundAppTitle%

	; stdout.WriteLine(A_NowUTC ",Get_Window_Geometry," image_name ",Main_Loop_Counter:," Main_Loop_Counter ",Restart_Loops:," Restart_Loops ",Reset_App_Yes:," Reset_App_Yes)

	LEWZGeo := Win_GetInfo(FoundAppTitle)
	; FoundAppTitle := LEWZGeo.Title
	; FoundAppClass := LEWZGeo.Class
	; FoundAppID := LEWZGeo.ID
	UpperX := FoundAppX := LEWZGeo.X
	UpperY := FoundAppY := LEWZGeo.Y
	WinWidth := FoundAppWidth := LEWZGeo.W
	WinHeight := FoundAppHeight := LEWZGeo.H

	; WinGetPos, FoundAppX, FoundAppY, FoundAppWidth, FoundAppHeight, %FoundAppTitle%
	; UpperX := FoundAppX
	; UpperY := FoundAppY
	; WinWidth := FoundAppWidth ; initialize Width of app window
	; WinHeight := FoundAppHeight ; initialize Height of app window

	LowerX := FoundAppWidth + UpperX ; compute lower right X coord of app window
	LowerY := FoundAppHeight + UpperY ; compute lower right X coord of app window
	; MsgBox, %FoundAppTitle% Upper: %FoundAppX%, %FoundAppY% %FoundAppWidth%x%FoundAppHeight% Lower: %LowerX%, %LowerY%
	; stdout.WriteLine(A_NowUTC ",Sub:""" Subroutine_Running """ Found App info: (X1:" FoundAppX ",Y1:" FoundAppY ",X2:" LowerX ",Y2:" LowerY ") Dimensions:" FoundAppWidth "x" FoundAppHeight " Title:" FoundAppTitle)
 stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; stdout.WriteLine(A_NowUTC ",Calculated UpperX,UpperY," UpperX "," UpperY ",LowerX,LowerY," LowerX "," LowerY)
	return
}

; check and Reposition window according to predefined settings
Check_Window_Geometry:
{
	; Subroutine_Running := "Check_Window_Geometry"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; stdout.WriteLine(A_NowUTC ",Check_Window_Geometry," image_name ",Main_Loop_Counter:," Main_Loop_Counter ",Restart_Loops:," Restart_Loops ",Reset_App_Yes:," Reset_App_Yes)
	; if !WinActive(FoundAppTitle), WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; stdout.WriteLine(A_NowUTC ",Inside Check_Window_Geometry image_name:," image_name)

	LEWZGeo := Win_GetInfo(FoundAppTitle)
	FoundAppTitle := LEWZGeo.Title
	FoundAppClass := LEWZGeo.Class
	FoundAppID := LEWZGeo.ID
	UpperX := FoundAppX := LEWZGeo.X
	UpperY := FoundAppY := LEWZGeo.Y
	WinWidth := FoundAppWidth := LEWZGeo.W
	WinHeight := FoundAppHeight := LEWZGeo.H
	LowerX := FoundAppWidth + UpperX ; compute lower right X coord of app window
	LowerY := FoundAppHeight + UpperY ; compute lower right X coord of app window

	; WinGetPos, FoundAppX, FoundAppY, FoundAppWidth, FoundAppHeight, %FoundAppTitle%
	; stdout.WriteLine(A_NowUTC ",Sub:," Subroutine_Running ", Found App info: (X1:" FoundAppX ",Y1:" FoundAppY ",X2:" LowerX ",Y2:" LowerY ") Dimensions:" FoundAppWidth "x" FoundAppHeight " Title:" FoundAppTitle)
 stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )

	if FoundAppX = App_Win_X
		if FoundAppY = App_Win_Y
			if FoundAppWidth = App_WinWidth
				if FoundAppHeight = App_WinHeight
					return

	; Changes the position and/or size of the specified window.
	; WinMove, X, Y
	; WinMove, FoundAppTitle, WinText, X, Y [, Width, Height, ExcludeTitle, ExcludeText]
	if FoundAppTitle contains MEmu
		WinMove, %FoundAppTitle%, , App_Win_X, App_Win_Y, App_WinWidth, App_WinHeight ; Move the window preset coords
	else
		WinMove, %FoundAppTitle%, , App_Win_X, App_Win_Y, App_WinWidth, App_WinHeight ; Move the window preset coords
	; MsgBox, %FoundAppTitle% Upper: %FoundAppX%, %FoundAppY% %FoundAppWidth%x%FoundAppHeight% Lower: %LowerX%, %LowerY%
	return

	MEmu_Operation_Recorder_X := App_Win_X
	MEmu_Operation_Recorder_Y := (App_Win_Y+App_WinHeight+1)

	IfWinNotExist, MEmu
	{
		IfWinNotExist, %Operation_Recorder_Window%
		{
			MsgBox, 3, , Please open Operation Recorder. Try auto launch?
			IfMsgBox Yes
			{
				; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
				Mouse_Click(339,14, {Timeout: (2*Delay_Long+0)}) ; Tap MEmu App header

				; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
				Mouse_Click(709,384, {Timeout: (2*Delay_Long+0)}) ; Tap to expand More menu

				; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
				Mouse_Click(630,382, {Timeout: (2*Delay_Long+0)}) ; Tap Operations Recorder
			}

			MsgBox, Click to expand More menu --> Click Operations Recorder

			loop, 10
			{
				WinWait, MEmu, , 0
				if !ErrorLevel ; (ErrorLevel = 0)
					goto Operation_Recorder_Position

				WinWait, %Operation_Recorder_Window%, , 0
				if !ErrorLevel ; (ErrorLevel = 0)
					goto Operation_Recorder_Position
			}
		}
	}

	Operation_Recorder_Position:
	; MsgBox, Operation_Recorder_Window = %Operation_Recorder_Window%, FoundAppTitle = %FoundAppTitle%
	IfWinExist, MEmu
	{
		; WinActivate, MEmu
		WinSetTitle, %Operation_Recorder_Window%
		goto Operation_Recorder_Position
	}

	; MsgBox, Operation_Recorder_Window = %Operation_Recorder_Window%, FoundAppTitle = %FoundAppTitle%

	IfWinExist, %Operation_Recorder_Window%
	{
		; WinActivate, %Operation_Recorder_Window% ; The above "IfWinNotExist" also set the "last found" window for us.
		WinMove, %Operation_Recorder_Window%, , FoundAppX, MEmu_Operation_Recorder_Y ; Move it to a new position.
	}

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	return
}

; Tap in the middle of the screen
Click_Middle_Screen:
{
	Subroutine_Running := "Click_Middle_Screen"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	Mouse_Click((LowerX-UpperX)/2+UpperX,(LowerY-UpperY)/2+(UpperY-100)) ; Tap in the middle of the screen
}

; Close and reopen log file for troubleshooting
Refresh_LogFiles:
{
	stdout.Close()
	CSVout.Close()
	LogFile := ".\logs\" . FileDateTimeString . "_MEmu.log"
	CSVFile := ".\CSV\" . FileDateTimeString . "_Farms.csv"
	AppendCSVFile := ".\CSV\" . FileDateTimeString . "_Append.csv"
	stdout := FileOpen(LogFile, "w `n")
	CSVout := FileOpen(CSVFile, "w `n")

	return
}

Select_App() {
	; MsgBox, 1. FoundAppTitle:"%FoundAppTitle%" NewTitle:"%NewTitle%" NewTitle2:"%NewTitle2%"
	global FoundAppClass := "Qt5QWindowIcon"
	global FoundAppControl := "Qt5QWindowIcon19"
	
	/*
	WW1 := Win_WaitRegEX("(LEWZ",,,"\")
	WW2 := Win_WaitRegEX(NewTitle)
	WW1_Info := % "Win_WaitRegEX()`nID:""" WW1.ID """`ntitle:""" WW1.title """"
	WW2_Info := % "Win_WaitRegEX(NewTitle)`nID:""" WW2.ID """`ntitle:""" WW2.title """"
	MsgBox, %WW1_Info% `n%WW2_Info%
	*/
	
	; NewTitle := InputBox2("App Title", "App Title", {Input:"Show", Width:300, Height:150, x:700, y:1000, Timeout: 10, Default:NewTitle})
	LEWZApp := Win_WaitRegEX(NewTitle)
	global FoundAppTitle := LEWZApp.title
	global FoundAppClass := LEWZApp.Class
	global FoundAppProcess := byref FoundAppControl ; LEWZApp.ID
	global FoundAppID := LEWZApp.ID
	; global FoundAppPID := LEWZApp.PID
	; MsgBox, % "Win_WaitRegEX(NewTitle) `nTitle:" FoundAppTitle "`nClass:" FoundAppClass "`nControl:" FoundAppControl "`nProcess:" FoundAppProcess "`nID:" FoundAppID
	
	NewTitle := RegExReplace(FoundAppTitle,"[^A-Za-z0-9]+")
	WinSetTitle, %NewTitle%
	FoundAppTitle := NewTitle
	; if !WinActive(FoundAppTitle), WinActivate, %FoundAppTitle%
	; MsgBox, 4. FoundAppTitle:"%FoundAppTitle%" NewTitle:"%NewTitle%" NewTitle2:"%NewTitle2%"
	; Operation_Recorder_Window := FoundAppTitle . " Recorder"
	; MsgBox, 2. FoundAppTitle:"%FoundAppTitle%" FoundAppID:"%FoundAppID%"
	
	return
}

; ****************************************
; HOT KEY assignments
; ****************************************

F1::
Gui, Show, W400 H40, Window List
return


^F6::
Reload_MEmu:
{
	Reload_LEWZ()
	; Reload_MEmu()
	; Launch_LEWZ()
	return
}

F6::
Reload_Script:
{
	Subroutine_Running := "Reload_Script"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )

	Gui, Status:new, , Status
	Gui, Status:Margin, 0, 0
	Gui, Status:add,text,, Script reloading... loop, %Main_Loop_Counter%
	; Gui, Status:show, x%MsgWinMove_X% y0 w300 h500
	Gui, Status:show, x731 y0 w300 h500
	Reload
	Random, rand_wait, %rand_min%, %rand_max%
	DllCall("Sleep","UInt",(rand_wait + 8*Delay_Short+0)) ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
	MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
	IfMsgBox, Yes, Edit
	return
}

F7::
	Resetting_Posit := True
	Key_Menu()
	Reset_Posit()
	Resetting_Posit := False
	Key_Menu()
return

Check_AppWindows_Timer:
	; Gosub Get_Window_Geometry
	Gosub Check_Window_Geometry
	Key_Menu()
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
return

; Shortcut for scrolling map
; slides from upper right to lower left
^F3::
	; Mouse_Drag(500,400,200,500, {EndMovement: F, SwipeTime: 200})
	; Mouse_Drag(575,150,50,900, {EndMovement: F, SwipeTime: 200})
	; Mouse_Drag(575,175,0,395, {EndMovement: F, SwipeTime: 200})
	; Mouse_Drag(575,175,0,491, {EndMovement: F, SwipeTime: 200})
	
	; Mouse_Drag(575,175,0,445, {EndMovement: F, SwipeTime: 200})
	Mouse_Drag(575,375,115,500, {EndMovement: F, SwipeTime: 50})
	; ratio 575/270 = 115/54 = 2.1296296296296 : 1 == 1 : 0.4695652173913
return

; Shortcut for claiming max items in inventory
; slides bar from left to right and presses OK
F3::
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Drag Slide Right to select all
	; Mouse_Drag(125, 687, 415, 703, {EndMovement: F, SwipeTime: 500}) ; original
	; Mouse_Click(382,774) ; Tap Use ; original

	; Mouse_Drag(115, 680, 360, 680, {EndMovement: F, SwipeTime: 500}) ; Client start: 115, 680, end: 360, 680
	Mouse_Drag(115, 680, 380, 680, {EndMovement: F, SwipeTime: 500}) ; Client start: 115, 680, end: 360, 680
	Mouse_Click(368,680, {Timeout: (3*Delay_Short+0)}) ; Tap Use ; 340, 786
	Mouse_Click(380,786, {Timeout: (3*Delay_Short+0)}) ; Tap Use ; 340, 786
Return


; Terminate running routine
F9::
if !Go_Back_To_Home_Screen()
	Reload_LEWZ()
Gosub, Exit_Sub
MsgBox, This MsgBox will never happen because of the EXIT.
return

^F9::
	Array_Gui(Base_Array)
return

Exit_Sub:
Exit ; Terminate this subroutine as well as the calling subroutine.

; Close running AHK
; #c:: OCR()
#g:: Vis2.OCR.google() ; Googles the text instead of saving it to clipboard.
#i:: ImageIdentify()

; Esc::ExitApp

; original Pause statement
; Pause::Pause ; Pressing pause once will pause the script. Pressing it again will unpause.

Pause:: ; Pressing pause once will pause the script. Pressing it again will unpause.
Pause,,1	; read the documentation on Pause to understand the consequences of this 1. It seems to matter where this hotkey is in the script.
Key_Menu()
; if !WinActive(FoundAppTitle), WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
Return

F4::ExitApp