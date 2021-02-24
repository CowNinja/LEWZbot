<<<<<<< Updated upstream
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
ListLines On	; Includes subsequently-executed lines in the history. This is the starting default for all scripts.
Process, Priority, , H
SetBatchLines, -1
SetKeyDelay, -1, 20 ; -1 ; default
SetMouseDelay, -1 ; -1 ; default
SetDefaultMouseSpeed, 3 ; 0 ; Move the mouse SPEED.
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
; #include lib\WindowListMenu_mod_004.ahk
; #include lib\LEZ_Functions.ahk
; #include lib\LEZ_Functions_1057_mod_002.ahk
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
		; stdout.WriteLine(A_Now " Main_loop, " image_name " Main_Loop_Counter: " Main_Loop_Counter " Restart_Loops: " Restart_Loops " Reset_App_Yes: " Reset_App_Yes)
		; if !WinActive(FoundAppTitle), WinActivate, %FoundAppTitle% ; WinActivate ; Automatically uses the window found above.

		; MouseMove UpperX+(WinWidth/2), UpperY+(WinHeight/2)

		; Generate Random time interval to add to all delays and pauses
		Random, rand_wait, %rand_min%, %rand_max%
		Key_Menu() ; display/update keyboard shortcut menu
		; Process_Menu()

		; Switch User
		For User,Val in User_Logins
		{
			; Gosub Get_Window_Geometry
			Gosub Check_Window_Geometry
			; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			
			; ([FoundAppTitle,FoundAppClass,FoundAppControl,FoundAppProcess])

			; Populate account variables from next keyed array item
			global User_Name := User
			global User_Email := Val[1]
			global User_Pass := Val[2]
			global User_PIN := Val[3]

			; Generate and combine text for account selection pop-up box
			Output := "User: " User " has: "
			Output .= "Email: " Val[1] " "
			; Output .= "Password: " Val[2] " "
			; Output .= "PIN: " Val[3]
			MsgBox, 3, , Login to %Output% ? (10 second Timeout & auto),10
			vRet := MsgBoxGetResult()
			if (vRet = "Yes") || if (vRet = "Timeout")
				Gosub Switch_Account
			else if (vRet = "No")
				goto END_of_user_loop

			; loop, 2
				Gosub Go_Back_To_Home_Screen
			
			; ***************************************
			; Main DEBUG and event Variables - START
			; ***************************************
			Pause_Script := False
			CSB_Event := False ; True ; True if CSB Event is going on
			Desert_Event := True ; False ; True ; True if Desert Event is going on
			; if CSB_Event ; || if Desert_Event
			At_War := False ; if set to True, peace shield will be enabled
			; ***************************************
			; Main DEBUG and event Variables - END
			; ***************************************

			; MsgBox, 4, , Enable Pause? (8 Second Timeout & skip), 8
			; vRet := MsgBoxGetResult()
			; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
			; Pause_Script := True

			; if Pause_Script
			; MsgBox, 0, Pause, Press OK to resume (No Timeout)

			; Jump to specific predefined routines
			; goto Special_Routine
			; goto New_Day_Game_Reset
			; goto Fast_Routine
			; goto End_Of_Day_Routine
			; goto FULL_Q_and_A_Routine
			; goto END_of_user_loop

			; if (A_Now >= startTime && A_Now <= endTime)

			/*
			if (A_Hour >= 12 && A_Hour < 19)
				goto End_Of_Day_Routine
			else if (A_Hour >= 19 || A_Hour <= 05)
				goto New_Day_Game_Reset
			else
				goto Fast_Routine
			*/

			; Figure out the day and time to determine if shield is needed
			; If time is within 24 hours of killing event, Peace_Shield_Needed variable = True
			FormatTime, today,, dddd
			if (today = "Thursday" && A_Hour >= 19)
				Peace_Shield_Needed := True
			if (today = "Friday" || today = "Saturday")
				Peace_Shield_Needed := True
			if (today = "Sunday" && A_Hour <= 19)
				Peace_Shield_Needed := True
			if At_War
				Peace_Shield_Needed := True

			; Figure out time of day for which subroutines will run
			if (A_Hour >= 12 && A_Hour < 19)
				Routine := "End_Of_Day"
			else if (A_Hour >= 19 || A_Hour <= 05)
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
				; ******************************************
				; MsgBox, Hour: %A_Hour% %Routine%
				; for testing routines
				; MsgBox, 0, Pause, Press OK to start (No Timeout)
				; Gosub Benefits_Center
				; Message_To_The_Boss := User_Name . " " . Routine . " Routine`,"
				; Gosub Benefits_Center
				; Gosub Mail_Collection
				; Gosub Desert_Oasis
				; Gosub Donate_Tech
				; Gosub Activity_Center_Wonder
				; Gosub BruteForcePIN
				; Gosub Speaker_Help
				; Gosub Golden_Chest
				; Gosub Depot_Rewards
				; Gosub Speaker_Help
				; MsgBox, 0, Pause, Press OK to end (No Timeout)
				; goto END_of_user_loop
				; Gosub Game_Start_popups
				; Gosub Shield_Warrior_Trial_etc
				; ******************************************
				; DEBUG / Troubleshooting block - END
				; ******************************************
				
				if Peace_Shield_Needed
					Gosub Peace_Shield
				; Gosub Reset_Posit

				; ** Position dependant **
				Gosub Collect_Collisions
				Gosub Collect_Recruits
				Gosub Collect_Equipment_Crafting
				Gosub Collect_Runes
				Gosub Collect_Cafeteria
				; ******************************************
				; DEBUG / Troubleshooting block - BEGIN
				; ******************************************
				; Gosub Speaker_Help
				; Gosub Active_Skill
				; Gosub Desert_Oasis
				; Gosub Mail_Collection
				; Gosub Speaker_Help
				; ; Activity_Center_Open()
				; MsgBox, 0, Pause, Press OK to end (No Timeout)
				; Gosub Go_Back_To_Home_Screen
				; Gosub Speaker_Help
				; goto END_of_user_loop
				; ******************************************
				; DEBUG / Troubleshooting block - END
				; ******************************************
				
				Gosub Depot_Rewards
				; if (Routine = "New_Day") || if (Routine = "End_Of_Day")
				; Gosub Golden_Chest
				Gosub Speaker_Help
				if (Routine = "New_Day") || if (Routine = "End_Of_Day")
					Gosub Drop_Zone

				; ** Not position dependant **
				if CSB_Event ; || if Desert_Event
					if !(A_Hour = 19 && A_Min <= 30)
						Gosub Reserve_Factory
				Gosub Active_Skill				
				Gosub Donate_tech
				Gosub Speaker_Help
				
				if (Routine = "New_Day") || if (Routine = "End_Of_Day")
				{
					Gosub VIP_Shop
					Gosub Benefits_Center
					Gosub Speaker_Help
					Gosub Alliance_Boss_Regular
					Gosub Alliance_Boss_Oasis
					Gosub Mail_Collection
					Gosub Alliance_Wages
				}
				if !Desert_Event
					Gosub Gather_On_Base_RSS

				if Desert_Event
				{
					Gosub Desert_Oasis
					Gosub Activity_Center_Wonder
				}
				; Gosub Gather_Resources
				Gosub Speaker_Help
				; Gosub Collect_Red_Envelopes

				Message_To_The_Boss := User_Name . " " . Routine . " Routine,"
				if (Routine = "New_Day") || if (Routine = "End_Of_Day")
					Gosub Get_User_Location
				Gosub Get_User_Info
				if (Routine = "New_Day") || if (Routine = "End_Of_Day")
					Gosub Get_Inventory
				Gosub Send_Mail_To_Boss
				; Gosub Send_Message_In_Chat

				; MsgBox, 4, , Pause before switching accounts? (4 Second Timeout & skip), 4
				; vRet := MsgBoxGetResult()
				; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
				; MsgBox, 0, Pause, Press OK to resume (No Timeout)

				goto END_of_user_loop
			}

			Special_Routine:
			{
				Routine_Running := "Special_Routine"
				; for testing routines
				; MsgBox, 0, Pause, Press OK to begin (No Timeout)
				; Gosub Active_Skill
				; Gosub Alliance_Boss_Oasis
				; Gosub Alliance_Boss_Regular
				; Gosub Alliance_Wages
				; Gosub Benefits_Center
				; Gosub Get_Window_Geometry
				; Gosub Check_Window_Geometry
				; Gosub Collect_Red_Envelopes

				; Gosub Game_Start_popups
				; Gosub Collect_Cafeteria
				; Gosub Collect_Collisions
				; Gosub Collect_Equipment_Crafting
				; Gosub Collect_Runes
				; Gosub Collect_Recruits
				; Gosub Depot_Rewards
				; Gosub Speaker_Help
				; Gosub Drop_Zone

				; Gosub Desert_Oasis
				; Gosub Donate_Tech
				; Gosub Elivate_program
				; Gosub Enter_Login_Password_PIN
				; Gosub Gather_On_Base_RSS
				; Gosub Gather_Resources
				; Gosub Get_Inventory
				; Gosub Get_User_Info
				; Gosub Get_User_Location
				; Gosub Go_Back_To_Home_Screen
				; Gosub Quit_LEWZ
				; Gosub Launch_Lewz
				; Gosub Mail_Collection
				; Gosub Refresh_LogFiles
				; Gosub Reserve_Factory
				; Gosub Reset_Posit
				; Gosub Send_Mail_To_Boss
				; Gosub Send_Message_In_Chat
				; Gosub Switch_Account
				; Gosub VIP_Shop
				; MsgBox, 0, Pause, Press OK to end (No Timeout)

				; Gosub Game_Start_popups
				; Gosub Shield_Warrior_Trial_etc
				; Gosub Reset_Posit
				; Gosub Peace_Shield

				; ** Position dependant **
				Gosub Collect_Collisions
				Gosub Collect_Recruits
				Gosub Collect_Equipment_Crafting
				Gosub Collect_Runes
				Gosub Depot_Rewards
				Gosub Collect_Cafeteria
				Gosub Speaker_Help
				Gosub Drop_Zone
				; Gosub Golden_Chest

				; ** Not position dependant **
				Gosub Active_Skill
				Gosub VIP_Shop
				Gosub Benefits_Center
				Gosub Alliance_Boss_Regular
				Gosub Alliance_Boss_Oasis
				Gosub Donate_tech
				Gosub Mail_Collection
				Gosub Alliance_Wages

				if CSB_Event ; || if Desert_Event
					Gosub Reserve_Factory
				if Desert_Event
					Gosub Desert_Oasis
				; Gosub Gather_Resources
				; Gosub Gather_On_Base_RSS
				Gosub Speaker_Help
				; Gosub Collect_Red_Envelopes

				; Message_To_The_Boss := User_Name . " Special Routine,"
				; Gosub Get_User_Location
				; Gosub Get_User_Info
				; Gosub Get_Inventory
				; Gosub Send_Mail_To_Boss
				; Gosub Send_Message_In_Chat

				; MsgBox, 4, , Pause before switching accounts? (4 Second Timeout & skip), 4
				; vRet := MsgBoxGetResult()
				; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
				MsgBox, 0, Pause, Press OK to resume (No Timeout)

				goto END_of_user_loop
			}

			New_Day_Game_Reset:
			{
				Routine_Running := "New_Day_Game_Reset"
				; MsgBox, Hour: %A_Hour% New_Day_Game_Reset
				; for testing routines
				; MsgBox, 0, Pause, Press OK to start (No Timeout)
				; Gosub Donate_Tech
				; MsgBox, 0, Pause, Press OK to end (No Timeout)

				; Gosub Game_Start_popups
				; Gosub Shield_Warrior_Trial_etc
				; Gosub Peace_Shield
				; Gosub Reset_Posit

				; ** Position dependant **
				Gosub Collect_Collisions
				Gosub Collect_Recruits
				Gosub Collect_Equipment_Crafting
				Gosub Collect_Runes
				Gosub Depot_Rewards
				Gosub Collect_Cafeteria
				Gosub Speaker_Help
				Gosub Drop_Zone
				; Gosub Golden_Chest

				; ** Not position dependant **
				Gosub Active_Skill
				Gosub VIP_Shop
				Gosub Benefits_Center
				Gosub Alliance_Boss_Regular
				Gosub Alliance_Boss_Oasis
				Gosub Donate_tech
				; Gosub Mail_Collection
				; Gosub Alliance_Wages

				if CSB_Event ; || if Desert_Event
					Gosub Reserve_Factory
				if Desert_Event
					Gosub Desert_Oasis
				; Gosub Gather_Resources
				; Gosub Gather_On_Base_RSS
				Gosub Speaker_Help
				; Gosub Collect_Red_Envelopes

				Message_To_The_Boss := User_Name . " New Day Routine,"
				Gosub Get_User_Location
				Gosub Get_User_Info
				Gosub Get_Inventory
				Gosub Send_Mail_To_Boss
				; Gosub Send_Message_In_Chat

				; MsgBox, 4, , Pause before switching accounts? (4 Second Timeout & skip), 4
				; vRet := MsgBoxGetResult()
				; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
				; MsgBox, 0, Pause, Press OK to resume (No Timeout)

				goto END_of_user_loop
			}

			Fast_Routine:
			{
				Routine_Running := "Fast_Routine"
				; MsgBox, Hour: %A_Hour% Fast_Routine
				; for testing routines
				; MsgBox, 0, Pause, Press OK to start (No Timeout)
				; Gosub Mail_Collection
				; MsgBox, 0, Pause, Press OK to resume (No Timeout)

				; Gosub Game_Start_popups
				; Gosub Shield_Warrior_Trial_etc
				; Gosub Peace_Shield
				; Gosub Reset_Posit

				; ** Position dependant **
				Gosub Collect_Collisions
				Gosub Collect_Recruits
				Gosub Collect_Equipment_Crafting
				Gosub Collect_Runes
				; Gosub Depot_Rewards
				Gosub Collect_Cafeteria
				Gosub Speaker_Help
				; Gosub Drop_Zone
				; Gosub Golden_Chest

				; ** Not position dependant **
				Gosub Active_Skill
				; Gosub VIP_Shop
				; Gosub Benefits_Center
				; Gosub Alliance_Boss_Regular
				; Gosub Alliance_Boss_Oasis
				; Gosub Donate_tech
				; Gosub Mail_Collection
				; Gosub Alliance_Wages

				if CSB_Event ; || if Desert_Event
					Gosub Reserve_Factory
				if Desert_Event
					Gosub Desert_Oasis
				; Gosub Gather_Resources
				; Gosub Gather_On_Base_RSS
				Gosub Speaker_Help
				; Gosub Collect_Red_Envelopes

				Message_To_The_Boss := User_Name . " Fast Routine,"
				; Gosub Get_User_Location
				Gosub Get_User_Info
				; Gosub Get_Inventory
				Gosub Send_Mail_To_Boss
				; Gosub Send_Message_In_Chat

				; MsgBox, 4, , Pause before switching accounts? (4 Second Timeout & skip), 4
				; vRet := MsgBoxGetResult()
				; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
				; MsgBox, 0, Pause, Press OK to end (No Timeout)

				goto END_of_user_loop
			}

			End_Of_Day_Routine:
			{
				Routine_Running := "End_Of_Day_Routine"
				; MsgBox, Hour: %A_Hour% End_Of_Day_Routine
				; for testing routines
				; MsgBox, 0, Pause, Press OK to start (No Timeout)
				; Gosub Mail_Collection
				; MsgBox, 0, Pause, Press OK to resume (No Timeout)

				; Gosub Game_Start_popups
				; Gosub Shield_Warrior_Trial_etc
				; Gosub Peace_Shield
				; Gosub Reset_Posit

				; ** Position dependant **
				Gosub Collect_Collisions
				Gosub Collect_Recruits
				Gosub Collect_Equipment_Crafting
				Gosub Collect_Runes
				Gosub Depot_Rewards
				Gosub Collect_Cafeteria
				Gosub Speaker_Help
				; Gosub Drop_Zone
				; Gosub Golden_Chest

				; ** Not position dependant **
				Gosub Active_Skill
				; Gosub VIP_Shop
				Gosub Benefits_Center
				; Gosub Alliance_Boss_Regular
				; Gosub Alliance_Boss_Oasis
				Gosub Donate_tech
				Gosub Mail_Collection
				Gosub Alliance_Wages

				if CSB_Event ; || if Desert_Event
					Gosub Reserve_Factory
				if Desert_Event
					Gosub Desert_Oasis
				; Gosub Gather_Resources
				; Gosub Gather_On_Base_RSS
				Gosub Speaker_Help
				; Gosub Collect_Red_Envelopes

				Message_To_The_Boss := User_Name . " End Of Day Routine,"
				Gosub Get_User_Location
				Gosub Get_User_Info
				Gosub Get_Inventory
				Gosub Send_Mail_To_Boss
				; Gosub Send_Message_In_Chat

				; MsgBox, 4, , Pause before switching accounts? (4 Second Timeout & skip), 4
				; vRet := MsgBoxGetResult()
				; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
				; MsgBox, 0, Pause, Press OK to end (No Timeout)

				goto END_of_user_loop
			}

			FULL_Q_and_A_Routine:
			{
				Routine_Running := "FULL_Q_and_A_Routine"
				; for testing and special routines
				; MsgBox, 0, Pause, Press OK to resume (No Timeout)

				MsgBox, 4, , Elivate_program (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Elivate_program

				MsgBox, 4, , Get_Window_Geometry (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Get_Window_Geometry

				MsgBox, 4, , Check_Window_Geometry (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Check_Window_Geometry

				MsgBox, 4, , Quit_LEWZ (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Quit_LEWZ

				MsgBox, 4, , Launch_Lewz (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Launch_Lewz

				MsgBox, 4, , Refresh_LogFiles (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Refresh_LogFiles

				MsgBox, 4, , Reset_Posit (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Reset_Posit

				MsgBox, 4, , Switch_Account (8 Second Timeout & skip), 8,
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Switch_Account

				MsgBox, 4, , Game_Start_popups (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Game_Start_popups

				MsgBox, 4, , Shield_Warrior_Trial_etc (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Shield_Warrior_Trial_etc

				MsgBox, 4, , Peace_Shield (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Peace_Shield

				MsgBox, 4, , Reset_Posit (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
				Gosub Reset_Posit
					MsgBox, 0, Pause, Press OK to resume (No Timeout)

				; ************************
				; ** Position dependant **
				; ************************
				MsgBox, 4, , Collect_Cafeteria (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Collect_Cafeteria

				MsgBox, 4, , Collect_Collisions (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Collect_Collisions

				MsgBox, 4, , Collect_Recruits (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Collect_Recruits

				MsgBox, 4, , Collect_Equipment_Crafting (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Collect_Equipment_Crafting

				MsgBox, 4, , Depot_Rewards (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Depot_Rewards

				MsgBox, 4, , Speaker_Help (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Speaker_Help

				MsgBox, 4, , Drop_Zone (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Drop_Zone

				MsgBox, 4, , Golden_Chest (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Golden_Chest

				; ****************************
				; ** Not position dependant **
				; ****************************
				MsgBox, 4, , Benefits_Center (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Benefits_Center

				MsgBox, 4, , Alliance_Boss_Oasis (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Alliance_Boss_Oasis

				MsgBox, 4, , Alliance_Boss_Regular (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Alliance_Boss_Regular

				MsgBox, 4, , Active_Skill (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Active_Skill

				MsgBox, 4, , Alliance_Wages (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Alliance_Wages

				MsgBox, 4, , Donate_Tech (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Donate_Tech

				MsgBox, 4, , Collect_Red_Envelopes (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Collect_Red_Envelopes

				; *************************************
				; ** Gathering and steeling routines **
				; *************************************
				MsgBox, 4, , Desert_Oasis (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Desert_Oasis

				MsgBox, 4, , Gather_On_Base_RSS (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Gather_On_Base_RSS

				MsgBox, 4, , Gather_Resources (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Gather_Resources

				MsgBox, 4, , Get_Inventory (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Get_Inventory

				MsgBox, 4, , Get_User_Info (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Get_User_Info

				MsgBox, 4, , Get_User_Location (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Get_User_Location

				MsgBox, 4, , Mail_Collection (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Mail_Collection

				MsgBox, 4, , Reserve_Factory (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Reserve_Factory

				MsgBox, 4, , Send_Mail_To_Boss (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Send_Mail_To_Boss

				MsgBox, 4, , Send_Message_In_Chat (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Send_Message_In_Chat

				MsgBox, 4, , VIP_Shop (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub VIP_Shop

				; *************************************
				; ** Messaging and user info capture **
				; *************************************
				Message_To_The_Boss := User_Name . " New Day Routine,"
				Gosub Get_User_Location
				Gosub Get_User_Info
				Gosub Get_Inventory

				MsgBox, 4, , Send_Mail_To_Boss (8 Second Timeout & auto), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") || if (vRet = "Timeout")
					Gosub Send_Mail_To_Boss

				; MsgBox, 4, , Send_Message_In_Chat (8 Second Timeout & auto), 8
				; vRet := MsgBoxGetResult()
				; if (vRet = "Yes") || if (vRet = "Timeout")
				; Gosub Send_Message_In_Chat

				MsgBox, 4, , Pause before switching accounts? (4 Second Timeout & skip), 4
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
					MsgBox, 0, Pause, Press OK to resume (No Timeout)

				goto END_of_user_loop
			}
			END_of_user_loop:
		}

		; start new log files
		Gosub Refresh_LogFiles
		; relaunch LEWZ
		; Gosub Quit_LEWZ
		; Gosub Launch_Lewz
		gosub Reload_Script
		Gosub Go_Back_To_Home_Screen
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

; Tap Memu Title Bar
Memu_Title_Bar:
{
	Subroutine_Running := "Memu_Title_Bar"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%

	Mouse_Click(423,25) ; Tap Memu Title Bar

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

; Launch LEWZ app from android main screen
Launch_Lewz:
{
	Subroutine_Running := "Launch_Lewz"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Launch_Lewz_Click_Icon:
	Search_Captured_Text := ["Last Empire"]
	OCR_X := 410
	OCR_Y := 536
	OCR_W := 140
	OCR_H := 42

	loop, 30
	{
		OCR_X := 410
		OCR_Y := 536
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
		{
			Mouse_Click(480,500) ; Tap LEWZ ICON
			Goto Launch_Lewz_Continue
		}

		OCR_X := 7
		OCR_Y := 880
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
		{
			Mouse_Click(67,844) ; Tap LEWZ ICON
			Goto Launch_Lewz_Continue
		}
	}
	Launch_Lewz_Retry:
	Gosub Quit_LEWZ
	goto Launch_Lewz_Click_Icon

	Launch_Lewz_Continue:
	DllCall("Sleep","UInt",(rand_wait + 10*Delay_Long+0))
	
	Search_Captured_Text := ["Enter"] ; ,"login","password"]
	PIN_X := 199 ; 190
	PIN_Y := 265 ; 250
	PIN_W := 77 ; 300
	PIN_H := 30 ; 50
	loop, 10
	{
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [PIN_X, PIN_Y], Size: [PIN_W, PIN_H], Timeout: 0}).Found
		{
			Gosub Enter_Login_Password_PIN
			break
		}
	}

	; Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Quit_LEWZ:
{
	Subroutine_Running := "Quit_LEWZ"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Quit LEWZ
	; Gosub Reset_Posit
	; Gosub Go_Back_To_Home_Screen
	; DllCall("Sleep","UInt",(rand_wait + 8*Delay_Long+0))

	Text_To_Screen("{F5}")
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	
	Go_Back_To_Home_Text := ["Quit"] ; ,"Quit the game"]
	OCR_X := 150 ; 140
	OCR_Y := 523 ; 515
	OCR_W := 50 ; 64 ; 252
	OCR_H := 26 ; 40 ; 155
	loop, 10
	{
		if Search_Captured_Text_OCR(Go_Back_To_Home_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			break

		Text_To_Screen("{F5}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Ledium+0))
		Gosub Check_Window_Geometry
	}

	Mouse_Click(327,770) ; Tap "OK"
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Text_To_Screen("{F8}") ; Home screen button
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	; loop, 5
	; {
	; 	Mouse_Click(283,5, {Control: Qt5QWindowIcon}) ; close LEWZ and/or other app tabs
	; SendEvent {Click, 283,5}
	;	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
	;}

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

; Clear in-game splash pages
Game_Start_popups:
{
	Subroutine_Running := "Game_Start_popups"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Clear first pop-up by pressing back
	Text_To_Screen("{F5}")
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(256,979) ; Check No More Prompts Today On Today'S Hot Sale
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(630,322) ; Tap X On Today'S Hot Sale
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	; Mouse_Click(379,736) ; Collect Cafeteria

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

; reset position
Reset_Posit:
{
	Subroutine_Running := "Reset_Posit"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; go back x times

	; Go_Back_Home_Delay_Long := True
	Gosub Go_Back_To_Home_Screen
	; Gosub Speaker_Help

	; Tap World/home button x times
		loop, 2
	{
		Mouse_Click(76,1200) ; Tap World/home button
		DllCall("Sleep","UInt",(rand_wait + 8*Delay_Long+0))
	}
	; Go_Back_Home_Delay_Long := True
	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Go_Back_To_Home_Screen:
{
	; Subroutine_Running := "Go_Back_To_Home_Screen"
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Go back
	loop, 10
	{
		Text_To_Screen("{F5}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	Gosub Go_Back_To_Home_Screen_OCR_Quit
	Gosub Go_Back_To_Home_Screen_OCR_NOT_Quit

	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	return

	Go_Back_To_Home_Screen_OCR_Quit:
	
	Go_Back_To_Home_Text := ["Quit"] ; ,"Quit the game"]
	OCR_X := 150 ; 140
	OCR_Y := 523 ; 515
	OCR_W := 50 ; 64 ; 252
	OCR_H := 26 ; 40 ; 155
	loop, 40
	{
		loop, 2
			if Search_Captured_Text_OCR(Go_Back_To_Home_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
				return

		Text_To_Screen("{F5}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		Gosub Check_Window_Geometry
	}
	goto Reload_LEWZ_routine	; Gosub Reload_LEWZ_routine
	return

	Go_Back_To_Home_Screen_OCR_NOT_Quit:
	Go_Back_To_Home_Text := ["Quit"] ; ,"Quit the game"]
	OCR_X := 150 ; 140
	OCR_Y := 523 ; 515
	OCR_W := 50 ; 64 ; 252
	OCR_H := 26 ; 40 ; 155
	loop, 10
	{
		loop, 2
			if !Search_Captured_Text_OCR(Go_Back_To_Home_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
				return

		Text_To_Screen("{F5}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		Gosub Check_Window_Geometry
	}
	goto Reload_LEWZ_routine	; Gosub Reload_LEWZ_routine
	return

	Reload_LEWZ_routine:
	{
		Gosub Quit_LEWZ
		Gosub Launch_Lewz
		; Gosub Switch_Account
		; Gosub Enter_Login_Password_PIN

		goto Go_Back_To_Home_Screen_OCR_Quit
		return
	}

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Switch_Account:
{
	Subroutine_Running := "Switch_Account"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	Gui, Status:add,text,, ********************************
	Gui, Status:add,text,, Switching to %User_Name%
	; Gui, Status:show, x%MsgWinMove_X% y0 w300 h500
	Gui, Status:show, x731 y0 w300 h500
	loop, 2
		GUI_Count++

	Switch_Account_START:
	loop, 5
	{
		Gosub Go_Back_To_Home_Screen
		Mouse_Click(50,70, {Clicks: 1,Timeout: (1*Delay_Long+0)}) ; Tap Commander Info

		Search_Captured_Text := ["Commander"]
		loop, 3
			if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0}).Found
				goto Switch_Account_Commander
	}

	Switch_Account_Commander:
	; loop, 2
		Mouse_Click(600,1200, {Clicks: 2,Timeout: (3*Delay_Short+0)}) ; Tap Settings
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

	Search_Captured_Text := ["Settings"]
	loop, 2
		if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0}).Found
			break

	; loop, 2
		Mouse_Click(100,300, {Clicks: 2,Timeout: (3*Delay_Short+0)}) ; Tap Account
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

	OCR_X := 315
	OCR_Y := 860
	OCR_W := 60
	OCR_H := 35
	; Capture_Screen_Text := OCR([315, 860, 60, 35], "eng") ; "Yes"
	loop, 3
		if Search_Captured_Text_OCR(["Yes"], {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			Mouse_Click(340,870, {Clicks: 1,Timeout: (5*Delay_Short+0)}) ; Tap Yes	
			
	Search_Captured_Text := ["Account"]
	loop, 2
		if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0}).Found
			break

	loop, 2
		Mouse_Click(350,875, {Clicks: 2,Timeout: (3*Delay_Short+0)}) ; Tap "Switch Account"
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

	Switch_Account_WarZ_Login:
	Subroutine_Running := "Switch_Account_WarZ_Login"
	Email_Entered := False
	Password_Entered := False
	loop, 5
	{
		; Search_Captured_Text := OCR([300, 690, 100, 40], "eng") ; "WarZ Account" button
		Subroutine_Running := "WarZ Account"
		Search_Captured_Text := ["WarZ"] ; 306, 693
		OCR_X := 302 ; 287
		OCR_Y := 692 ; 676
		OCR_W := 70 ; 200
		OCR_H := 25 ; 55
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found ; 602, 550
			Mouse_Click(350,700, {Clicks: 1,Timeout: (1*Delay_Long+0)}) ; Tap WarZ Account ; goto Switch_Account_WarZ_Account_Button

		; Search_Captured_Text := OCR([422, 1145, 50, 25], "eng") ; "Other Account" button
		Subroutine_Running := "Other Account"
		Search_Captured_Text := ["Other","Account"]
		OCR_X := 422 ; 420
		OCR_Y := 1145 ; 1140
		OCR_W := 50 ; 130
		OCR_H := 25 ; 37
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found ; 602, 550
			Mouse_Click(475,1150, {Clicks: 1,Timeout: (1*Delay_Long+0)}) ; Tap Other Account
			; goto Switch_Account_Other_Account

		; Search_Captured_Text := OCR([378, 720, 100, 32], "eng") ; "Use your email" button
		Subroutine_Running := "Use your email"
		Search_Captured_Text := ["Use your"]
		Use_Email_OCR_X := 378 ; 374
		Use_Email_OCR_Y := 722 ; 719
		Use_Email_OCR_W := 92 ; 160
		Use_Email_OCR_H := 30 ; 40
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [Use_Email_OCR_X, Use_Email_OCR_Y], Size: [Use_Email_OCR_W, Use_Email_OCR_H], Timeout: 0}).Found
		{			
			Gosub Switch_Account_User_Email
			Gosub Switch_Account_User_Password
			goto Switch_Account_Next
		}
	}
	
	/*
		
			loop, 2
			{
				if !Email_Entered
				{
				OCR_X := 65
				OCR_Y := 362
				OCR_W := 535
				OCR_H := 50
				; Read contents of Email Box, default message: "Please enter your email address here..."
				Search_Captured_Text := ["Please enter","your email","email address"]
				OCR_Y := 362
				if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
					if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
						Gosub Switch_Account_User_Email
					else
						Email_Entered := True
				Else
					Email_Entered := True
				}

				if !Password_Entered
				{
				; Read contents of Password Box, default message: "Please enter your password here..."
				Search_Captured_Text := ["Please enter","your password","password here"]
				OCR_X := 65
				OCR_Y := 505
				OCR_W := 535
				OCR_H := 50
				if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
					if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
						Gosub Switch_Account_User_Password
					Else
						Password_Entered := True
				Else
					Password_Entered := True
				}
			}

		if (Email_Entered && Password_Entered)
			goto Switch_Account_Next
		; if !WinActive(FoundAppTitle), WinActivate, %FoundAppTitle%
	}
	*/

	Switch_Account_Try_Again:
	; Mouse_Click(475,1150) ; Tap Other Account
	goto Switch_Account_WarZ_Login

	Switch_Account_User_Email:
	{
		loop, 3
		{
			Mouse_Click(220,382) ;, {Clicks: 2}) ; , Timeout: (1*Delay_Short+0)}) ; Tap inside Email Text Box
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		Text_To_Screen(User_Email)
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		Text_To_Screen("{Enter}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		return
	}

	Switch_Account_User_Password:
	{
		loop, 3
		{
			Mouse_Click(209,527) ; , {Clicks: 2}) ; , Timeout: (1*Delay_Short+0)}) ; Tap inside Email Text Box
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		Text_To_Screen(User_Pass)
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		Text_To_Screen("{Enter}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		return
	}

	Switch_Account_Next:
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Mouse_Click(455,739, {Clicks: 2,Timeout: (1*Delay_Short+0)}) ; Tap Use your email to log in
	
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	loop, 3
	{
		Mouse_Click(340,785) ; Tap "OK"	
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Medium+0))
	}

	loop, 5 ; 10 ; 15
	{
		OCR_X := 330 ; 320
		OCR_Y := 675 ; 720
		OCR_W := 40 ; 50
		OCR_H := 30 ; 80
		; Capture_Screen_Text := OCR([323, 732, 47, 77], "eng")
		if Search_Captured_Text_OCR(["OK"], {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			Mouse_Click(340,780, {Clicks: 1,Timeout: (5*Delay_Short+0)}) ; Tap "OK"	
			
		OCR_X := 315
		OCR_Y := 860
		OCR_W := 60
		OCR_H := 35
		; Capture_Screen_Text := OCR([315, 860, 60, 35], "eng") ; "Yes"
		if Search_Captured_Text_OCR(["Yes"], {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			Mouse_Click(340,870, {Clicks: 1,Timeout: (5*Delay_Short+0)}) ; Tap Yes	
			
		/*
		Search_Captured_Text := ["previous game","progress found","Are you sure","log in and"]	; ,"overwrite the","current game","progress?"]
		OCR_X := 40
		OCR_Y := 510
		OCR_W := 425
		OCR_H := 42	; 118
		; "Are you sure to log in and overwrite the current game progress?"
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			Mouse_Click(336,780, {Clicks: 1,Timeout: (5*Delay_Short+0)}) ; Tap "OK"
		*/

		Search_Captured_Text := ["Enter"] ; ,"login","password"]
		PIN_X := 199 ; 190
		PIN_Y := 265 ; 250
		PIN_W := 77 ; 300
		PIN_H := 30 ; 50
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [PIN_X, PIN_Y], Size: [PIN_W, PIN_H], Timeout: 0}).Found
		{
			Gosub Enter_Login_Password_PIN
			break ; goto Switch_Account_PIN
		}
	}
	
	; gosub BruteForcePIN

	/*
	; old loop
	loop, 6
	{
		Search_Captured_Text := ["previous game","progress found"]
		OCR_X := 40
		OCR_Y := 510
		OCR_W := 366
		OCR_H := 40
		; "Previous game progress found:"
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			Mouse_Click(336,780, {Clicks: 1, Timeout: (5*Delay_Short+0)}) ; Tap "OK"

		Search_Captured_Text := ["Are you sure to","log in and","overwrite the","current game","progress?"]
		OCR_X := 140
		OCR_Y := 516
		OCR_W := 325
		OCR_H := 110
		; "Are you sure to log in and overwrite the current game progress?"
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			Mouse_Click(336,780, {Clicks: 1,Timeout: (5*Delay_Short+0)}) ; Tap "OK"

		Search_Captured_Text := ["Enter","login","password"]
		PIN_X := 190
		PIN_Y := 250
		PIN_W := 300
		PIN_H := 50
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [PIN_X, PIN_Y], Size: [PIN_W, PIN_H], Timeout: 0}).Found
			Break
	}
	*/
	
	Switch_Account_PIN:
	MsgBox, 4, User PIN, user PIN: %User_PIN% - Pause script? (10 second Timeout), 5 ; 10
	vRet := MsgBoxGetResult()
	; if (vRet = "No")
	;	DllCall("Sleep","UInt",(rand_wait + 5*Delay_Long+0))
	if (vRet = "Yes")
		MsgBox, 0, Pause, User PIN: %User_PIN% Press OK to resume (No Timeout)

	Switch_Account_END:

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%

	return
}

Enter_Login_Password_PIN:
{
	; Subroutine_Running := "Enter_Login_Password_PIN"
	
	Goto Enter_Login_Password_PIN_Dialog

	Enter_Login_Password_PIN_Search:
	Search_Captured_Text := ["Enter","login","password"]
	PIN_X := 190
	PIN_Y := 250
	PIN_W := 300
	PIN_H := 50
	loop, 6
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [PIN_X, PIN_Y], Size: [PIN_W, PIN_H], Timeout: 0}).Found
			Goto Enter_Login_Password_PIN_Dialog
	return

	Enter_Login_Password_PIN_Search_old:
	PIN_X := (190 + X_Pixel_offset)
	PIN_Y := (250 + Y_Pixel_offset)
	PIN_W := 300
	PIN_H := 50
	{
		Capture_Screen_Text := OCR([PIN_X, PIN_Y, PIN_W, PIN_H], "eng")
		Capture_Screen_Text := RegExReplace(Capture_Screen_Text,"[\r\n\h]+")

		For index, value in Enter_Login_Password_PIN_Text_Array
			If (RegExMatch(Capture_Screen_Text,value))
				Goto Enter_Login_Password_PIN_Dialog
	}
	return

	Enter_Login_Password_PIN_Dialog:
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	loop, 6
		Mouse_Click(577,1213, {Timeout: 5}) ; , {Timeout: Delay_Medium+0}) ; Tap backspace
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

	Enter_User_PIN := StrSplit(User_PIN)
	Loop % Enter_User_PIN.MaxIndex()
	{
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		if Enter_User_PIN[A_Index] = "0"
			Mouse_Click(340,1200, {Timeout: 0}) ; Tap 0
		if Enter_User_PIN[A_Index] = "1"
			Mouse_Click(120,920, {Timeout: 0}) ; Tap 1
		if Enter_User_PIN[A_Index] = "2"
			Mouse_Click(340,920, {Timeout: 0}) ; Tap 2
		if Enter_User_PIN[A_Index] = "3"
			Mouse_Click(560,920, {Timeout: 0}) ; Tap 3
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
	}
	return
}

BruteForcePIN:
{
	; MsgBox, incorrect PIN: %User_PIN%
	User_PIN_INIT := "110100"
	loop, 1000000
	{
		User_PIN := (User_PIN_INIT + A_Index)
		; MsgBox, PIN: %User_PIN%
		
		loop, 5		
		if StrLen(User_PIN) < 6		
			User_PIN := "0" . User_PIN
			
		if StrLen(User_PIN) > 6		
			User_PIN := "0"	
		
		; MsgBox, sub:"%Subroutine_Running%" PIN:"%User_PIN%"
		gosub Enter_Login_Password_PIN
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		
		if (Mod(A_Index, 100) == 0)
		{
			Subroutine_Running := "User_PIN " . User_PIN
			Capture_Screen_Text := OCR([220, 551, 121, 71], "eng")
			If (RegExMatch(Capture_Screen_Text,"Incorrect")) || if (RegExMatch(Capture_Screen_Text,"orgot"))
				goto NOT_Right_PIN
			
			Else
			{
				MsgBox, 3, , Did %User_PIN% work? OCR:"%Capture_Screen_Text%" (10 second Timeout & auto),10
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") || if (vRet = "Timeout")
					break
			}
		}
		NOT_Right_PIN:
	}
	
	
	MsgBox, correct PIN: %User_PIN%
	return
}

Peace_Shield_OLD:
{
	Subroutine_Running := "Peace_Shield"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%

	Mouse_Click(290,405) ; Tap on base
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(359,487) ; Tap On City Buffs
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(302,235) ; Tap on Peace shield
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

	MsgBox, 4, , Pause script to place shield? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		MsgBox, 0, Pause, Activate Peace Shield, Press OK to resume (No Timeout)

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}


Peace_Shield:
{
	Subroutine_Running := "Peace_Shield"

	Shield_Open_Base:
	Shield_Found_3Day := False
	Shield_Found_24hour := False
	Shield_Found_8hour := False
	Loop, 2
	{
		Mouse_Click(265,392) ;  Left, 1}  ; Tap Base
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		Mouse_Click(348,499) ;  Left, 1}  ; Tap City buffs
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		
		loop, 3
		{
			if Search_Captured_Text_OCR(["City","Buff"], {Timeout: 0}).Found
				Goto, Shield_Search_Buttons
		
			if Search_Captured_Text_OCR(["Buff"], {Pos: [362, 512], Size: [44, 14], Timeout: 0}).Found
			{
				Mouse_Click(348,499) ;  Left, 1}  ; Tap City buffs
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
			}
		}
		Gosub Go_Back_To_Home_Screen
	}
	goto Peace_Shield_END


	Goto, Shield_Open_Base
	Shield_Search_Buttons:
	Shield_Pos01 := Search_Captured_Text_OCR(["Peace","Shield"], {Pos: [134, 160], Size: [150, 21], Timeout: 0})
	Shield_Pos02 := Search_Captured_Text_OCR(["Peace","Shield"], {Pos: [134, 312], Size: [150, 21], Timeout: 0})
	Shield_Ends_Pos01 := Search_Captured_Text_OCR(["Ends"], {Pos: [270, 242], Size: [200, 22], Timeout: 0})
	Shield_Ends_Pos02 := Search_Captured_Text_OCR(["Ends"], {Pos: [270, 394], Size: [200, 22], Timeout: 0})
		
	Loop, 10
	{
		if Shield_Pos01.Found
		{
			Click_X := 165
			Click_Y := 216
			If Shield_Ends_Pos01.Found
			{
				Shield_Ends := (Shield_Ends_Pos01.Text)
				Goto, Shield_Already_Active
			}
			Else
				Goto, Activate_Shield
		}
		
		if Shield_Pos02.Found
		{
			Click_X := 200
			Click_Y := 367
			If Shield_Ends_Pos02.Found
			{
				Shield_Ends := (Shield_Ends_Pos02.Text)
				Goto, Shield_Already_Active
			}
			Else
				Goto, Activate_Shield
		}
		
	}
	
	Shield_Not_Found:	
	MsgBox, 4, , % "Shield Button not found in:""" Shield_Pos01.Text """ Or """ Shield_Pos02.Text """`, Try again? (10 second Timeout & skip)",10
	vRet := MsgBoxGetResult()
	if (vRet = "Yes")
		goto Shield_Open_Base
	else if (vRet = "No") || if (vRet = "Timeout")
		goto Peace_Shield_END

	Shield_Already_Active:
	{
		Shield_DD := Shield_HH := Shield_MM := Shield_SS := 0
		
		if RegExMatch(Shield_Ends,"\d+d",Shield_Days1)
			RegExMatch(Shield_Days1,"\d+",Shield_DD)
		
		if RegExMatch(Shield_Ends,"\d+\:\d+\:\d+",Shield_Hours1)
		{
			Shield_Hours2 := RegExReplace(Shield_Hours1,"[^\d]")
			Shield_Hour_Array := StrSplit(Shield_Hours1, ":")
			Shield_HH := Shield_Hour_Array[1]
			Shield_MM := Shield_Hour_Array[2]
			Shield_SS := Shield_Hour_Array[3]
		}
		
		Shield_Expires10 := "000000" . Shield_DD . Shield_HH . "24" . Shield_MM . Shield_SS
		Shield_Expires11 := FormatTime(A_Now, "YYYYMMDDHH24MISS")
		EnvAdd, Shield_Expires12, Shield_DD, d
		EnvAdd, Shield_Expires12, Shield_HH, h
		EnvAdd, Shield_Expires12, Shield_MM, m
		EnvAdd, Shield_Expires12, Shield_SS, s
		Shield_Expires13 := FormatTime(Shield_Expires12)
		
		if At_War
		{
			MsgBox, 4, ,Shield expires on %Shield_Expires13%`, recommend 3Day shield (10 sec Timeout & auto),10
			vRet := MsgBoxGetResult()
			if (vRet = "Yes") || if (vRet = "Timeout") ; || if (vRet = "No")
			Goto, Shield_for_3Day
		}
		else if (Shield_Expires11 = "Thursday")
		{
			MsgBox, 4, ,Shield expires on %Shield_Expires13%`, recommend 3Day shield (10 sec Timeout & auto),10
			vRet := MsgBoxGetResult()
			if (vRet = "Yes") || if (vRet = "Timeout") ; || if (vRet = "No")
			Goto, Shield_for_3Day
		}
		else if (Shield_Expires11 = "Friday")
		{
			MsgBox, 4, ,Shield expires on %Shield_Expires13%`, recommend 3Day shield (10 sec Timeout & auto),10
			vRet := MsgBoxGetResult()
			if (vRet = "Yes") || if (vRet = "Timeout") ; || if (vRet = "No")
			Goto, Shield_for_3Day
		}
		else if (Shield_Expires11 = "Saturday" && Shield_Expires_Hour <= 19)
		{
			MsgBox, 4, ,Shield expires on %Shield_Expires13%`, recommend 3Day shield (10 sec Timeout & auto),10
			vRet := MsgBoxGetResult()
			if (vRet = "Yes") || if (vRet = "Timeout") ; || if (vRet = "No")
			Goto, Shield_for_3Day
		}
		else if (Shield_Expires11 = "Saturday" && Shield_Expires_Hour >= 19)
		{
			MsgBox, 4, ,Shield expires on %Shield_Expires13%`, recommend 24hour shield (10 sec Timeout & auto),10
			vRet := MsgBoxGetResult()
			if (vRet = "Yes") || if (vRet = "Timeout") ; || if (vRet = "No")
			Goto, Shield_for_24hour
		}
		else if (Shield_Expires11 = "Sunday" && Shield_Expires_Hour <= 19)
		{
			MsgBox, 4, ,Shield expires on %Shield_Expires13%`, recommend 24hour shield (10 sec Timeout & auto),10
			vRet := MsgBoxGetResult()
			if (vRet = "Yes") || if (vRet = "Timeout") ; || if (vRet = "No")
			Goto, Shield_for_24hour
		}
		else
		{
			MsgBox, 4, ,Shield expires on %Shield_Expires13%`, No shield needed. (10 sec Timeout & auto),10
			Goto, Peace_Shield_END
		}
	}
	
	MsgBox, 4, , Shield Already Active`, %Capture_Screen_Text%`,  Select new shield anyway? (10 second Timeout & skip),10
	vRet := MsgBoxGetResult()
	if (vRet = "Yes")
		goto Activate_Shield
	else if (vRet = "No") || if (vRet = "Timeout")
		goto Peace_Shield_END

	Activate_Shield:
	Mouse_Click(Click_X,Click_Y) ; SendEvent, {Click, %Click_X%, %Click_Y% Left, 1}  ; Click first box to enable shield
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	
	MsgBox("Would you like to place a shield?`n(Esc) to cancel`n(10 second Timeout & skip)`,10", "Peace Shield", 3, "&3Day", "&24hour", "&8hour", 5)
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; 3Day
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
		Mouse_Click(590,310) ;  Left, 1}  ; Tap Get & use 3-Day Peace Shield
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Goto, Shield_Purchase
	}
	Goto, Shield_Not_Selected
	
	Shield_for_24hour:
	{
		Shield_Found_24hour := True
		Mouse_Click(590,458) ;  Left, 1}  ; Tap Get & use 24-Hour Peace Shield
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Goto, Shield_Purchase
	}
	Goto, Shield_Not_Selected
	
	Shield_for_8hour:
	{
		Shield_Found_8hour := True
		Mouse_Click(590,610) ;  Left, 1}  ; Tap Get & use 8-Hour Peace Shield
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Goto, Shield_Purchase
	}
	Goto, Shield_Not_Selected
	
	Shield_Not_Selected:
	MsgBox, 4, , Shield not selected:"%Capture_Screen_Text%"`, Try again? (10 second Timeout & skip),10
	vRet := MsgBoxGetResult()
	if (vRet = "Yes")
		Goto, Shield_Open_Base
	else if (vRet = "No") || if (vRet = "Timeout")
		Goto, Peace_Shield_END

	Shield_Purchase:
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Shield_Purchase := Search_Captured_Text_OCR(["are","you","sure","After","usage"], {Pos: [139, 521], Size: [411, 72], Timeout: 0})

	loop, 5
		If Shield_Purchase.Found
			Mouse_Click(336,781) ;  Left, 1}  ; Tap Get & Use button, to confirm buying shield
	
	Peace_Shield_END:	
	MsgBox, 4, , Pause script to place shield? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		MsgBox, 0, Pause, Activate Peace Shield, Press OK to resume (No Timeout)

	Gosub Go_Back_To_Home_Screen

	return
}

; collect collisions
Collect_Collisions:
{
	Subroutine_Running := "Collect_Collisions"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	loop, 2
	{
		Mouse_Click(430,280) ; Tap Command Center
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		Mouse_Click(515,375) ; Tap Collision
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		loop, 3
			if Search_Captured_Text_OCR(["Particle"], {Timeout: 0}).Found
				goto Collect_Collisions_Found
		Gosub Go_Back_To_Home_Screen
	}
	goto Collect_Collisions_END
	Collect_Collisions_Found:
	{
		Mouse_Click(180,1130) ; Tap Collide
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		goto Collect_Collisions_END
		Loop, 3
		{
			Mouse_Click(450,1180) ; Tap "OK"
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		}
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	Collect_Collisions_END:
	Gosub Go_Back_To_Home_Screen
	return
	
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	;loop, 2
		Mouse_Click(430,280) ; Tap Command Center
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Mouse_Click(540,367) ; Tap Collide ; Mouse_Click(540,400) ; Tap Collide
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	loop, 2
		Mouse_Click(180,1130, {Timeout: Delay_Medium+0}) ; Tap Collide
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Mouse_Click(450,1180, {Timeout: Delay_Medium+0}) ; Tap "OK"
	Gosub Go_Back_To_Home_Screen
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

; collect Equipment Crafting
Collect_Equipment_Crafting:
{
	Subroutine_Running := "Collect_Equipment_Crafting"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	loop, 2
	{
		Mouse_Click(430,280) ; Tap Command Center
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		Mouse_Click(430,390) ; Tap Craft
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		loop, 3
			if Search_Captured_Text_OCR(["Giant"], {Timeout: 0}).Found
					goto Collect_Equipment_Found
		Gosub Go_Back_To_Home_Screen
	}
	goto Collect_Equipment_END
	Collect_Equipment_Found:
	{
		Mouse_Click(180,1180, {Timeout: Delay_Medium+0}) ; Tap Craft or Recruit or Extract
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		goto Collect_Equipment_END
		Loop, 3
		{
			Mouse_Click(450,1180) ; Tap "OK"
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		}
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	Collect_Equipment_END:
	Gosub Go_Back_To_Home_Screen
	return
	
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	;loop, 2
		Mouse_Click(430,280) ; Tap Command Center
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Mouse_Click(475,389) ; Tap craft
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	loop, 2
		Mouse_Click(180,1180, {Timeout: Delay_Medium+0}) ; Tap Craft or Recruit or Extract
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Mouse_Click(450,1180, {Timeout: Delay_Medium+0}) ; Tap "OK"
	Gosub Go_Back_To_Home_Screen
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

; Collect Recruits
Collect_Recruits:
{
	Subroutine_Running := "Collect_Recruits"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	loop, 2
	{
		Mouse_Click(430,280) ; Tap Command Center
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		Mouse_Click(350,375) ; Tap Recruit
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		loop, 3
			if Search_Captured_Text_OCR(["Recruitment"], {Timeout: 0}).Found
				goto Collect_Recruits_Found
		Gosub Go_Back_To_Home_Screen
	}
	goto Collect_Recruits_END
	Collect_Recruits_Found:
	{
		Mouse_Click(160,1180) ; Tap Recruit 1 times
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		goto Collect_Recruits_END
		Loop, 3
		{
			Mouse_Click(450,1180) ; Tap "OK"
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		}
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	Collect_Recruits_END:
	Gosub Go_Back_To_Home_Screen
	return
	
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	;loop, 2
		Mouse_Click(430,280) ; Tap Command Center
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Mouse_Click(430,280) ; Tap Recruit ; Mouse_Click(200,1160) ; Tap Recruit
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	loop, 3
		Mouse_Click(180,1180, {Timeout: Delay_Medium+0}) ; Tap Craft or Recruit or Extract
	; Mouse_Click(460,1180) ; Tap "OK"
	loop, 3
		Mouse_Click(460,1180, {Timeout: Delay_Medium+0}) ; Tap "OK"
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Mouse_Click(450,1180, {Timeout: Delay_Medium+0}) ; Tap "OK"
	Gosub Go_Back_To_Home_Screen
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

; Collect Runes
Collect_Runes:
{
	Subroutine_Running := "Collect_Runes"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	loop, 2
	{
		Mouse_Click(430,280) ; Tap Command Center
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		Mouse_Click(570,340) ; Rune Extraction
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		loop, 3
			if Search_Captured_Text_OCR(["Rune"], {Timeout: 0}).Found
				goto Collect_Runes_Found
		Gosub Go_Back_To_Home_Screen
	}
	goto Collect_Runes_END
	Collect_Runes_Found:
	{
		Mouse_Click(180,1180) ; Tap Craft or Recruit or Extract
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		goto Collect_Runes_END
		Loop, 3
		{
			Mouse_Click(450,1180) ; Tap "OK"
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		}
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	Collect_Runes_END:
	Gosub Go_Back_To_Home_Screen
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Collect_Red_Envelopes:
{
	Subroutine_Running := "Collect_Red_Envelopes"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	loop, 3
	{

		Mouse_Click(316,1122) ; Tap on Chat Bar
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		Mouse_Click(33,62) ; Tap back Button
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		Mouse_Click(289,165) ; Tap on first Chat Room "Alliance"
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		Mouse_Click(227,1215) ; Tap in Message Box
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		; Shake phone
		Text_To_Screen("!{F2}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		; Gosub Get_Window_Geometry
		Gosub Check_Window_Geometry

		Mouse_Click(33,62) ; Tap back Button
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		Gosub Go_Back_To_Home_Screen
	}

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Shield_Warrior_Trial_etc:
{
	; check shield and unclaimed rewards

	/*
	MsgBox, 4, Peace_Shield, Peace_Shield? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		Gosub Peace_Shield

	MsgBox, 4, Location, Check location? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") ; || if (vRet = "No")
		{

			Mouse_Click(76,1200) ; Tap World/home button

			MsgBox, 0, Pause, Check location`, Press OK to return home (No Timeout)

			; Go_Back_Home_Delay_Long := True
			Gosub Go_Back_To_Home_Screen
		+0}
	*/

	MsgBox, 4, Wonder Rewards, Wonder Rewards? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") ; || if (vRet = "No")
		Gosub Activity_Center_Wonder

	/*
	; MsgBox, 4, SVIP, check SVIP? (8 Second Timeout & skip), 8
	; vRet := MsgBoxGetResult()
	; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
	; {
	;
	; Mouse_Click(157,102) ; Tap SVIP

	; MsgBox, 0, Pause, Check SVIP`, Press OK to return home (No Timeout)

	; Gosub Go_Back_To_Home_Screen
	; }

	MsgBox, 4, Benefits, Benefits_Center_Monthly? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") ; || if (vRet = "No")
		Gosub Benefits_Center_Monthly

	; MsgBox, 4, Activate Skills, Activate Skills? (8 Second Timeout & skip), 8
	; vRet := MsgBoxGetResult()
	; if (vRet = "Yes") ; || if (vRet = "Timeout") ; || if (vRet = "No")
	; {
	; Mouse_Click(195,1195) ; Tap Activate Skills

	; MsgBox, 0, Pause, Check Activate Skills`, Press OK to return home (No Timeout)

	; Gosub Go_Back_To_Home_Screen
	; }

	MsgBox, 4, Desert_Oasis, Desert_Oasis? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") ; || if (vRet = "No")
		Gosub Desert_Oasis
	*/

	MsgBox, 4, , Pause? Check location`, SVIP`, wonder rewards`, activate skills`, etc? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") ; || if (vRet = "No")
		MsgBox, 0, Pause, Check location`, SVIP`, wonder rewards`, activate skills`, etc? Press OK to resume (No Timeout)

	Gosub Go_Back_To_Home_Screen
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

}

Activity_Center_Wonder_old:
{
	Mouse_Drag(109, 536, 262, 536, {EndMovement: T, SwipeTime: 500})
	/*
	Click, 109, 536 Left, Down ; drag home screen to right
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Click, 130, 536, 0
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Click, 139, 536, 0
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Click, 150, 536, 0
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Click, 159, 536, 0
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Click, 262, 536, 0
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
	Click, 262, 536 Left, Up
	*/

	Mouse_Click(137,580) ; Tap activity center

	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Long+0))
	Mouse_Click(170,140) ; Tap on "in progress" tab
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Drag(330, 1194, 337, 849, {EndMovement: F, SwipeTime: 500})
	/*
	Click, 330, 1194 Left, Down ; drag activity center list up
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Click, 337, 849, 0
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
	Click, 337, 849 Left, Up
	*/

	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Mouse_Click(297,1095) ; Tap on desert wonder
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
	Mouse_Click(250,150) ; Tap on second tab "wonder"
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Mouse_Click(244,592) ; Tap and open reward box number 1
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
	Mouse_Click(340,987) ; Tap Collect Button
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
	Mouse_Click(320,70) ; Tap top title bar
	; Mouse_Click(250,150) ; Tap Outside reward popup
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
	Mouse_Click(439,593) ; Tap and open reward box number 2
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
	Mouse_Click(330,994) ; Tap Collect Button
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
	Mouse_Click(320,70) ; Tap top title bar
	; Mouse_Click(250,150) ; Tap Outside reward popup
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
	Mouse_Click(640,600) ; Tap and open reward box number 3
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
	Mouse_Click(340,1000) ; Tap Collect Button
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
	Mouse_Click(320,70) ; Tap top title bar
	; Mouse_Click(250,150) ; Tap Outside reward popup

	MsgBox, 0, Pause, All rewards claimed? Press OK to return home (No Timeout)
	Gosub Go_Back_To_Home_Screen

	return
}

Activity_Center_Open()
{
	loop, 3
	{
		loop, 3
		{
			Gosub Go_Back_To_Home_Screen
			Mouse_Drag(200, 350, 332, 350, {EndMovement: T, SwipeTime: 500})
			; Mouse_Drag(110, 536, 262, 537, {EndMovement: T, SwipeTime: 500})
			Mouse_Click(137,580) ; Tap activity center
			DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
			
			; Mouse_Drag(82, 536, 335, 536, {EndMovement: T, SwipeTime: 500})
			; Mouse_Click(180,600) ; Tap Activity Center

			loop, 5
				if Search_Captured_Text_OCR(["Activity","Center"], {Timeout: 0}).Found
					return 1
		}
		Gosub Reset_Posit
	}
	return 0
}

Activity_Center_Wonder:
{
	if !Activity_Center_Open()
		goto Activity_Center_END
		
	Activity_Center_Continue:
	Loop, 10
	{
		Search_Captured_Text := ["Desert Wonder"]
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [170, 589], Size: [300, 50], Timeout: 0}).Found
		{
			Mouse_Click(282,610) ; Tap activity 01
			goto Activity_Center_Continue_Tab
		}
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [170, 779], Size: [300, 50], Timeout: 0}).Found
		{
			Mouse_Click(256,803) ; Tap activity 02
			goto Activity_Center_Continue_Tab
		}
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [170, 976], Size: [300, 50], Timeout: 0}).Found
		{
			Mouse_Click(242,1005) ; Tap activity 03
			goto Activity_Center_Continue_Tab
		}
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [170, 1174], Size: [300, 50], Timeout: 0}).Found
		{
			Mouse_Click(210,1200) ; Tap activity 04
			goto Activity_Center_Continue_Tab
		}
	}
	goto Activity_Center_END

	Activity_Center_Continue_Tab:
	; MsgBox, 0, , Capture_Screen_Text:"%Capture_Screen_Text%"`nSearch_Text_Array:"%Search_Text_Array%"
	
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Loop, 5
	{
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [233, 44], Size: [230, 52], Timeout: 0}).Found
		{
			Mouse_Click(250,136) ; Tap Wonder tab
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
			goto Activity_Center_Continue_Claim
		}
	}
	goto Activity_Center_END

	Activity_Center_Continue_Claim:
	; MsgBox, 0, , Capture_Screen_Text:"%Capture_Screen_Text%"`nSearch_Text_Array:"%Search_Text_Array%"
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	Mouse_Click(240,596) ; Tap Wonder reward box 01
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(330,1000) ; Tap Collect Rewards
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(330,70) ; Tap to clear reward
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(439,600) ; Tap Wonder reward box 02
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(330,1000) ; Tap Collect Rewards
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(330,70) ; Tap to clear reward
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(640,600) ; Tap Wonder reward box 03
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(330,1000) ; Tap Collect Rewards
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(330,70) ; Tap to clear reward
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	
	
	Mouse_Click(600,800) ; Tap "Receive Rewards" 1
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(350, 70) ; Tap To clear popup rewards message
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(600,970) ; Tap "Receive Rewards" 2
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(350, 70) ; Tap To clear popup rewards message
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(600,1130) ; Tap "Receive Rewards" 3
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(350, 70) ; Tap To clear popup rewards message
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	
	Activity_Center_END:
	; MsgBox, 0, Pause, All rewards claimed? Press OK to return home (No Timeout)
	Gosub Go_Back_To_Home_Screen

	return
}

Benefits_Center_Monthly:
{
	Subroutine_Running := "Benefits_Center_Monthly"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	Mouse_Click(625,280) ; Tap Benefits Center
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	; Gosub Click_through_benefits_tabs
	; loop, 4
	; {
	; Gosub Swipe_Right_trial
	; Gosub Click_through_benefits_tabs
	; }

	MsgBox, 0, Pause, Collect Warrior Trials and monthly package`, Press OK to resume (No Timeout)

	Gosub Go_Back_To_Home_Screen
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

	; loop, through benefits tabs to clear any new ones
	Click_through_benefits_tabs:
	{
		Mouse_Click(70,166) ; Tap Tab 1 Benefits Center
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		Mouse_Click(155,166) ; Tap Tab 1.5 Benefits Center
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

		Mouse_Click(235,166) ; Tap Tab 2 Benefits Center
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

		Mouse_Click(315,166) ; Tap Tab 2.5 Benefits Center
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

		Mouse_Click(395,166) ; Tap Tab 3 Benefits Center
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

		Mouse_Click(475,166) ; Tap Tab 3.5 Benefits Center
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

		Mouse_Click(560,166) ; Tap Tab 4 Benefits Center
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
		return
	}

	Swipe_Right_trial:
	loop, 4
	{
		; Benefits Center Swipe Right One position
		Mouse_Drag(630, 187, 353, 187, {EndMovement: T, SwipeTime: 500})
		/*
		Click, 630, 187 Left, Down
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 530, 187, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 430, 187, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 375, 187, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 363, 187, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 355, 187, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 354, 187, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Click, 353, 187 Left, Up
		*/
	}
	return

}

Benefits_Center:
{
	Subroutine_Running := "Benefits_Center"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; Initialize text to search for
	Battle_Honor_text := "BattleHonor"
	Daily_Signin_text := "Sign"
	Daily_Signin_text2 := "LOGIN"
	Monthly_Package_text := "ackage" ; "MonthlyPackage" "Monthly PRackage", "Rackage", "Monthly Package"
	Monthly_Signin_text := "MonthlySign"
	Select_Reward_text := "SelectReward"
	Selection_Chest_text := "SelectionChest"
	Single_Cumulation_text := "Cumulation"
	Warrior_Trial_text := "Warrior" ; "trial"
	Claim_text := "Claim"
	
	; Select_Reward_text := OCR([15, 210, 133, 30], "eng")
	; Selection_Chest_text := OCR([176, 210, 133, 25], "eng")
	; Single_Cumulation_text := OCR([354, 210, 105, 50], "eng")
	; Daily_Signin_text := OCR([530, 210, 72, 30], "eng")
	; Monthly_Signin_text := OCR([8, 209, 136, 30], "eng")
	; Battle_Honor_text := OCR([189, 207, 110, 30], "eng")
	; Monthly_Package_text := OCR([400, 200, 92, 47], "eng")

	; "ReactionFurnace"
	; "Warriortrial"
	; "WarZAccountbindrewards"
	; "MonthlySign-In"
	; Select Reward
	; Selection Chest
	; Cumulation Purchase
	; Sign In
	; Monthly Sign In
	; Battle Honor
	; Alliance Purchase
	; Continuous purchase
	; Limited Arms Supply
	; Arms Supply
	; Upgrade Base

	; Set tabs = True (1) to completed or False (0) to be skipped.
	Battle_Honor_Run := False
	Daily_Signin_Run := True
	Monthly_Package_Collect_Run := True
	Monthly_Signin_Run := True
	Select_Reward_Run := True
	Selection_Chest_Run := True
	Single_Cumulation_Run := True
	Claim_Buttons_Run := True
	Warrior_Trial_Run := True

	loop, 2
		Mouse_Click(625,310) ; Tap Benefits Center
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0)) ; wait for Benefits Center to load

	loop, 2
	{
		Gosub Benefits_Check_Tabs
		Gosub Benefits_Check_Tabs
		Gosub Go_Back_To_Home_Screen
	}
	Goto Benefits_Center_END

	; loop, 4
	{
		; Gosub Benefits_Center_Reload
		Gosub Benefits_Check_Tabs
		Loop, 3
			Gosub Benefits_swipe_Check_Tabs
		Gosub Go_Back_To_Home_Screen
	}
	; return

	Goto Benefits_Center_END

	Benefits_Center_Reload:
	Subroutine_Running := "Benefits_Center_Reload"
	loop, 5
	{
		Search_Captured_Text := ["Benefits Center"]
		loop, 2
			if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0}).Found
				return

		; Gosub Get_Window_Geometry
		Gosub Check_Window_Geometry
		Gosub Go_Back_To_Home_Screen
		loop, 2
			Mouse_Click(625,310, {Timeout: Delay_Short}) ; Tap Benefits Center
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Long+0))
	}
	return

	Benefits_Center_END:
	; Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

	Benefits_swipe_Check_Tabs:
	Subroutine_Running := "Benefits_swipe_Check_Tabs"
	{
		; Gosub Swipe_Right
		Gosub Swipe_Right2
		Gosub Benefits_Check_Tabs
		return
	}

	Benefits_Check_Tabs:
	Subroutine_Running := "Benefits_Check_Tabs"
	{

		; Capture_Screen_Text := OCR([0, 180, 160, 80], "eng")
		; Capture_Screen_Text := OCR([160, 180, 160, 80], "eng")
		; Capture_Screen_Text := OCR([320, 180, 160, 80], "eng")
		; Capture_Screen_Text := OCR([480, 180, 160, 80], "eng")

		Benefits_X_Min := 0 ; 15 ; 0
		Benefits_X_Max := 480 ; 510 ; 409
		Benefits_OCR_X := Benefits_X_Min
		Benefits_OCR_Y := 200 ; 180 ; 184
		Benefits_OCR_W := 170 ; 272
		Benefits_OCR_H := 80 ; 72
		Benefits_X_Delta := 160 ; 135 ; 165
		Benefits_Click_X := (Benefits_OCR_X + 2/Benefits_OCR_W)
		Benefits_Click_Y := (Benefits_OCR_Y + 2/Benefits_OCR_H)
		; X=0-684, 684/5=136, and 136*2=272, 0,136,272,408,544,680
		; 684/4=171, 684/3=228
		; or 484/3=161

		loop, 4
		{
			Mouse_Click(645,249) ; Tap to clear scrolling messages
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0)) ; wait for tab to load
			loop, 2
			{
				Mouse_Click(Benefits_Click_X,Benefits_Click_Y) ; Tap Next Tab in Benefits Center
				DllCall("Sleep","UInt",(rand_wait + 4*Delay_Short+0)) ; wait for tab to load
			}
			; DllCall("Sleep","UInt",(rand_wait + 4*Delay_Short+0)) ; wait for tab to load
			; Capture_Screen_Text := ""
			Capture_Screen_Text := OCR([Benefits_OCR_X, Benefits_OCR_Y, Benefits_OCR_W, Benefits_OCR_H], "eng") ; benefit tab 1
			Gosub Benefits_Selection_and_Run
			Benefits_OCR_X += Benefits_X_Delta
			Benefits_Click_X := (Benefits_OCR_X + Benefits_X_Delta)
		}
		Gosub Benefits_Center_Reload
		return
	}

	/*

	Capture_Screen_Text := OCR([
		Benefits_OCR_X := 15
		Benefits_OCR_Y := 185
		Benefits_OCR_W := 135
		Benefits_OCR_H := 70
	Capture_Screen_Text := OCR([
		Benefits_OCR_X := 180 ; 15 + 165
		Benefits_OCR_Y := 185
		Benefits_OCR_W := 135
		Benefits_OCR_H := 70
	Capture_Screen_Text := OCR([
		Benefits_OCR_X := 350 ; 180 + 170
		Benefits_OCR_Y := 185
		Benefits_OCR_W := 135
		Benefits_OCR_H := 70
	Capture_Screen_Text := OCR([
		Benefits_OCR_X := 512 ; 350 + 162
		Benefits_OCR_Y := 185
		Benefits_OCR_W := 135
		Benefits_OCR_H := 70

	Benefits_Check_Tabs_Old:
	{
		Benefits_OCR_X := 136
		Benefits_Click_X := (Benefits_OCR_X + 136)
		; Capture_Screen_Text := OCR([170, 184, 160, 72], "eng") ; benefit tab 2
		Capture_Screen_Text := OCR([Benefits_OCR_X, Benefits_OCR_Y, Benefits_OCR_W, Benefits_OCR_H], "eng") ; benefit tab 2
		loop, 2
			Mouse_Click(Benefits_Click_X,Benefits_Click_Y) ; Tap Tab 2 Benefits Center
		Gosub Benefits_Selection_and_Run

		Benefits_OCR_X := 272
		Benefits_Click_X := (Benefits_OCR_X + 136)
		; Capture_Screen_Text := OCR([342, 184, 160, 72], "eng") ; benefit tab 3
		Capture_Screen_Text := OCR([Benefits_OCR_X, Benefits_OCR_Y, Benefits_OCR_W, Benefits_OCR_H], "eng") ; benefit tab 3
		loop, 2
			Mouse_Click(Benefits_Click_X,Benefits_Click_Y) ; Tap Tab 3 Benefits Center
		Gosub Benefits_Selection_and_Run

		Benefits_OCR_X := 408
		Benefits_Click_X := (Benefits_OCR_X + 136)
		; Capture_Screen_Text := OCR([513, 184, 160, 72], "eng") ; benefit tab 4
		Capture_Screen_Text := OCR([Benefits_OCR_X, Benefits_OCR_Y, Benefits_OCR_W, Benefits_OCR_H], "eng") ; benefit tab 4
		loop, 2
			Mouse_Click(Benefits_Click_X,Benefits_Click_Y) ; Tap Tab 4 Benefits Center
		Gosub Benefits_Selection_and_Run

		return
	}
	*/

	Benefits_Selection_and_Run:
	{
		Subroutine_Running := Benefits_Selection_and_Run
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0)) ; wait for tab to load

		loop, 5
		{
			if (Capture_Screen_Text = "")
				Capture_Screen_Text := OCR([Benefits_OCR_X, Benefits_OCR_Y, Benefits_OCR_W, Benefits_OCR_H], "eng")
			else
				break
		}

		loop, 5
		{
			if (Capture_Screen_Text = "")
				Capture_Screen_Text := OCR([0, 288, 300, 112], "eng")
			else
				break
		}

		Capture_Screen_Text := RegExReplace(Capture_Screen_Text,"[\r\n\h-_]+")

		; MsgBox, Text Found:%Capture_Screen_Text%

		If (RegExMatch(Capture_Screen_Text,Monthly_Signin_text))
			Gosub Monthly_Signin
		Else If (RegExMatch(Capture_Screen_Text,Select_Reward_text))
			Gosub Select_Reward
		Else If (RegExMatch(Capture_Screen_Text,Single_Cumulation_text))
			Gosub Single_Cumulation
		Else If (RegExMatch(Capture_Screen_Text,Warrior_Trial_text))
			Gosub Warrior_Trial
		Else If (RegExMatch(Capture_Screen_Text,Selection_Chest_text))
			Gosub Selection_Chest
		Else If (RegExMatch(Capture_Screen_Text,Battle_Honor_text))
			Gosub Battle_Honor_Collect
		Else If (RegExMatch(Capture_Screen_Text,Monthly_Package_text))
			Gosub Monthly_Package_Collect
		Else If (RegExMatch(Capture_Screen_Text,Daily_Signin_text))
			Gosub Daily_Signin
		Else If (RegExMatch(Capture_Screen_Text,Claim_text))
			Gosub Claim_Buttons
		Else If (RegExMatch(Capture_Screen_Text,Daily_Signin_text2))
			Gosub Daily_Signin

		; else
		; MsgBox, 4, Text Not Found, Text Not Found in %Capture_Screen_Text% (4 Second Timeout), 4

		Gosub Benefits_Center_Reload

		Benefits_Text_Found:
		Capture_Screen_Text := ""
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0)) ; wait to read next tab

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
		return
	}

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

	; **************************
	; BEGIN unused section below
	; **************************

	Gosub Monthly_Signin
	Gosub Single_Cumulation
	Gosub Selection_Chest
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Gosub Swipe_Right
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

	Mouse_Click(553,172) ; Tap Tab 4 Benefits Center
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	; MsgBox, 4, , Battle_Honor_Collect (8 Second Timeout & skip), 8
	; vRet := MsgBoxGetResult()
	; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
	; Gosub Battle_Honor_Collect

	; **************************
	; END unused section below
	; **************************

	Swipe_Right:
	loop, 4
	{
		; Benefits Center Swipe Right One position
		Mouse_Drag(630, 187, 353, 187, {EndMovement: T, SwipeTime: 500})
		/*
		Click, 630, 187 Left, Down
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 530, 187, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 430, 187, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 375, 187, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 363, 187, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 353, 187, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 353, 187, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Click, 353, 187 Left, Up
		*/
	}
	return

	Swipe_Right2:
	; 0,136,272,408,544,680
		; Capture_Screen_Text := OCR([0, 180, 160, 80], "eng")
		; Capture_Screen_Text := OCR([160, 180, 160, 80], "eng")
		; Capture_Screen_Text := OCR([320, 180, 160, 80], "eng")
		; Capture_Screen_Text := OCR([480, 180, 160, 80], "eng")
	loop, 2
	{
		; Benefits Center Swipe Right One position
		; Mouse_Drag(580, 187, 116, 187, {EndMovement: T, SwipeTime: 500})
		; Mouse_Drag(580, 187, 90, 187, {EndMovement: T, SwipeTime: 500})
		Mouse_Drag(500, 187, 120, 187, {EndMovement: T, SwipeTime: 500})
	}
	return

	Swipe_Left:
	{
		; Benefits Center Swipe Right One position
		Mouse_Drag(353, 187, 553, 187, {EndMovement: T, SwipeTime: 500})
		return
	}

	Select_Reward:
	{
		if !Select_Reward_Run
			return

		Subroutine_Running := "Select_Reward"

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%

		Mouse_Click(644,512) ; Select Reward - Drop Down Menu
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		; Mouse_Click(570,696) ; Select Reward - Select Tech
		Mouse_Click(570, 936) ; Select Reward - Select Other
		; Mouse_Click(570,602) ; Select Reward - Select Desert
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Mouse_Click(565,995) ; Claim VIP points
		; Mouse_Click(343,750) ; Claim Strengthening also silver medals
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Mouse_Click(320,70) ; Tap top title bar
		; Mouse_Click(379,1172) ; Tap Outside Congrats Popup
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Select_Reward_Run := False
		return
	}

	Monthly_Package_Collect:
	{
		if !Monthly_Package_Collect_Run
			return

		Subroutine_Running := "Monthly_Package_Collect"

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%

		Mouse_Click(500,1200) ; Tap Claim

		Monthly_Package_Collect_Run := False
		return
	}

	Warrior_Trial:
	{
		if !Warrior_Trial_Run
			return

		Subroutine_Running := "Warrior_Trial_Collect"

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
		; Mouse_Click(500,1200) ; Tap Claim

		Mouse_Click(560,1220) ; Select redeem steel
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Mouse_Click(366,680) ; Select max redeem slide bar
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Mouse_Click(336,780) ; Select Exchange button
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Mouse_Click(560,975) ; Select redeem silver medals
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Mouse_Click(366,680) ; Select max redeem slide bar
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Mouse_Click(336,780) ; Select Exchange button
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Warrior_Trial_Run := False
		return
	}

	Single_Cumulation:
	{
		if !Single_Cumulation_Run
			return

		Subroutine_Running := "Single_Cumulation"

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%

		Mouse_Click(560,550) ; Tap Claim

		Single_Cumulation_Run := False
		return
	}

	Claim_Buttons:
	{
		; if !Claim_Buttons_Run
		;	return

		Subroutine_Running := "Claim_Buttons"
		; Mouse_Click(180,1130, {Timeout: Delay_Short+0}) ; Tap Collide

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
		if (OCR([530, 479, 150, 60], "eng") = "Claim") ; Search for "Claim" Text on Button #1
			Mouse_Click(600,500, {Timeout: Delay_Medium+0}), Mouse_Click(300,50, {Timeout: Delay_Medium+0}) ; Tap "Claim" Button 01
		if (OCR([530, 633, 150, 60], "eng") = "Claim") ; Search for "Claim" Text on Button #2
			Mouse_Click(600,660, {Timeout: Delay_Medium+0}), Mouse_Click(300,50, {Timeout: Delay_Medium+0}) ; Tap "Claim" Button 02
		if (OCR([530, 789, 150, 60], "eng") = "Claim") ; Search for "Claim" Text on Button #3
			Mouse_Click(600,800, {Timeout: Delay_Medium+0}), Mouse_Click(300,50, {Timeout: Delay_Medium+0}) ; Tap "Claim" Button 03
		if (OCR([530, 943, 150, 60], "eng") = "Claim") ; Search for "Claim" Text on Button #4
			Mouse_Click(600,970, {Timeout: Delay_Medium+0}), Mouse_Click(300,50, {Timeout: Delay_Medium+0}) ; Tap "Claim" Button 04
		if (OCR([530, 1100, 150, 60], "eng") = "Claim") ; Search for "Claim" Text on Button #5
			Mouse_Click(600,1130, {Timeout: Delay_Medium+0}), Mouse_Click(300,50, {Timeout: Delay_Medium+0}) ; Tap "Claim" Button 05

		; Claim_Buttons_Run := False

		return
	}

	Daily_Signin:
	{
		if !Daily_Signin_Run
			return

		Subroutine_Running := "Daily_Signin"

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
		Mouse_Click(103,553) ; Daily Sign-In Click Day 1
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(343,560) ; Daily Sign-In Click Day 2
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(560,550) ; Select B Reward
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(560,550) ; Select B Reward
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(343,1125) ; Tap "OK"
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(330,1230) ; Tap Bottom Middle
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(560,550) ; Daily Sign-In Click Day 3
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(560,550) ; Select B Reward
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(343,1125) ; Tap "OK"
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(330,1230) ; Tap Bottom Middle
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(556,819) ; Daily Sign-In Click Day 4
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(330,1230) ; Tap Bottom Middle
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(334,819) ; Daily Sign-In Click Day 5
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(330,1230) ; Tap Bottom Middle
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(109,809) ; Daily Sign-In Click Day 6
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(330,1230) ; Tap Bottom Middle
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(330,1035) ; Daily Sign-In Click Day 7
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(560,550) ; Select B Reward
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(343,1125) ; Tap "OK"
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		
		loop, 12
		{
			Mouse_Click(320,70) ; Tap top title bar
			; Mouse_Click(330,1160) ; Tap Bottom Middle
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		}

		loop, 7
		{
			Mouse_Click(320,70) ; Tap top title bar
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}

		; loop, 12
		; Mouse_Click(330,1230) ; Tap Bottom Middle

		Daily_Signin_Run := False

		return
	}

	Monthly_Signin:
	{
		if !Monthly_Signin_Run
			return

		Subroutine_Running := "Monthly_Signin"

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
		; Claim Monthly
		loop, 2
			Mouse_Click(342,1215) ; Tap collect Monthly Signin
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(153,323) ; Claim 5 Days
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Collect_and_Clear

		Mouse_Click(266,323) ; Claim 10 Days
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Collect_and_Clear

		Mouse_Click(380,323) ; Claim 15 Days
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Collect_and_Clear

		Mouse_Click(505,323) ; Claim 20 Days
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Collect_and_Clear

		Mouse_Click(633,323) ; Claim 25 Days
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Collect_and_Clear

		Monthly_Signin_Run := False

		return
	}

	Collect_and_Clear:
	{
		Mouse_Click(340,1000) ; Tap Collect Button
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(340,40) ; 1215) ; Tap to Clear
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		return
	}

	Selection_Chest:
	{
		if !Selection_Chest_Run
			return

		Subroutine_Running := "Selection_Chest"

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%

		Mouse_Click(87,430) ; Tap Free Chest
		DllCall("Sleep","UInt",(rand_wait + 8*Delay_Short+0))

		Mouse_Click(52,682) ; Select 1,000 Diamonds
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Mouse_Click(517,680) ; Select Silver Medal
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		; Swipe Up X times
		loop, 4
			Mouse_Drag(133, 1027, 115, 522, {EndMovement: F, SwipeTime: 500})

		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		Mouse_Click(205,770) ; Select 1,000 Vip Points X 10
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Mouse_Click(520,960) ; Select 500K Strength Abilities Exp
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Mouse_Click(60,960) ; Select Super Officer
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		loop, 2
		{
			Mouse_Click(349,1207) ; Tap Collect
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}
		
		Selection_Chest_Run := False

		return
	}

	Battle_Honor_Collect:
	Subroutine_Running := "Battle_Honor_Collect"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	{
		if !Battle_Honor_Run
			return

		loop, 4
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
			Mouse_Click(260,636, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 01
			Mouse_Click(260,636, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 01
			Mouse_Click(260,720, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 02
			Mouse_Click(260,720, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 02
			Mouse_Click(260,800, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 03
			Mouse_Click(260,800, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 03
			Mouse_Click(260,883, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 04
			Mouse_Click(260,883, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 04
			Mouse_Click(260,963, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 05
			Mouse_Click(260,963, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 05
			Mouse_Click(260,1050, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 06
			Mouse_Click(260,1050, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 06
			Mouse_Click(260,1126, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 07
			Mouse_Click(260,1126, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 07
			Mouse_Click(260,1202, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 08
			Mouse_Click(260,1202, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 08

			return
		}

		Battle_Honor_Swipe:
		{
			Mouse_Drag(350, 1203, 360, 609, {EndMovement: T, SwipeTime: 500})
			/*
			Click, 350, 1203 Left, Down
			Click, 350, 1190 , 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 356, 1135 , 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 365, 1040 , 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 369, 957 , 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 370, 820 , 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 366, 767 , 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 364, 716 , 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 362, 689 , 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 360, 660 , 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 360, 635 , 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 360, 614 , 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 360, 600 , 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 360, 609, 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
			Click, 360, 609, 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
			Click, 360, 609 Left, Up
			*/
			Return
		}

		Battle_Honor_END:

		Battle_Honor_Run := False

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
		return
	}

}

; Tap Speaker/help
Speaker_Help:
{
	Subroutine_Running := "Speaker_Help"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	Search_Captured_Text := ["Claim"]
	OCR_X := 308 ; 290
	OCR_Y := 565 ; 550
	OCR_W := 75 ; 110
	OCR_H := 30 ; 60
	loop, 2
	{
		loop, 2
		{
			Mouse_Click(630,1033) ; Tap speaker/help
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}

		loop, 2
			if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			{
				Mouse_Click(357,570) ; Tap Claim
				DllCall("Sleep","UInt",(rand_wait + 5*Delay_Short+0))
			}
	}

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Drop_Zone:
{
	Subroutine_Running := "Drop_Zone"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(285,200) ; Tap On Drop Zone
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	; Mouse_Click(410,1050) ; Get Steel X Times
	; Search_Captured_Text := ["Click"]
	; loop, 20
	; {
	; Capture_Screen_Text := OCR([359, 1020, 146, 57], "eng")
	; If (RegExMatch(Capture_Screen_Text,Search_Captured_Text))
	; {
	; loop, 5
	; Mouse_Click(410,1050) ; Get Steel X Times
	; }
	; else
	; break
	; }

	; Mouse_Click(410,1050) ; Get Steel X Times
	Search_Captured_Text := ["Click"]
	OCR_X := 365
	OCR_Y := 1020
	OCR_W := 70
	OCR_H := 50	; 100
	loop, 5
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			break

	loop, 5
	{
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			loop, 20
				Mouse_Click(410,1050, {Clicks: 2,Timeout: (1*Delay_Short+0)}) ; Get Steel X Times
		; else
		;	break
	}

	; loop, 40
	; {
	;	Mouse_Click(410,1050) ; Get Steel X Times
	;	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	; }

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Adventure_Missions:
{
	Subroutine_Running := "Adventure_Missions"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Collect_Cafeteria:
{
	Subroutine_Running := "Collect_Cafeteria"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(379,736) ; Collect Cafeteria

	; Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Active_Skill:
{
	Subroutine_Running := "Active_Skill"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(195,1195) ; Tap Activate Skills
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Medium+0))

	Gosub Active_Skill_Reload

	; if !Active_Skill_Detected

	Continue_Active_Skill:

	loop, 2
		Mouse_Click(215,425) ; Active Skill tab #2 - Officer
	Gosub Active_Skill_Click_Button

	; loop, 2
	; Mouse_Click(340,425) ; Active Skill tab #3 - Combat
	; Gosub Active_Skill_Click_Button

	loop, 2
		Mouse_Click(470,425) ; Active Skill tab #4 - Develop
	Gosub Active_Skill_Click_Button

	loop, 2
		Mouse_Click(600,425) ; Active Skill tab #5 - Support
	Gosub Active_Skill_Click_Button

	goto Active_Skill_END

	; Capture_Screen_Text := OCR([70, 600, 124, 60], "eng") ; Button 01
	; Capture_Screen_Text := OCR([275, 600, 124, 60], "eng") ; Button 02
	; Capture_Screen_Text := OCR([480, 600, 124, 60], "eng") ; Button 03
	; Capture_Screen_Text := OCR([70, 815, 124, 60], "eng") ; Button 04
	; Capture_Screen_Text := OCR([275, 815, 124, 60], "eng") ; Button 05
	; Capture_Screen_Text := OCR([480, 815, 124, 60], "eng") ; Button 06

	Active_Skill_Click_Button:
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Medium+0))
	; set variables
	Button_Max_X := 510 ; 480 ; 500 ; 480
	Button_Max_Y := 830 ; 815
	Button_Min_X := 100 ; 90 ; 70 ; 75 ; 70
	Button_Min_Y := 620 ; 610 ; 600 ; 610 ; 600

	Button_OCR_X := Button_Max_X ; delta 71-276-481 = 205
	Button_OCR_Y := Button_Max_Y ; delta 600-815 = 215
	Button_OCR_W := 100 ; 130 ; 100 ; 130
	Button_OCR_H := 40 ; 50 ; 60 ; 40 ; 60
	Button_OCR_X_Delta := 205 ; 203 ; 100, 305 to 510 = 205
	Button_OCR_Y_Delta := 210 ; 215 ; 217 ; 215 ; 620 to 830 = 210
	Click_X_Delta := 60 ; 50 ; 60
	Click_Y_Delta := 15 ; 15 ; 30
	Click_X := (Button_OCR_X + Click_X_Delta)
	Click_Y := (Button_OCR_Y + Click_Y_Delta)

	Active_Skills_Text := ["Harvest", "Special", "Skillful", "Workman", "Ability", "First", "Riches", "Magic", "Clown", "Promotion", "Instructor"]
	Active_Skill_Button_text := ["Use"]
	loop, 6
	{
		; Looking for green use buttons on main active skill interface
		Look_For_Use_Button:
		if !Search_Captured_Text_OCR(Active_Skill_Button_text, {Pos: [Button_OCR_X, Button_OCR_Y], Size: [Button_OCR_W, Button_OCR_H], Timeout: 0}).Found
			Goto Active_Skill_Click_Button_Next

		Active_Skill_Click_Button_NOW:
		Mouse_Click(Click_X,Click_Y) ; Tap Use button found
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		; Looking for Skill titles that match list
		Match_OCR_X := 180
		Match_OCR_Y := 445
		Match_OCR_W := 330
		Match_OCR_H := 36
		loop, 2
		if Search_Captured_Text_OCR(Active_Skills_Text, {Pos: [Match_OCR_X, Match_OCR_Y], Size: [Match_OCR_W, Match_OCR_H], Timeout: 0}).Found
				goto Active_Skill_Skill_Opened

		goto Active_Skill_Click_Button_Next ; No matching title found, examin next button

		Active_Skill_Skill_Opened:
		loop, 3
			Mouse_Click(340,780) ; Tap "Use" button
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Medium+0))

		Active_Skill_Click_Button_Next:
		Gosub Active_Skill_Reload
		Mouse_Click(333,355) ; Tap title bar
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		if (Button_OCR_X <= Button_Min_X)
		{
			Button_OCR_X := Button_Max_X
			if (Button_OCR_Y <= Button_Min_Y)
				Button_OCR_Y := Button_Max_Y
			else
				Button_OCR_Y -= Button_OCR_Y_Delta
		}
		else
			Button_OCR_X -= Button_OCR_X_Delta
		/*	
		if (Button_OCR_X <= 0)
			Button_OCR_X := Button_Max_X			
			
		if (Button_OCR_Y <= 0)
			Button_OCR_Y := Button_Max_Y
		*/

		Click_X := (Button_OCR_X + Click_X_Delta)
		Click_Y := (Button_OCR_Y + Click_Y_Delta)
	}
	return

	Active_Skill_Reload:
	loop, 5
	{
		Search_Captured_Text := ["Active Skill"]
		Active_Skill_OCR_X := 280 ; 260
		Active_Skill_OCR_Y := 350 ; 337
		Active_Skill_OCR_W := 140 ; 174
		Active_Skill_OCR_H := 25 ; 46
		; check to see if active skill is properly displayed x times
		loop, 5
			if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [Active_Skill_OCR_X, Active_Skill_OCR_Y], Size: [Active_Skill_OCR_W, Active_Skill_OCR_H], Timeout: 0}).Found
				return

		; Gosub Get_Window_Geometry
		Gosub Check_Window_Geometry
		Gosub Go_Back_To_Home_Screen
		Mouse_Click(195,1195) ; Tap Activate Skills
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Medium+0))
	}
	return

	Active_Skill_END:
	Gosub Go_Back_To_Home_Screen
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

}

Collect_Chips_Underground:
{
	Subroutine_Running := "Collect_Chips_Underground"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; Tap underground
	; Tap Misslie Silo
	; Tap underground Construsction Center
	; Hit F5 for back button
	; Swipe from lower right to upper left
	; Tap on each Chip Plant
	; Hit F5 for back button

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Reserve_Factory:
{
	Subroutine_Running := "Reserve_Factory"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	; *******************************
	; Collect Reserve supplies
	; *******************************
	Mouse_Click(610,1200) ; Tap Alliance Menu
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	Mouse_Click(355,825) ; Tap Alliance Help
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(480,140) ; Tap Reserve Factory Help
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	if Pause_Script
		MsgBox, 0, Pause, Press OK to resume (No Timeout)

	Mouse_Click(110,340) ; Tap Reserve Factory Icon
	DllCall("Sleep","UInt",(rand_wait + 6*Delay_Long+0))

	loop, 4
	{
		Mouse_Click(344,590) ; Tap Reserve Factory On World Map
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

	; *******************************
	; Upgrade, Add Energy, Use, Etc, X Times
	; *******************************
	Loop, 2
	{
		Mouse_Click(609,1186) ; Tap Alliance Menu
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

		Mouse_Click(383,835) ; Tap Alliance Help
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		Mouse_Click(480,140) ; Tap Reserve Factory Help
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		Mouse_Click(119,336) ; Tap Reserve Factory Icon
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		Mouse_Click(240,613) ; Tap Info Menu On Reserve Factory On World Map
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		; Mouse_Click(324,797) ; Tap Upgrade, Add Energy, Use, Etc, X Times
		loop, 10
		{
			Mouse_Click(324,797) ; Tap Upgrade, Add Energy, Use, Etc, X Times
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}
		Mouse_Click(320,70) ; Tap top title bar
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		Mouse_Click(320,70) ; Tap top title bar
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		
		Mouse_Click(33,62) ; Tap back Button
		; Text_To_Screen("{F5}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}
	
	; *******************************
	; Instant Help and Request Help
	; *******************************
	Mouse_Click(596,1196) ; Tap Alliance Menu
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(440,817) ; Tap Alliance Help
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(480,140) ; Tap Reserve Factory Help
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	loop, 2
	{
		Mouse_Click(320,405) ; Tap Instant Help
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		Mouse_Click(510,415) ; Tap Request Help
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	; Go_Back_Home_Delay_Long := True
	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}


Donate_Tech:
{
	Subroutine_Running := "Donate_tech"

	Search_Captured_Text := ["Technology"]
	loop, 3
	{
		Gosub Donate_Tech_Control_Desk_Expand
		loop, 3
		{
			Gosub Click_Top_Tech
			if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0}).Found
				goto Donate_Tech_Open_NEXT ; Donate_Tech_Open
		}
		Gosub Go_Back_To_Home_Screen
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
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
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

			Inner_Loop_Donation:
			; loop, 2
			{
				Mouse_Click(469,Tech_Click_Y) ; select tech
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

				OCR_Donate_04 := Search_Captured_Text_OCR(["04:"], {Pos: [295, 730], Size: [50, 30], Timeout: 0})
				; OCR_Donate_imm := Search_Captured_Text_OCR(["immediately"], {Pos: [140, 642], Size: [169, 42], Timeout: 0})
				OCR_Donate_Buy := Search_Captured_Text_OCR(["Buy"], {Pos: [70, 820], Size: [55, 35], Timeout: 0})
				
				if (OCR_Donate_04.Found)
					Goto Donations_OVER ; Goto Outer_Loop_Donation_Break ; Break Outer_Loop_Donation
				else if (OCR_Donate_Buy.Found)
				{
					loop, 22
					{
						Loop, 2
						{
							Mouse_Click(420,1000, {Timeout: (1*Delay_Micro+0)}) ; Tap On Donation Box 3
							; DllCall("Sleep","UInt",(1*Delay_Micro+0))
						}
						Loop, 2
						{
							Mouse_Click(260,1000, {Timeout: (1*Delay_Micro+0)}) ; Tap On Donation Box 2
							; DllCall("Sleep","UInt",(1*Delay_Micro+0))
						}
						Loop, 2
						{
							Mouse_Click(100,1000, {Timeout: (1*Delay_Micro+0)}) ; Tap On Donation Box 1
							DllCall("Sleep","UInt",(3*Delay_Micro+0))
						}
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
				MsgBox, 0, OCR return, % "Was value (F)ound? Using what (V)alue? Found (T)ext:`n" VAR1 "`n" VAR2 "`n" VAR3
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
		{
			Mouse_Click(7,637) ; Tap to Expand Control Desk
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		}
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
			Mouse_Click(Click_X,Click_Y) ; Tap To expand previous Rank Tech
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
			; Gosub Donate_Tech_Find_And_Click
			return

			Donate_Tech_Collapse_Tech_Next:
			{
				Tech_Click_Initial := (Click_Y + 110)
				Mouse_Click(Click_X,Click_Y) ; Tap To Collapse Rank Tech
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
			}

			if (OCR_Y >= Max_Y)
				break

			if (OCR_Y < Max_Y)
				OCR_Y += OCR_Y_Delta

			Click_Y := (OCR_Y + 25)
			Gosub Click_Top_Tech
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
			Capture_Screen_Text := ""

		}
		return
	}

	Click_Top_Tech:
	loop, 3
	{
		Mouse_Click(340,70) ; Tap header
		DllCall("Sleep","UInt",(2*Delay_Micro+0))
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}
	return
	
	Donations_OVER:
	Gosub Go_Back_To_Home_Screen
	return
}

Depot_Rewards:
{
	Subroutine_Running := "Depot_Rewards"

	; set variables
	Depot_Rewards_Button_Text_Array := ["Free","Reward","Request","Help"]

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	loop, 2
	{
		Mouse_Click(140,662, {Timeout: 1*Delay_Long+0}) ; Tap depot
		Mouse_Click(250,722, {Timeout: 1*Delay_Long+0}) ; Tap Alliance Treasures
	}
	; DllCall("Sleep","UInt",rand_wait + (3*Delay_Medium))

	Search_Captured_Text := ["Treasures"]
	loop, 5
	{
		loop, 3
			if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0}).Found
				goto Continue_Depot_Treasures

		Gosub Go_Back_To_Home_Screen
		Mouse_Click(140,662, {Timeout: 1*Delay_Long+0}) ; Tap depot
		Mouse_Click(250,722, {Timeout: 1*Delay_Long+0}) ; Tap Alliance Treasures
		; DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))
	}
	goto Depot_Rewards_END

	Continue_Depot_Treasures:

	Mouse_Click(105,150) ; Tap Tab 1 Treasure list
	Gosub Depot_Click_Button

	Mouse_Click(340,150) ; Tap Tab 2 My Treasures
	Gosub Depot_Click_Button

	Mouse_Click(570,150) ; Tap Tab 3 Help_List
	Gosub Depot_Click_Button

	Depot_Rewards_END:
	Gosub Go_Back_To_Home_Screen
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

	Depot_Click_Button:
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	; set variables
	Max_X := Min_X := 510	; 515
	Max_Y := (Min_Y + 3*OCR_Y_Delta) ; 1200
	; Min_X := 500
	Min_Y := 415	; 400
	OCR_X := Min_X ; delta 71-276-481 = 205
	OCR_Y := Min_Y ; delta 600-815 = 215
	OCR_W := 130	; 150 ; X = 510-650
	OCR_H := 30	; 50 ; Y = 400-450
	OCR_X_Delta := 0
	OCR_Y_Delta := 202	; 200
	Click_X_Delta := 75
	Click_Y_Delta := 25
	Click_X := (OCR_X + Click_X_Delta)
	Click_Y := (OCR_Y + Click_Y_Delta)

	loop, 8
	{
		; Looking for Rewards Button titles that match list
		if !Search_Captured_Text_OCR(Depot_Rewards_Button_Text_Array, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			goto Next_Depot_Button

		Depot_Rewards_Click_Found_Item:
		Mouse_Click(Click_X,Click_Y, {Timeout: 1*Delay_Medium+0}) ; Tap found button
		Mouse_Click(320,70) ; Tap top title bar
		; Mouse_Click(340,70, {Timeout: 1*Delay_Short+0}) ; Tap Outside Rewards Box
		; DllCall("Sleep","UInt",rand_wait + (4*Delay_Short))

		Next_Depot_Button:
		if (OCR_Y >= Max_Y)
			OCR_Y := Min_Y
		else
			OCR_Y += OCR_Y_Delta
		Click_Y := (OCR_Y + Click_Y_Delta)
	}
	return

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

VIP_Shop:
{
	Subroutine_Running := "VIP_Shop"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(156,90) ; Tap VIP Shop
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Search_Captured_Text := ["VIP Shop"]
	loop, 2
	{
		loop, 2
			if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0}).Found
				goto Continue_VIP_Shop

		Gosub Go_Back_To_Home_Screen
		Mouse_Click(156,90) ; Tap VIP Shop
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	}
	goto VIP_Shop_END

	Continue_VIP_Shop:
	; Button01 := 225, 575 ; (delta X:80, Y:100)
	; Button02 := 560, 575 ; (delta X:80, Y:100)
	; Button03 := 225, 745 ; (delta X:80, Y:100)
	; Button04 := 560, 745 ; (delta X:80, Y:100)

	Gosub VIP_Shop_Click_Button

	VIP_Shop_END:
	Gosub Go_Back_To_Home_Screen
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
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
		if !Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			goto VIP_Shop_Click_Button_Next

		VIP_Shop_Click_Found_Item:
		Mouse_Click(Click_X,Click_Y) ; Tap VIP item to purchase
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
		Mouse_Click(350,890) ; confirm purchase
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
		Mouse_Click(320,70) ; Tap top title bar
		; Mouse_Click(350,1150) ; Tap Outside Rewards Box
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Medium+0))

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
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Mail_Collection:
{
	Subroutine_Running := "Mail_Collection"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen
	
	Mail_Keyword_Array := ["Mail","Activities","Alliance","Last Empire","System"]
	Mail_BACK2_Array := ["Alliance Arms","Cross-State","Desert Conflict","Other Event","Single Player","Arms Race"]
	
	Gosub Mail_Collection_Open

	Mouse_Click(200,272) ; Tap Alliance
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Mouse_Click(200,545) ; Tap Last Empire - War Z Studios
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Mouse_Click(200,633) ; Tap System
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Mouse_Click(200,760) ; Tap reports 01 - RSS gathering 
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Mouse_Click(200,860) ; Tap reports 02 - Zombies
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Mouse_Click(200,960) ; Tap reports 03 - Missile attack
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Mouse_Click(200,1060) ; Tap reports 04 - Transport
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Mouse_Click(200,1160) ; Tap reports 05 - Other
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Mouse_Click(200,445) ; Tap Activities
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

	Subroutine_Running := "Single Player Arms Race"
	Mouse_Click(200,170) ; Tap Activities - SPAR (Single Player Arms Race)
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Subroutine_Running := "Alliance Arms Race"
	Mouse_Click(200,257) ; Tap Activities - AAR (Alliance Arms Race)
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Subroutine_Running := "Cross-State Battle"
	Mouse_Click(200,360) ; Tap Activities - CSB (Cross-State Battle)
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Subroutine_Running := "Desert Conflict"
	Mouse_Click(200,445) ; Tap Activities - Desert Conflict
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Subroutine_Running := "Other Event Mail"
	Mouse_Click(200,540) ; Tap Activities - Other Event Mail
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

	Mark_All_As_Read:
	Subroutine_Running := "Mark_All_As_Read"
	Loop, 2
	{
		if Search_Captured_Text_OCR(["MARK","READ"], {Pos: [273, 1185], Size: [142, 26], Timeout: 0}).Found ; Is the Mark as Read button displayed?
		{
			Mouse_Click(340,1200) ; Tap "MARK AS READ" button
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
			Mouse_Click(202,705) ; Tap "CONFIRM" button
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
			Mouse_Click(340,70) ; Tap header to clear message
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}
	}
	; Tap Message back
	; loop, 2
	; {
	; 	Mouse_Click(50,60) ; Tap Message back
	; 	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	; }
	gosub Mail_Collection_Open
	return
	
	Mail_Collection_Open:
	Subroutine_Running := "Mail_Collection_Open"
	loop, 2
	{
		loop, 5
		{
			; if mail loaded, return
			if Search_Captured_Text_OCR(["Mail"], {Pos: [309, 46], Size: [76, 50], Timeout: 0}).Found
				return ; Gosub, Read_Mail_Open
				
			; if mail not loaded, tap on mail icon
			if Search_Captured_Text_OCR(["Mail"], {Pos: [466, 1222], Size: [56, 24], Timeout: 0}).Found
			{
				Mouse_Click(500,1200) ; Tap Mail
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
				Goto, Mail_Collection_Open
			}

			; if mail not loaded and mail icon not available, go back
			Mouse_Click(50,60) ; Tap Message back
			Text_To_Screen("{F5}")
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		}
		Gosub Go_Back_To_Home_Screen
	}
	return
}

Alliance_Boss_Regular:
{
	Subroutine_Running := "Alliance_Boss"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	Mouse_Click(610,1214) ; Tap Alliance
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	; Swipe up
	loop, 2
		Mouse_Drag(345, 1100, 409, 196, {EndMovement: F, SwipeTime: 500})
	/*
	{
		Click, 345, 1100 Left, Down
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Click, 370, 1003, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Click, 409, 196 Left, Up
	}
	*/
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(273,540) ; Tap Alliance Boss regular play
	; Mouse_Click(273,630) ; Tap Alliance Boss desert oasis
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(525,1186) ; Tap Feed Boss
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(340,780) ; Tap Confirm Feed Boss

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Alliance_Boss_Oasis:
{
	Subroutine_Running := "Alliance_Boss"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	Mouse_Click(610,1214) ; Tap Alliance
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	; Swipe up
	loop, 2
		Mouse_Drag(345, 1100, 409, 196, {EndMovement: F, SwipeTime: 500})
	/*
	{
		Click, 345, 1100 Left, Down
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Click, 370, 1003, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Click, 409, 196 Left, Up
	}
	*/
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	; Mouse_Click(273,540) ; Tap Alliance Boss regular play
	Mouse_Click(273,630) ; Tap Alliance Boss desert oasis
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(525,1186) ; Tap Feed Boss
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(340,780) ; Tap Confirm Feed Boss

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Alliance_Wages:
{
	Subroutine_Running := "Alliance_Wages"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	Goto Alliance_Menu_Wages

	Control_Desk_Alliance_Wages:
	{

		Mouse_Click(27,612) ; Tap to Expand Control Desk
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		; Swipe Down (linear)
		loop, 2
			Mouse_Drag(326, 405, 326, 957, {EndMovement: F, SwipeTime: 500})
		/*
		{
			Click, 326, 405 Left, Down
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 326, 474, 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 326, 543, 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 326, 680, 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 326, 957 Left, Up
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		}
		*/
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		Loop, 2
			Mouse_Click(470,960) ; Tap Goto Alliance Wages

		Goto Alliance_Wages_Continue
	}

	Alliance_Menu_Wages:
	{

		Mouse_Click(605,1212) ; Tap Alliance Menu
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		Search_Captured_Text := ["Wages"]
		OCR_X := 230
		OCR_Y := 920
		OCR_W := 100
		OCR_H := 60
		loop, 5
		{
			loop, 3
			{
				OCR_Y := 920
				if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
				{
					Mouse_Click(405,932) ; Tap Alliance Wages button
					goto Found_Alliance_Wages_Menu
				}

				OCR_Y := 1020
				if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
				{
					Mouse_Click(405,1044) ; Tap Alliance Wages button
					goto Found_Alliance_Wages_Menu
				}
			}

			Gosub Go_Back_To_Home_Screen
			Mouse_Click(605,1212) ; Tap Alliance Menu
		}
		goto Alliance_Wages_END

		Found_Alliance_Wages_Menu:
		Gosub Alliance_Wages_Continue

		Alliance_Wages_END:
		Gosub Go_Back_To_Home_Screen
		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
		return
	}

	Alliance_Wages_Continue:
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	; Alliance Wages - Active (TAB 1)
	Alliance_Wages_Active_TAB_1:
	Subroutine_Running := "Alliance_Wages_Active_TAB_1"
	{
		; Gosub Click_Through_Wage_Tabs
		Gosub Click_Points_Boxes
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		goto END_Alliance_Wages_Active_TAB_1

		TRY_MORE_01_Alliance_Wages_Active_TAB_1:
		Gosub Click_Through_Wage_Tabs
		; Swipe Right
		loop, 5
			Mouse_Drag(216, 647, 624, 647, {EndMovement: F, SwipeTime: 500})
		/*
		{
			Click, 216, 647 Left, Down
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 275, 647, 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 324, 647, 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 424, 647, 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 624, 647 Left, Up
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		}
		*/
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
		Gosub Click_Points_Boxes
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

		; MsgBox, 4, , Retry? (8 Second Timeout & skip), 8
		; vRet := MsgBoxGetResult()
		; if (vRet = "No")
		; goto Alliance_Wages_Active_TAB_2

		TRY_MORE_02_Alliance_Wages_Active_TAB_1:
		Gosub Click_Through_Wage_Tabs
		; Swipe Left
		loop, 5
			Mouse_Drag(624, 647, 216, 647, {EndMovement: F, SwipeTime: 500})
		/*
		{
			Click, 624, 647 Left, Down
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 424, 647, 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 324, 647, 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 275, 647, 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 216, 647 Left, Up
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		}
		*/
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
		Gosub Click_Points_Boxes
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

		END_Alliance_Wages_Active_TAB_1:
		; MsgBox, 4, , Retry? (8 Second Timeout & skip), 8
		; vRet := MsgBoxGetResult()
		; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		; goto TRY_MORE_01_Alliance_Wages_Active_TAB_1
	}

	; Alliance Wages - Active (TAB 2)
	Alliance_Wages_Active_TAB_2:
	Subroutine_Running := "Alliance_Wages_Active_TAB_2"
	{
		Mouse_Click(335,390) ; Tap Alliance Wages - Attendance (TAB 2)
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		loop, 3
		{
			Mouse_Click(134,725) ; Tap Attendance 1
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}

		; loop, 3
			; Mouse_Click(134,725) ; Tap Attendance 1
		; DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

		loop, 3
		{
			Mouse_Click(280,730) ; Tap Attendance 30
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}

		; loop, 3
			; Mouse_Click(280,730) ; Tap Attendance 30
		; DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

		loop, 3
		{
			Mouse_Click(615,726) ; Tap Attendance 50
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}

		; loop, 3
			; Mouse_Click(615,726) ; Tap Attendance 50
		; DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
	}

	; Alliance Wages - Active (TAB 3)
	Alliance_Wages_Active_TAB_3:
	Subroutine_Running := "Alliance_Wages_Active_TAB_3"
	{

		loop, 2
			Mouse_Click(562,390) ; Tap Alliance Wages - Contribution (TAB 3)
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		loop, 3
		{
			Mouse_Click(140,726) ; Tap Alliance Contribution Box 1
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}

		loop, 3
		{
			Mouse_Click(275,726) ; Tap Alliance Contribution Box 2
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}

		loop, 3
		{
			Mouse_Click(410,726) ; Tap Alliance Contribution Box 3
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}

		loop, 3
		{
			Mouse_Click(622,726) ; Tap Alliance Contribution Box 4
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}
	}
	return

	Click_Through_Wage_Tabs:
	{
		Mouse_Click(335,390) ; Tap Alliance Wages - Attendance (TAB 2)
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Mouse_Click(562,390) ; Tap Alliance Wages - Contribution (TAB 3)
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Mouse_Click(112,390) ; Tap Alliance Wages - Active (TAB 1)
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		return
	}

	Click_Points_Boxes:
	{
		; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
		Mouse_Click(40,650) ; Tap Points Box 30
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(100,650) ; Tap Points Box 30
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(160,650) ; Tap Points Box 70
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(220,650) ; Tap Points Box 70
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(280,650) ; Tap Points Box 120
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(340,650) ; Tap Points Box 120
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(400,650) ; Tap Points Box 180
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(460,650) ; Tap Points Box 180
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(520,650) ; Tap Points Box 260
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(580,650) ; Tap Points Box 260
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(640,650) ; Tap Points Box 340
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Click_Collect_Daily_Rewards_Chest

		return
	}

	Click_Collect_Daily_Rewards_Chest:
	{
		; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

		Mouse_Click(352,982) ; Tap Collect Daily Rewards Chest
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(320,70) ; Tap top title bar
		; Mouse_Click(366,175) ; Tap Outside Chest
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		return
	}

}

Train_Daily_Requirement:
{
	Subroutine_Running := "Train_Daily_Requirement"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	Gosub Reset_Posit
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	; Zoom out
	loop, 10
	{
		Text_To_Screen("{F2}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2
	{

		Mouse_Click(474,1186) ; Tap Mail
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

		Mouse_Click(50,60) ; Tap Message back
		; Mouse_Click(630,75) ; Tap Message back
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

		; Zoom out
		loop, 10
		{
			Text_To_Screen("{F2}")
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		}
	}

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; Zoom out
	loop, 10
	{
		Text_To_Screen("{F2") ; 2}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	; Swipe Right
	; Mouse_Click(250,650) ; Swipe Right
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	; Click, 400, 650, 0
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	; Click, 475, 650, 0
	; DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
	; Click, 512, 650, 0
	; DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
	; Click, 530, 650, 0
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	; Click, 550, 650 Left, Up

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Tap Vehicle Factory
	; Mouse_Click(393,985); Tap Vehicle Factory
	loop, 2
	{
		Mouse_Click(390,940) ; Tap Vehicle Factory
		Gosub Click_Middle_Screen
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	}
	; Tap Train Button
	Mouse_Click(530,964) ; Mouse_Click(530,986)
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Gosub Training_Number

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	
	; Mouse_Click(183,852) ; Tap Warrior Camp
	loop, 2
	{
		Mouse_Click(220,845) ; Tap Warrior Camp
		Gosub Click_Middle_Screen
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	}
	; Tap Train Button
	Mouse_Click(354,879) ; Tap Train Button
	; Mouse_Click(324,872) ; Tap Train Button
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Gosub Training_Number

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	
	; Mouse_Click(63,770) ; Tap Shooter Camp
	loop, 2
	{
		Mouse_Click(100,800) ; Tap Shooter Camp
		Gosub Click_Middle_Screen
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	}
	; Tap Train Button
	Mouse_Click(240,850) ; Tap Train Button
	; Mouse_Click(270,833) ; Tap Train Button
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Gosub Training_Number

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; Mouse_Click(10,730) ; Tap Biochemical Center
	loop, 2
		{
		Mouse_Click(10,717) ; Tap Biochemical Center
		Gosub Click_Middle_Screen
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	}
	; Tap Train Button
	Mouse_Click(250,755) ; Mouse_Click(275,732)
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Gosub Training_Number

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

	Training_Number:
	{
		; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

		Mouse_Click(550,1100) ; Tap Troop Number Box
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		loop, 8
		{
			Text_To_Screen("{Backspace}")
			DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
		}
		Text_To_Screen("{3}")
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
		Text_To_Screen("{0}")
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
		Text_To_Screen("{0}")
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
		Text_To_Screen("{Enter}")
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

		Mouse_Click(509,1189) ; Tap Train Now

		Gosub Go_Back_To_Home_Screen

		return
	}
}

Gather_Resources:
{
	Subroutine_Running := "Gather_Resources"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	Mouse_Click(76,1200) ; Tap World/home button
	DllCall("Sleep","UInt",(rand_wait + 8*Delay_Long+0))

	Gather_Fuel:
	Subroutine_Running := "Gather_Fuel"
	; Tap search button x times
	loop, 2
	{
		Mouse_Click(627,1069) ; Mouse_Click(627,1034)
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

	; Swipe right x times
	loop, 2
		Mouse_Drag(100, 990, 600, 990, {EndMovement: F, SwipeTime: 500})
	/*
	{
		; World search Swipe Right One position

		Click, 100, 990 Left, Down
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 350, 990, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 475, 990, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 562, 990, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 600, 990 Left, Up
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}
	*/
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	MsgBox, 4, , Gather Oil Well? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		{
			Mouse_Click(407,974) ; Tap Oil Well
			Gosub Search_And_Deploy_Resources
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		}

	Gather_Farm:
	Subroutine_Running := "Gather_Farm"
	MsgBox, 4, , Gather Farm? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		{
			Mouse_Click(547,970) ; Tap Farm
			Gosub Search_And_Deploy_Resources
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		}

	Gather_Steel:
	Subroutine_Running := "Gather_Steel"
	; Tap search button x times
	loop, 2
	{
		Mouse_Click(627,1069) ; Mouse_Click(627,1034)
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

	; Swipe left x times
	loop, 2
		Mouse_Drag(600, 990, 100, 990, {EndMovement: F, SwipeTime: 500})
	/*
	{
		; World search Swipe Right One position
		Click, 600, 990 Left, Down
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 562, 990, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 475, 990, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 350, 990, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 100, 990 Left, Up
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}
	*/
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	MsgBox, 4, , Gather Steel Mill? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		{
			Mouse_Click(124,983) ; Tap Steel Mill
			Gosub Search_And_Deploy_Resources
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		}

	Gather_Alloy:
	Subroutine_Running := "Gather_Alloy"
	; Swipe left x times
	loop, 2
		Mouse_Drag(600, 990, 100, 990, {EndMovement: F, SwipeTime: 500})
	/*
	{
		; World search Swipe Right One position
		Click, 600, 990 Left, Down
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 562, 990, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 475, 990, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 350, 990, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 100, 990 Left, Up
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}
	*/
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	MsgBox, 4, , Gather Alloy Mine? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		{
			Mouse_Click(270,970) ; Tap Alloy Mine
			Gosub Search_And_Deploy_Resources
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		}

	MsgBox, 4, , Gather more? (10 Second Timeout & skip), 10
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		Gosub Gather_Fuel

	End_Gathering:

	; Go_Back_Home_Delay_Long := True
	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

	Search_And_Deploy_Resources:
	{
		; Tap Level Box
		Mouse_Click(637,1112) ; Mouse_Click(637,1112+0)
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Text_To_Screen("{6}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Text_To_Screen("{Enter}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Mouse_Click(346,1200) ; Tap Search Button
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Medium+0))

		Mouse_Click(440,640) ; Tap Gather Button

		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		Select_Gather_Officers:
		{
			Mouse_Click(525,437) ; Tap Officer 5
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Mouse_Click(319,350) ; Tap Above Officer In Case Already Marching
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

			Mouse_Click(407,434) ; Tap Officer 4
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Mouse_Click(319,350) ; Tap Above Officer In Case Already Marching
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

			Mouse_Click(300,435) ; Tap Officer 3
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Mouse_Click(319,350) ; Tap Above Officer In Case Already Marching
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

			Mouse_Click(180,440) ; Tap Officer 2
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Mouse_Click(319,350) ; Tap Above Officer In Case Already Marching
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

			Mouse_Click(54,436) ; Tap Officer 1
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Mouse_Click(319,350) ; Tap Above Officer In Case Already Marching
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		}
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		Mouse_Click(480,1186) ; Tap March
		DllCall("Sleep","UInt",(rand_wait + 8*Delay_Short+0))

		; Mouse_Click(54,965) ; Tap Do Not Remind Me Again
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		Mouse_Click(560,1020) ; Tap Deploy
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		; Tap search button x times
		loop, 2
		{
			Mouse_Click(627,1069) ; Mouse_Click(627,1034)
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
		return
	}
}

Desert_Oasis:
{
	Subroutine_Running := "Desert_Oasis"
	
	loop, 3
		if Enter_Coordinates_From_Home()
			gosub Desert_Oasis_Enter_Coordinates_Next
	
	goto END_Stealing
	
	Desert_Oasis_Enter_Coordinates_Next:
	Subroutine_Running := "Desert_Oasis_Enter_Coordinates_Next"
	{
		; Mouse_Click(242,526) ; Tap inside X Coordinate Text box
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		; NW_Tower Coordinates X: 595-596 Y: 599-600 (595,599) steal: 439, 681
		; NE_Tower Coordinates X: 599-600 Y: 595-596 (599,595) steal: 441, 681
		; SW_Tower Coordinates X: 599-600 Y: 604-605 (599,604) steal: 447, 678
		; SE_Tower Coordinates X: 604-605 Y: 599-600 (604,599) steal: 440, 680

		; if none selected, auto Steal from:
		; goto NW_Tower
		; goto NE_Tower
		; goto SW_Tower
		goto SE_Tower
		; goto END_Stealing

		MsgBox, 4, , Steal from NW_Tower (595:599)? (8 Second Timeout & skip), 8
		vRet := MsgBoxGetResult()
		if (vRet = "Yes")
			goto NW_Tower

		MsgBox, 4, , Steal from NE_Tower(599:595)? (8 Second Timeout & skip), 8
		vRet := MsgBoxGetResult()
		if (vRet = "Yes")
			goto NE_Tower

		MsgBox, 4, , Steal from SW_Tower(600:604)? (8 Second Timeout & skip), 8
		vRet := MsgBoxGetResult()
		if (vRet = "Yes")
			goto SE_Tower

		MsgBox, 4, , Steal from SE_Tower(604:599)? (8 Second Timeout & skip), 8
		vRet := MsgBoxGetResult()
		if (vRet = "Yes")
			goto SE_Tower

		; if none selected, auto Steal from:
		; goto NW_Tower
		; goto NE_Tower
		; goto SW_Tower
		goto SE_Tower
		return ; goto END_Stealing

		NW_Tower:
		{
			Desert_Tower_X := "{Raw}595"
			Desert_Tower_Y := "{Raw}599"
			goto Desert_Oasis_Tower
		}

		NE_Tower:
		{
			Desert_Tower_X := "{Raw}599"
			Desert_Tower_Y := "{Raw}595"
			goto Desert_Oasis_Tower
		}

		SW_Tower:
		{
			Desert_Tower_X := "{Raw}599"
			Desert_Tower_Y := "{Raw}604"
			goto Desert_Oasis_Tower
		}

		SE_Tower:
		{
			Desert_Tower_X := "{Raw}604"
			Desert_Tower_Y := "{Raw}599"
			goto Desert_Oasis_Tower
		}

		; if none selected, auto go to
		{
			Desert_Tower_X := "{Raw}599"
			Desert_Tower_Y := "{Raw}595"
			goto Desert_Oasis_Tower
		}

		return ; goto END_Stealing

		Desert_Oasis_Tower:
		Subroutine_Running := "Desert_Oasis_Tower"
		; NW_Tower Coordinates X: 595-596 Y: 599-600 (595,599) steal: 439, 681
		; NE_Tower Coordinates X: 599-600 Y: 595-596 (599,595) steal: 441, 681
		; SW_Tower Coordinates X: 599-600 Y: 604-605 (599,604) steal: 447, 678
		; SE_Tower Coordinates X: 604-605 Y: 599-600 (604,599) steal: 440, 680
		; MsgBox, 4, Coordinates, Are Desert_Tower_X`,Y %Desert_Tower_X% %Desert_Tower_X% Correct? (8 Second Timeout & auto),8

		loop, 2
		{
			Mouse_Click(242,526) ; Tap inside X Coordinate Text box
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Text_To_Screen(Desert_Tower_X)
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Text_To_Screen("{Enter}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		loop, 2
		{
			Mouse_Click(484,530) ; Tap inside Y Coordinate Text box
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Text_To_Screen(Desert_Tower_Y)
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Text_To_Screen("{Enter}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Mouse_Click(340,620) ; Tap Go to Coordinates
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Long+0))
		Mouse_Click(340,680) ; Tap on Holy Tower
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
		Mouse_Click(440,680) ; Tap Holy Tower Steal button
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		Desert_Oasis_Coordinates_Text := ["Steal"]
		OCR_X := 315
		OCR_Y := 1190
		OCR_W := 55
		OCR_H := 30
		loop, 2
		{
			loop, 5
				if Search_Captured_Text_OCR(Desert_Oasis_Coordinates_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
					Goto Desert_Oasis_Stealing_Found
					
			Mouse_Click(590,690) ; Tap Close Steal dialog if open
			if !Enter_Coordinates_From_World()
				return
		}
		return ; goto END_Stealing

		Desert_Oasis_Stealing_Found:

		DllCall("Sleep","UInt",(rand_wait + 5*Delay_Long+0))
		Mouse_Click(340,1200) ; Tap Steal
		DllCall("Sleep","UInt",(rand_wait + 5*Delay_Long+0))
		return ; goto END_Stealing
	}

	END_Stealing:

	if Pause_Script
		MsgBox, 0, Pause, Press OK to resume (No Timeout)

	; Go_Back_Home_Delay_Long := True
	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}


Enter_Coordinates_From_Home()
{
	Subroutine_Running := "Enter_Coordinates_From_Home"
	Mouse_Click(73,1207) ; Tap on World Button
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Long+0))
	
	loop, 2
		if Enter_Coordinates_From_World()
			return 1
	
	Gosub Go_Back_To_Home_Screen
	return 0
}

Enter_Coordinates_From_World()
{
	Subroutine_Running := "Enter_Coordinates_From_World"
	Mouse_Click(337,1000) ; Tap on Enter Coordinates Button
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	
	loop, 2
		if Enter_Coordinates_Open_Check()
			return 1
	
	Gosub Check_Window_Geometry
	return 0
}

Enter_Coordinates_Open_Check()
{
	Subroutine_Running := "Enter_Coordinates_Open_Check"
	Coordinates_Box_Text := ["Enter","coordinates"]
	OCR_X := 237
	OCR_Y := 303
	OCR_W := 220
	OCR_H := 40
	loop, 5
		if Search_Captured_Text_OCR(Coordinates_Box_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			return 1
	return 0
}

Gather_On_Base_RSS:
{
	Subroutine_Running := "Gather_On_Base_RSS"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	Swipe_Up_Left_RSS:
	loop, 5
	{
		Mouse_Drag(560, 900, 50, 600, {EndMovement: F, SwipeTime: 300})
		; Mouse_Drag(480, 786, 143, 50, {EndMovement: F, SwipeTime: 500})
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(405,653) ; Plot # 50
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(396,553) ; Plot # 49
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(397,453) ; Plot # 47
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(350,374) ; Plot # 35
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(330,280) ; Plot # 34
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(239,233) ; Plot # 32
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	; inserts pause
	; Search_Captured_Text := ["Desert"]
	; Capture_Screen_Text := OCR([236, 40, 215, 57], "eng") ; check if
	; If (RegExMatch(Capture_Screen_Text,Search_Captured_Text))
	
	if Search_Captured_Text_OCR(["Desert"], {Timeout: 0}).Found
		Goto END_Gather_Base_RSS

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(305,587) ; Plot # 48
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(292,509) ; Plot # 46
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(250,337) ; Plot # 33
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(160,282) ; Plot # 31
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(137,817) ; Plot # 40
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(36,760) ; Plot # 39 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	loop, 2 {
		Mouse_Click(29,726) ; Plot # 37 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}
	; DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	; inserts pause
	; Search_Captured_Text := ["Desert"]
	; Capture_Screen_Text := OCR([236, 40, 215, 57], "eng") ; check if
	; If (RegExMatch(Capture_Screen_Text,Search_Captured_Text))
	
	if Search_Captured_Text_OCR(["Desert"], {Timeout: 0}).Found
		Goto END_Gather_Base_RSS

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(130,827) ; Plot # 38
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(40,770) ; Plot # 36 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(445,583) ; Plot # 45
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(367,542) ; Plot # 43
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(272,493) ; Plot # 41
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(485,510) ; Plot # 44
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(380,462) ; Plot # 42
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	Swipe_Right_RSS_02:
	Mouse_Drag(147, 854, 330, 649, {EndMovement: T, SwipeTime: 500})
	; Mouse_Drag(147, 854, 373, 649, {EndMovement: T, SwipeTime: 500})
	/*
	{
		Click, 147, 854 Left, Down
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 263, 729, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 269, 726, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 270, 724, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 326, 697, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 346, 680, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 346, 676, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 350, 676, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 350, 674, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 350, 674, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 373, 649, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 373, 649 Left, Up
	}
	*/

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(307,424) ; Plot # 29
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(400,376) ; Plot # 30
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(360,293) ; Plot # 28
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(167,412) ; Plot # 26
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(273,354) ; Plot # 27
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(110,600) ; Plot # 24 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	loop, 2 {
		Mouse_Click(34,540) ; Plot # 22 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(160,680) ; Plot # 25
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(110,644) ; Plot # 23 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	loop, 2 {
		Mouse_Click(74,593) ; Plot # 21 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
	
	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(167,826) ; Plot # 19
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(86,770) ; Plot # 17 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(310,780) ; Plot # 20
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(202,710) ; Plot # 18
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(114,665) ; Plot # 16 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}
	; DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	END_Gather_Base_RSS:
	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Golden_Chest:
{
	Subroutine_Running := "Golden_Chest"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen
	
	if !Activity_Center_Open()
		goto Golden_Chest_END
	/*
	loop, 2
	{
		Mouse_Click(630,530) ; Tap Activity Center
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Medium+0))
		loop, 5
			if Search_Captured_Text_OCR(["Activity Center"], {Timeout: 0}).Found
				goto Golden_Chest_Next
		Gosub Go_Back_To_Home_Screen
	}
	goto Golden_Chest_END
	*/
					
	Golden_Chest_Next:
	Golden_Chest_Text := ["Golden"]
	loop, 3
	{
		; Capture_Screen_Text := OCR([181, 596, 80, 33], "eng") ; Check Activity Center item 01
		if Search_Captured_Text_OCR(Golden_Chest_Text, {Pos: [180, 596], Size: [120, 33], Timeout: 0}).Found
		{
			Mouse_Click(180, 596) ; Tap Activity Center item 01
			goto Golden_Chest_Open_for_free_button
		}
		
		; Capture_Screen_Text := OCR([181, 790, 80, 33], "eng") ; Check Activity Center item 02
		if Search_Captured_Text_OCR(Golden_Chest_Text, {Pos: [180, 790], Size: [120, 33], Timeout: 0}).Found
		{
			Mouse_Click(180, 793) ; Tap Activity Center item 02
			goto Golden_Chest_Open_for_free_button
		}
		
		; Capture_Screen_Text := OCR([181, 985, 80, 33], "eng") ; Check Activity Center item 03
		if Search_Captured_Text_OCR(Golden_Chest_Text, {Pos: [180, 985], Size: [120, 33], Timeout: 0}).Found
		{
			Mouse_Click(180, 989) ; Tap Activity Center item 03
			goto Golden_Chest_Open_for_free_button
		}
		
		; Capture_Screen_Text := OCR([181, 1182, 80, 33], "eng") ; Check Activity Center item 04
		if Search_Captured_Text_OCR(Golden_Chest_Text, {Pos: [180, 1182], Size: [120, 33], Timeout: 0}).Found
		{
			Mouse_Click(180, 1182) ; Tap Activity Center item 04
			goto Golden_Chest_Open_for_free_button
		}
	}
	; MsgBox, 0, Pause, Tap Golden Chest`, Press OK to resume (No Timeout)
	
	Golden_Chest_Open_for_free_button:
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Medium+0))
	loop, 2
	{
		loop, 3
			if Search_Captured_Text_OCR(["Golden Chest"], {Timeout: 0}).Found
				goto Golden_Chest_Finish
				
		; MsgBox, 0, Pause, Tap Golden Chest`, Press OK to resume (No Timeout)
	}
	goto Golden_Chest_END
	
	Golden_Chest_Finish:
	; DllCall("Sleep","UInt",(rand_wait + 4*Delay_Long+0))
	if Pause_Script
		MsgBox, 0, Pause, Press OK to resume (No Timeout)
		
	Golden_Chest_Text := ["free"]
	
	; Capture_Screen_Text := OCR([150, 1182, 40, 30], "eng") ; Check if "Open for free" button
	if Search_Captured_Text_OCR(Golden_Chest_Text, {Pos: [150, 1182], Size: [40, 21], Timeout: 0}).Found
		Mouse_Click(125, 1200) ; Tap "Open for free" button
	DllCall("Sleep","UInt",(rand_wait + 5*Delay_Medium+0))
	loop, 2
		Mouse_Click(320,70) ; Tap top title bar
		; Mouse_Click(585,250) ; Tap outside claim banner
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Mouse_Click(357,495) ; Tap Silver tab
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	
	
	; Capture_Screen_Text := OCR([150, 1182, 85, 30], "eng") ; Check if "Open for free" button
	if Search_Captured_Text_OCR(Golden_Chest_Text, {Pos: [150, 1182], Size: [40, 21], Timeout: 0}).Found
		Mouse_Click(125, 1200) ; Tap "Open for free" button
	DllCall("Sleep","UInt",(rand_wait + 5*Delay_Medium+0))
	loop, 2
		Mouse_Click(320,70) ; Tap top title bar
		; Mouse_Click(585,250) ; Tap outside claim banner
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	
	
	Mouse_Click(633,600) ; Tap rankings
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Mouse_Click(157,367) ; Tap Open box
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Mouse_Click(330,1000) ; Tap Collect Rewards
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Golden_Chest_END:
	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Send_Mail_To_Boss:
{
	Subroutine_Running := "Send_Mail_To_Boss"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; FormatTime, DateString,, yyyy-MM-dd
	; FormatTime, TimeString,, HH:mm
	FormatTime, LogDateTimeString,, yyyy-MM-dd HH:mm:ss
	FormatTime, DayOfWeek,, ddd
	CSVout.WriteLine(LogDateTimeString "," Message_To_The_Boss)
	FormatTime, TimeString_Message, R
	Message_To_The_Boss .= DayOfWeek . ", " . LogDateTimeString

	; MsgBox, before: %Message_To_The_Boss%

	Message_To_The_Boss := RegExReplace(Message_To_The_Boss,"[\r\n ]+"," ")

	; MsgBox, After: %Message_To_The_Boss%

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	Open_Mail:

	Mouse_Click(492,1202) ; Tap mail
	; DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	Search_Captured_Text := ["Mail"]
	loop, 2
	{
		loop, 5
			if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0}).Found
				goto Compose_Message

		Gosub Go_Back_To_Home_Screen
		Mouse_Click(492,1202) ; Tap mail
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	; MsgBox, Capture_Screen_Text: %Capture_Screen_Text%
	Gosub Go_Back_To_Home_Screen
	return

	Compose_Message:
	Mouse_Click(636,55) ; Tap new Message
	DllCall("Sleep","UInt",(rand_wait + 7*Delay_Short+0))
	Mouse_Click(500,173) ; Tap User Name Text Box
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
	Text_To_Screen(Boss_User_name) ; Type user name to send message to
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Mouse_Click(433,327) ; Tap Message text body
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
	Text_To_Screen(Message_To_The_Boss) ; Type Message to user
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	; MsgBox, 0, Pause, Press OK to resume (No Timeout)

	Mouse_Click(352,1174) ; Tap Send button
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Send_Message_In_Chat:
{
	Subroutine_Running := "Send_Message_In_Chat"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(316,1122) ; Tap on Chat Bar
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(33,62) ; Tap back Button
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(229,389) ; Tap on third Chat Room "Hack Root"
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(227,1215) ; Tap in Message Box
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

	Chat_Message = % GetRandom(Chat_Message_List,"`n","`r")

	; MsgBox, SendInput
	; Mouse_Click(227,1215) ; Tap in Message Box
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	; Text_To_Screen(Chat_Message) ; Type message to send
	; Mouse_Click(227,1215) ; Tap in Message Box
	; DllCall("Sleep","UInt",(rand_wait + 5*Delay_Long+0))
	; Mouse_Click(650,1213) ; Tap Send
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	; MsgBox, SendRaw
	Mouse_Click(227,1215) ; Tap in Message Box
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
	SendRaw, %Chat_Message% ; Type message to send
	; Mouse_Click(227,1215) ; Tap in Message Box
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Mouse_Click(650,1213) ; Tap Send
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Get_Inventory:
{
	Subroutine_Running := "Get_Inventory"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(169,40) ; Tap Fuel on upper menu bar

	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Available_Food := OCR([244, 132, 90, 25], "eng") ; capture Available Food number
	Available_Steel := OCR([414, 132, 90, 25], "eng") ; capture Available Steel number
	Available_Alloy := OCR([584, 132, 90, 25], "eng") ; capture Available Alloy number
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

	Mouse_Click(95,140) ; Tap Fuel tab
	DllCall("Sleep","UInt",(rand_wait + 7*Delay_Short+0))
	Inventory_Fuel := OCR([87, 180, 520, 40], "eng") ; capture Reserve Fuel number
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

	Mouse_Click(249,140) ; Tap Food tab
	DllCall("Sleep","UInt",(rand_wait + 7*Delay_Short+0))
	Inventory_Food := OCR([87, 180, 520, 40], "eng") ; capture Reserve Food number
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

	Mouse_Click(442,136) ; Tap Steel tab
	DllCall("Sleep","UInt",(rand_wait + 7*Delay_Short+0))
	Inventory_Steel := OCR([87, 180, 520, 40], "eng") ; capture Reserve Steel number
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

	Mouse_Click(594,140) ; Tap Alloy tab
	DllCall("Sleep","UInt",(rand_wait + 7*Delay_Short+0))
	Inventory_Alloy := OCR([87, 180, 520, 40], "eng") ; capture Reserve Alloy number
	Available_Fuel := OCR([70, 132, 90, 25], "eng") ; capture Available Fuel number
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

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

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Get_User_Info:
{
	Subroutine_Running := "Get_User_Info"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(47,80) ; Tap commander info on upper menu bar

	; capture text from commander info screen
	DllCall("Sleep","UInt",(rand_wait + 7*Delay_Short+0))
	User_Name_Captured := OCR([196, 183, 270, 30], "eng")
	User_State_Alliance := OCR([292, 145, 222, 32], "eng")
	User_VIP := OCR([183, 139, 116, 44], "eng")
	User_Power := OCR([497, 362, 122, 27], "eng")

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

	Gosub Go_Back_To_Home_Screen

	; User_Diamonds := OCR([590, 90, 96, 30], "eng")
	User_Diamonds := OCR([590, 95, 90, 20], "eng")
	User_Diamonds := % Convert_OCR_Value(User_Diamonds)

	Message_To_The_Boss .= User_Name_Captured
	. "`,Alliance:`," . User_Found_Alliance
	. "`,State:`," . User_Found_State
	. "`,VIP:`," . User_VIP
	. "`,Power:`," . User_Power . "`,"
	. "`,Diamonds:`," . User_Diamonds . "`,"

	/*
	Message_To_The_Boss .= User_Name_Captured
	. ",Alliance:," . User_Found_Alliance
	. ",State:," . User_Found_State
	. ",VIP:," . User_VIP
	. ",Power:," . User_Power . ","
	*/

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Get_User_Location:
{
	Subroutine_Running := "Get_User_Location"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(76,1200) ; Tap World/home button
	DllCall("Sleep","UInt",(rand_wait + 5*Delay_Long+0))

	Mouse_Click(347,600) ; Tap My City on World Map
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
	User_City_Location := OCR([300, 664, 120, 43], "eng")
	; User_City_Location := Trim(User_City_Location)
	User_City_Location := % RegExMatch(User_City_Location,"X:\d+[^\d]*Y:\d+[^\d]*", User_City_Location_XY)
	User_City_Location_XY := % RegExReplace(User_City_Location_XY,"[^0-9,]+")
	User_City_Location_XY := StrReplace(User_City_Location_XY, ",", ":")

	; MsgBox, % "User_City_Location: " . User_City_Location . " User_City_Location_XY: " . User_City_Location_XY

	Message_To_The_Boss .= "Location:`,""(" . User_City_Location_XY . ")""`,"

	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	; User_City_Location := OCR([304, 663, 85, 22], "eng")
	; User_City_Location_Array := StrSplit(User_City_Location, "`,","XY: ") ; Omits X, Y, : and space.

	; MsgBox, % "1. before split X`,Y:" User_City_Location " 2. after split X:Y" User_City_Location_Array[1] ":" User_City_Location_Array[2]
	; Message_To_The_Boss .= "Location:`,""" . User_City_Location_Array[1] . ":" . User_City_Location_Array[2] . """`,"

	; Go_Back_Home_Delay_Long := True
	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Base_Search_World_Map:
{
	Subroutine_Running := "Base_Search_World_Map"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
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

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
		return
	}

	Enter_Search_Coordinates:
	{
		; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
		Mouse_Click(220,1000) ; Tap Map Coordinate button
		; Mouse_Click(189,870); Tap Map Coordinate button
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

		Mouse_Click(200,530) ; Tap inside X coordinate Box
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
		Text_To_Screen(Map_X)
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
		Text_To_Screen("{Enter}")
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
		Mouse_Click(449,530) ; Tap inside Y coordinate Box
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
		Text_To_Screen(Map_Y)
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
		Text_To_Screen("{Enter}")
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
		; Mouse_Click(196,467) ; Tap Go To Coordinates1
		Mouse_Click(350,620) ; Tap Go To Coordinates2
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))

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
			Mouse_Click(Px,Py) ; Tap to shrink activity bar
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		}
		return
	}

	Swipe_LL_To_UR:
		Mouse_Drag(112, 897, 497, 703, {EndMovement: F, SwipeTime: 500})
	/*
	{
		SendEvent {Click 112, 897, Down}
		SendEvent {Click 169, 870, 0}
		SendEvent {Click 183, 860, 0}
		SendEvent {Click 212, 847, 0}
		SendEvent {Click 280, 813, 0}
		SendEvent {Click 375, 764, 0}
		SendEvent {Click 445, 730, 0}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		SendEvent {Click 497, 703, 0}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		SendEvent {Click 497, 703, 0}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		SendEvent {Click 497, 703, Up}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		SendEvent {Click 497, 703, 0}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		SendEvent {Click 497, 703, 0}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		SendEvent {Click 497, 703, 0}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		SendEvent {Click 497, 703, 0}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		SendEvent {Click 497, 703, 0}
	}
		*/

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
				stdout.WriteLine(A_Now "A " Base_Picture " was found at X"FoundPictureX " Y" FoundPictureY )
				Mouse_Click(FoundPictureX,FoundPictureY) ; Tap Found Base
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
				MsgBox, 1 ErrorLevel: %ErrorLevel% - A %Base_Picture% found at X%FoundPictureX% Y%FoundPictureY%.
			}

			; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			ImageSearch, FoundPictureX, FoundPictureY, %PixelSearch_UpperX2%, %PixelSearch_UpperY2%, %PixelSearch_LowerX2%, %PixelSearch_LowerY2%, *145 *Trans0xF0F0F0 %Base_Picture%
			if !ErrorLevel ; (ErrorLevel = 0)
			{
				stdout.WriteLine(A_Now "A " Base_Picture " was found at X"FoundPictureX " Y" FoundPictureY )
				Mouse_Click(FoundPictureX,FoundPictureY) ; Tap Found Base
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
				MsgBox, 2 ErrorLevel: %ErrorLevel% - A %Base_Picture% found at X%FoundPictureX% Y%FoundPictureY%.
			}

			; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			ImageSearch, FoundPictureX, FoundPictureY, %PixelSearch_UpperX1%, %PixelSearch_UpperY1%, %PixelSearch_LowerX1%, %PixelSearch_LowerY1%, *145 *Trans0xFFFFFF %Base_Picture%
			if !ErrorLevel ; (ErrorLevel = 0)
			{
				stdout.WriteLine(A_Now "A " Base_Picture " was found at X"FoundPictureX " Y" FoundPictureY )
				Mouse_Click(FoundPictureX,FoundPictureY) ; Tap Found Base
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
				MsgBox, 3 ErrorLevel: %ErrorLevel% - A %Base_Picture% found at X%FoundPictureX% Y%FoundPictureY%.
			}

			; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			ImageSearch, FoundPictureX, FoundPictureY, %PixelSearch_UpperX2%, %PixelSearch_UpperY2%, %PixelSearch_LowerX2%, %PixelSearch_LowerY2%, *145 *Trans0xFFFFFF %Base_Picture%
			if !ErrorLevel ; (ErrorLevel = 0)
			{
				stdout.WriteLine(A_Now "A " Base_Picture " was found at X"FoundPictureX " Y" FoundPictureY )
				Mouse_Click(FoundPictureX,FoundPictureY) ; Tap Found Base
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
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

				Mouse_Click(Px,Py) ; Tap on potential city
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

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

				stdout.WriteLine(A_Now "Found_City_Info1," Found_City_Info1 " Found_City_Info2," Found_City_Info2 ",Found_City_Name," Found_City_Name ",Found_City_Location," Found_City_Location ",")

				if (Found_City_Location = "") ; if location blank, skip
					goto Next_Coord_Search
				if (Found_City_Location = Last_City_Loc_Found) ; if location same as before, skip
					goto Next_Coord_Search

				MsgBox, ErrorLevel: %ErrorLevel% - A %Base_Level% color within %PixelSearch_Variation% shades of %Base_Color%, pixel:%Px%,%Py% and coords (%Found_City_Location%) Found_City_Name2: %Found_City_Name2% 1: "%Found_City_Info1%" 2: "%Found_City_Info2%"

				Last_City_Info_Found := Found_City_Info2
				Last_City_Name_Found := Found_City_Name2
				Last_City_Loc_Found := Found_City_Location

				stdout.WriteLine(A_Now "Found_City_Info," Found_City_Info ",Found_City_Name," Found_City_Name ",Found_City_Location," Found_City_Location ",")

				Next_Coord_Search:
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
	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

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
		; MsgBox, No Zombie or Rover return 0
		return 0
	}
	else
	{
		Mouse_Click(550,1037) ; Tap next to speaker
		; Text_To_Screen("{Esc}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		; MsgBox, Zombie or Rover return 1
		return 1
	}

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Elivate_program:
{
	Subroutine_Running := "Elivate_program"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; ([Subroutine_Running,A_ThisLabel])

	; stdout.WriteLine(A_Now " Elivate_program, " image_name " Main_Loop_Counter: " Main_Loop_Counter " Restart_Loops: " Restart_Loops " Reset_App_Yes: " Reset_App_Yes)

	; PERC := Chr(37)
	; wmic process where "Name like '%PERC%MEmu%PERC%' OR Name like '%PERC%MEmu%PERC%'" CALL setpriority "above normal"
	; wmic process where "Name like '`%MEmu`%' OR Name like '`%MEmu`%'" CALL setpriority "above normal"
	; wmic process where "Name like '`%MEmu`%' OR Name like '`%MEmu`%'" CALL setpriority 128
	commands=
	(join&
	wmic process where "Name like '`%MEmu`%' OR Name like '`%MEmu`%'" CALL setpriority 128
	)
	; runwait, %comspec% /c %commands%

	; stdout.WriteLine(A_Now ", commands, " commands ", result: ," RunWaitOne(commands))
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
			FileAppend, "%A_NOW%"`,"Function"`,"%Function%"`,"WinWait cmdTitle"`,"%cmdTitle%"`n, %AppendCSVFile%
			;break
		}
		if WinExist("ahk_class " . cmdClass) ; ahk_class ConsoleWindowClass ; if !ErrorLevel
		{
			WinWait, ahk_class %cmdClass%, , 0
			WinMinimize ; Minimize the window found by WinWait.
			DllCall("Sleep","UInt",(rand_wait + 3*Delay_Long+0))
			WinRestore
			; MsgBox, WinWait "ahk_class " %cmdClass% ; ahk_class ConsoleWindowClass
			FileAppend, "%A_NOW%"`,"Function"`,"%Function%"`,"WinWait cmdClass"`,"%cmdClass%"`n, %AppendCSVFile%
			;break
		}
		if WinExist("ahk_exe " . cmdEXE) ; ahk_exe AutoHotkey.exe ; if !ErrorLevel
		{
			WinWait, ahk_exe %cmdEXE%, , 0
			WinMinimize ; Minimize the window found by WinWait.
			DllCall("Sleep","UInt",(rand_wait + 3*Delay_Long+0))
			WinRestore
			; MsgBox, WinWait "ahk_exe " %cmdEXE% ; ahk_exe AutoHotkey.exe
			FileAppend, "%A_NOW%"`,"Function"`,"%Function%"`,"WinWait cmdEXE"`,"%cmdEXE%"`n, %AppendCSVFile%
			;break
		}
		if WinExist("ahk_id " . cmdID) ; ahk_id 0x64f14dc ; if !ErrorLevel
		{
			WinWait, ahk_id %cmdID%, , 0
			WinMinimize ; Minimize the window found by WinWait.
			DllCall("Sleep","UInt",(rand_wait + 3*Delay_Long+0))
			WinRestore
			; MsgBox, WinWait "ahk_id " %cmdID% ; ahk_id 0x64f14dc
			FileAppend, "%A_NOW%"`,"Function"`,"%Function%"`,"WinWait cmdID"`,"%cmdID%"`n, %AppendCSVFile%
			;break
		}
		if WinExist("ahk_pid " . cmdPID) ; ahk_pid 16120 ; if !ErrorLevel
		{
			WinWait, ahk_pid %cmdPID%, , 0
			WinMinimize ; Minimize the window found by WinWait.
			DllCall("Sleep","UInt",(rand_wait + 3*Delay_Long+0))
			WinRestore
			; MsgBox, WinWait "ahk_pid " %cmdPID% ; ahk_pid 16120
			FileAppend, "%A_NOW%"`,"Function"`,"%Function%"`,"WinWait cmdPID"`,"%cmdPID%"`n, %AppendCSVFile%
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

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Get_Window_Geometry:
{
	Subroutine_Running := "Get_Window_Geometry"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; if !WinActive(FoundAppTitle), WinActivate, %FoundAppTitle%

	stdout.WriteLine(A_Now " Get_Window_Geometry, " image_name " Main_Loop_Counter: " Main_Loop_Counter " Restart_Loops: " Restart_Loops " Reset_App_Yes: " Reset_App_Yes)

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
	stdout.WriteLine(A_Now "Sub:""" Subroutine_Running """ Found App info: (X1:" FoundAppX ",Y1:" FoundAppY ",X2:" LowerX ",Y2:" LowerY ") Dimensions:" FoundAppWidth "x" FoundAppHeight " Title:" FoundAppTitle)
	stdout.WriteLine(A_Now " Calculated UpperX,UpperY " UpperX ", " UpperY " and LowerX, LowerY " LowerX ", " LowerY)

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

; collapse sidebar menu and Reposition window
Check_Window_Geometry:
{
	Subroutine_Running := "Check_Window_Geometry"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; stdout.WriteLine(A_Now " Check_Window_Geometry, " image_name " Main_Loop_Counter: " Main_Loop_Counter " Restart_Loops: " Restart_Loops " Reset_App_Yes: " Reset_App_Yes)
	; if !WinActive(FoundAppTitle), WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; stdout.WriteLine(A_Now " Inside Check_Window_Geometry, image_name: " image_name)

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
	stdout.WriteLine(A_Now "Sub:" Subroutine_Running " Found App info: (X1:" FoundAppX ",Y1:" FoundAppY ",X2:" LowerX ",Y2:" LowerY ") Dimensions:" FoundAppWidth "x" FoundAppHeight " Title:" FoundAppTitle)

	if FoundAppX = App_Win_X
		if FoundAppY = App_Win_Y
			if FoundAppWidth = App_WinWidth
				if FoundAppHeight = App_WinHeight
					return

	; Changes the position and/or size of the specified window.
	; WinMove, X, Y
	; WinMove, FoundAppTitle, WinText, X, Y [, Width, Height, ExcludeTitle, ExcludeText]
	if FoundAppTitle contains MEmu
		WinMove, %FoundAppTitle%, , App_Win_X, App_Win_Y, MEmu_WinWidth, MEmu_WinHeight ; Move the window to the top left corner.
	else
		WinMove, %FoundAppTitle%, , App_Win_X, App_Win_Y, App_WinWidth, App_WinHeight ; Move the window to the top left corner.
	; MsgBox, %FoundAppTitle% Upper: %FoundAppX%, %FoundAppY% %FoundAppWidth%x%FoundAppHeight% Lower: %LowerX%, %LowerY%

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
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
				Mouse_Click(339,14) ; Tap MEmu App header
				DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

				; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
				Mouse_Click(709,384) ; Tap to expand More menu
				DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

				; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
				Mouse_Click(630,382) ; Tap Operations Recorder
				DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
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

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

; Tap in the middle of the screen
Click_Middle_Screen:
{
	Subroutine_Running := "Click_Middle_Screen"
	Mouse_Click((LowerX-UpperX)/2+UpperX,(LowerY-UpperY)/2+(UpperY-100)) ; Tap in the middle of the screen
}

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

F1::
Gui, Show, W400 H40, Window List
return

F6::
Reload_Script:
{
	Subroutine_Running := "Reload_Script"

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

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

F7::
	Resetting_Posit := True
	Key_Menu()
	Gosub Reset_Posit
	Resetting_Posit := False
	Key_Menu()
return

Check_AppWindows_Timer:
	; Gosub Get_Window_Geometry
	Gosub Check_Window_Geometry
	Key_Menu()
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
return

; Esc::ExitApp

; original Pause statement
; Pause::Pause ; Pressing pause once will pause the script. Pressing it again will unpause.

Pause:: ; Pressing pause once will pause the script. Pressing it again will unpause.
Pause,,1	; read the documentation on Pause to understand the consequences of this 1. It seems to matter where this hotkey is in the script.
Key_Menu()
; if !WinActive(FoundAppTitle), WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
Return

F3::
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Drag Slide Right to select all
	; Mouse_Drag(125, 687, 415, 703, {EndMovement: F, SwipeTime: 500}) ; original
	; Mouse_Click(382,774) ; Tap Use ; original

	Mouse_Drag(115, 680, 360, 680, {EndMovement: F, SwipeTime: 500}) ; Client start: 115, 680, end: 360, 680
	Mouse_Click(380,786) ; Tap Use ; 340, 786

	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
Return

F9::
Gosub Go_Back_To_Home_Screen
Gosub, Exit_Sub
MsgBox, This MsgBox will never happen because of the EXIT.
return

Exit_Sub:
Exit ; Terminate this subroutine as well as the calling subroutine.

F4::ExitApp
; #c:: OCR()
#g:: Vis2.OCR.google() ; Googles the text instead of saving it to clipboard.
#i:: ImageIdentify()
=======
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
ListLines On	; Includes subsequently-executed lines in the history. This is the starting default for all scripts.
Process, Priority, , H
SetBatchLines, -1
SetKeyDelay, -1, 20 ; -1 ; default
SetMouseDelay, -1 ; -1 ; default
SetDefaultMouseSpeed, 3 ; 0 ; Move the mouse SPEED.
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
; #include lib\WindowListMenu_mod_004.ahk
; #include lib\LEZ_Functions.ahk
; #include lib\LEZ_Functions_1057_mod_002.ahk
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
		; stdout.WriteLine(A_Now " Main_loop, " image_name " Main_Loop_Counter: " Main_Loop_Counter " Restart_Loops: " Restart_Loops " Reset_App_Yes: " Reset_App_Yes)
		; if !WinActive(FoundAppTitle), WinActivate, %FoundAppTitle% ; WinActivate ; Automatically uses the window found above.

		; MouseMove UpperX+(WinWidth/2), UpperY+(WinHeight/2)

		Random, rand_wait, %rand_min%, %rand_max%
		Key_Menu()
		; Process_Menu()

		; Switch User
		For User,Val in User_Logins
		{
			; Gosub Get_Window_Geometry
			Gosub Check_Window_Geometry
			; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			
			; ([FoundAppTitle,FoundAppClass,FoundAppControl,FoundAppProcess])

			global User_Name := User
			global User_Email := Val[1]
			global User_Pass := Val[2]
			global User_PIN := Val[3]

			Output := "User: " User " has: "
			Output .= "Email: " Val[1] " "
			; Output .= "Password: " Val[2] " "
			; Output .= "PIN: " Val[3]
			MsgBox, 3, , Login to %Output% ? (10 second Timeout & auto),10
			vRet := MsgBoxGetResult()
			if (vRet = "Yes") || if (vRet = "Timeout")
				Gosub Switch_Account
			else if (vRet = "No")
				goto END_of_user_loop

			; loop, 2
				Gosub Go_Back_To_Home_Screen
			
			; ***************************************
			; Main DEBUG and event Variables - START
			; ***************************************
			Pause_Script := False
			CSB_Event := False ; True ; True if CSB Event is going on
			Desert_Event := True ; False ; True ; True if Desert Event is going on
			; if CSB_Event ; || if Desert_Event
			At_War := False
			; ***************************************
			; Main DEBUG and event Variables - END
			; ***************************************

			; MsgBox, 4, , Enable Pause? (8 Second Timeout & skip), 8
			; vRet := MsgBoxGetResult()
			; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
			; Pause_Script := True

			; if Pause_Script
			; MsgBox, 0, Pause, Press OK to resume (No Timeout)

			; goto Special_Routine
			; goto New_Day_Game_Reset
			; goto Fast_Routine
			; goto End_Of_Day_Routine
			; goto FULL_Q_and_A_Routine
			; goto END_of_user_loop

			; if (A_Now >= startTime && A_Now <= endTime)

			/*
			if (A_Hour >= 12 && A_Hour < 19)
				goto End_Of_Day_Routine
			else if (A_Hour >= 19 || A_Hour <= 05)
				goto New_Day_Game_Reset
			else
				goto Fast_Routine
			*/

			FormatTime, today,, dddd
			if (today = "Thursday" && A_Hour >= 19)
				Peace_Shield_Needed := True
			if (today = "Friday" || today = "Saturday")
				Peace_Shield_Needed := True
			if (today = "Sunday" && A_Hour <= 19)
				Peace_Shield_Needed := True
			if At_War
				Peace_Shield_Needed := True

			if (A_Hour >= 12 && A_Hour < 19)
				Routine := "End_Of_Day"
			else if (A_Hour >= 19 || A_Hour <= 05)
				Routine := "New_Day"
			else
				Routine := "Fast"

			; if (Routine = "New_Day") ; || if (Routine = "Fast") ; || if (Routine = "End_Of_Day")

			Routine_Set_Routine:
			{
				Routine_Running := Routine
				; MsgBox, Hour: %A_Hour% %Routine%
				; for testing routines
				; MsgBox, 0, Pause, Press OK to start (No Timeout)
				; Gosub Benefits_Center
				; Message_To_The_Boss := User_Name . " " . Routine . " Routine`,"
				; Gosub Benefits_Center
				; Gosub Mail_Collection
				; Gosub Desert_Oasis
				; Gosub Donate_Tech
				; Gosub Activity_Center_Wonder
				; Gosub BruteForcePIN
				; Gosub Speaker_Help
				; Gosub Golden_Chest
				; Gosub Depot_Rewards
				; Gosub Speaker_Help
				; MsgBox, 0, Pause, Press OK to end (No Timeout)
				; goto END_of_user_loop

				; Gosub Game_Start_popups
				; Gosub Shield_Warrior_Trial_etc
				if Peace_Shield_Needed
					Gosub Peace_Shield
				; Gosub Reset_Posit

				; ** Position dependant **
				Gosub Collect_Collisions
				Gosub Collect_Recruits
				Gosub Collect_Equipment_Crafting
				Gosub Collect_Runes
				Gosub Collect_Cafeteria
				; ******************************************
				; Gosub Speaker_Help
				; Gosub Active_Skill
				; Gosub Desert_Oasis
				; Gosub Mail_Collection
				; Gosub Speaker_Help
				; ; Activity_Center_Open()
				; MsgBox, 0, Pause, Press OK to end (No Timeout)
				; Gosub Go_Back_To_Home_Screen
				; Gosub Speaker_Help
				; goto END_of_user_loop
				; ******************************************
				
				Gosub Depot_Rewards
				; if (Routine = "New_Day") || if (Routine = "End_Of_Day")
				; Gosub Golden_Chest
				Gosub Speaker_Help
				if (Routine = "New_Day") || if (Routine = "End_Of_Day")
					Gosub Drop_Zone

				; ** Not position dependant **
				if CSB_Event ; || if Desert_Event
					if !(A_Hour = 19 && A_Min <= 30)
						Gosub Reserve_Factory
				Gosub Active_Skill				
				Gosub Donate_tech
				Gosub Speaker_Help
				
				if (Routine = "New_Day") || if (Routine = "End_Of_Day")
				{
					Gosub VIP_Shop
					Gosub Benefits_Center
					Gosub Speaker_Help
					Gosub Alliance_Boss_Regular
					Gosub Alliance_Boss_Oasis
					Gosub Mail_Collection
					Gosub Alliance_Wages
				}
				if !Desert_Event
					Gosub Gather_On_Base_RSS

				if Desert_Event
				{
					Gosub Desert_Oasis
					Gosub Activity_Center_Wonder
				}
				; Gosub Gather_Resources
				Gosub Speaker_Help
				; Gosub Collect_Red_Envelopes

				Message_To_The_Boss := User_Name . " " . Routine . " Routine,"
				if (Routine = "New_Day") || if (Routine = "End_Of_Day")
					Gosub Get_User_Location
				Gosub Get_User_Info
				if (Routine = "New_Day") || if (Routine = "End_Of_Day")
					Gosub Get_Inventory
				Gosub Send_Mail_To_Boss
				; Gosub Send_Message_In_Chat

				; MsgBox, 4, , Pause before switching accounts? (4 Second Timeout & skip), 4
				; vRet := MsgBoxGetResult()
				; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
				; MsgBox, 0, Pause, Press OK to resume (No Timeout)

				goto END_of_user_loop
			}

			Special_Routine:
			{
				Routine_Running := "Special_Routine"
				; for testing routines
				; MsgBox, 0, Pause, Press OK to begin (No Timeout)
				; Gosub Active_Skill
				; Gosub Alliance_Boss_Oasis
				; Gosub Alliance_Boss_Regular
				; Gosub Alliance_Wages
				; Gosub Benefits_Center
				; Gosub Get_Window_Geometry
				; Gosub Check_Window_Geometry
				; Gosub Collect_Red_Envelopes

				; Gosub Game_Start_popups
				; Gosub Collect_Cafeteria
				; Gosub Collect_Collisions
				; Gosub Collect_Equipment_Crafting
				; Gosub Collect_Runes
				; Gosub Collect_Recruits
				; Gosub Depot_Rewards
				; Gosub Speaker_Help
				; Gosub Drop_Zone

				; Gosub Desert_Oasis
				; Gosub Donate_Tech
				; Gosub Elivate_program
				; Gosub Enter_Login_Password_PIN
				; Gosub Gather_On_Base_RSS
				; Gosub Gather_Resources
				; Gosub Get_Inventory
				; Gosub Get_User_Info
				; Gosub Get_User_Location
				; Gosub Go_Back_To_Home_Screen
				; Gosub Quit_LEWZ
				; Gosub Launch_Lewz
				; Gosub Mail_Collection
				; Gosub Refresh_LogFiles
				; Gosub Reserve_Factory
				; Gosub Reset_Posit
				; Gosub Send_Mail_To_Boss
				; Gosub Send_Message_In_Chat
				; Gosub Switch_Account
				; Gosub VIP_Shop
				; MsgBox, 0, Pause, Press OK to end (No Timeout)

				; Gosub Game_Start_popups
				; Gosub Shield_Warrior_Trial_etc
				; Gosub Reset_Posit
				; Gosub Peace_Shield

				; ** Position dependant **
				Gosub Collect_Collisions
				Gosub Collect_Recruits
				Gosub Collect_Equipment_Crafting
				Gosub Collect_Runes
				Gosub Depot_Rewards
				Gosub Collect_Cafeteria
				Gosub Speaker_Help
				Gosub Drop_Zone
				; Gosub Golden_Chest

				; ** Not position dependant **
				Gosub Active_Skill
				Gosub VIP_Shop
				Gosub Benefits_Center
				Gosub Alliance_Boss_Regular
				Gosub Alliance_Boss_Oasis
				Gosub Donate_tech
				Gosub Mail_Collection
				Gosub Alliance_Wages

				if CSB_Event ; || if Desert_Event
					Gosub Reserve_Factory
				if Desert_Event
					Gosub Desert_Oasis
				; Gosub Gather_Resources
				; Gosub Gather_On_Base_RSS
				Gosub Speaker_Help
				; Gosub Collect_Red_Envelopes

				; Message_To_The_Boss := User_Name . " Special Routine,"
				; Gosub Get_User_Location
				; Gosub Get_User_Info
				; Gosub Get_Inventory
				; Gosub Send_Mail_To_Boss
				; Gosub Send_Message_In_Chat

				; MsgBox, 4, , Pause before switching accounts? (4 Second Timeout & skip), 4
				; vRet := MsgBoxGetResult()
				; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
				MsgBox, 0, Pause, Press OK to resume (No Timeout)

				goto END_of_user_loop
			}

			New_Day_Game_Reset:
			{
				Routine_Running := "New_Day_Game_Reset"
				; MsgBox, Hour: %A_Hour% New_Day_Game_Reset
				; for testing routines
				; MsgBox, 0, Pause, Press OK to start (No Timeout)
				; Gosub Donate_Tech
				; MsgBox, 0, Pause, Press OK to end (No Timeout)

				; Gosub Game_Start_popups
				; Gosub Shield_Warrior_Trial_etc
				; Gosub Peace_Shield
				; Gosub Reset_Posit

				; ** Position dependant **
				Gosub Collect_Collisions
				Gosub Collect_Recruits
				Gosub Collect_Equipment_Crafting
				Gosub Collect_Runes
				Gosub Depot_Rewards
				Gosub Collect_Cafeteria
				Gosub Speaker_Help
				Gosub Drop_Zone
				; Gosub Golden_Chest

				; ** Not position dependant **
				Gosub Active_Skill
				Gosub VIP_Shop
				Gosub Benefits_Center
				Gosub Alliance_Boss_Regular
				Gosub Alliance_Boss_Oasis
				Gosub Donate_tech
				; Gosub Mail_Collection
				; Gosub Alliance_Wages

				if CSB_Event ; || if Desert_Event
					Gosub Reserve_Factory
				if Desert_Event
					Gosub Desert_Oasis
				; Gosub Gather_Resources
				; Gosub Gather_On_Base_RSS
				Gosub Speaker_Help
				; Gosub Collect_Red_Envelopes

				Message_To_The_Boss := User_Name . " New Day Routine,"
				Gosub Get_User_Location
				Gosub Get_User_Info
				Gosub Get_Inventory
				Gosub Send_Mail_To_Boss
				; Gosub Send_Message_In_Chat

				; MsgBox, 4, , Pause before switching accounts? (4 Second Timeout & skip), 4
				; vRet := MsgBoxGetResult()
				; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
				; MsgBox, 0, Pause, Press OK to resume (No Timeout)

				goto END_of_user_loop
			}

			Fast_Routine:
			{
				Routine_Running := "Fast_Routine"
				; MsgBox, Hour: %A_Hour% Fast_Routine
				; for testing routines
				; MsgBox, 0, Pause, Press OK to start (No Timeout)
				; Gosub Mail_Collection
				; MsgBox, 0, Pause, Press OK to resume (No Timeout)

				; Gosub Game_Start_popups
				; Gosub Shield_Warrior_Trial_etc
				; Gosub Peace_Shield
				; Gosub Reset_Posit

				; ** Position dependant **
				Gosub Collect_Collisions
				Gosub Collect_Recruits
				Gosub Collect_Equipment_Crafting
				Gosub Collect_Runes
				; Gosub Depot_Rewards
				Gosub Collect_Cafeteria
				Gosub Speaker_Help
				; Gosub Drop_Zone
				; Gosub Golden_Chest

				; ** Not position dependant **
				Gosub Active_Skill
				; Gosub VIP_Shop
				; Gosub Benefits_Center
				; Gosub Alliance_Boss_Regular
				; Gosub Alliance_Boss_Oasis
				; Gosub Donate_tech
				; Gosub Mail_Collection
				; Gosub Alliance_Wages

				if CSB_Event ; || if Desert_Event
					Gosub Reserve_Factory
				if Desert_Event
					Gosub Desert_Oasis
				; Gosub Gather_Resources
				; Gosub Gather_On_Base_RSS
				Gosub Speaker_Help
				; Gosub Collect_Red_Envelopes

				Message_To_The_Boss := User_Name . " Fast Routine,"
				; Gosub Get_User_Location
				Gosub Get_User_Info
				; Gosub Get_Inventory
				Gosub Send_Mail_To_Boss
				; Gosub Send_Message_In_Chat

				; MsgBox, 4, , Pause before switching accounts? (4 Second Timeout & skip), 4
				; vRet := MsgBoxGetResult()
				; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
				; MsgBox, 0, Pause, Press OK to end (No Timeout)

				goto END_of_user_loop
			}

			End_Of_Day_Routine:
			{
				Routine_Running := "End_Of_Day_Routine"
				; MsgBox, Hour: %A_Hour% End_Of_Day_Routine
				; for testing routines
				; MsgBox, 0, Pause, Press OK to start (No Timeout)
				; Gosub Mail_Collection
				; MsgBox, 0, Pause, Press OK to resume (No Timeout)

				; Gosub Game_Start_popups
				; Gosub Shield_Warrior_Trial_etc
				; Gosub Peace_Shield
				; Gosub Reset_Posit

				; ** Position dependant **
				Gosub Collect_Collisions
				Gosub Collect_Recruits
				Gosub Collect_Equipment_Crafting
				Gosub Collect_Runes
				Gosub Depot_Rewards
				Gosub Collect_Cafeteria
				Gosub Speaker_Help
				; Gosub Drop_Zone
				; Gosub Golden_Chest

				; ** Not position dependant **
				Gosub Active_Skill
				; Gosub VIP_Shop
				Gosub Benefits_Center
				; Gosub Alliance_Boss_Regular
				; Gosub Alliance_Boss_Oasis
				Gosub Donate_tech
				Gosub Mail_Collection
				Gosub Alliance_Wages

				if CSB_Event ; || if Desert_Event
					Gosub Reserve_Factory
				if Desert_Event
					Gosub Desert_Oasis
				; Gosub Gather_Resources
				; Gosub Gather_On_Base_RSS
				Gosub Speaker_Help
				; Gosub Collect_Red_Envelopes

				Message_To_The_Boss := User_Name . " End Of Day Routine,"
				Gosub Get_User_Location
				Gosub Get_User_Info
				Gosub Get_Inventory
				Gosub Send_Mail_To_Boss
				; Gosub Send_Message_In_Chat

				; MsgBox, 4, , Pause before switching accounts? (4 Second Timeout & skip), 4
				; vRet := MsgBoxGetResult()
				; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
				; MsgBox, 0, Pause, Press OK to end (No Timeout)

				goto END_of_user_loop
			}

			FULL_Q_and_A_Routine:
			{
				Routine_Running := "FULL_Q_and_A_Routine"
				; for testing and special routines
				; MsgBox, 0, Pause, Press OK to resume (No Timeout)

				MsgBox, 4, , Elivate_program (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Elivate_program

				MsgBox, 4, , Get_Window_Geometry (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Get_Window_Geometry

				MsgBox, 4, , Check_Window_Geometry (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Check_Window_Geometry

				MsgBox, 4, , Quit_LEWZ (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Quit_LEWZ

				MsgBox, 4, , Launch_Lewz (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Launch_Lewz

				MsgBox, 4, , Refresh_LogFiles (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Refresh_LogFiles

				MsgBox, 4, , Reset_Posit (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Reset_Posit

				MsgBox, 4, , Switch_Account (8 Second Timeout & skip), 8,
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Switch_Account

				MsgBox, 4, , Game_Start_popups (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Game_Start_popups

				MsgBox, 4, , Shield_Warrior_Trial_etc (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Shield_Warrior_Trial_etc

				MsgBox, 4, , Peace_Shield (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Peace_Shield

				MsgBox, 4, , Reset_Posit (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
				Gosub Reset_Posit
					MsgBox, 0, Pause, Press OK to resume (No Timeout)

				; ************************
				; ** Position dependant **
				; ************************
				MsgBox, 4, , Collect_Cafeteria (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Collect_Cafeteria

				MsgBox, 4, , Collect_Collisions (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Collect_Collisions

				MsgBox, 4, , Collect_Recruits (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Collect_Recruits

				MsgBox, 4, , Collect_Equipment_Crafting (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Collect_Equipment_Crafting

				MsgBox, 4, , Depot_Rewards (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Depot_Rewards

				MsgBox, 4, , Speaker_Help (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Speaker_Help

				MsgBox, 4, , Drop_Zone (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Drop_Zone

				MsgBox, 4, , Golden_Chest (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Golden_Chest

				; ****************************
				; ** Not position dependant **
				; ****************************
				MsgBox, 4, , Benefits_Center (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Benefits_Center

				MsgBox, 4, , Alliance_Boss_Oasis (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Alliance_Boss_Oasis

				MsgBox, 4, , Alliance_Boss_Regular (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Alliance_Boss_Regular

				MsgBox, 4, , Active_Skill (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Active_Skill

				MsgBox, 4, , Alliance_Wages (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Alliance_Wages

				MsgBox, 4, , Donate_Tech (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Donate_Tech

				MsgBox, 4, , Collect_Red_Envelopes (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Collect_Red_Envelopes

				; *************************************
				; ** Gathering and steeling routines **
				; *************************************
				MsgBox, 4, , Desert_Oasis (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Desert_Oasis

				MsgBox, 4, , Gather_On_Base_RSS (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Gather_On_Base_RSS

				MsgBox, 4, , Gather_Resources (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Gather_Resources

				MsgBox, 4, , Get_Inventory (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Get_Inventory

				MsgBox, 4, , Get_User_Info (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Get_User_Info

				MsgBox, 4, , Get_User_Location (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Get_User_Location

				MsgBox, 4, , Mail_Collection (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Mail_Collection

				MsgBox, 4, , Reserve_Factory (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Reserve_Factory

				MsgBox, 4, , Send_Mail_To_Boss (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Send_Mail_To_Boss

				MsgBox, 4, , Send_Message_In_Chat (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub Send_Message_In_Chat

				MsgBox, 4, , VIP_Shop (8 Second Timeout & skip), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout")
					Gosub VIP_Shop

				; *************************************
				; ** Messaging and user info capture **
				; *************************************
				Message_To_The_Boss := User_Name . " New Day Routine,"
				Gosub Get_User_Location
				Gosub Get_User_Info
				Gosub Get_Inventory

				MsgBox, 4, , Send_Mail_To_Boss (8 Second Timeout & auto), 8
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") || if (vRet = "Timeout")
					Gosub Send_Mail_To_Boss

				; MsgBox, 4, , Send_Message_In_Chat (8 Second Timeout & auto), 8
				; vRet := MsgBoxGetResult()
				; if (vRet = "Yes") || if (vRet = "Timeout")
				; Gosub Send_Message_In_Chat

				MsgBox, 4, , Pause before switching accounts? (4 Second Timeout & skip), 4
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
					MsgBox, 0, Pause, Press OK to resume (No Timeout)

				goto END_of_user_loop
			}
			END_of_user_loop:
		}

		; start new log files
		Gosub Refresh_LogFiles
		; relaunch LEWZ
		; Gosub Quit_LEWZ
		; Gosub Launch_Lewz
		gosub Reload_Script
		Gosub Go_Back_To_Home_Screen
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

; Tap Memu Title Bar
Memu_Title_Bar:
{
	Subroutine_Running := "Memu_Title_Bar"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%

	Mouse_Click(423,25) ; Tap Memu Title Bar

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Launch_Lewz:
{
	Subroutine_Running := "Launch_Lewz"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Launch_Lewz_Click_Icon:
	Search_Captured_Text := ["Last Empire"]
	OCR_X := 410
	OCR_Y := 536
	OCR_W := 140
	OCR_H := 42

	loop, 30
	{
		OCR_X := 410
		OCR_Y := 536
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
		{
			Mouse_Click(480,500) ; Tap LEWZ ICON
			Goto Launch_Lewz_Continue
		}

		OCR_X := 7
		OCR_Y := 880
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
		{
			Mouse_Click(67,844) ; Tap LEWZ ICON
			Goto Launch_Lewz_Continue
		}
	}
	Launch_Lewz_Retry:
	Gosub Quit_LEWZ
	goto Launch_Lewz_Click_Icon

	Launch_Lewz_Continue:
	DllCall("Sleep","UInt",(rand_wait + 10*Delay_Long+0))
	
	Search_Captured_Text := ["Enter"] ; ,"login","password"]
	PIN_X := 199 ; 190
	PIN_Y := 265 ; 250
	PIN_W := 77 ; 300
	PIN_H := 30 ; 50
	loop, 10
	{
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [PIN_X, PIN_Y], Size: [PIN_W, PIN_H], Timeout: 0}).Found
		{
			Gosub Enter_Login_Password_PIN
			break
		}
	}

	; Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Quit_LEWZ:
{
	Subroutine_Running := "Quit_LEWZ"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Quit LEWZ
	; Gosub Reset_Posit
	; Gosub Go_Back_To_Home_Screen
	; DllCall("Sleep","UInt",(rand_wait + 8*Delay_Long+0))

	Text_To_Screen("{F5}")
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	
	Go_Back_To_Home_Text := ["Quit"] ; ,"Quit the game"]
	OCR_X := 150 ; 140
	OCR_Y := 523 ; 515
	OCR_W := 50 ; 64 ; 252
	OCR_H := 26 ; 40 ; 155
	loop, 10
	{
		if Search_Captured_Text_OCR(Go_Back_To_Home_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			break

		Text_To_Screen("{F5}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Ledium+0))
		Gosub Check_Window_Geometry
	}

	Mouse_Click(327,770) ; Tap "OK"
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Text_To_Screen("{F8}") ; Home screen button
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	; loop, 5
	; {
	; 	Mouse_Click(283,5, {Control: Qt5QWindowIcon}) ; close LEWZ and/or other app tabs
	; SendEvent {Click, 283,5}
	;	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
	;}

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

; Clear in-game splash pages
Game_Start_popups:
{
	Subroutine_Running := "Game_Start_popups"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Clear first pop-up by pressing back
	Text_To_Screen("{F5}")
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(256,979) ; Check No More Prompts Today On Today'S Hot Sale
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(630,322) ; Tap X On Today'S Hot Sale
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	; Mouse_Click(379,736) ; Collect Cafeteria

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

; reset position
Reset_Posit:
{
	Subroutine_Running := "Reset_Posit"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; go back x times

	; Go_Back_Home_Delay_Long := True
	Gosub Go_Back_To_Home_Screen
	; Gosub Speaker_Help

	; Tap World/home button x times
		loop, 2
	{
		Mouse_Click(76,1200) ; Tap World/home button
		DllCall("Sleep","UInt",(rand_wait + 8*Delay_Long+0))
	}
	; Go_Back_Home_Delay_Long := True
	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Go_Back_To_Home_Screen:
{
	; Subroutine_Running := "Go_Back_To_Home_Screen"
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Go back
	loop, 10
	{
		Text_To_Screen("{F5}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	Gosub Go_Back_To_Home_Screen_OCR_Quit
	Gosub Go_Back_To_Home_Screen_OCR_NOT_Quit

	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	return

	Go_Back_To_Home_Screen_OCR_Quit:
	
	Go_Back_To_Home_Text := ["Quit"] ; ,"Quit the game"]
	OCR_X := 150 ; 140
	OCR_Y := 523 ; 515
	OCR_W := 50 ; 64 ; 252
	OCR_H := 26 ; 40 ; 155
	loop, 40
	{
		loop, 2
			if Search_Captured_Text_OCR(Go_Back_To_Home_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
				return

		Text_To_Screen("{F5}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		Gosub Check_Window_Geometry
	}
	goto Reload_LEWZ_routine	; Gosub Reload_LEWZ_routine
	return

	Go_Back_To_Home_Screen_OCR_NOT_Quit:
	Go_Back_To_Home_Text := ["Quit"] ; ,"Quit the game"]
	OCR_X := 150 ; 140
	OCR_Y := 523 ; 515
	OCR_W := 50 ; 64 ; 252
	OCR_H := 26 ; 40 ; 155
	loop, 10
	{
		loop, 2
			if !Search_Captured_Text_OCR(Go_Back_To_Home_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
				return

		Text_To_Screen("{F5}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		Gosub Check_Window_Geometry
	}
	goto Reload_LEWZ_routine	; Gosub Reload_LEWZ_routine
	return

	Reload_LEWZ_routine:
	{
		Gosub Quit_LEWZ
		Gosub Launch_Lewz
		; Gosub Switch_Account
		; Gosub Enter_Login_Password_PIN

		goto Go_Back_To_Home_Screen_OCR_Quit
		return
	}

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Switch_Account:
{
	Subroutine_Running := "Switch_Account"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	Gui, Status:add,text,, ********************************
	Gui, Status:add,text,, Switching to %User_Name%
	; Gui, Status:show, x%MsgWinMove_X% y0 w300 h500
	Gui, Status:show, x731 y0 w300 h500
	loop, 2
		GUI_Count++

	Switch_Account_START:
	loop, 5
	{
		Gosub Go_Back_To_Home_Screen
		Mouse_Click(50,70, {Clicks: 1,Timeout: (1*Delay_Long+0)}) ; Tap Commander Info

		Search_Captured_Text := ["Commander"]
		loop, 3
			if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0}).Found
				goto Switch_Account_Commander
	}

	Switch_Account_Commander:
	; loop, 2
		Mouse_Click(600,1200, {Clicks: 2,Timeout: (3*Delay_Short+0)}) ; Tap Settings
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

	Search_Captured_Text := ["Settings"]
	loop, 2
		if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0}).Found
			break

	; loop, 2
		Mouse_Click(100,300, {Clicks: 2,Timeout: (3*Delay_Short+0)}) ; Tap Account
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

	OCR_X := 315
	OCR_Y := 860
	OCR_W := 60
	OCR_H := 35
	; Capture_Screen_Text := OCR([315, 860, 60, 35], "eng") ; "Yes"
	loop, 3
		if Search_Captured_Text_OCR(["Yes"], {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			Mouse_Click(340,870, {Clicks: 1,Timeout: (5*Delay_Short+0)}) ; Tap Yes	
			
	Search_Captured_Text := ["Account"]
	loop, 2
		if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0}).Found
			break

	loop, 2
		Mouse_Click(350,875, {Clicks: 2,Timeout: (3*Delay_Short+0)}) ; Tap "Switch Account"
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

	Switch_Account_WarZ_Login:
	Subroutine_Running := "Switch_Account_WarZ_Login"
	Email_Entered := False
	Password_Entered := False
	loop, 5
	{
		; Search_Captured_Text := OCR([300, 690, 100, 40], "eng") ; "WarZ Account" button
		Subroutine_Running := "WarZ Account"
		Search_Captured_Text := ["WarZ"] ; 306, 693
		OCR_X := 302 ; 287
		OCR_Y := 692 ; 676
		OCR_W := 70 ; 200
		OCR_H := 25 ; 55
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found ; 602, 550
			Mouse_Click(350,700, {Clicks: 1,Timeout: (1*Delay_Long+0)}) ; Tap WarZ Account ; goto Switch_Account_WarZ_Account_Button

		; Search_Captured_Text := OCR([422, 1145, 50, 25], "eng") ; "Other Account" button
		Subroutine_Running := "Other Account"
		Search_Captured_Text := ["Other","Account"]
		OCR_X := 422 ; 420
		OCR_Y := 1145 ; 1140
		OCR_W := 50 ; 130
		OCR_H := 25 ; 37
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found ; 602, 550
			Mouse_Click(475,1150, {Clicks: 1,Timeout: (1*Delay_Long+0)}) ; Tap Other Account
			; goto Switch_Account_Other_Account

		; Search_Captured_Text := OCR([378, 720, 100, 32], "eng") ; "Use your email" button
		Subroutine_Running := "Use your email"
		Search_Captured_Text := ["Use your"]
		Use_Email_OCR_X := 378 ; 374
		Use_Email_OCR_Y := 722 ; 719
		Use_Email_OCR_W := 92 ; 160
		Use_Email_OCR_H := 30 ; 40
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [Use_Email_OCR_X, Use_Email_OCR_Y], Size: [Use_Email_OCR_W, Use_Email_OCR_H], Timeout: 0}).Found
		{			
			Gosub Switch_Account_User_Email
			Gosub Switch_Account_User_Password
			goto Switch_Account_Next
		}
	}
	
	/*
		
			loop, 2
			{
				if !Email_Entered
				{
				OCR_X := 65
				OCR_Y := 362
				OCR_W := 535
				OCR_H := 50
				; Read contents of Email Box, default message: "Please enter your email address here..."
				Search_Captured_Text := ["Please enter","your email","email address"]
				OCR_Y := 362
				if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
					if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
						Gosub Switch_Account_User_Email
					else
						Email_Entered := True
				Else
					Email_Entered := True
				}

				if !Password_Entered
				{
				; Read contents of Password Box, default message: "Please enter your password here..."
				Search_Captured_Text := ["Please enter","your password","password here"]
				OCR_X := 65
				OCR_Y := 505
				OCR_W := 535
				OCR_H := 50
				if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
					if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
						Gosub Switch_Account_User_Password
					Else
						Password_Entered := True
				Else
					Password_Entered := True
				}
			}

		if (Email_Entered && Password_Entered)
			goto Switch_Account_Next
		; if !WinActive(FoundAppTitle), WinActivate, %FoundAppTitle%
	}
	*/

	Switch_Account_Try_Again:
	; Mouse_Click(475,1150) ; Tap Other Account
	goto Switch_Account_WarZ_Login

	Switch_Account_User_Email:
	{
		loop, 3
		{
			Mouse_Click(220,382) ;, {Clicks: 2}) ; , Timeout: (1*Delay_Short+0)}) ; Tap inside Email Text Box
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		Text_To_Screen(User_Email)
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		Text_To_Screen("{Enter}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		return
	}

	Switch_Account_User_Password:
	{
		loop, 3
		{
			Mouse_Click(209,527) ; , {Clicks: 2}) ; , Timeout: (1*Delay_Short+0)}) ; Tap inside Email Text Box
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		Text_To_Screen(User_Pass)
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		Text_To_Screen("{Enter}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		return
	}

	Switch_Account_Next:
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Mouse_Click(455,739, {Clicks: 2,Timeout: (1*Delay_Short+0)}) ; Tap Use your email to log in
	
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	loop, 3
	{
		Mouse_Click(340,785) ; Tap "OK"	
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Medium+0))
	}

	loop, 5 ; 10 ; 15
	{
		OCR_X := 330 ; 320
		OCR_Y := 675 ; 720
		OCR_W := 40 ; 50
		OCR_H := 30 ; 80
		; Capture_Screen_Text := OCR([323, 732, 47, 77], "eng")
		if Search_Captured_Text_OCR(["OK"], {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			Mouse_Click(340,780, {Clicks: 1,Timeout: (5*Delay_Short+0)}) ; Tap "OK"	
			
		OCR_X := 315
		OCR_Y := 860
		OCR_W := 60
		OCR_H := 35
		; Capture_Screen_Text := OCR([315, 860, 60, 35], "eng") ; "Yes"
		if Search_Captured_Text_OCR(["Yes"], {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			Mouse_Click(340,870, {Clicks: 1,Timeout: (5*Delay_Short+0)}) ; Tap Yes	
			
		/*
		Search_Captured_Text := ["previous game","progress found","Are you sure","log in and"]	; ,"overwrite the","current game","progress?"]
		OCR_X := 40
		OCR_Y := 510
		OCR_W := 425
		OCR_H := 42	; 118
		; "Are you sure to log in and overwrite the current game progress?"
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			Mouse_Click(336,780, {Clicks: 1,Timeout: (5*Delay_Short+0)}) ; Tap "OK"
		*/

		Search_Captured_Text := ["Enter"] ; ,"login","password"]
		PIN_X := 199 ; 190
		PIN_Y := 265 ; 250
		PIN_W := 77 ; 300
		PIN_H := 30 ; 50
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [PIN_X, PIN_Y], Size: [PIN_W, PIN_H], Timeout: 0}).Found
		{
			Gosub Enter_Login_Password_PIN
			break ; goto Switch_Account_PIN
		}
	}
	
	; gosub BruteForcePIN

	/*
	; old loop
	loop, 6
	{
		Search_Captured_Text := ["previous game","progress found"]
		OCR_X := 40
		OCR_Y := 510
		OCR_W := 366
		OCR_H := 40
		; "Previous game progress found:"
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			Mouse_Click(336,780, {Clicks: 1, Timeout: (5*Delay_Short+0)}) ; Tap "OK"

		Search_Captured_Text := ["Are you sure to","log in and","overwrite the","current game","progress?"]
		OCR_X := 140
		OCR_Y := 516
		OCR_W := 325
		OCR_H := 110
		; "Are you sure to log in and overwrite the current game progress?"
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			Mouse_Click(336,780, {Clicks: 1,Timeout: (5*Delay_Short+0)}) ; Tap "OK"

		Search_Captured_Text := ["Enter","login","password"]
		PIN_X := 190
		PIN_Y := 250
		PIN_W := 300
		PIN_H := 50
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [PIN_X, PIN_Y], Size: [PIN_W, PIN_H], Timeout: 0}).Found
			Break
	}
	*/
	
	Switch_Account_PIN:
	MsgBox, 4, User PIN, user PIN: %User_PIN% - Pause script? (10 second Timeout), 5 ; 10
	vRet := MsgBoxGetResult()
	; if (vRet = "No")
	;	DllCall("Sleep","UInt",(rand_wait + 5*Delay_Long+0))
	if (vRet = "Yes")
		MsgBox, 0, Pause, User PIN: %User_PIN% Press OK to resume (No Timeout)

	Switch_Account_END:

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%

	return
}

Enter_Login_Password_PIN:
{
	; Subroutine_Running := "Enter_Login_Password_PIN"
	
	Goto Enter_Login_Password_PIN_Dialog

	Enter_Login_Password_PIN_Search:
	Search_Captured_Text := ["Enter","login","password"]
	PIN_X := 190
	PIN_Y := 250
	PIN_W := 300
	PIN_H := 50
	loop, 6
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [PIN_X, PIN_Y], Size: [PIN_W, PIN_H], Timeout: 0}).Found
			Goto Enter_Login_Password_PIN_Dialog
	return

	Enter_Login_Password_PIN_Search_old:
	PIN_X := (190 + X_Pixel_offset)
	PIN_Y := (250 + Y_Pixel_offset)
	PIN_W := 300
	PIN_H := 50
	{
		Capture_Screen_Text := OCR([PIN_X, PIN_Y, PIN_W, PIN_H], "eng")
		Capture_Screen_Text := RegExReplace(Capture_Screen_Text,"[\r\n\h]+")

		For index, value in Enter_Login_Password_PIN_Text_Array
			If (RegExMatch(Capture_Screen_Text,value))
				Goto Enter_Login_Password_PIN_Dialog
	}
	return

	Enter_Login_Password_PIN_Dialog:
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	loop, 6
		Mouse_Click(577,1213, {Timeout: 5}) ; , {Timeout: Delay_Medium+0}) ; Tap backspace
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

	Enter_User_PIN := StrSplit(User_PIN)
	Loop % Enter_User_PIN.MaxIndex()
	{
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		if Enter_User_PIN[A_Index] = "0"
			Mouse_Click(340,1200, {Timeout: 0}) ; Tap 0
		if Enter_User_PIN[A_Index] = "1"
			Mouse_Click(120,920, {Timeout: 0}) ; Tap 1
		if Enter_User_PIN[A_Index] = "2"
			Mouse_Click(340,920, {Timeout: 0}) ; Tap 2
		if Enter_User_PIN[A_Index] = "3"
			Mouse_Click(560,920, {Timeout: 0}) ; Tap 3
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
	}
	return
}

BruteForcePIN:
{
	; MsgBox, incorrect PIN: %User_PIN%
	User_PIN_INIT := "110100"
	loop, 1000000
	{
		User_PIN := (User_PIN_INIT + A_Index)
		; MsgBox, PIN: %User_PIN%
		
		loop, 5		
		if StrLen(User_PIN) < 6		
			User_PIN := "0" . User_PIN
			
		if StrLen(User_PIN) > 6		
			User_PIN := "0"	
		
		; MsgBox, sub:"%Subroutine_Running%" PIN:"%User_PIN%"
		gosub Enter_Login_Password_PIN
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		
		if (Mod(A_Index, 100) == 0)
		{
			Subroutine_Running := "User_PIN " . User_PIN
			Capture_Screen_Text := OCR([220, 551, 121, 71], "eng")
			If (RegExMatch(Capture_Screen_Text,"Incorrect")) || if (RegExMatch(Capture_Screen_Text,"orgot"))
				goto NOT_Right_PIN
			
			Else
			{
				MsgBox, 3, , Did %User_PIN% work? OCR:"%Capture_Screen_Text%" (10 second Timeout & auto),10
				vRet := MsgBoxGetResult()
				if (vRet = "Yes") || if (vRet = "Timeout")
					break
			}
		}
		NOT_Right_PIN:
	}
	
	
	MsgBox, correct PIN: %User_PIN%
	return
}

Peace_Shield_OLD:
{
	Subroutine_Running := "Peace_Shield"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%

	Mouse_Click(290,405) ; Tap on base
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(359,487) ; Tap On City Buffs
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(302,235) ; Tap on Peace shield
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

	MsgBox, 4, , Pause script to place shield? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		MsgBox, 0, Pause, Activate Peace Shield, Press OK to resume (No Timeout)

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}


Peace_Shield:
{
	Subroutine_Running := "Peace_Shield"

	Shield_Open_Base:
	Shield_Found_3Day := False
	Shield_Found_24hour := False
	Shield_Found_8hour := False
	Loop, 2
	{
		Mouse_Click(265,392) ;  Left, 1}  ; Tap Base
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		Mouse_Click(348,499) ;  Left, 1}  ; Tap City buffs
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		
		loop, 3
		{
			if Search_Captured_Text_OCR(["City","Buff"], {Timeout: 0}).Found
				Goto, Shield_Search_Buttons
		
			if Search_Captured_Text_OCR(["Buff"], {Pos: [362, 512], Size: [44, 14], Timeout: 0}).Found
			{
				Mouse_Click(348,499) ;  Left, 1}  ; Tap City buffs
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
			}
		}
		Gosub Go_Back_To_Home_Screen
	}
	goto Peace_Shield_END


	Goto, Shield_Open_Base
	Shield_Search_Buttons:
	Shield_Pos01 := Search_Captured_Text_OCR(["Peace","Shield"], {Pos: [134, 160], Size: [150, 21], Timeout: 0})
	Shield_Pos02 := Search_Captured_Text_OCR(["Peace","Shield"], {Pos: [134, 312], Size: [150, 21], Timeout: 0})
	Shield_Ends_Pos01 := Search_Captured_Text_OCR(["Ends"], {Pos: [270, 242], Size: [200, 22], Timeout: 0})
	Shield_Ends_Pos02 := Search_Captured_Text_OCR(["Ends"], {Pos: [270, 394], Size: [200, 22], Timeout: 0})
		
	Loop, 10
	{
		if Shield_Pos01.Found
		{
			Click_X := 165
			Click_Y := 216
			If Shield_Ends_Pos01.Found
			{
				Shield_Ends := (Shield_Ends_Pos01.Text)
				Goto, Shield_Already_Active
			}
			Else
				Goto, Activate_Shield
		}
		
		if Shield_Pos02.Found
		{
			Click_X := 200
			Click_Y := 367
			If Shield_Ends_Pos02.Found
			{
				Shield_Ends := (Shield_Ends_Pos02.Text)
				Goto, Shield_Already_Active
			}
			Else
				Goto, Activate_Shield
		}
		
	}
	
	Shield_Not_Found:	
	MsgBox, 4, , % "Shield Button not found in:""" Shield_Pos01.Text """ Or """ Shield_Pos02.Text """`, Try again? (10 second Timeout & skip)",10
	vRet := MsgBoxGetResult()
	if (vRet = "Yes")
		goto Shield_Open_Base
	else if (vRet = "No") || if (vRet = "Timeout")
		goto Peace_Shield_END

	Shield_Already_Active:
	{
		Shield_DD := Shield_HH := Shield_MM := Shield_SS := 0
		
		if RegExMatch(Shield_Ends,"\d+d",Shield_Days1)
			RegExMatch(Shield_Days1,"\d+",Shield_DD)
		
		if RegExMatch(Shield_Ends,"\d+\:\d+\:\d+",Shield_Hours1)
		{
			Shield_Hours2 := RegExReplace(Shield_Hours1,"[^\d]")
			Shield_Hour_Array := StrSplit(Shield_Hours1, ":")
			Shield_HH := Shield_Hour_Array[1]
			Shield_MM := Shield_Hour_Array[2]
			Shield_SS := Shield_Hour_Array[3]
		}
		
		Shield_Expires10 := "000000" . Shield_DD . Shield_HH . "24" . Shield_MM . Shield_SS
		Shield_Expires11 := FormatTime(A_Now, "YYYYMMDDHH24MISS")
		EnvAdd, Shield_Expires12, Shield_DD, d
		EnvAdd, Shield_Expires12, Shield_HH, h
		EnvAdd, Shield_Expires12, Shield_MM, m
		EnvAdd, Shield_Expires12, Shield_SS, s
		Shield_Expires13 := FormatTime(Shield_Expires12)
		
		if At_War
		{
			MsgBox, 4, ,Shield expires on %Shield_Expires13%`, recommend 3Day shield (10 sec Timeout & auto),10
			vRet := MsgBoxGetResult()
			if (vRet = "Yes") || if (vRet = "Timeout") ; || if (vRet = "No")
			Goto, Shield_for_3Day
		}
		else if (Shield_Expires11 = "Thursday")
		{
			MsgBox, 4, ,Shield expires on %Shield_Expires13%`, recommend 3Day shield (10 sec Timeout & auto),10
			vRet := MsgBoxGetResult()
			if (vRet = "Yes") || if (vRet = "Timeout") ; || if (vRet = "No")
			Goto, Shield_for_3Day
		}
		else if (Shield_Expires11 = "Friday")
		{
			MsgBox, 4, ,Shield expires on %Shield_Expires13%`, recommend 3Day shield (10 sec Timeout & auto),10
			vRet := MsgBoxGetResult()
			if (vRet = "Yes") || if (vRet = "Timeout") ; || if (vRet = "No")
			Goto, Shield_for_3Day
		}
		else if (Shield_Expires11 = "Saturday" && Shield_Expires_Hour <= 19)
		{
			MsgBox, 4, ,Shield expires on %Shield_Expires13%`, recommend 3Day shield (10 sec Timeout & auto),10
			vRet := MsgBoxGetResult()
			if (vRet = "Yes") || if (vRet = "Timeout") ; || if (vRet = "No")
			Goto, Shield_for_3Day
		}
		else if (Shield_Expires11 = "Saturday" && Shield_Expires_Hour >= 19)
		{
			MsgBox, 4, ,Shield expires on %Shield_Expires13%`, recommend 24hour shield (10 sec Timeout & auto),10
			vRet := MsgBoxGetResult()
			if (vRet = "Yes") || if (vRet = "Timeout") ; || if (vRet = "No")
			Goto, Shield_for_24hour
		}
		else if (Shield_Expires11 = "Sunday" && Shield_Expires_Hour <= 19)
		{
			MsgBox, 4, ,Shield expires on %Shield_Expires13%`, recommend 24hour shield (10 sec Timeout & auto),10
			vRet := MsgBoxGetResult()
			if (vRet = "Yes") || if (vRet = "Timeout") ; || if (vRet = "No")
			Goto, Shield_for_24hour
		}
		else
		{
			MsgBox, 4, ,Shield expires on %Shield_Expires13%`, No shield needed. (10 sec Timeout & auto),10
			Goto, Peace_Shield_END
		}
	}
	
	MsgBox, 4, , Shield Already Active`, %Capture_Screen_Text%`,  Select new shield anyway? (10 second Timeout & skip),10
	vRet := MsgBoxGetResult()
	if (vRet = "Yes")
		goto Activate_Shield
	else if (vRet = "No") || if (vRet = "Timeout")
		goto Peace_Shield_END

	Activate_Shield:
	Mouse_Click(Click_X,Click_Y) ; SendEvent, {Click, %Click_X%, %Click_Y% Left, 1}  ; Click first box to enable shield
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	
	MsgBox("Would you like to place a shield?`n(Esc) to cancel`n(10 second Timeout & skip)`,10", "Peace Shield", 3, "&3Day", "&24hour", "&8hour", 5)
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; 3Day
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
		Mouse_Click(590,310) ;  Left, 1}  ; Tap Get & use 3-Day Peace Shield
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Goto, Shield_Purchase
	}
	Goto, Shield_Not_Selected
	
	Shield_for_24hour:
	{
		Shield_Found_24hour := True
		Mouse_Click(590,458) ;  Left, 1}  ; Tap Get & use 24-Hour Peace Shield
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Goto, Shield_Purchase
	}
	Goto, Shield_Not_Selected
	
	Shield_for_8hour:
	{
		Shield_Found_8hour := True
		Mouse_Click(590,610) ;  Left, 1}  ; Tap Get & use 8-Hour Peace Shield
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Goto, Shield_Purchase
	}
	Goto, Shield_Not_Selected
	
	Shield_Not_Selected:
	MsgBox, 4, , Shield not selected:"%Capture_Screen_Text%"`, Try again? (10 second Timeout & skip),10
	vRet := MsgBoxGetResult()
	if (vRet = "Yes")
		Goto, Shield_Open_Base
	else if (vRet = "No") || if (vRet = "Timeout")
		Goto, Peace_Shield_END

	Shield_Purchase:
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Shield_Purchase := Search_Captured_Text_OCR(["are","you","sure","After","usage"], {Pos: [139, 521], Size: [411, 72], Timeout: 0})

	loop, 5
		If Shield_Purchase.Found
			Mouse_Click(336,781) ;  Left, 1}  ; Tap Get & Use button, to confirm buying shield
	
	Peace_Shield_END:	
	MsgBox, 4, , Pause script to place shield? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		MsgBox, 0, Pause, Activate Peace Shield, Press OK to resume (No Timeout)

	Gosub Go_Back_To_Home_Screen

	return
}

; collect collisions
Collect_Collisions:
{
	Subroutine_Running := "Collect_Collisions"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	loop, 2
	{
		Mouse_Click(430,280) ; Tap Command Center
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		Mouse_Click(515,375) ; Tap Collision
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		loop, 3
			if Search_Captured_Text_OCR(["Particle"], {Timeout: 0}).Found
				goto Collect_Collisions_Found
		Gosub Go_Back_To_Home_Screen
	}
	goto Collect_Collisions_END
	Collect_Collisions_Found:
	{
		Mouse_Click(180,1130) ; Tap Collide
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		goto Collect_Collisions_END
		Loop, 3
		{
			Mouse_Click(450,1180) ; Tap "OK"
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		}
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	Collect_Collisions_END:
	Gosub Go_Back_To_Home_Screen
	return
	
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	;loop, 2
		Mouse_Click(430,280) ; Tap Command Center
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Mouse_Click(540,367) ; Tap Collide ; Mouse_Click(540,400) ; Tap Collide
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	loop, 2
		Mouse_Click(180,1130, {Timeout: Delay_Medium+0}) ; Tap Collide
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Mouse_Click(450,1180, {Timeout: Delay_Medium+0}) ; Tap "OK"
	Gosub Go_Back_To_Home_Screen
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

; collect Equipment Crafting
Collect_Equipment_Crafting:
{
	Subroutine_Running := "Collect_Equipment_Crafting"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	loop, 2
	{
		Mouse_Click(430,280) ; Tap Command Center
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		Mouse_Click(430,390) ; Tap Craft
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		loop, 3
			if Search_Captured_Text_OCR(["Giant"], {Timeout: 0}).Found
					goto Collect_Equipment_Found
		Gosub Go_Back_To_Home_Screen
	}
	goto Collect_Equipment_END
	Collect_Equipment_Found:
	{
		Mouse_Click(180,1180, {Timeout: Delay_Medium+0}) ; Tap Craft or Recruit or Extract
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		goto Collect_Equipment_END
		Loop, 3
		{
			Mouse_Click(450,1180) ; Tap "OK"
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		}
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	Collect_Equipment_END:
	Gosub Go_Back_To_Home_Screen
	return
	
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	;loop, 2
		Mouse_Click(430,280) ; Tap Command Center
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Mouse_Click(475,389) ; Tap craft
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	loop, 2
		Mouse_Click(180,1180, {Timeout: Delay_Medium+0}) ; Tap Craft or Recruit or Extract
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Mouse_Click(450,1180, {Timeout: Delay_Medium+0}) ; Tap "OK"
	Gosub Go_Back_To_Home_Screen
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

; Collect Recruits
Collect_Recruits:
{
	Subroutine_Running := "Collect_Recruits"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	loop, 2
	{
		Mouse_Click(430,280) ; Tap Command Center
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		Mouse_Click(350,375) ; Tap Recruit
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		loop, 3
			if Search_Captured_Text_OCR(["Recruitment"], {Timeout: 0}).Found
				goto Collect_Recruits_Found
		Gosub Go_Back_To_Home_Screen
	}
	goto Collect_Recruits_END
	Collect_Recruits_Found:
	{
		Mouse_Click(160,1180) ; Tap Recruit 1 times
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		goto Collect_Recruits_END
		Loop, 3
		{
			Mouse_Click(450,1180) ; Tap "OK"
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		}
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	Collect_Recruits_END:
	Gosub Go_Back_To_Home_Screen
	return
	
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	;loop, 2
		Mouse_Click(430,280) ; Tap Command Center
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Mouse_Click(430,280) ; Tap Recruit ; Mouse_Click(200,1160) ; Tap Recruit
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	loop, 3
		Mouse_Click(180,1180, {Timeout: Delay_Medium+0}) ; Tap Craft or Recruit or Extract
	; Mouse_Click(460,1180) ; Tap "OK"
	loop, 3
		Mouse_Click(460,1180, {Timeout: Delay_Medium+0}) ; Tap "OK"
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Mouse_Click(450,1180, {Timeout: Delay_Medium+0}) ; Tap "OK"
	Gosub Go_Back_To_Home_Screen
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

; Collect Runes
Collect_Runes:
{
	Subroutine_Running := "Collect_Runes"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	loop, 2
	{
		Mouse_Click(430,280) ; Tap Command Center
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		Mouse_Click(570,340) ; Rune Extraction
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		loop, 3
			if Search_Captured_Text_OCR(["Rune"], {Timeout: 0}).Found
				goto Collect_Runes_Found
		Gosub Go_Back_To_Home_Screen
	}
	goto Collect_Runes_END
	Collect_Runes_Found:
	{
		Mouse_Click(180,1180) ; Tap Craft or Recruit or Extract
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		goto Collect_Runes_END
		Loop, 3
		{
			Mouse_Click(450,1180) ; Tap "OK"
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		}
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	Collect_Runes_END:
	Gosub Go_Back_To_Home_Screen
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Collect_Red_Envelopes:
{
	Subroutine_Running := "Collect_Red_Envelopes"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	loop, 3
	{

		Mouse_Click(316,1122) ; Tap on Chat Bar
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		Mouse_Click(33,62) ; Tap back Button
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		Mouse_Click(289,165) ; Tap on first Chat Room "Alliance"
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		Mouse_Click(227,1215) ; Tap in Message Box
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		; Shake phone
		Text_To_Screen("!{F2}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		; Gosub Get_Window_Geometry
		Gosub Check_Window_Geometry

		Mouse_Click(33,62) ; Tap back Button
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		Gosub Go_Back_To_Home_Screen
	}

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Shield_Warrior_Trial_etc:
{
	; check shield and unclaimed rewards

	/*
	MsgBox, 4, Peace_Shield, Peace_Shield? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		Gosub Peace_Shield

	MsgBox, 4, Location, Check location? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") ; || if (vRet = "No")
		{

			Mouse_Click(76,1200) ; Tap World/home button

			MsgBox, 0, Pause, Check location`, Press OK to return home (No Timeout)

			; Go_Back_Home_Delay_Long := True
			Gosub Go_Back_To_Home_Screen
		+0}
	*/

	MsgBox, 4, Wonder Rewards, Wonder Rewards? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") ; || if (vRet = "No")
		Gosub Activity_Center_Wonder

	/*
	; MsgBox, 4, SVIP, check SVIP? (8 Second Timeout & skip), 8
	; vRet := MsgBoxGetResult()
	; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
	; {
	;
	; Mouse_Click(157,102) ; Tap SVIP

	; MsgBox, 0, Pause, Check SVIP`, Press OK to return home (No Timeout)

	; Gosub Go_Back_To_Home_Screen
	; }

	MsgBox, 4, Benefits, Benefits_Center_Monthly? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") ; || if (vRet = "No")
		Gosub Benefits_Center_Monthly

	; MsgBox, 4, Activate Skills, Activate Skills? (8 Second Timeout & skip), 8
	; vRet := MsgBoxGetResult()
	; if (vRet = "Yes") ; || if (vRet = "Timeout") ; || if (vRet = "No")
	; {
	; Mouse_Click(195,1195) ; Tap Activate Skills

	; MsgBox, 0, Pause, Check Activate Skills`, Press OK to return home (No Timeout)

	; Gosub Go_Back_To_Home_Screen
	; }

	MsgBox, 4, Desert_Oasis, Desert_Oasis? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") ; || if (vRet = "No")
		Gosub Desert_Oasis
	*/

	MsgBox, 4, , Pause? Check location`, SVIP`, wonder rewards`, activate skills`, etc? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") ; || if (vRet = "No")
		MsgBox, 0, Pause, Check location`, SVIP`, wonder rewards`, activate skills`, etc? Press OK to resume (No Timeout)

	Gosub Go_Back_To_Home_Screen
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

}

Activity_Center_Wonder_old:
{
	Mouse_Drag(109, 536, 262, 536, {EndMovement: T, SwipeTime: 500})
	/*
	Click, 109, 536 Left, Down ; drag home screen to right
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Click, 130, 536, 0
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Click, 139, 536, 0
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Click, 150, 536, 0
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Click, 159, 536, 0
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Click, 262, 536, 0
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
	Click, 262, 536 Left, Up
	*/

	Mouse_Click(137,580) ; Tap activity center

	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Long+0))
	Mouse_Click(170,140) ; Tap on "in progress" tab
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Drag(330, 1194, 337, 849, {EndMovement: F, SwipeTime: 500})
	/*
	Click, 330, 1194 Left, Down ; drag activity center list up
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Click, 337, 849, 0
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
	Click, 337, 849 Left, Up
	*/

	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Mouse_Click(297,1095) ; Tap on desert wonder
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
	Mouse_Click(250,150) ; Tap on second tab "wonder"
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Mouse_Click(244,592) ; Tap and open reward box number 1
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
	Mouse_Click(340,987) ; Tap Collect Button
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
	Mouse_Click(320,70) ; Tap top title bar
	; Mouse_Click(250,150) ; Tap Outside reward popup
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
	Mouse_Click(439,593) ; Tap and open reward box number 2
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
	Mouse_Click(330,994) ; Tap Collect Button
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
	Mouse_Click(320,70) ; Tap top title bar
	; Mouse_Click(250,150) ; Tap Outside reward popup
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
	Mouse_Click(640,600) ; Tap and open reward box number 3
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
	Mouse_Click(340,1000) ; Tap Collect Button
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
	Mouse_Click(320,70) ; Tap top title bar
	; Mouse_Click(250,150) ; Tap Outside reward popup

	MsgBox, 0, Pause, All rewards claimed? Press OK to return home (No Timeout)
	Gosub Go_Back_To_Home_Screen

	return
}

Activity_Center_Open()
{
	loop, 3
	{
		loop, 3
		{
			Gosub Go_Back_To_Home_Screen
			Mouse_Drag(200, 350, 332, 350, {EndMovement: T, SwipeTime: 500})
			; Mouse_Drag(110, 536, 262, 537, {EndMovement: T, SwipeTime: 500})
			Mouse_Click(137,580) ; Tap activity center
			DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
			
			; Mouse_Drag(82, 536, 335, 536, {EndMovement: T, SwipeTime: 500})
			; Mouse_Click(180,600) ; Tap Activity Center

			loop, 5
				if Search_Captured_Text_OCR(["Activity","Center"], {Timeout: 0}).Found
					return 1
		}
		Gosub Reset_Posit
	}
	return 0
}

Activity_Center_Wonder:
{
	if !Activity_Center_Open()
		goto Activity_Center_END
		
	Activity_Center_Continue:
	Loop, 10
	{
		Search_Captured_Text := ["Desert Wonder"]
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [170, 589], Size: [300, 50], Timeout: 0}).Found
		{
			Mouse_Click(282,610) ; Tap activity 01
			goto Activity_Center_Continue_Tab
		}
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [170, 779], Size: [300, 50], Timeout: 0}).Found
		{
			Mouse_Click(256,803) ; Tap activity 02
			goto Activity_Center_Continue_Tab
		}
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [170, 976], Size: [300, 50], Timeout: 0}).Found
		{
			Mouse_Click(242,1005) ; Tap activity 03
			goto Activity_Center_Continue_Tab
		}
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [170, 1174], Size: [300, 50], Timeout: 0}).Found
		{
			Mouse_Click(210,1200) ; Tap activity 04
			goto Activity_Center_Continue_Tab
		}
	}
	goto Activity_Center_END

	Activity_Center_Continue_Tab:
	; MsgBox, 0, , Capture_Screen_Text:"%Capture_Screen_Text%"`nSearch_Text_Array:"%Search_Text_Array%"
	
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Loop, 5
	{
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [233, 44], Size: [230, 52], Timeout: 0}).Found
		{
			Mouse_Click(250,136) ; Tap Wonder tab
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
			goto Activity_Center_Continue_Claim
		}
	}
	goto Activity_Center_END

	Activity_Center_Continue_Claim:
	; MsgBox, 0, , Capture_Screen_Text:"%Capture_Screen_Text%"`nSearch_Text_Array:"%Search_Text_Array%"
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	Mouse_Click(240,596) ; Tap Wonder reward box 01
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(330,1000) ; Tap Collect Rewards
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(330,70) ; Tap to clear reward
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(439,600) ; Tap Wonder reward box 02
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(330,1000) ; Tap Collect Rewards
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(330,70) ; Tap to clear reward
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(640,600) ; Tap Wonder reward box 03
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(330,1000) ; Tap Collect Rewards
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(330,70) ; Tap to clear reward
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	
	
	Mouse_Click(600,800) ; Tap "Receive Rewards" 1
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(350, 70) ; Tap To clear popup rewards message
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(600,970) ; Tap "Receive Rewards" 2
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(350, 70) ; Tap To clear popup rewards message
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(600,1130) ; Tap "Receive Rewards" 3
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	Mouse_Click(350, 70) ; Tap To clear popup rewards message
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	
	Activity_Center_END:
	; MsgBox, 0, Pause, All rewards claimed? Press OK to return home (No Timeout)
	Gosub Go_Back_To_Home_Screen

	return
}

Benefits_Center_Monthly:
{
	Subroutine_Running := "Benefits_Center_Monthly"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	Mouse_Click(625,280) ; Tap Benefits Center
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	; Gosub Click_through_benefits_tabs
	; loop, 4
	; {
	; Gosub Swipe_Right_trial
	; Gosub Click_through_benefits_tabs
	; }

	MsgBox, 0, Pause, Collect Warrior Trials and monthly package`, Press OK to resume (No Timeout)

	Gosub Go_Back_To_Home_Screen
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

	; loop, through benefits tabs to clear any new ones
	Click_through_benefits_tabs:
	{
		Mouse_Click(70,166) ; Tap Tab 1 Benefits Center
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		Mouse_Click(155,166) ; Tap Tab 1.5 Benefits Center
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

		Mouse_Click(235,166) ; Tap Tab 2 Benefits Center
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

		Mouse_Click(315,166) ; Tap Tab 2.5 Benefits Center
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

		Mouse_Click(395,166) ; Tap Tab 3 Benefits Center
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

		Mouse_Click(475,166) ; Tap Tab 3.5 Benefits Center
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

		Mouse_Click(560,166) ; Tap Tab 4 Benefits Center
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
		return
	}

	Swipe_Right_trial:
	loop, 4
	{
		; Benefits Center Swipe Right One position
		Mouse_Drag(630, 187, 353, 187, {EndMovement: T, SwipeTime: 500})
		/*
		Click, 630, 187 Left, Down
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 530, 187, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 430, 187, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 375, 187, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 363, 187, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 355, 187, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 354, 187, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Click, 353, 187 Left, Up
		*/
	}
	return

}

Benefits_Center:
{
	Subroutine_Running := "Benefits_Center"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; Initialize text to search for
	Battle_Honor_text := "BattleHonor"
	Daily_Signin_text := "Sign"
	Daily_Signin_text2 := "LOGIN"
	Monthly_Package_text := "ackage" ; "MonthlyPackage" "Monthly PRackage", "Rackage", "Monthly Package"
	Monthly_Signin_text := "MonthlySign"
	Select_Reward_text := "SelectReward"
	Selection_Chest_text := "SelectionChest"
	Single_Cumulation_text := "Cumulation"
	Warrior_Trial_text := "Warrior" ; "trial"
	Claim_text := "Claim"
	
	; Select_Reward_text := OCR([15, 210, 133, 30], "eng")
	; Selection_Chest_text := OCR([176, 210, 133, 25], "eng")
	; Single_Cumulation_text := OCR([354, 210, 105, 50], "eng")
	; Daily_Signin_text := OCR([530, 210, 72, 30], "eng")
	; Monthly_Signin_text := OCR([8, 209, 136, 30], "eng")
	; Battle_Honor_text := OCR([189, 207, 110, 30], "eng")
	; Monthly_Package_text := OCR([400, 200, 92, 47], "eng")

	; "ReactionFurnace"
	; "Warriortrial"
	; "WarZAccountbindrewards"
	; "MonthlySign-In"
	; Select Reward
	; Selection Chest
	; Cumulation Purchase
	; Sign In
	; Monthly Sign In
	; Battle Honor
	; Alliance Purchase
	; Continuous purchase
	; Limited Arms Supply
	; Arms Supply
	; Upgrade Base

	; Set tabs = True (1) to completed or False (0) to be skipped.
	Battle_Honor_Run := False
	Daily_Signin_Run := True
	Monthly_Package_Collect_Run := True
	Monthly_Signin_Run := True
	Select_Reward_Run := True
	Selection_Chest_Run := True
	Single_Cumulation_Run := True
	Claim_Buttons_Run := True
	Warrior_Trial_Run := True

	loop, 2
		Mouse_Click(625,310) ; Tap Benefits Center
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0)) ; wait for Benefits Center to load

	loop, 2
	{
		Gosub Benefits_Check_Tabs
		Gosub Benefits_Check_Tabs
		Gosub Go_Back_To_Home_Screen
	}
	Goto Benefits_Center_END

	; loop, 4
	{
		; Gosub Benefits_Center_Reload
		Gosub Benefits_Check_Tabs
		Loop, 3
			Gosub Benefits_swipe_Check_Tabs
		Gosub Go_Back_To_Home_Screen
	}
	; return

	Goto Benefits_Center_END

	Benefits_Center_Reload:
	Subroutine_Running := "Benefits_Center_Reload"
	loop, 5
	{
		Search_Captured_Text := ["Benefits Center"]
		loop, 2
			if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0}).Found
				return

		; Gosub Get_Window_Geometry
		Gosub Check_Window_Geometry
		Gosub Go_Back_To_Home_Screen
		loop, 2
			Mouse_Click(625,310, {Timeout: Delay_Short}) ; Tap Benefits Center
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Long+0))
	}
	return

	Benefits_Center_END:
	; Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

	Benefits_swipe_Check_Tabs:
	Subroutine_Running := "Benefits_swipe_Check_Tabs"
	{
		; Gosub Swipe_Right
		Gosub Swipe_Right2
		Gosub Benefits_Check_Tabs
		return
	}

	Benefits_Check_Tabs:
	Subroutine_Running := "Benefits_Check_Tabs"
	{

		; Capture_Screen_Text := OCR([0, 180, 160, 80], "eng")
		; Capture_Screen_Text := OCR([160, 180, 160, 80], "eng")
		; Capture_Screen_Text := OCR([320, 180, 160, 80], "eng")
		; Capture_Screen_Text := OCR([480, 180, 160, 80], "eng")

		Benefits_X_Min := 0 ; 15 ; 0
		Benefits_X_Max := 480 ; 510 ; 409
		Benefits_OCR_X := Benefits_X_Min
		Benefits_OCR_Y := 200 ; 180 ; 184
		Benefits_OCR_W := 170 ; 272
		Benefits_OCR_H := 80 ; 72
		Benefits_X_Delta := 160 ; 135 ; 165
		Benefits_Click_X := (Benefits_OCR_X + 2/Benefits_OCR_W)
		Benefits_Click_Y := (Benefits_OCR_Y + 2/Benefits_OCR_H)
		; X=0-684, 684/5=136, and 136*2=272, 0,136,272,408,544,680
		; 684/4=171, 684/3=228
		; or 484/3=161

		loop, 4
		{
			Mouse_Click(645,249) ; Tap to clear scrolling messages
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0)) ; wait for tab to load
			loop, 2
			{
				Mouse_Click(Benefits_Click_X,Benefits_Click_Y) ; Tap Next Tab in Benefits Center
				DllCall("Sleep","UInt",(rand_wait + 4*Delay_Short+0)) ; wait for tab to load
			}
			; DllCall("Sleep","UInt",(rand_wait + 4*Delay_Short+0)) ; wait for tab to load
			; Capture_Screen_Text := ""
			Capture_Screen_Text := OCR([Benefits_OCR_X, Benefits_OCR_Y, Benefits_OCR_W, Benefits_OCR_H], "eng") ; benefit tab 1
			Gosub Benefits_Selection_and_Run
			Benefits_OCR_X += Benefits_X_Delta
			Benefits_Click_X := (Benefits_OCR_X + Benefits_X_Delta)
		}
		Gosub Benefits_Center_Reload
		return
	}

	/*

	Capture_Screen_Text := OCR([
		Benefits_OCR_X := 15
		Benefits_OCR_Y := 185
		Benefits_OCR_W := 135
		Benefits_OCR_H := 70
	Capture_Screen_Text := OCR([
		Benefits_OCR_X := 180 ; 15 + 165
		Benefits_OCR_Y := 185
		Benefits_OCR_W := 135
		Benefits_OCR_H := 70
	Capture_Screen_Text := OCR([
		Benefits_OCR_X := 350 ; 180 + 170
		Benefits_OCR_Y := 185
		Benefits_OCR_W := 135
		Benefits_OCR_H := 70
	Capture_Screen_Text := OCR([
		Benefits_OCR_X := 512 ; 350 + 162
		Benefits_OCR_Y := 185
		Benefits_OCR_W := 135
		Benefits_OCR_H := 70

	Benefits_Check_Tabs_Old:
	{
		Benefits_OCR_X := 136
		Benefits_Click_X := (Benefits_OCR_X + 136)
		; Capture_Screen_Text := OCR([170, 184, 160, 72], "eng") ; benefit tab 2
		Capture_Screen_Text := OCR([Benefits_OCR_X, Benefits_OCR_Y, Benefits_OCR_W, Benefits_OCR_H], "eng") ; benefit tab 2
		loop, 2
			Mouse_Click(Benefits_Click_X,Benefits_Click_Y) ; Tap Tab 2 Benefits Center
		Gosub Benefits_Selection_and_Run

		Benefits_OCR_X := 272
		Benefits_Click_X := (Benefits_OCR_X + 136)
		; Capture_Screen_Text := OCR([342, 184, 160, 72], "eng") ; benefit tab 3
		Capture_Screen_Text := OCR([Benefits_OCR_X, Benefits_OCR_Y, Benefits_OCR_W, Benefits_OCR_H], "eng") ; benefit tab 3
		loop, 2
			Mouse_Click(Benefits_Click_X,Benefits_Click_Y) ; Tap Tab 3 Benefits Center
		Gosub Benefits_Selection_and_Run

		Benefits_OCR_X := 408
		Benefits_Click_X := (Benefits_OCR_X + 136)
		; Capture_Screen_Text := OCR([513, 184, 160, 72], "eng") ; benefit tab 4
		Capture_Screen_Text := OCR([Benefits_OCR_X, Benefits_OCR_Y, Benefits_OCR_W, Benefits_OCR_H], "eng") ; benefit tab 4
		loop, 2
			Mouse_Click(Benefits_Click_X,Benefits_Click_Y) ; Tap Tab 4 Benefits Center
		Gosub Benefits_Selection_and_Run

		return
	}
	*/

	Benefits_Selection_and_Run:
	{
		Subroutine_Running := Benefits_Selection_and_Run
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0)) ; wait for tab to load

		loop, 5
		{
			if (Capture_Screen_Text = "")
				Capture_Screen_Text := OCR([Benefits_OCR_X, Benefits_OCR_Y, Benefits_OCR_W, Benefits_OCR_H], "eng")
			else
				break
		}

		loop, 5
		{
			if (Capture_Screen_Text = "")
				Capture_Screen_Text := OCR([0, 288, 300, 112], "eng")
			else
				break
		}

		Capture_Screen_Text := RegExReplace(Capture_Screen_Text,"[\r\n\h-_]+")

		; MsgBox, Text Found:%Capture_Screen_Text%

		If (RegExMatch(Capture_Screen_Text,Monthly_Signin_text))
			Gosub Monthly_Signin
		Else If (RegExMatch(Capture_Screen_Text,Select_Reward_text))
			Gosub Select_Reward
		Else If (RegExMatch(Capture_Screen_Text,Single_Cumulation_text))
			Gosub Single_Cumulation
		Else If (RegExMatch(Capture_Screen_Text,Warrior_Trial_text))
			Gosub Warrior_Trial
		Else If (RegExMatch(Capture_Screen_Text,Selection_Chest_text))
			Gosub Selection_Chest
		Else If (RegExMatch(Capture_Screen_Text,Battle_Honor_text))
			Gosub Battle_Honor_Collect
		Else If (RegExMatch(Capture_Screen_Text,Monthly_Package_text))
			Gosub Monthly_Package_Collect
		Else If (RegExMatch(Capture_Screen_Text,Daily_Signin_text))
			Gosub Daily_Signin
		Else If (RegExMatch(Capture_Screen_Text,Claim_text))
			Gosub Claim_Buttons
		Else If (RegExMatch(Capture_Screen_Text,Daily_Signin_text2))
			Gosub Daily_Signin

		; else
		; MsgBox, 4, Text Not Found, Text Not Found in %Capture_Screen_Text% (4 Second Timeout), 4

		Gosub Benefits_Center_Reload

		Benefits_Text_Found:
		Capture_Screen_Text := ""
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0)) ; wait to read next tab

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
		return
	}

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

	; **************************
	; BEGIN unused section below
	; **************************

	Gosub Monthly_Signin
	Gosub Single_Cumulation
	Gosub Selection_Chest
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Gosub Swipe_Right
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

	Mouse_Click(553,172) ; Tap Tab 4 Benefits Center
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	; MsgBox, 4, , Battle_Honor_Collect (8 Second Timeout & skip), 8
	; vRet := MsgBoxGetResult()
	; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
	; Gosub Battle_Honor_Collect

	; **************************
	; END unused section below
	; **************************

	Swipe_Right:
	loop, 4
	{
		; Benefits Center Swipe Right One position
		Mouse_Drag(630, 187, 353, 187, {EndMovement: T, SwipeTime: 500})
		/*
		Click, 630, 187 Left, Down
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 530, 187, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 430, 187, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 375, 187, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 363, 187, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 353, 187, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 353, 187, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Click, 353, 187 Left, Up
		*/
	}
	return

	Swipe_Right2:
	; 0,136,272,408,544,680
		; Capture_Screen_Text := OCR([0, 180, 160, 80], "eng")
		; Capture_Screen_Text := OCR([160, 180, 160, 80], "eng")
		; Capture_Screen_Text := OCR([320, 180, 160, 80], "eng")
		; Capture_Screen_Text := OCR([480, 180, 160, 80], "eng")
	loop, 2
	{
		; Benefits Center Swipe Right One position
		; Mouse_Drag(580, 187, 116, 187, {EndMovement: T, SwipeTime: 500})
		; Mouse_Drag(580, 187, 90, 187, {EndMovement: T, SwipeTime: 500})
		Mouse_Drag(500, 187, 120, 187, {EndMovement: T, SwipeTime: 500})
	}
	return

	Swipe_Left:
	{
		; Benefits Center Swipe Right One position
		Mouse_Drag(353, 187, 553, 187, {EndMovement: T, SwipeTime: 500})
		return
	}

	Select_Reward:
	{
		if !Select_Reward_Run
			return

		Subroutine_Running := "Select_Reward"

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%

		Mouse_Click(644,512) ; Select Reward - Drop Down Menu
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		; Mouse_Click(570,696) ; Select Reward - Select Tech
		Mouse_Click(570, 936) ; Select Reward - Select Other
		; Mouse_Click(570,602) ; Select Reward - Select Desert
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Mouse_Click(565,995) ; Claim VIP points
		; Mouse_Click(343,750) ; Claim Strengthening also silver medals
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Mouse_Click(320,70) ; Tap top title bar
		; Mouse_Click(379,1172) ; Tap Outside Congrats Popup
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Select_Reward_Run := False
		return
	}

	Monthly_Package_Collect:
	{
		if !Monthly_Package_Collect_Run
			return

		Subroutine_Running := "Monthly_Package_Collect"

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%

		Mouse_Click(500,1200) ; Tap Claim

		Monthly_Package_Collect_Run := False
		return
	}

	Warrior_Trial:
	{
		if !Warrior_Trial_Run
			return

		Subroutine_Running := "Warrior_Trial_Collect"

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
		; Mouse_Click(500,1200) ; Tap Claim

		Mouse_Click(560,1220) ; Select redeem steel
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Mouse_Click(366,680) ; Select max redeem slide bar
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Mouse_Click(336,780) ; Select Exchange button
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Mouse_Click(560,975) ; Select redeem silver medals
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Mouse_Click(366,680) ; Select max redeem slide bar
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Mouse_Click(336,780) ; Select Exchange button
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Warrior_Trial_Run := False
		return
	}

	Single_Cumulation:
	{
		if !Single_Cumulation_Run
			return

		Subroutine_Running := "Single_Cumulation"

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%

		Mouse_Click(560,550) ; Tap Claim

		Single_Cumulation_Run := False
		return
	}

	Claim_Buttons:
	{
		; if !Claim_Buttons_Run
		;	return

		Subroutine_Running := "Claim_Buttons"
		; Mouse_Click(180,1130, {Timeout: Delay_Short+0}) ; Tap Collide

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
		if (OCR([530, 479, 150, 60], "eng") = "Claim") ; Search for "Claim" Text on Button #1
			Mouse_Click(600,500, {Timeout: Delay_Medium+0}), Mouse_Click(300,50, {Timeout: Delay_Medium+0}) ; Tap "Claim" Button 01
		if (OCR([530, 633, 150, 60], "eng") = "Claim") ; Search for "Claim" Text on Button #2
			Mouse_Click(600,660, {Timeout: Delay_Medium+0}), Mouse_Click(300,50, {Timeout: Delay_Medium+0}) ; Tap "Claim" Button 02
		if (OCR([530, 789, 150, 60], "eng") = "Claim") ; Search for "Claim" Text on Button #3
			Mouse_Click(600,800, {Timeout: Delay_Medium+0}), Mouse_Click(300,50, {Timeout: Delay_Medium+0}) ; Tap "Claim" Button 03
		if (OCR([530, 943, 150, 60], "eng") = "Claim") ; Search for "Claim" Text on Button #4
			Mouse_Click(600,970, {Timeout: Delay_Medium+0}), Mouse_Click(300,50, {Timeout: Delay_Medium+0}) ; Tap "Claim" Button 04
		if (OCR([530, 1100, 150, 60], "eng") = "Claim") ; Search for "Claim" Text on Button #5
			Mouse_Click(600,1130, {Timeout: Delay_Medium+0}), Mouse_Click(300,50, {Timeout: Delay_Medium+0}) ; Tap "Claim" Button 05

		; Claim_Buttons_Run := False

		return
	}

	Daily_Signin:
	{
		if !Daily_Signin_Run
			return

		Subroutine_Running := "Daily_Signin"

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
		Mouse_Click(103,553) ; Daily Sign-In Click Day 1
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(343,560) ; Daily Sign-In Click Day 2
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(560,550) ; Select B Reward
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(560,550) ; Select B Reward
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(343,1125) ; Tap "OK"
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(330,1230) ; Tap Bottom Middle
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(560,550) ; Daily Sign-In Click Day 3
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(560,550) ; Select B Reward
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(343,1125) ; Tap "OK"
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(330,1230) ; Tap Bottom Middle
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(556,819) ; Daily Sign-In Click Day 4
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(330,1230) ; Tap Bottom Middle
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(334,819) ; Daily Sign-In Click Day 5
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(330,1230) ; Tap Bottom Middle
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(109,809) ; Daily Sign-In Click Day 6
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(330,1230) ; Tap Bottom Middle
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(330,1035) ; Daily Sign-In Click Day 7
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(560,550) ; Select B Reward
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(343,1125) ; Tap "OK"
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		
		loop, 12
		{
			Mouse_Click(320,70) ; Tap top title bar
			; Mouse_Click(330,1160) ; Tap Bottom Middle
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		}

		loop, 7
		{
			Mouse_Click(320,70) ; Tap top title bar
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}

		; loop, 12
		; Mouse_Click(330,1230) ; Tap Bottom Middle

		Daily_Signin_Run := False

		return
	}

	Monthly_Signin:
	{
		if !Monthly_Signin_Run
			return

		Subroutine_Running := "Monthly_Signin"

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
		; Claim Monthly
		loop, 2
			Mouse_Click(342,1215) ; Tap collect Monthly Signin
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(153,323) ; Claim 5 Days
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Collect_and_Clear

		Mouse_Click(266,323) ; Claim 10 Days
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Collect_and_Clear

		Mouse_Click(380,323) ; Claim 15 Days
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Collect_and_Clear

		Mouse_Click(505,323) ; Claim 20 Days
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Collect_and_Clear

		Mouse_Click(633,323) ; Claim 25 Days
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Collect_and_Clear

		Monthly_Signin_Run := False

		return
	}

	Collect_and_Clear:
	{
		Mouse_Click(340,1000) ; Tap Collect Button
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(340,40) ; 1215) ; Tap to Clear
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		return
	}

	Selection_Chest:
	{
		if !Selection_Chest_Run
			return

		Subroutine_Running := "Selection_Chest"

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%

		Mouse_Click(87,430) ; Tap Free Chest
		DllCall("Sleep","UInt",(rand_wait + 8*Delay_Short+0))

		Mouse_Click(52,682) ; Select 1,000 Diamonds
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Mouse_Click(517,680) ; Select Silver Medal
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		; Swipe Up X times
		loop, 4
			Mouse_Drag(133, 1027, 115, 522, {EndMovement: F, SwipeTime: 500})

		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		Mouse_Click(205,770) ; Select 1,000 Vip Points X 10
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Mouse_Click(520,960) ; Select 500K Strength Abilities Exp
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Mouse_Click(60,960) ; Select Super Officer
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		loop, 2
		{
			Mouse_Click(349,1207) ; Tap Collect
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}
		
		Selection_Chest_Run := False

		return
	}

	Battle_Honor_Collect:
	Subroutine_Running := "Battle_Honor_Collect"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	{
		if !Battle_Honor_Run
			return

		loop, 4
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
			Mouse_Click(260,636, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 01
			Mouse_Click(260,636, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 01
			Mouse_Click(260,720, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 02
			Mouse_Click(260,720, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 02
			Mouse_Click(260,800, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 03
			Mouse_Click(260,800, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 03
			Mouse_Click(260,883, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 04
			Mouse_Click(260,883, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 04
			Mouse_Click(260,963, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 05
			Mouse_Click(260,963, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 05
			Mouse_Click(260,1050, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 06
			Mouse_Click(260,1050, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 06
			Mouse_Click(260,1126, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 07
			Mouse_Click(260,1126, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 07
			Mouse_Click(260,1202, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 08
			Mouse_Click(260,1202, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 08

			return
		}

		Battle_Honor_Swipe:
		{
			Mouse_Drag(350, 1203, 360, 609, {EndMovement: T, SwipeTime: 500})
			/*
			Click, 350, 1203 Left, Down
			Click, 350, 1190 , 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 356, 1135 , 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 365, 1040 , 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 369, 957 , 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 370, 820 , 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 366, 767 , 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 364, 716 , 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 362, 689 , 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 360, 660 , 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 360, 635 , 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 360, 614 , 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 360, 600 , 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 360, 609, 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
			Click, 360, 609, 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
			Click, 360, 609 Left, Up
			*/
			Return
		}

		Battle_Honor_END:

		Battle_Honor_Run := False

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
		return
	}

}

; Tap Speaker/help
Speaker_Help:
{
	Subroutine_Running := "Speaker_Help"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	Search_Captured_Text := ["Claim"]
	OCR_X := 308 ; 290
	OCR_Y := 565 ; 550
	OCR_W := 75 ; 110
	OCR_H := 30 ; 60
	loop, 2
	{
		loop, 2
		{
			Mouse_Click(630,1033) ; Tap speaker/help
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}

		loop, 2
			if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			{
				Mouse_Click(357,570) ; Tap Claim
				DllCall("Sleep","UInt",(rand_wait + 5*Delay_Short+0))
			}
	}

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Drop_Zone:
{
	Subroutine_Running := "Drop_Zone"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(285,200) ; Tap On Drop Zone
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	; Mouse_Click(410,1050) ; Get Steel X Times
	; Search_Captured_Text := ["Click"]
	; loop, 20
	; {
	; Capture_Screen_Text := OCR([359, 1020, 146, 57], "eng")
	; If (RegExMatch(Capture_Screen_Text,Search_Captured_Text))
	; {
	; loop, 5
	; Mouse_Click(410,1050) ; Get Steel X Times
	; }
	; else
	; break
	; }

	; Mouse_Click(410,1050) ; Get Steel X Times
	Search_Captured_Text := ["Click"]
	OCR_X := 365
	OCR_Y := 1020
	OCR_W := 70
	OCR_H := 50	; 100
	loop, 5
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			break

	loop, 5
	{
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			loop, 20
				Mouse_Click(410,1050, {Clicks: 2,Timeout: (1*Delay_Short+0)}) ; Get Steel X Times
		; else
		;	break
	}

	; loop, 40
	; {
	;	Mouse_Click(410,1050) ; Get Steel X Times
	;	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	; }

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Adventure_Missions:
{
	Subroutine_Running := "Adventure_Missions"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Collect_Cafeteria:
{
	Subroutine_Running := "Collect_Cafeteria"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(379,736) ; Collect Cafeteria

	; Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Active_Skill:
{
	Subroutine_Running := "Active_Skill"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(195,1195) ; Tap Activate Skills
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Medium+0))

	Gosub Active_Skill_Reload

	; if !Active_Skill_Detected

	Continue_Active_Skill:

	loop, 2
		Mouse_Click(215,425) ; Active Skill tab #2 - Officer
	Gosub Active_Skill_Click_Button

	; loop, 2
	; Mouse_Click(340,425) ; Active Skill tab #3 - Combat
	; Gosub Active_Skill_Click_Button

	loop, 2
		Mouse_Click(470,425) ; Active Skill tab #4 - Develop
	Gosub Active_Skill_Click_Button

	loop, 2
		Mouse_Click(600,425) ; Active Skill tab #5 - Support
	Gosub Active_Skill_Click_Button

	goto Active_Skill_END

	; Capture_Screen_Text := OCR([70, 600, 124, 60], "eng") ; Button 01
	; Capture_Screen_Text := OCR([275, 600, 124, 60], "eng") ; Button 02
	; Capture_Screen_Text := OCR([480, 600, 124, 60], "eng") ; Button 03
	; Capture_Screen_Text := OCR([70, 815, 124, 60], "eng") ; Button 04
	; Capture_Screen_Text := OCR([275, 815, 124, 60], "eng") ; Button 05
	; Capture_Screen_Text := OCR([480, 815, 124, 60], "eng") ; Button 06

	Active_Skill_Click_Button:
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Medium+0))
	; set variables
	Button_Max_X := 510 ; 480 ; 500 ; 480
	Button_Max_Y := 830 ; 815
	Button_Min_X := 100 ; 90 ; 70 ; 75 ; 70
	Button_Min_Y := 620 ; 610 ; 600 ; 610 ; 600

	Button_OCR_X := Button_Max_X ; delta 71-276-481 = 205
	Button_OCR_Y := Button_Max_Y ; delta 600-815 = 215
	Button_OCR_W := 100 ; 130 ; 100 ; 130
	Button_OCR_H := 40 ; 50 ; 60 ; 40 ; 60
	Button_OCR_X_Delta := 205 ; 203 ; 100, 305 to 510 = 205
	Button_OCR_Y_Delta := 210 ; 215 ; 217 ; 215 ; 620 to 830 = 210
	Click_X_Delta := 60 ; 50 ; 60
	Click_Y_Delta := 15 ; 15 ; 30
	Click_X := (Button_OCR_X + Click_X_Delta)
	Click_Y := (Button_OCR_Y + Click_Y_Delta)

	Active_Skills_Text := ["Harvest", "Special", "Skillful", "Workman", "Ability", "First", "Riches", "Magic", "Clown", "Promotion", "Instructor"]
	Active_Skill_Button_text := ["Use"]
	loop, 6
	{
		; Looking for green use buttons on main active skill interface
		Look_For_Use_Button:
		if !Search_Captured_Text_OCR(Active_Skill_Button_text, {Pos: [Button_OCR_X, Button_OCR_Y], Size: [Button_OCR_W, Button_OCR_H], Timeout: 0}).Found
			Goto Active_Skill_Click_Button_Next

		Active_Skill_Click_Button_NOW:
		Mouse_Click(Click_X,Click_Y) ; Tap Use button found
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		; Looking for Skill titles that match list
		Match_OCR_X := 180
		Match_OCR_Y := 445
		Match_OCR_W := 330
		Match_OCR_H := 36
		loop, 2
		if Search_Captured_Text_OCR(Active_Skills_Text, {Pos: [Match_OCR_X, Match_OCR_Y], Size: [Match_OCR_W, Match_OCR_H], Timeout: 0}).Found
				goto Active_Skill_Skill_Opened

		goto Active_Skill_Click_Button_Next ; No matching title found, examin next button

		Active_Skill_Skill_Opened:
		loop, 3
			Mouse_Click(340,780) ; Tap "Use" button
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Medium+0))

		Active_Skill_Click_Button_Next:
		Gosub Active_Skill_Reload
		Mouse_Click(333,355) ; Tap title bar
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		if (Button_OCR_X <= Button_Min_X)
		{
			Button_OCR_X := Button_Max_X
			if (Button_OCR_Y <= Button_Min_Y)
				Button_OCR_Y := Button_Max_Y
			else
				Button_OCR_Y -= Button_OCR_Y_Delta
		}
		else
			Button_OCR_X -= Button_OCR_X_Delta
		/*	
		if (Button_OCR_X <= 0)
			Button_OCR_X := Button_Max_X			
			
		if (Button_OCR_Y <= 0)
			Button_OCR_Y := Button_Max_Y
		*/

		Click_X := (Button_OCR_X + Click_X_Delta)
		Click_Y := (Button_OCR_Y + Click_Y_Delta)
	}
	return

	Active_Skill_Reload:
	loop, 5
	{
		Search_Captured_Text := ["Active Skill"]
		Active_Skill_OCR_X := 280 ; 260
		Active_Skill_OCR_Y := 350 ; 337
		Active_Skill_OCR_W := 140 ; 174
		Active_Skill_OCR_H := 25 ; 46
		; check to see if active skill is properly displayed x times
		loop, 5
			if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [Active_Skill_OCR_X, Active_Skill_OCR_Y], Size: [Active_Skill_OCR_W, Active_Skill_OCR_H], Timeout: 0}).Found
				return

		; Gosub Get_Window_Geometry
		Gosub Check_Window_Geometry
		Gosub Go_Back_To_Home_Screen
		Mouse_Click(195,1195) ; Tap Activate Skills
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Medium+0))
	}
	return

	Active_Skill_END:
	Gosub Go_Back_To_Home_Screen
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

}

Collect_Chips_Underground:
{
	Subroutine_Running := "Collect_Chips_Underground"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; Tap underground
	; Tap Misslie Silo
	; Tap underground Construsction Center
	; Hit F5 for back button
	; Swipe from lower right to upper left
	; Tap on each Chip Plant
	; Hit F5 for back button

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Reserve_Factory:
{
	Subroutine_Running := "Reserve_Factory"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	; *******************************
	; Collect Reserve supplies
	; *******************************
	Mouse_Click(610,1200) ; Tap Alliance Menu
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	Mouse_Click(355,825) ; Tap Alliance Help
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(480,140) ; Tap Reserve Factory Help
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	if Pause_Script
		MsgBox, 0, Pause, Press OK to resume (No Timeout)

	Mouse_Click(110,340) ; Tap Reserve Factory Icon
	DllCall("Sleep","UInt",(rand_wait + 6*Delay_Long+0))

	loop, 4
	{
		Mouse_Click(344,590) ; Tap Reserve Factory On World Map
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

	; *******************************
	; Upgrade, Add Energy, Use, Etc, X Times
	; *******************************
	Loop, 2
	{
		Mouse_Click(609,1186) ; Tap Alliance Menu
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

		Mouse_Click(383,835) ; Tap Alliance Help
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		Mouse_Click(480,140) ; Tap Reserve Factory Help
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		Mouse_Click(119,336) ; Tap Reserve Factory Icon
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		Mouse_Click(240,613) ; Tap Info Menu On Reserve Factory On World Map
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		; Mouse_Click(324,797) ; Tap Upgrade, Add Energy, Use, Etc, X Times
		loop, 10
		{
			Mouse_Click(324,797) ; Tap Upgrade, Add Energy, Use, Etc, X Times
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}
		Mouse_Click(320,70) ; Tap top title bar
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		Mouse_Click(320,70) ; Tap top title bar
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		
		Mouse_Click(33,62) ; Tap back Button
		; Text_To_Screen("{F5}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}
	
	; *******************************
	; Instant Help and Request Help
	; *******************************
	Mouse_Click(596,1196) ; Tap Alliance Menu
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(440,817) ; Tap Alliance Help
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(480,140) ; Tap Reserve Factory Help
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	loop, 2
	{
		Mouse_Click(320,405) ; Tap Instant Help
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		Mouse_Click(510,415) ; Tap Request Help
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	; Go_Back_Home_Delay_Long := True
	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}


Donate_Tech:
{
	Subroutine_Running := "Donate_tech"

	Search_Captured_Text := ["Technology"]
	loop, 3
	{
		Gosub Donate_Tech_Control_Desk_Expand
		loop, 3
		{
			Gosub Click_Top_Tech
			if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0}).Found
				goto Donate_Tech_Open_NEXT ; Donate_Tech_Open
		}
		Gosub Go_Back_To_Home_Screen
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
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
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

			Inner_Loop_Donation:
			; loop, 2
			{
				Mouse_Click(469,Tech_Click_Y) ; select tech
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

				OCR_Donate_04 := Search_Captured_Text_OCR(["04:"], {Pos: [295, 730], Size: [50, 30], Timeout: 0})
				; OCR_Donate_imm := Search_Captured_Text_OCR(["immediately"], {Pos: [140, 642], Size: [169, 42], Timeout: 0})
				OCR_Donate_Buy := Search_Captured_Text_OCR(["Buy"], {Pos: [70, 820], Size: [55, 35], Timeout: 0})
				
				if (OCR_Donate_04.Found)
					Goto Donations_OVER ; Goto Outer_Loop_Donation_Break ; Break Outer_Loop_Donation
				else if (OCR_Donate_Buy.Found)
				{
					loop, 22
					{
						Loop, 2
						{
							Mouse_Click(420,1000, {Timeout: (1*Delay_Micro+0)}) ; Tap On Donation Box 3
							; DllCall("Sleep","UInt",(1*Delay_Micro+0))
						}
						Loop, 2
						{
							Mouse_Click(260,1000, {Timeout: (1*Delay_Micro+0)}) ; Tap On Donation Box 2
							; DllCall("Sleep","UInt",(1*Delay_Micro+0))
						}
						Loop, 2
						{
							Mouse_Click(100,1000, {Timeout: (1*Delay_Micro+0)}) ; Tap On Donation Box 1
							DllCall("Sleep","UInt",(3*Delay_Micro+0))
						}
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
				MsgBox, 0, OCR return, % "Was value (F)ound? Using what (V)alue? Found (T)ext:`n" VAR1 "`n" VAR2 "`n" VAR3
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
		{
			Mouse_Click(7,637) ; Tap to Expand Control Desk
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		}
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
			Mouse_Click(Click_X,Click_Y) ; Tap To expand previous Rank Tech
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
			; Gosub Donate_Tech_Find_And_Click
			return

			Donate_Tech_Collapse_Tech_Next:
			{
				Tech_Click_Initial := (Click_Y + 110)
				Mouse_Click(Click_X,Click_Y) ; Tap To Collapse Rank Tech
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
			}

			if (OCR_Y >= Max_Y)
				break

			if (OCR_Y < Max_Y)
				OCR_Y += OCR_Y_Delta

			Click_Y := (OCR_Y + 25)
			Gosub Click_Top_Tech
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
			Capture_Screen_Text := ""

		}
		return
	}

	Click_Top_Tech:
	loop, 3
	{
		Mouse_Click(340,70) ; Tap header
		DllCall("Sleep","UInt",(2*Delay_Micro+0))
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}
	return
	
	Donations_OVER:
	Gosub Go_Back_To_Home_Screen
	return
}

Depot_Rewards:
{
	Subroutine_Running := "Depot_Rewards"

	; set variables
	Depot_Rewards_Button_Text_Array := ["Free","Reward","Request","Help"]

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	loop, 2
	{
		Mouse_Click(140,662, {Timeout: 1*Delay_Long+0}) ; Tap depot
		Mouse_Click(250,722, {Timeout: 1*Delay_Long+0}) ; Tap Alliance Treasures
	}
	; DllCall("Sleep","UInt",rand_wait + (3*Delay_Medium))

	Search_Captured_Text := ["Treasures"]
	loop, 5
	{
		loop, 3
			if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0}).Found
				goto Continue_Depot_Treasures

		Gosub Go_Back_To_Home_Screen
		Mouse_Click(140,662, {Timeout: 1*Delay_Long+0}) ; Tap depot
		Mouse_Click(250,722, {Timeout: 1*Delay_Long+0}) ; Tap Alliance Treasures
		; DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))
	}
	goto Depot_Rewards_END

	Continue_Depot_Treasures:

	Mouse_Click(105,150) ; Tap Tab 1 Treasure list
	Gosub Depot_Click_Button

	Mouse_Click(340,150) ; Tap Tab 2 My Treasures
	Gosub Depot_Click_Button

	Mouse_Click(570,150) ; Tap Tab 3 Help_List
	Gosub Depot_Click_Button

	Depot_Rewards_END:
	Gosub Go_Back_To_Home_Screen
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

	Depot_Click_Button:
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	; set variables
	Max_X := Min_X := 510	; 515
	Max_Y := (Min_Y + 3*OCR_Y_Delta) ; 1200
	; Min_X := 500
	Min_Y := 415	; 400
	OCR_X := Min_X ; delta 71-276-481 = 205
	OCR_Y := Min_Y ; delta 600-815 = 215
	OCR_W := 130	; 150 ; X = 510-650
	OCR_H := 30	; 50 ; Y = 400-450
	OCR_X_Delta := 0
	OCR_Y_Delta := 202	; 200
	Click_X_Delta := 75
	Click_Y_Delta := 25
	Click_X := (OCR_X + Click_X_Delta)
	Click_Y := (OCR_Y + Click_Y_Delta)

	loop, 8
	{
		; Looking for Rewards Button titles that match list
		if !Search_Captured_Text_OCR(Depot_Rewards_Button_Text_Array, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			goto Next_Depot_Button

		Depot_Rewards_Click_Found_Item:
		Mouse_Click(Click_X,Click_Y, {Timeout: 1*Delay_Medium+0}) ; Tap found button
		Mouse_Click(320,70) ; Tap top title bar
		; Mouse_Click(340,70, {Timeout: 1*Delay_Short+0}) ; Tap Outside Rewards Box
		; DllCall("Sleep","UInt",rand_wait + (4*Delay_Short))

		Next_Depot_Button:
		if (OCR_Y >= Max_Y)
			OCR_Y := Min_Y
		else
			OCR_Y += OCR_Y_Delta
		Click_Y := (OCR_Y + Click_Y_Delta)
	}
	return

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

VIP_Shop:
{
	Subroutine_Running := "VIP_Shop"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(156,90) ; Tap VIP Shop
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Search_Captured_Text := ["VIP Shop"]
	loop, 2
	{
		loop, 2
			if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0}).Found
				goto Continue_VIP_Shop

		Gosub Go_Back_To_Home_Screen
		Mouse_Click(156,90) ; Tap VIP Shop
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	}
	goto VIP_Shop_END

	Continue_VIP_Shop:
	; Button01 := 225, 575 ; (delta X:80, Y:100)
	; Button02 := 560, 575 ; (delta X:80, Y:100)
	; Button03 := 225, 745 ; (delta X:80, Y:100)
	; Button04 := 560, 745 ; (delta X:80, Y:100)

	Gosub VIP_Shop_Click_Button

	VIP_Shop_END:
	Gosub Go_Back_To_Home_Screen
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
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
		if !Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			goto VIP_Shop_Click_Button_Next

		VIP_Shop_Click_Found_Item:
		Mouse_Click(Click_X,Click_Y) ; Tap VIP item to purchase
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
		Mouse_Click(350,890) ; confirm purchase
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
		Mouse_Click(320,70) ; Tap top title bar
		; Mouse_Click(350,1150) ; Tap Outside Rewards Box
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Medium+0))

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
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Mail_Collection:
{
	Subroutine_Running := "Mail_Collection"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen
	
	Mail_Keyword_Array := ["Mail","Activities","Alliance","Last Empire","System"]
	Mail_BACK2_Array := ["Alliance Arms","Cross-State","Desert Conflict","Other Event","Single Player","Arms Race"]
	
	Gosub Mail_Collection_Open

	Mouse_Click(200,272) ; Tap Alliance
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Mouse_Click(200,545) ; Tap Last Empire - War Z Studios
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Mouse_Click(200,633) ; Tap System
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Mouse_Click(200,760) ; Tap reports 01 - RSS gathering 
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Mouse_Click(200,860) ; Tap reports 02 - Zombies
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Mouse_Click(200,960) ; Tap reports 03 - Missile attack
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Mouse_Click(200,1060) ; Tap reports 04 - Transport
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Mouse_Click(200,1160) ; Tap reports 05 - Other
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Mouse_Click(200,445) ; Tap Activities
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

	Subroutine_Running := "Single Player Arms Race"
	Mouse_Click(200,170) ; Tap Activities - SPAR (Single Player Arms Race)
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Subroutine_Running := "Alliance Arms Race"
	Mouse_Click(200,257) ; Tap Activities - AAR (Alliance Arms Race)
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Subroutine_Running := "Cross-State Battle"
	Mouse_Click(200,360) ; Tap Activities - CSB (Cross-State Battle)
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Subroutine_Running := "Desert Conflict"
	Mouse_Click(200,445) ; Tap Activities - Desert Conflict
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Subroutine_Running := "Other Event Mail"
	Mouse_Click(200,540) ; Tap Activities - Other Event Mail
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

	Mark_All_As_Read:
	Subroutine_Running := "Mark_All_As_Read"
	Loop, 2
	{
		if Search_Captured_Text_OCR(["MARK","READ"], {Pos: [273, 1185], Size: [142, 26], Timeout: 0}).Found ; Is the Mark as Read button displayed?
		{
			Mouse_Click(340,1200) ; Tap "MARK AS READ" button
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
			Mouse_Click(202,705) ; Tap "CONFIRM" button
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
			Mouse_Click(340,70) ; Tap header to clear message
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}
	}
	; Tap Message back
	; loop, 2
	; {
	; 	Mouse_Click(50,60) ; Tap Message back
	; 	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	; }
	gosub Mail_Collection_Open
	return
	
	Mail_Collection_Open:
	Subroutine_Running := "Mail_Collection_Open"
	loop, 2
	{
		loop, 5
		{
			; if mail loaded, return
			if Search_Captured_Text_OCR(["Mail"], {Pos: [309, 46], Size: [76, 50], Timeout: 0}).Found
				return ; Gosub, Read_Mail_Open
				
			; if mail not loaded, tap on mail icon
			if Search_Captured_Text_OCR(["Mail"], {Pos: [466, 1222], Size: [56, 24], Timeout: 0}).Found
			{
				Mouse_Click(500,1200) ; Tap Mail
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
				Goto, Mail_Collection_Open
			}

			; if mail not loaded and mail icon not available, go back
			Mouse_Click(50,60) ; Tap Message back
			Text_To_Screen("{F5}")
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		}
		Gosub Go_Back_To_Home_Screen
	}
	return
}

Alliance_Boss_Regular:
{
	Subroutine_Running := "Alliance_Boss"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	Mouse_Click(610,1214) ; Tap Alliance
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	; Swipe up
	loop, 2
		Mouse_Drag(345, 1100, 409, 196, {EndMovement: F, SwipeTime: 500})
	/*
	{
		Click, 345, 1100 Left, Down
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Click, 370, 1003, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Click, 409, 196 Left, Up
	}
	*/
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(273,540) ; Tap Alliance Boss regular play
	; Mouse_Click(273,630) ; Tap Alliance Boss desert oasis
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(525,1186) ; Tap Feed Boss
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(340,780) ; Tap Confirm Feed Boss

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Alliance_Boss_Oasis:
{
	Subroutine_Running := "Alliance_Boss"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	Mouse_Click(610,1214) ; Tap Alliance
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	; Swipe up
	loop, 2
		Mouse_Drag(345, 1100, 409, 196, {EndMovement: F, SwipeTime: 500})
	/*
	{
		Click, 345, 1100 Left, Down
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Click, 370, 1003, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Click, 409, 196 Left, Up
	}
	*/
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	; Mouse_Click(273,540) ; Tap Alliance Boss regular play
	Mouse_Click(273,630) ; Tap Alliance Boss desert oasis
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(525,1186) ; Tap Feed Boss
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(340,780) ; Tap Confirm Feed Boss

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Alliance_Wages:
{
	Subroutine_Running := "Alliance_Wages"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	Goto Alliance_Menu_Wages

	Control_Desk_Alliance_Wages:
	{

		Mouse_Click(27,612) ; Tap to Expand Control Desk
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		; Swipe Down (linear)
		loop, 2
			Mouse_Drag(326, 405, 326, 957, {EndMovement: F, SwipeTime: 500})
		/*
		{
			Click, 326, 405 Left, Down
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 326, 474, 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 326, 543, 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 326, 680, 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 326, 957 Left, Up
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		}
		*/
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		Loop, 2
			Mouse_Click(470,960) ; Tap Goto Alliance Wages

		Goto Alliance_Wages_Continue
	}

	Alliance_Menu_Wages:
	{

		Mouse_Click(605,1212) ; Tap Alliance Menu
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		Search_Captured_Text := ["Wages"]
		OCR_X := 230
		OCR_Y := 920
		OCR_W := 100
		OCR_H := 60
		loop, 5
		{
			loop, 3
			{
				OCR_Y := 920
				if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
				{
					Mouse_Click(405,932) ; Tap Alliance Wages button
					goto Found_Alliance_Wages_Menu
				}

				OCR_Y := 1020
				if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
				{
					Mouse_Click(405,1044) ; Tap Alliance Wages button
					goto Found_Alliance_Wages_Menu
				}
			}

			Gosub Go_Back_To_Home_Screen
			Mouse_Click(605,1212) ; Tap Alliance Menu
		}
		goto Alliance_Wages_END

		Found_Alliance_Wages_Menu:
		Gosub Alliance_Wages_Continue

		Alliance_Wages_END:
		Gosub Go_Back_To_Home_Screen
		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
		return
	}

	Alliance_Wages_Continue:
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	; Alliance Wages - Active (TAB 1)
	Alliance_Wages_Active_TAB_1:
	Subroutine_Running := "Alliance_Wages_Active_TAB_1"
	{
		; Gosub Click_Through_Wage_Tabs
		Gosub Click_Points_Boxes
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		goto END_Alliance_Wages_Active_TAB_1

		TRY_MORE_01_Alliance_Wages_Active_TAB_1:
		Gosub Click_Through_Wage_Tabs
		; Swipe Right
		loop, 5
			Mouse_Drag(216, 647, 624, 647, {EndMovement: F, SwipeTime: 500})
		/*
		{
			Click, 216, 647 Left, Down
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 275, 647, 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 324, 647, 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 424, 647, 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 624, 647 Left, Up
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		}
		*/
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
		Gosub Click_Points_Boxes
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

		; MsgBox, 4, , Retry? (8 Second Timeout & skip), 8
		; vRet := MsgBoxGetResult()
		; if (vRet = "No")
		; goto Alliance_Wages_Active_TAB_2

		TRY_MORE_02_Alliance_Wages_Active_TAB_1:
		Gosub Click_Through_Wage_Tabs
		; Swipe Left
		loop, 5
			Mouse_Drag(624, 647, 216, 647, {EndMovement: F, SwipeTime: 500})
		/*
		{
			Click, 624, 647 Left, Down
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 424, 647, 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 324, 647, 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 275, 647, 0
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Click, 216, 647 Left, Up
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		}
		*/
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
		Gosub Click_Points_Boxes
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

		END_Alliance_Wages_Active_TAB_1:
		; MsgBox, 4, , Retry? (8 Second Timeout & skip), 8
		; vRet := MsgBoxGetResult()
		; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		; goto TRY_MORE_01_Alliance_Wages_Active_TAB_1
	}

	; Alliance Wages - Active (TAB 2)
	Alliance_Wages_Active_TAB_2:
	Subroutine_Running := "Alliance_Wages_Active_TAB_2"
	{
		Mouse_Click(335,390) ; Tap Alliance Wages - Attendance (TAB 2)
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		loop, 3
		{
			Mouse_Click(134,725) ; Tap Attendance 1
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}

		; loop, 3
			; Mouse_Click(134,725) ; Tap Attendance 1
		; DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

		loop, 3
		{
			Mouse_Click(280,730) ; Tap Attendance 30
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}

		; loop, 3
			; Mouse_Click(280,730) ; Tap Attendance 30
		; DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

		loop, 3
		{
			Mouse_Click(615,726) ; Tap Attendance 50
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}

		; loop, 3
			; Mouse_Click(615,726) ; Tap Attendance 50
		; DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
	}

	; Alliance Wages - Active (TAB 3)
	Alliance_Wages_Active_TAB_3:
	Subroutine_Running := "Alliance_Wages_Active_TAB_3"
	{

		loop, 2
			Mouse_Click(562,390) ; Tap Alliance Wages - Contribution (TAB 3)
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		loop, 3
		{
			Mouse_Click(140,726) ; Tap Alliance Contribution Box 1
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}

		loop, 3
		{
			Mouse_Click(275,726) ; Tap Alliance Contribution Box 2
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}

		loop, 3
		{
			Mouse_Click(410,726) ; Tap Alliance Contribution Box 3
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}

		loop, 3
		{
			Mouse_Click(622,726) ; Tap Alliance Contribution Box 4
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}
	}
	return

	Click_Through_Wage_Tabs:
	{
		Mouse_Click(335,390) ; Tap Alliance Wages - Attendance (TAB 2)
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Mouse_Click(562,390) ; Tap Alliance Wages - Contribution (TAB 3)
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Mouse_Click(112,390) ; Tap Alliance Wages - Active (TAB 1)
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		return
	}

	Click_Points_Boxes:
	{
		; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
		Mouse_Click(40,650) ; Tap Points Box 30
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(100,650) ; Tap Points Box 30
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(160,650) ; Tap Points Box 70
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(220,650) ; Tap Points Box 70
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(280,650) ; Tap Points Box 120
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(340,650) ; Tap Points Box 120
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(400,650) ; Tap Points Box 180
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(460,650) ; Tap Points Box 180
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(520,650) ; Tap Points Box 260
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(580,650) ; Tap Points Box 260
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Click_Collect_Daily_Rewards_Chest

		Mouse_Click(640,650) ; Tap Points Box 340
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Gosub Click_Collect_Daily_Rewards_Chest

		return
	}

	Click_Collect_Daily_Rewards_Chest:
	{
		; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

		Mouse_Click(352,982) ; Tap Collect Daily Rewards Chest
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		Mouse_Click(320,70) ; Tap top title bar
		; Mouse_Click(366,175) ; Tap Outside Chest
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

		return
	}

}

Train_Daily_Requirement:
{
	Subroutine_Running := "Train_Daily_Requirement"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	Gosub Reset_Posit
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	; Zoom out
	loop, 10
	{
		Text_To_Screen("{F2}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2
	{

		Mouse_Click(474,1186) ; Tap Mail
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

		Mouse_Click(50,60) ; Tap Message back
		; Mouse_Click(630,75) ; Tap Message back
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

		; Zoom out
		loop, 10
		{
			Text_To_Screen("{F2}")
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		}
	}

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; Zoom out
	loop, 10
	{
		Text_To_Screen("{F2") ; 2}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	; Swipe Right
	; Mouse_Click(250,650) ; Swipe Right
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	; Click, 400, 650, 0
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	; Click, 475, 650, 0
	; DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
	; Click, 512, 650, 0
	; DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
	; Click, 530, 650, 0
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	; Click, 550, 650 Left, Up

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Tap Vehicle Factory
	; Mouse_Click(393,985); Tap Vehicle Factory
	loop, 2
	{
		Mouse_Click(390,940) ; Tap Vehicle Factory
		Gosub Click_Middle_Screen
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	}
	; Tap Train Button
	Mouse_Click(530,964) ; Mouse_Click(530,986)
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Gosub Training_Number

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	
	; Mouse_Click(183,852) ; Tap Warrior Camp
	loop, 2
	{
		Mouse_Click(220,845) ; Tap Warrior Camp
		Gosub Click_Middle_Screen
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	}
	; Tap Train Button
	Mouse_Click(354,879) ; Tap Train Button
	; Mouse_Click(324,872) ; Tap Train Button
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Gosub Training_Number

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	
	; Mouse_Click(63,770) ; Tap Shooter Camp
	loop, 2
	{
		Mouse_Click(100,800) ; Tap Shooter Camp
		Gosub Click_Middle_Screen
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	}
	; Tap Train Button
	Mouse_Click(240,850) ; Tap Train Button
	; Mouse_Click(270,833) ; Tap Train Button
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Gosub Training_Number

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; Mouse_Click(10,730) ; Tap Biochemical Center
	loop, 2
		{
		Mouse_Click(10,717) ; Tap Biochemical Center
		Gosub Click_Middle_Screen
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	}
	; Tap Train Button
	Mouse_Click(250,755) ; Mouse_Click(275,732)
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Gosub Training_Number

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

	Training_Number:
	{
		; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

		Mouse_Click(550,1100) ; Tap Troop Number Box
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		loop, 8
		{
			Text_To_Screen("{Backspace}")
			DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
		}
		Text_To_Screen("{3}")
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
		Text_To_Screen("{0}")
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
		Text_To_Screen("{0}")
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
		Text_To_Screen("{Enter}")
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

		Mouse_Click(509,1189) ; Tap Train Now

		Gosub Go_Back_To_Home_Screen

		return
	}
}

Gather_Resources:
{
	Subroutine_Running := "Gather_Resources"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	Mouse_Click(76,1200) ; Tap World/home button
	DllCall("Sleep","UInt",(rand_wait + 8*Delay_Long+0))

	Gather_Fuel:
	Subroutine_Running := "Gather_Fuel"
	; Tap search button x times
	loop, 2
	{
		Mouse_Click(627,1069) ; Mouse_Click(627,1034)
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

	; Swipe right x times
	loop, 2
		Mouse_Drag(100, 990, 600, 990, {EndMovement: F, SwipeTime: 500})
	/*
	{
		; World search Swipe Right One position

		Click, 100, 990 Left, Down
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 350, 990, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 475, 990, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 562, 990, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 600, 990 Left, Up
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}
	*/
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	MsgBox, 4, , Gather Oil Well? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		{
			Mouse_Click(407,974) ; Tap Oil Well
			Gosub Search_And_Deploy_Resources
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		}

	Gather_Farm:
	Subroutine_Running := "Gather_Farm"
	MsgBox, 4, , Gather Farm? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		{
			Mouse_Click(547,970) ; Tap Farm
			Gosub Search_And_Deploy_Resources
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		}

	Gather_Steel:
	Subroutine_Running := "Gather_Steel"
	; Tap search button x times
	loop, 2
	{
		Mouse_Click(627,1069) ; Mouse_Click(627,1034)
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

	; Swipe left x times
	loop, 2
		Mouse_Drag(600, 990, 100, 990, {EndMovement: F, SwipeTime: 500})
	/*
	{
		; World search Swipe Right One position
		Click, 600, 990 Left, Down
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 562, 990, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 475, 990, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 350, 990, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 100, 990 Left, Up
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}
	*/
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	MsgBox, 4, , Gather Steel Mill? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		{
			Mouse_Click(124,983) ; Tap Steel Mill
			Gosub Search_And_Deploy_Resources
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		}

	Gather_Alloy:
	Subroutine_Running := "Gather_Alloy"
	; Swipe left x times
	loop, 2
		Mouse_Drag(600, 990, 100, 990, {EndMovement: F, SwipeTime: 500})
	/*
	{
		; World search Swipe Right One position
		Click, 600, 990 Left, Down
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 562, 990, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 475, 990, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 350, 990, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 100, 990 Left, Up
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}
	*/
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	MsgBox, 4, , Gather Alloy Mine? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		{
			Mouse_Click(270,970) ; Tap Alloy Mine
			Gosub Search_And_Deploy_Resources
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		}

	MsgBox, 4, , Gather more? (10 Second Timeout & skip), 10
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		Gosub Gather_Fuel

	End_Gathering:

	; Go_Back_Home_Delay_Long := True
	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

	Search_And_Deploy_Resources:
	{
		; Tap Level Box
		Mouse_Click(637,1112) ; Mouse_Click(637,1112+0)
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Text_To_Screen("{6}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Text_To_Screen("{Enter}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Mouse_Click(346,1200) ; Tap Search Button
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Medium+0))

		Mouse_Click(440,640) ; Tap Gather Button

		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		Select_Gather_Officers:
		{
			Mouse_Click(525,437) ; Tap Officer 5
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Mouse_Click(319,350) ; Tap Above Officer In Case Already Marching
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

			Mouse_Click(407,434) ; Tap Officer 4
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Mouse_Click(319,350) ; Tap Above Officer In Case Already Marching
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

			Mouse_Click(300,435) ; Tap Officer 3
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Mouse_Click(319,350) ; Tap Above Officer In Case Already Marching
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

			Mouse_Click(180,440) ; Tap Officer 2
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Mouse_Click(319,350) ; Tap Above Officer In Case Already Marching
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

			Mouse_Click(54,436) ; Tap Officer 1
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
			Mouse_Click(319,350) ; Tap Above Officer In Case Already Marching
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		}
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		Mouse_Click(480,1186) ; Tap March
		DllCall("Sleep","UInt",(rand_wait + 8*Delay_Short+0))

		; Mouse_Click(54,965) ; Tap Do Not Remind Me Again
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		Mouse_Click(560,1020) ; Tap Deploy
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		; Tap search button x times
		loop, 2
		{
			Mouse_Click(627,1069) ; Mouse_Click(627,1034)
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
		return
	}
}

Desert_Oasis:
{
	Subroutine_Running := "Desert_Oasis"
	
	loop, 3
		if Enter_Coordinates_From_Home()
			gosub Desert_Oasis_Enter_Coordinates_Next
	
	goto END_Stealing
	
	Desert_Oasis_Enter_Coordinates_Next:
	Subroutine_Running := "Desert_Oasis_Enter_Coordinates_Next"
	{
		; Mouse_Click(242,526) ; Tap inside X Coordinate Text box
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

		; NW_Tower Coordinates X: 595-596 Y: 599-600 (595,599) steal: 439, 681
		; NE_Tower Coordinates X: 599-600 Y: 595-596 (599,595) steal: 441, 681
		; SW_Tower Coordinates X: 599-600 Y: 604-605 (599,604) steal: 447, 678
		; SE_Tower Coordinates X: 604-605 Y: 599-600 (604,599) steal: 440, 680

		; if none selected, auto Steal from:
		; goto NW_Tower
		; goto NE_Tower
		; goto SW_Tower
		goto SE_Tower
		; goto END_Stealing

		MsgBox, 4, , Steal from NW_Tower (595:599)? (8 Second Timeout & skip), 8
		vRet := MsgBoxGetResult()
		if (vRet = "Yes")
			goto NW_Tower

		MsgBox, 4, , Steal from NE_Tower(599:595)? (8 Second Timeout & skip), 8
		vRet := MsgBoxGetResult()
		if (vRet = "Yes")
			goto NE_Tower

		MsgBox, 4, , Steal from SW_Tower(600:604)? (8 Second Timeout & skip), 8
		vRet := MsgBoxGetResult()
		if (vRet = "Yes")
			goto SE_Tower

		MsgBox, 4, , Steal from SE_Tower(604:599)? (8 Second Timeout & skip), 8
		vRet := MsgBoxGetResult()
		if (vRet = "Yes")
			goto SE_Tower

		; if none selected, auto Steal from:
		; goto NW_Tower
		; goto NE_Tower
		; goto SW_Tower
		goto SE_Tower
		return ; goto END_Stealing

		NW_Tower:
		{
			Desert_Tower_X := "{Raw}595"
			Desert_Tower_Y := "{Raw}599"
			goto Desert_Oasis_Tower
		}

		NE_Tower:
		{
			Desert_Tower_X := "{Raw}599"
			Desert_Tower_Y := "{Raw}595"
			goto Desert_Oasis_Tower
		}

		SW_Tower:
		{
			Desert_Tower_X := "{Raw}599"
			Desert_Tower_Y := "{Raw}604"
			goto Desert_Oasis_Tower
		}

		SE_Tower:
		{
			Desert_Tower_X := "{Raw}604"
			Desert_Tower_Y := "{Raw}599"
			goto Desert_Oasis_Tower
		}

		; if none selected, auto go to
		{
			Desert_Tower_X := "{Raw}599"
			Desert_Tower_Y := "{Raw}595"
			goto Desert_Oasis_Tower
		}

		return ; goto END_Stealing

		Desert_Oasis_Tower:
		Subroutine_Running := "Desert_Oasis_Tower"
		; NW_Tower Coordinates X: 595-596 Y: 599-600 (595,599) steal: 439, 681
		; NE_Tower Coordinates X: 599-600 Y: 595-596 (599,595) steal: 441, 681
		; SW_Tower Coordinates X: 599-600 Y: 604-605 (599,604) steal: 447, 678
		; SE_Tower Coordinates X: 604-605 Y: 599-600 (604,599) steal: 440, 680
		; MsgBox, 4, Coordinates, Are Desert_Tower_X`,Y %Desert_Tower_X% %Desert_Tower_X% Correct? (8 Second Timeout & auto),8

		loop, 2
		{
			Mouse_Click(242,526) ; Tap inside X Coordinate Text box
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Text_To_Screen(Desert_Tower_X)
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Text_To_Screen("{Enter}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		loop, 2
		{
			Mouse_Click(484,530) ; Tap inside Y Coordinate Text box
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Text_To_Screen(Desert_Tower_Y)
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Text_To_Screen("{Enter}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Mouse_Click(340,620) ; Tap Go to Coordinates
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Long+0))
		Mouse_Click(340,680) ; Tap on Holy Tower
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
		Mouse_Click(440,680) ; Tap Holy Tower Steal button
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		Desert_Oasis_Coordinates_Text := ["Steal"]
		OCR_X := 315
		OCR_Y := 1190
		OCR_W := 55
		OCR_H := 30
		loop, 2
		{
			loop, 5
				if Search_Captured_Text_OCR(Desert_Oasis_Coordinates_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
					Goto Desert_Oasis_Stealing_Found
					
			Mouse_Click(590,690) ; Tap Close Steal dialog if open
			if !Enter_Coordinates_From_World()
				return
		}
		return ; goto END_Stealing

		Desert_Oasis_Stealing_Found:

		DllCall("Sleep","UInt",(rand_wait + 5*Delay_Long+0))
		Mouse_Click(340,1200) ; Tap Steal
		DllCall("Sleep","UInt",(rand_wait + 5*Delay_Long+0))
		return ; goto END_Stealing
	}

	END_Stealing:

	if Pause_Script
		MsgBox, 0, Pause, Press OK to resume (No Timeout)

	; Go_Back_Home_Delay_Long := True
	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}


Enter_Coordinates_From_Home()
{
	Subroutine_Running := "Enter_Coordinates_From_Home"
	Mouse_Click(73,1207) ; Tap on World Button
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Long+0))
	
	loop, 2
		if Enter_Coordinates_From_World()
			return 1
	
	Gosub Go_Back_To_Home_Screen
	return 0
}

Enter_Coordinates_From_World()
{
	Subroutine_Running := "Enter_Coordinates_From_World"
	Mouse_Click(337,1000) ; Tap on Enter Coordinates Button
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	
	loop, 2
		if Enter_Coordinates_Open_Check()
			return 1
	
	Gosub Check_Window_Geometry
	return 0
}

Enter_Coordinates_Open_Check()
{
	Subroutine_Running := "Enter_Coordinates_Open_Check"
	Coordinates_Box_Text := ["Enter","coordinates"]
	OCR_X := 237
	OCR_Y := 303
	OCR_W := 220
	OCR_H := 40
	loop, 5
		if Search_Captured_Text_OCR(Coordinates_Box_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0}).Found
			return 1
	return 0
}

Gather_On_Base_RSS:
{
	Subroutine_Running := "Gather_On_Base_RSS"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	Swipe_Up_Left_RSS:
	loop, 5
	{
		Mouse_Drag(560, 900, 50, 600, {EndMovement: F, SwipeTime: 300})
		; Mouse_Drag(480, 786, 143, 50, {EndMovement: F, SwipeTime: 500})
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(405,653) ; Plot # 50
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(396,553) ; Plot # 49
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(397,453) ; Plot # 47
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(350,374) ; Plot # 35
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(330,280) ; Plot # 34
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(239,233) ; Plot # 32
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	; inserts pause
	; Search_Captured_Text := ["Desert"]
	; Capture_Screen_Text := OCR([236, 40, 215, 57], "eng") ; check if
	; If (RegExMatch(Capture_Screen_Text,Search_Captured_Text))
	
	if Search_Captured_Text_OCR(["Desert"], {Timeout: 0}).Found
		Goto END_Gather_Base_RSS

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(305,587) ; Plot # 48
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(292,509) ; Plot # 46
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(250,337) ; Plot # 33
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(160,282) ; Plot # 31
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(137,817) ; Plot # 40
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(36,760) ; Plot # 39 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	loop, 2 {
		Mouse_Click(29,726) ; Plot # 37 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}
	; DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	; inserts pause
	; Search_Captured_Text := ["Desert"]
	; Capture_Screen_Text := OCR([236, 40, 215, 57], "eng") ; check if
	; If (RegExMatch(Capture_Screen_Text,Search_Captured_Text))
	
	if Search_Captured_Text_OCR(["Desert"], {Timeout: 0}).Found
		Goto END_Gather_Base_RSS

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(130,827) ; Plot # 38
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(40,770) ; Plot # 36 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(445,583) ; Plot # 45
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(367,542) ; Plot # 43
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(272,493) ; Plot # 41
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(485,510) ; Plot # 44
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(380,462) ; Plot # 42
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	Swipe_Right_RSS_02:
	Mouse_Drag(147, 854, 330, 649, {EndMovement: T, SwipeTime: 500})
	; Mouse_Drag(147, 854, 373, 649, {EndMovement: T, SwipeTime: 500})
	/*
	{
		Click, 147, 854 Left, Down
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 263, 729, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 269, 726, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 270, 724, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 326, 697, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 346, 680, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 346, 676, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 350, 676, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 350, 674, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 350, 674, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 373, 649, 0
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		Click, 373, 649 Left, Up
	}
	*/

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(307,424) ; Plot # 29
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(400,376) ; Plot # 30
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(360,293) ; Plot # 28
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(167,412) ; Plot # 26
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(273,354) ; Plot # 27
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(110,600) ; Plot # 24 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	loop, 2 {
		Mouse_Click(34,540) ; Plot # 22 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(160,680) ; Plot # 25
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(110,644) ; Plot # 23 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	loop, 2 {
		Mouse_Click(74,593) ; Plot # 21 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
	
	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(167,826) ; Plot # 19
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(86,770) ; Plot # 17 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(310,780) ; Plot # 20
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(202,710) ; Plot # 18
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	loop, 2 {
		Mouse_Click(114,665) ; Plot # 16 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}
	; DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	END_Gather_Base_RSS:
	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Golden_Chest:
{
	Subroutine_Running := "Golden_Chest"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen
	
	if !Activity_Center_Open()
		goto Golden_Chest_END
	/*
	loop, 2
	{
		Mouse_Click(630,530) ; Tap Activity Center
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Medium+0))
		loop, 5
			if Search_Captured_Text_OCR(["Activity Center"], {Timeout: 0}).Found
				goto Golden_Chest_Next
		Gosub Go_Back_To_Home_Screen
	}
	goto Golden_Chest_END
	*/
					
	Golden_Chest_Next:
	Golden_Chest_Text := ["Golden"]
	loop, 3
	{
		; Capture_Screen_Text := OCR([181, 596, 80, 33], "eng") ; Check Activity Center item 01
		if Search_Captured_Text_OCR(Golden_Chest_Text, {Pos: [180, 596], Size: [120, 33], Timeout: 0}).Found
		{
			Mouse_Click(180, 596) ; Tap Activity Center item 01
			goto Golden_Chest_Open_for_free_button
		}
		
		; Capture_Screen_Text := OCR([181, 790, 80, 33], "eng") ; Check Activity Center item 02
		if Search_Captured_Text_OCR(Golden_Chest_Text, {Pos: [180, 790], Size: [120, 33], Timeout: 0}).Found
		{
			Mouse_Click(180, 793) ; Tap Activity Center item 02
			goto Golden_Chest_Open_for_free_button
		}
		
		; Capture_Screen_Text := OCR([181, 985, 80, 33], "eng") ; Check Activity Center item 03
		if Search_Captured_Text_OCR(Golden_Chest_Text, {Pos: [180, 985], Size: [120, 33], Timeout: 0}).Found
		{
			Mouse_Click(180, 989) ; Tap Activity Center item 03
			goto Golden_Chest_Open_for_free_button
		}
		
		; Capture_Screen_Text := OCR([181, 1182, 80, 33], "eng") ; Check Activity Center item 04
		if Search_Captured_Text_OCR(Golden_Chest_Text, {Pos: [180, 1182], Size: [120, 33], Timeout: 0}).Found
		{
			Mouse_Click(180, 1182) ; Tap Activity Center item 04
			goto Golden_Chest_Open_for_free_button
		}
	}
	; MsgBox, 0, Pause, Tap Golden Chest`, Press OK to resume (No Timeout)
	
	Golden_Chest_Open_for_free_button:
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Medium+0))
	loop, 2
	{
		loop, 3
			if Search_Captured_Text_OCR(["Golden Chest"], {Timeout: 0}).Found
				goto Golden_Chest_Finish
				
		; MsgBox, 0, Pause, Tap Golden Chest`, Press OK to resume (No Timeout)
	}
	goto Golden_Chest_END
	
	Golden_Chest_Finish:
	; DllCall("Sleep","UInt",(rand_wait + 4*Delay_Long+0))
	if Pause_Script
		MsgBox, 0, Pause, Press OK to resume (No Timeout)
		
	Golden_Chest_Text := ["free"]
	
	; Capture_Screen_Text := OCR([150, 1182, 40, 30], "eng") ; Check if "Open for free" button
	if Search_Captured_Text_OCR(Golden_Chest_Text, {Pos: [150, 1182], Size: [40, 21], Timeout: 0}).Found
		Mouse_Click(125, 1200) ; Tap "Open for free" button
	DllCall("Sleep","UInt",(rand_wait + 5*Delay_Medium+0))
	loop, 2
		Mouse_Click(320,70) ; Tap top title bar
		; Mouse_Click(585,250) ; Tap outside claim banner
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Mouse_Click(357,495) ; Tap Silver tab
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	
	
	; Capture_Screen_Text := OCR([150, 1182, 85, 30], "eng") ; Check if "Open for free" button
	if Search_Captured_Text_OCR(Golden_Chest_Text, {Pos: [150, 1182], Size: [40, 21], Timeout: 0}).Found
		Mouse_Click(125, 1200) ; Tap "Open for free" button
	DllCall("Sleep","UInt",(rand_wait + 5*Delay_Medium+0))
	loop, 2
		Mouse_Click(320,70) ; Tap top title bar
		; Mouse_Click(585,250) ; Tap outside claim banner
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	
	
	Mouse_Click(633,600) ; Tap rankings
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Mouse_Click(157,367) ; Tap Open box
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Mouse_Click(330,1000) ; Tap Collect Rewards
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Golden_Chest_END:
	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Send_Mail_To_Boss:
{
	Subroutine_Running := "Send_Mail_To_Boss"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; FormatTime, DateString,, yyyy-MM-dd
	; FormatTime, TimeString,, HH:mm
	FormatTime, LogDateTimeString,, yyyy-MM-dd HH:mm:ss
	FormatTime, DayOfWeek,, ddd
	CSVout.WriteLine(LogDateTimeString "," Message_To_The_Boss)
	FormatTime, TimeString_Message, R
	Message_To_The_Boss .= DayOfWeek . ", " . LogDateTimeString

	; MsgBox, before: %Message_To_The_Boss%

	Message_To_The_Boss := RegExReplace(Message_To_The_Boss,"[\r\n ]+"," ")

	; MsgBox, After: %Message_To_The_Boss%

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	Open_Mail:

	Mouse_Click(492,1202) ; Tap mail
	; DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	Search_Captured_Text := ["Mail"]
	loop, 2
	{
		loop, 5
			if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0}).Found
				goto Compose_Message

		Gosub Go_Back_To_Home_Screen
		Mouse_Click(492,1202) ; Tap mail
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	; MsgBox, Capture_Screen_Text: %Capture_Screen_Text%
	Gosub Go_Back_To_Home_Screen
	return

	Compose_Message:
	Mouse_Click(636,55) ; Tap new Message
	DllCall("Sleep","UInt",(rand_wait + 7*Delay_Short+0))
	Mouse_Click(500,173) ; Tap User Name Text Box
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
	Text_To_Screen(Boss_User_name) ; Type user name to send message to
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Mouse_Click(433,327) ; Tap Message text body
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
	Text_To_Screen(Message_To_The_Boss) ; Type Message to user
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	; MsgBox, 0, Pause, Press OK to resume (No Timeout)

	Mouse_Click(352,1174) ; Tap Send button
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Send_Message_In_Chat:
{
	Subroutine_Running := "Send_Message_In_Chat"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(316,1122) ; Tap on Chat Bar
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(33,62) ; Tap back Button
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(229,389) ; Tap on third Chat Room "Hack Root"
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(227,1215) ; Tap in Message Box
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

	Chat_Message = % GetRandom(Chat_Message_List,"`n","`r")

	; MsgBox, SendInput
	; Mouse_Click(227,1215) ; Tap in Message Box
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	; Text_To_Screen(Chat_Message) ; Type message to send
	; Mouse_Click(227,1215) ; Tap in Message Box
	; DllCall("Sleep","UInt",(rand_wait + 5*Delay_Long+0))
	; Mouse_Click(650,1213) ; Tap Send
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	; MsgBox, SendRaw
	Mouse_Click(227,1215) ; Tap in Message Box
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
	SendRaw, %Chat_Message% ; Type message to send
	; Mouse_Click(227,1215) ; Tap in Message Box
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Mouse_Click(650,1213) ; Tap Send
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Get_Inventory:
{
	Subroutine_Running := "Get_Inventory"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(169,40) ; Tap Fuel on upper menu bar

	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Available_Food := OCR([244, 132, 90, 25], "eng") ; capture Available Food number
	Available_Steel := OCR([414, 132, 90, 25], "eng") ; capture Available Steel number
	Available_Alloy := OCR([584, 132, 90, 25], "eng") ; capture Available Alloy number
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

	Mouse_Click(95,140) ; Tap Fuel tab
	DllCall("Sleep","UInt",(rand_wait + 7*Delay_Short+0))
	Inventory_Fuel := OCR([87, 180, 520, 40], "eng") ; capture Reserve Fuel number
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

	Mouse_Click(249,140) ; Tap Food tab
	DllCall("Sleep","UInt",(rand_wait + 7*Delay_Short+0))
	Inventory_Food := OCR([87, 180, 520, 40], "eng") ; capture Reserve Food number
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

	Mouse_Click(442,136) ; Tap Steel tab
	DllCall("Sleep","UInt",(rand_wait + 7*Delay_Short+0))
	Inventory_Steel := OCR([87, 180, 520, 40], "eng") ; capture Reserve Steel number
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

	Mouse_Click(594,140) ; Tap Alloy tab
	DllCall("Sleep","UInt",(rand_wait + 7*Delay_Short+0))
	Inventory_Alloy := OCR([87, 180, 520, 40], "eng") ; capture Reserve Alloy number
	Available_Fuel := OCR([70, 132, 90, 25], "eng") ; capture Available Fuel number
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))

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

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Get_User_Info:
{
	Subroutine_Running := "Get_User_Info"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(47,80) ; Tap commander info on upper menu bar

	; capture text from commander info screen
	DllCall("Sleep","UInt",(rand_wait + 7*Delay_Short+0))
	User_Name_Captured := OCR([196, 183, 270, 30], "eng")
	User_State_Alliance := OCR([292, 145, 222, 32], "eng")
	User_VIP := OCR([183, 139, 116, 44], "eng")
	User_Power := OCR([497, 362, 122, 27], "eng")

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

	Gosub Go_Back_To_Home_Screen

	; User_Diamonds := OCR([590, 90, 96, 30], "eng")
	User_Diamonds := OCR([590, 95, 90, 20], "eng")
	User_Diamonds := % Convert_OCR_Value(User_Diamonds)

	Message_To_The_Boss .= User_Name_Captured
	. "`,Alliance:`," . User_Found_Alliance
	. "`,State:`," . User_Found_State
	. "`,VIP:`," . User_VIP
	. "`,Power:`," . User_Power . "`,"
	. "`,Diamonds:`," . User_Diamonds . "`,"

	/*
	Message_To_The_Boss .= User_Name_Captured
	. ",Alliance:," . User_Found_Alliance
	. ",State:," . User_Found_State
	. ",VIP:," . User_VIP
	. ",Power:," . User_Power . ","
	*/

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Get_User_Location:
{
	Subroutine_Running := "Get_User_Location"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(76,1200) ; Tap World/home button
	DllCall("Sleep","UInt",(rand_wait + 5*Delay_Long+0))

	Mouse_Click(347,600) ; Tap My City on World Map
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
	User_City_Location := OCR([300, 664, 120, 43], "eng")
	; User_City_Location := Trim(User_City_Location)
	User_City_Location := % RegExMatch(User_City_Location,"X:\d+[^\d]*Y:\d+[^\d]*", User_City_Location_XY)
	User_City_Location_XY := % RegExReplace(User_City_Location_XY,"[^0-9,]+")
	User_City_Location_XY := StrReplace(User_City_Location_XY, ",", ":")

	; MsgBox, % "User_City_Location: " . User_City_Location . " User_City_Location_XY: " . User_City_Location_XY

	Message_To_The_Boss .= "Location:`,""(" . User_City_Location_XY . ")""`,"

	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	; User_City_Location := OCR([304, 663, 85, 22], "eng")
	; User_City_Location_Array := StrSplit(User_City_Location, "`,","XY: ") ; Omits X, Y, : and space.

	; MsgBox, % "1. before split X`,Y:" User_City_Location " 2. after split X:Y" User_City_Location_Array[1] ":" User_City_Location_Array[2]
	; Message_To_The_Boss .= "Location:`,""" . User_City_Location_Array[1] . ":" . User_City_Location_Array[2] . """`,"

	; Go_Back_Home_Delay_Long := True
	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Base_Search_World_Map:
{
	Subroutine_Running := "Base_Search_World_Map"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
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

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
		return
	}

	Enter_Search_Coordinates:
	{
		; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
		Mouse_Click(220,1000) ; Tap Map Coordinate button
		; Mouse_Click(189,870); Tap Map Coordinate button
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

		Mouse_Click(200,530) ; Tap inside X coordinate Box
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
		Text_To_Screen(Map_X)
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
		Text_To_Screen("{Enter}")
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
		Mouse_Click(449,530) ; Tap inside Y coordinate Box
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
		Text_To_Screen(Map_Y)
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
		Text_To_Screen("{Enter}")
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))
		; Mouse_Click(196,467) ; Tap Go To Coordinates1
		Mouse_Click(350,620) ; Tap Go To Coordinates2
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Short+0))

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
			Mouse_Click(Px,Py) ; Tap to shrink activity bar
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		}
		return
	}

	Swipe_LL_To_UR:
		Mouse_Drag(112, 897, 497, 703, {EndMovement: F, SwipeTime: 500})
	/*
	{
		SendEvent {Click 112, 897, Down}
		SendEvent {Click 169, 870, 0}
		SendEvent {Click 183, 860, 0}
		SendEvent {Click 212, 847, 0}
		SendEvent {Click 280, 813, 0}
		SendEvent {Click 375, 764, 0}
		SendEvent {Click 445, 730, 0}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		SendEvent {Click 497, 703, 0}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		SendEvent {Click 497, 703, 0}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		SendEvent {Click 497, 703, Up}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		SendEvent {Click 497, 703, 0}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		SendEvent {Click 497, 703, 0}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		SendEvent {Click 497, 703, 0}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		SendEvent {Click 497, 703, 0}
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
		SendEvent {Click 497, 703, 0}
	}
		*/

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
				stdout.WriteLine(A_Now "A " Base_Picture " was found at X"FoundPictureX " Y" FoundPictureY )
				Mouse_Click(FoundPictureX,FoundPictureY) ; Tap Found Base
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
				MsgBox, 1 ErrorLevel: %ErrorLevel% - A %Base_Picture% found at X%FoundPictureX% Y%FoundPictureY%.
			}

			; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			ImageSearch, FoundPictureX, FoundPictureY, %PixelSearch_UpperX2%, %PixelSearch_UpperY2%, %PixelSearch_LowerX2%, %PixelSearch_LowerY2%, *145 *Trans0xF0F0F0 %Base_Picture%
			if !ErrorLevel ; (ErrorLevel = 0)
			{
				stdout.WriteLine(A_Now "A " Base_Picture " was found at X"FoundPictureX " Y" FoundPictureY )
				Mouse_Click(FoundPictureX,FoundPictureY) ; Tap Found Base
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
				MsgBox, 2 ErrorLevel: %ErrorLevel% - A %Base_Picture% found at X%FoundPictureX% Y%FoundPictureY%.
			}

			; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			ImageSearch, FoundPictureX, FoundPictureY, %PixelSearch_UpperX1%, %PixelSearch_UpperY1%, %PixelSearch_LowerX1%, %PixelSearch_LowerY1%, *145 *Trans0xFFFFFF %Base_Picture%
			if !ErrorLevel ; (ErrorLevel = 0)
			{
				stdout.WriteLine(A_Now "A " Base_Picture " was found at X"FoundPictureX " Y" FoundPictureY )
				Mouse_Click(FoundPictureX,FoundPictureY) ; Tap Found Base
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
				MsgBox, 3 ErrorLevel: %ErrorLevel% - A %Base_Picture% found at X%FoundPictureX% Y%FoundPictureY%.
			}

			; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			ImageSearch, FoundPictureX, FoundPictureY, %PixelSearch_UpperX2%, %PixelSearch_UpperY2%, %PixelSearch_LowerX2%, %PixelSearch_LowerY2%, *145 *Trans0xFFFFFF %Base_Picture%
			if !ErrorLevel ; (ErrorLevel = 0)
			{
				stdout.WriteLine(A_Now "A " Base_Picture " was found at X"FoundPictureX " Y" FoundPictureY )
				Mouse_Click(FoundPictureX,FoundPictureY) ; Tap Found Base
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
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

				Mouse_Click(Px,Py) ; Tap on potential city
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

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

				stdout.WriteLine(A_Now "Found_City_Info1," Found_City_Info1 " Found_City_Info2," Found_City_Info2 ",Found_City_Name," Found_City_Name ",Found_City_Location," Found_City_Location ",")

				if (Found_City_Location = "") ; if location blank, skip
					goto Next_Coord_Search
				if (Found_City_Location = Last_City_Loc_Found) ; if location same as before, skip
					goto Next_Coord_Search

				MsgBox, ErrorLevel: %ErrorLevel% - A %Base_Level% color within %PixelSearch_Variation% shades of %Base_Color%, pixel:%Px%,%Py% and coords (%Found_City_Location%) Found_City_Name2: %Found_City_Name2% 1: "%Found_City_Info1%" 2: "%Found_City_Info2%"

				Last_City_Info_Found := Found_City_Info2
				Last_City_Name_Found := Found_City_Name2
				Last_City_Loc_Found := Found_City_Location

				stdout.WriteLine(A_Now "Found_City_Info," Found_City_Info ",Found_City_Name," Found_City_Name ",Found_City_Location," Found_City_Location ",")

				Next_Coord_Search:
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
	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

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
		; MsgBox, No Zombie or Rover return 0
		return 0
	}
	else
	{
		Mouse_Click(550,1037) ; Tap next to speaker
		; Text_To_Screen("{Esc}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		; MsgBox, Zombie or Rover return 1
		return 1
	}

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Elivate_program:
{
	Subroutine_Running := "Elivate_program"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; ([Subroutine_Running,A_ThisLabel])

	; stdout.WriteLine(A_Now " Elivate_program, " image_name " Main_Loop_Counter: " Main_Loop_Counter " Restart_Loops: " Restart_Loops " Reset_App_Yes: " Reset_App_Yes)

	; PERC := Chr(37)
	; wmic process where "Name like '%PERC%MEmu%PERC%' OR Name like '%PERC%MEmu%PERC%'" CALL setpriority "above normal"
	; wmic process where "Name like '`%MEmu`%' OR Name like '`%MEmu`%'" CALL setpriority "above normal"
	; wmic process where "Name like '`%MEmu`%' OR Name like '`%MEmu`%'" CALL setpriority 128
	commands=
	(join&
	wmic process where "Name like '`%MEmu`%' OR Name like '`%MEmu`%'" CALL setpriority 128
	)
	; runwait, %comspec% /c %commands%

	; stdout.WriteLine(A_Now ", commands, " commands ", result: ," RunWaitOne(commands))
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
			FileAppend, "%A_NOW%"`,"Function"`,"%Function%"`,"WinWait cmdTitle"`,"%cmdTitle%"`n, %AppendCSVFile%
			;break
		}
		if WinExist("ahk_class " . cmdClass) ; ahk_class ConsoleWindowClass ; if !ErrorLevel
		{
			WinWait, ahk_class %cmdClass%, , 0
			WinMinimize ; Minimize the window found by WinWait.
			DllCall("Sleep","UInt",(rand_wait + 3*Delay_Long+0))
			WinRestore
			; MsgBox, WinWait "ahk_class " %cmdClass% ; ahk_class ConsoleWindowClass
			FileAppend, "%A_NOW%"`,"Function"`,"%Function%"`,"WinWait cmdClass"`,"%cmdClass%"`n, %AppendCSVFile%
			;break
		}
		if WinExist("ahk_exe " . cmdEXE) ; ahk_exe AutoHotkey.exe ; if !ErrorLevel
		{
			WinWait, ahk_exe %cmdEXE%, , 0
			WinMinimize ; Minimize the window found by WinWait.
			DllCall("Sleep","UInt",(rand_wait + 3*Delay_Long+0))
			WinRestore
			; MsgBox, WinWait "ahk_exe " %cmdEXE% ; ahk_exe AutoHotkey.exe
			FileAppend, "%A_NOW%"`,"Function"`,"%Function%"`,"WinWait cmdEXE"`,"%cmdEXE%"`n, %AppendCSVFile%
			;break
		}
		if WinExist("ahk_id " . cmdID) ; ahk_id 0x64f14dc ; if !ErrorLevel
		{
			WinWait, ahk_id %cmdID%, , 0
			WinMinimize ; Minimize the window found by WinWait.
			DllCall("Sleep","UInt",(rand_wait + 3*Delay_Long+0))
			WinRestore
			; MsgBox, WinWait "ahk_id " %cmdID% ; ahk_id 0x64f14dc
			FileAppend, "%A_NOW%"`,"Function"`,"%Function%"`,"WinWait cmdID"`,"%cmdID%"`n, %AppendCSVFile%
			;break
		}
		if WinExist("ahk_pid " . cmdPID) ; ahk_pid 16120 ; if !ErrorLevel
		{
			WinWait, ahk_pid %cmdPID%, , 0
			WinMinimize ; Minimize the window found by WinWait.
			DllCall("Sleep","UInt",(rand_wait + 3*Delay_Long+0))
			WinRestore
			; MsgBox, WinWait "ahk_pid " %cmdPID% ; ahk_pid 16120
			FileAppend, "%A_NOW%"`,"Function"`,"%Function%"`,"WinWait cmdPID"`,"%cmdPID%"`n, %AppendCSVFile%
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

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Get_Window_Geometry:
{
	Subroutine_Running := "Get_Window_Geometry"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; if !WinActive(FoundAppTitle), WinActivate, %FoundAppTitle%

	stdout.WriteLine(A_Now " Get_Window_Geometry, " image_name " Main_Loop_Counter: " Main_Loop_Counter " Restart_Loops: " Restart_Loops " Reset_App_Yes: " Reset_App_Yes)

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
	stdout.WriteLine(A_Now "Sub:""" Subroutine_Running """ Found App info: (X1:" FoundAppX ",Y1:" FoundAppY ",X2:" LowerX ",Y2:" LowerY ") Dimensions:" FoundAppWidth "x" FoundAppHeight " Title:" FoundAppTitle)
	stdout.WriteLine(A_Now " Calculated UpperX,UpperY " UpperX ", " UpperY " and LowerX, LowerY " LowerX ", " LowerY)

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

; collapse sidebar menu and Reposition window
Check_Window_Geometry:
{
	Subroutine_Running := "Check_Window_Geometry"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; stdout.WriteLine(A_Now " Check_Window_Geometry, " image_name " Main_Loop_Counter: " Main_Loop_Counter " Restart_Loops: " Restart_Loops " Reset_App_Yes: " Reset_App_Yes)
	; if !WinActive(FoundAppTitle), WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; stdout.WriteLine(A_Now " Inside Check_Window_Geometry, image_name: " image_name)

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
	stdout.WriteLine(A_Now "Sub:" Subroutine_Running " Found App info: (X1:" FoundAppX ",Y1:" FoundAppY ",X2:" LowerX ",Y2:" LowerY ") Dimensions:" FoundAppWidth "x" FoundAppHeight " Title:" FoundAppTitle)

	if FoundAppX = App_Win_X
		if FoundAppY = App_Win_Y
			if FoundAppWidth = App_WinWidth
				if FoundAppHeight = App_WinHeight
					return

	; Changes the position and/or size of the specified window.
	; WinMove, X, Y
	; WinMove, FoundAppTitle, WinText, X, Y [, Width, Height, ExcludeTitle, ExcludeText]
	if FoundAppTitle contains MEmu
		WinMove, %FoundAppTitle%, , App_Win_X, App_Win_Y, MEmu_WinWidth, MEmu_WinHeight ; Move the window to the top left corner.
	else
		WinMove, %FoundAppTitle%, , App_Win_X, App_Win_Y, App_WinWidth, App_WinHeight ; Move the window to the top left corner.
	; MsgBox, %FoundAppTitle% Upper: %FoundAppX%, %FoundAppY% %FoundAppWidth%x%FoundAppHeight% Lower: %LowerX%, %LowerY%

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
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
				Mouse_Click(339,14) ; Tap MEmu App header
				DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

				; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
				Mouse_Click(709,384) ; Tap to expand More menu
				DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

				; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
				Mouse_Click(630,382) ; Tap Operations Recorder
				DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
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

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

; Tap in the middle of the screen
Click_Middle_Screen:
{
	Subroutine_Running := "Click_Middle_Screen"
	Mouse_Click((LowerX-UpperX)/2+UpperX,(LowerY-UpperY)/2+(UpperY-100)) ; Tap in the middle of the screen
}

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

F1::
Gui, Show, W400 H40, Window List
return

F6::
Reload_Script:
{
	Subroutine_Running := "Reload_Script"

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

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

F7::
	Resetting_Posit := True
	Key_Menu()
	Gosub Reset_Posit
	Resetting_Posit := False
	Key_Menu()
return

Check_AppWindows_Timer:
	; Gosub Get_Window_Geometry
	Gosub Check_Window_Geometry
	Key_Menu()
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
return

; Esc::ExitApp

; original Pause statement
; Pause::Pause ; Pressing pause once will pause the script. Pressing it again will unpause.

Pause:: ; Pressing pause once will pause the script. Pressing it again will unpause.
Pause,,1	; read the documentation on Pause to understand the consequences of this 1. It seems to matter where this hotkey is in the script.
Key_Menu()
; if !WinActive(FoundAppTitle), WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
Return

F3::
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Drag Slide Right to select all
	; Mouse_Drag(125, 687, 415, 703, {EndMovement: F, SwipeTime: 500}) ; original
	; Mouse_Click(382,774) ; Tap Use ; original

	Mouse_Drag(115, 680, 360, 680, {EndMovement: F, SwipeTime: 500}) ; Client start: 115, 680, end: 360, 680
	Mouse_Click(380,786) ; Tap Use ; 340, 786

	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
Return

F9::
Gosub Go_Back_To_Home_Screen
Gosub, Exit_Sub
MsgBox, This MsgBox will never happen because of the EXIT.
return

Exit_Sub:
Exit ; Terminate this subroutine as well as the calling subroutine.

F4::ExitApp
; #c:: OCR()
#g:: Vis2.OCR.google() ; Googles the text instead of saving it to clipboard.
#i:: ImageIdentify()
>>>>>>> Stashed changes
