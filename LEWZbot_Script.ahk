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
			MsgBox, 3, , Login to %Output% ? (5 second Timeout & auto),5 ; 5
			vRet := MsgBoxGetResult()
			if (vRet = "Yes") || if (vRet = "Timeout")
				Gosub Switch_Account
			else if (vRet = "No")
				goto END_of_user_loop

			; loop, 2
			if !Go_Back_To_Home_Screen()
				Reload_MEmu()

			; ***************************************
			; Main DEBUG and event Variables - START
			; ***************************************
			Pause_Script := False
			CSB_Event := False ; True ; True if CSB Event is going on
			Desert_Event := False ; False ; True ; True if Desert Event is going on
			; if CSB_Event ; || if Desert_Event
			At_War := False ; if set to True, peace shield will be enabled
			; ***************************************
			; Main DEBUG and event Variables - END
			; ***************************************

			; MsgBox, 4, , Enable Pause? (8 Second Timeout & skip), 5 ; 8
			; vRet := MsgBoxGetResult()
			; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
			; Pause_Script := True

			; if Pause_Script
			; MsgBox, 0, Pause, Press OK to resume (No Timeout)

			; Extract current UTC hour
			Current_Hour_UTC := FormatTime(A_NowUTC, "HH")
			Current_Day_UTC := FormatTime(A_NowUTC, "dddd")

			; Figure out the day and time to determine if shield is needed
			; If time is within 24 hours of killing event, Peace_Shield_Needed variable = True
			if ((Current_Day_UTC = "Friday") || (Current_Day_UTC = "Saturday") || (Current_Day_UTC = "Sunday"))
				Peace_Shield_Needed := True
			if At_War
				Peace_Shield_Needed := True

			; Figure out time of day for which subroutines will run
			if (Current_Hour_UTC >= 16 && Current_Hour_UTC < 24)
				Routine := "End_Of_Day"
			else if (Current_Hour_UTC >= 24 || Current_Hour_UTC <= 10)
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
				; MsgBox, Hour: %Current_Hour_UTC% %Routine%
				; for testing routines
				; MsgBox, 0, Pause, Press OK to start (No Timeout)
				; Gosub Benefits_Center
				; Gosub Active_Skill
				; Gosub Peace_Shield
				; Gosub Desert_Wonder
				; Gosub Depot_Rewards
				; Gosub Donate_Tech
				; Gosub Peace_Shield
				; Gosub BruteForcePIN
				; Gosub Speaker_Help
				; Gosub Golden_Chest
				; Gosub Reserve_Factory
				; Login_Password_PIN_BruteForce()
				; MsgBox, 0, Pause, Press OK to end (No Timeout)
				; goto END_of_user_loop
				; Gosub Game_Start_popups
				; Gosub Shield_Warrior_Trial_etc
				; ******************************************
				; DEBUG / Troubleshooting block - END
				; ******************************************

				; ****************************
				; ** Position dependant **
				; ****************************
				; if Peace_Shield_Needed
				; 	Gosub Peace_Shield
				; Gosub Reset_Posit
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
				; if !Go_Back_To_Home_Screen()
					; Reload_MEmu()
				; Gosub Speaker_Help
				; goto END_of_user_loop
				; ******************************************
				; DEBUG / Troubleshooting block - END
				; ******************************************

				Gosub Depot_Rewards
				; if (Routine = "New_Day") || if (Routine = "End_Of_Day")
				;	Gosub Golden_Chest
				Gosub Speaker_Help
				if (Routine = "New_Day") || if (Routine = "End_Of_Day")
					Gosub Drop_Zone

				; ****************************
				; ** Not position dependant **
				; ****************************
				if CSB_Event ; || if Desert_Event
					if !(Current_Hour_UTC = 00 && A_Min <= 30)
						Gosub Reserve_Factory
				Gosub Active_Skill
				; Gosub Donate_tech
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
				; if !Desert_Event
				;	Gosub Gather_On_Base_RSS
				if Desert_Event
				{
					Gosub Desert_Oasis
					Gosub Desert_Wonder
				}
				; Gosub Gather_Resources
				Gosub Speaker_Help
				; Gosub Collect_Red_Envelopes

				Message_To_The_Boss := User_Name . " " . Routine . " Routine,"
				; if (Routine = "New_Day") || if (Routine = "End_Of_Day")
				Gosub Get_User_Location
				
				if (Routine = "New_Day") || if (Routine = "End_Of_Day")
					Gosub Get_User_Info
					Gosub Get_Inventory
				Gosub Send_Mail_To_Boss
				; Gosub Send_Message_In_Chat

				; MsgBox, 4, , Pause before switching accounts? (4 Second Timeout & skip), 5 ; 4
				; vRet := MsgBoxGetResult()
				; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
				; MsgBox, 0, Pause, Press OK to resume (No Timeout)

				goto END_of_user_loop
			}

			; removed bulk of subroutines, to ease readability, no longer needed
			Special_Routine:
			New_Day_Game_Reset:
			Fast_Routine:
			End_Of_Day_Routine:
			FULL_Q_and_A_Routine:
			goto END_of_user_loop

			END_of_user_loop:
		}

		; start new log files
		Gosub Refresh_LogFiles
		; relaunch LEWZ
		; Reload_MEmu()
		; Launch_Lewz()
		gosub Reload_Script
		if !Go_Back_To_Home_Screen()
			Reload_MEmu()
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


; Reload_MEmu() <--> Launch_LEWZ() <--> Go_Back_To_Home_Screen()

; Reload_MEmu() calls Launch_LEWZ() and NOT Go_Back_To_Home_Screen()
Reload_MEmu()
{
	Subroutine_Running := "Reload_MEmu"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	
	MEmu_Instance := "MEmu_1" ; MEmu_1 MEmu_2
	
	Reload_MEmu_START:
	gosub Reload_MEmu_Kill
	gosub Reload_MEmu_Launch
		
	Loop, 10
	{
		; DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
		loop, 3
			if Launch_LEWZ()
			{
				Gui, Status:add,text,, MEmu finished Loaded!!
				Gui, Status:show, x731 y0 w300 h500
				GUI_Count++
				return 1
			}

			Gui, Status:add,text,, Loading MEmu %A_Index%
			Gui, Status:show, x731 y0 w300 h500
			GUI_Count++
	}
	Gui, Status:add,text,, MEmu NOT Loaded!
	Gui, Status:show, x731 y0 w300 h500
	GUI_Count++
	goto Reload_MEmu_START
	return 0
	
	
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
			DllCall("Sleep","UInt",(rand_wait + 10*Delay_Long+0))
		}
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
			DllCall("Sleep","UInt",(rand_wait + 5*Delay_Long+0))
		}
		return
	}
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
	
	oGraphicSearch := new graphicsearch()	
	loop, 30
	{
		resultObj := oGraphicSearch.search(0_Icon_LEWZ_Graphic, optionsObjCoords)
		if (resultObj)
		{
			loop, % resultObj.Count()
			{
				Click_X := resultObj[A_Index].x
				Click_Y := resultObj[A_Index].y
				Gui, Status:add,text,, LEWZ icon found #%A_Index% (%Click_X%,%Click_Y%)
				Mouse_Click(Click_X,Click_Y, {Clicks: 3,Timeout: Delay_Medium}) ; Tap LEWZ ICON
				Gui, Status:show, x731 y0 w300 h500
				GUI_Count++
				Icon_Found := True ; Goto Launch_LEWZ_Continue
			}
		}		
		Login_Password_PIN_Enter()
	}
	if Icon_Found
		Goto Launch_LEWZ_Continue
	Else
		return 0

	Launch_LEWZ_Continue:
	Gui, Status:add,text,, Loading LEWZ %A_Index%
	Gui, Status:show, x731 y0 w300 h500
	GUI_Count++
	
	DllCall("Sleep","UInt",(rand_wait + 20*Delay_Long+0))
	Loop, 20
	{
		Login_Password_PIN_Enter()
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	}
	
	Loop, 10
	{
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
		Login_Password_PIN_Enter()
		if Go_Back_To_Home_Screen()
		{
			Gui, Status:add,text,, LEWZ Loaded!!
			Gui, Status:show, x731 y0 w300 h500
			GUI_Count++
			return 1
		}
		
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
		Text_To_Screen("{F5}")
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}
	
	Go_Back_To_Home_Screen_OCR_Quit:
	oGraphicSearch := new graphicsearch()	
	loop, 200
	{
			resultObj := oGraphicSearch.search(1_Quit_Title_Graphic, optionsObjCoords)
			if (resultObj)
				goto Go_Back_To_Home_Screen_OCR_NOT_Quit ; return 1
				
		Text_To_Screen("{F5}")
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
		Gosub Check_Window_Geometry
	}
	; goto Reload_LEWZ_routine	; Gosub Reload_LEWZ_routine
	return 0

	Go_Back_To_Home_Screen_OCR_NOT_Quit:
	loop, 10
	{
			resultObj := oGraphicSearch.search(1_Quit_Title_Graphic, optionsObjCoords)
			if !(resultObj)
				return 1 ; goto Go_Back_To_Home_Screen_OCR_NOT_Quit

		Text_To_Screen("{F5}")
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
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
	Text_To_Screen("{F5}")
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(256,979) ; Check No More Prompts Today On Today'S Hot Sale
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(630,322) ; Tap X On Today'S Hot Sale
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	; Mouse_Click(379,736) ; Collect Cafeteria

	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
	return
}

; reset position by going to world screen and back home
Reset_Posit:
{
	Subroutine_Running := "Reset_Posit"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; go back x times

	; Go_Back_Home_Delay_Long := True
	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
	; Gosub Speaker_Help

	; Tap World/home button x times
		loop, 2
	{
		Mouse_Click(76,1200) ; Tap World/home button
		DllCall("Sleep","UInt",(rand_wait + 8*Delay_Long+0))
	}
	; Go_Back_Home_Delay_Long := True
	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
	return
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
		Reload_MEmu()
	Mouse_Click(50,70) ; , {Clicks: 1,Timeout: (1*Delay_Long+0)}) ; Tap Commander Info
	
	; check if any graphic was found
	oAccountSearch := new graphicsearch()	
	oLoginSearch := new graphicsearch()			
	allQueries_Account := 1A_Settings_Button_Graphic 1A1_Account_Button_Graphic 1A12_Switch_Button_Graphic 1A123_WarZ_Button_Graphic 1A1232_OtherAccount_Button_Graphic
	allQueries_Login := 1A1234_Email_Box_Button_Graphic 1A1235_PW_Box_Button_Graphic 1A1237_UseEmailLog_Button_Graphic
	loop, 32
	{
		resultObj := oAccountSearch.search(allQueries_Account, optionsObjCoords)
		if (resultObj)
			Mouse_Click(resultObj[1].x,resultObj[1].y) ;, {Timeout: (5*Delay_Medium+0)})
		
		if Search_Captured_Text_OCR(["Yes"], {Pos: [315, 860], Size: [60, 35]}).Found
			Mouse_Click(340,870) ;  {Clicks: 1,Timeout: (5*Delay_Short+0)}) ; Tap Yes
		
		resultObj := oLoginSearch.search(allQueries_Login, optionsObjCoords)
		if (resultObj)
			goto Switch_Account_Dialog
	}
	goto Switch_Account_START

	Switch_Account_Dialog:
	Gosub Switch_Account_User_Email
	Gosub Switch_Account_User_Password
	goto Switch_Account_Next

	Switch_Account_User_Email:
	{
		loop, 3
		{
			Mouse_Click(220,382, {Timeout: (2*Delay_Short+0)}) ; Tap inside Email Text Box
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
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
			Mouse_Click(209,527, {Timeout: (2*Delay_Short+0)}) ; Tap inside Email Text Box
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
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
	
	oGraphicSearch := new graphicsearch()	
	Last_Game_Loading := 0
	loop, 30
	{
		resultObj := oGraphicSearch.search(1A12371_OK_Button_Graphic, optionsObjCoords)
		if (resultObj)
		{
			Mouse_Click(resultObj[1].x,resultObj[1].y) ; Tap "OK"
		}
		
		if Search_Captured_Text_OCR(["Yes"], {Pos: [315, 860], Size: [60, 35]}).Found
			Mouse_Click(340,870) ; Tap Yes

		Login_Password_PIN_Enter()
		
		AccountLoading := Search_Captured_Text_OCR(["0","1","2","3","4","5","6","7","8","9","%"], {Pos: [319, 1067], Size: [54, 25]})
		while (AccountLoading.Found)
		{
			Game_Loading_RAW := RegExReplace(AccountLoading.Text,"[^\d]")
			RegExMatch(Game_Loading_RAW, "([\d]{1,2})",Game_Loading)
			if (Game_Loading = Last_Game_Loading)
				sleep, 1
			Else
			{
				Gui, Status:new, , Status
				Gui, Status:Margin, 0, 0
				Gui, Status:add,text,, Account %User_Name%
				GUI_Count := 0
				Gui, Status:add,text,, Account Loading %Game_Loading%`%
				Gui, Status:show, x731 y0 w300 h500
				GUI_Count++
				Last_Game_Loading = Game_Loading
			}
			AccountLoading := Search_Captured_Text_OCR(["0","1","2","3","4","5","6","7","8","9","%"], {Pos: [319, 1067], Size: [54, 25]})
		}
	}

	; gosub BruteForcePIN

	Switch_Account_PIN:
	if Login_Password_PIN_Find() ; if Text_Found
		MsgBox, 4, User PIN failed, user PIN: %User_PIN% did not work for Account %User_Name%`nEnter PIN manually, Press OK to resume (No Timeout)

	Switch_Account_END:
	Login_Password_PIN_Enter()

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
		return 1 ; true if PIN text found

	Text_Found := False
	return 0 ; false if PIN text not found
	
}

Login_Password_PIN_Taps() ; FMR Enter_Login_PIN_Dialog:
{
	; tap backspace X times
	loop, 6
		Mouse_Click(465, 1164, {Timeout: 3*Delay_Pico}) ; Tap backspace
		; old Mouse_Click(577,1213, {Timeout: 2*Delay_Pico}) ; Tap backspace
	DllCall("Sleep","UInt",(1*Delay_Micro+0))

	; Split PIN and tap each corrsponding number
	Enter_User_PIN := StrSplit(User_PIN)
	Loop % Enter_User_PIN.MaxIndex()
	{
		DllCall("Sleep","UInt",(3*Delay_Pico+0))

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
	DllCall("Sleep","UInt",(3*Delay_Micro+0))
		
	return
}

Login_Password_PIN_BruteForce(User_PIN_INIT := "000000", Check_After_Loops := "1000") ; FMR BruteForcePIN:
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

			if (Mod(A_Index, %Check_After_Loops%) == 0) ; if !Text_Found
				if Login_Password_PIN_Find()
				{
					PIN_Start := (User_PIN - Check_After_Loops)
					stdout.WriteLine(A_NowUTC ",Found," Text_Found ",User_Email," User_Email ",Check_After_Loops," Check_After_Loops ",PIN," User_PIN )
					MsgBox, 3, , % " PIN discovered for account:" User_Email "`nbetween: " PIN_Start " and " User_PIN " (10 second Timeout & auto)",15 ; 0
						vRet := MsgBoxGetResult()
						if (vRet = "Yes")
							break	

					if Go_Back_To_Home_Screen()
						break
				}

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
	Loop, 2
	{
		Mouse_Click(265,392) ;  Left, 1}  ; Tap Base
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		Mouse_Click(348,499) ;  Left, 1}  ; Tap City buffs
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		loop, 3
		{
			oGraphicSearch := new graphicsearch()	
			resultObj := oGraphicSearch.search(B2240_CityBuffs_Title_Graphic, optionsObjCoords)
			if (resultObj)
				Goto, Shield_Search_Buttons
			
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

			oGraphicSearch := new graphicsearch()	
			resultObj := oGraphicSearch.search(B224_CityBuffs_Button_Graphic, optionsObjCoords)
			if (resultObj)
			{
				Click_X := resultObj[1].x
				Click_Y := resultObj[1].y
				Mouse_Click(Click_X,Click_Y) ;  Left, 1}  ; Tap City buffs
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
			}
			
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		}
		if !Go_Back_To_Home_Screen()
			Reload_MEmu()
	}
	; MsgBox, Shield_Open_Base Failed
	goto Peace_Shield_END

	Goto, Shield_Open_Base
	
	Shield_Search_Buttons:	
	oGraphicSearch := new graphicsearch()
	loop, 10
	{
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		resultObj := oGraphicSearch.search(B2241_Shield_Button_Graphic, optionsObjCoords)
		if (resultObj)
		{
			Click_X := resultObj[1].x
			Click_Y := resultObj[1].y
			Mouse_Click(Click_X,Click_Y) ; Click to open shield menu
			Goto Shield_Search_Title
		}
	}
	; MsgBox, Shield_Search_Buttons Failed
	goto Peace_Shield_END
	
	Shield_Search_Title:
	; Check for shield title banner
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	loop, 30
	{
		oGraphicSearch := new graphicsearch()			
		resultObj := oGraphicSearch.search(B22410_Shield_Title_Graphic, optionsObjCoords)
		if (resultObj)
			Goto Shield_Search_Ends
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
			
		; RegExMatch(Shield_Ends,"(\d\d)\:*\d\d\:*\d\d",Shield_HH)
		; RegExMatch(Shield_Ends,"\d\d\:*(\d\d)\:*\d\d",Shield_MM)
		; RegExMatch(Shield_Ends,"\d\d\:*\d\d\:*(\d\d)",Shield_SS)
		
		; MsgBox, % "1. Shield_Ends:" Shield_Ends "`nShield Duration D:" Shield_DD " hh:" Shield_HH " mm:" Shield_MM " ss:" Shield_SS "`nA_NowUTC:" A_NowUTC "`nShield_NOW_Plus_Duration:" Shield_NOW_Plus_Duration
		
		; extract Hours, Minutes and Days till shield expires
		if RegExMatch(Shield_Ends,"\d\d\:*\d\d\:*\d\d",Shield_HHMMSS)
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
		
		Shield_Expires_Day := Shield_NOW_Plus_Duration
		Shield_Expires_HH := Shield_NOW_Plus_Duration
		Shield_Expires_MM := Shield_NOW_Plus_Duration
		
		Shield_Expires_Day := FormatTime(Shield_Expires_Day, "dddd")
		Shield_Expires_HH := FormatTime(Shield_Expires_HH, "h")
		Shield_Expires_MM := FormatTime(Shield_Expires_MM, "m")
		; Shield_Expires_DateTime := FormatTime(Shield_NOW_Plus_Duration)
		Shield_Expires_DateTime := Shield_Expires_Day . " @ " Shield_Expires_HH ":" Shield_Expires_MM

		if (At_War && (Shield_DD < 1))
		{
			MsgBox, 4, ,Shield expires on %Shield_Expires_DateTime%`, recommend 3Day shield (5 sec Timeout & auto),5 ; 5
			vRet := MsgBoxGetResult()
			if (vRet = "Yes") || if (vRet = "Timeout") ; || if (vRet = "No")
			Goto, Shield_for_3Day
		}
		else if (Shield_Expires_Day = "Thursday")
		{
			MsgBox, 4, ,Shield expires on %Shield_Expires_DateTime%`, recommend 3Day shield (5 sec Timeout & auto),5 ; 5
			vRet := MsgBoxGetResult()
			if (vRet = "Yes") || if (vRet = "Timeout") ; || if (vRet = "No")
			Goto, Shield_for_3Day
		}
		else if (Shield_Expires_Day = "Friday")
		{
			MsgBox, 4, ,Shield expires on %Shield_Expires_DateTime%`, recommend 3Day shield (5 sec Timeout & auto),5 ; 5
			vRet := MsgBoxGetResult()
			if (vRet = "Yes") || if (vRet = "Timeout") ; || if (vRet = "No")
			Goto, Shield_for_3Day
		}
		else if (Shield_Expires_Day = "Saturday" && Shield_Expires_Hour <= 19)
		{
			MsgBox, 4, ,Shield expires on %Shield_Expires_DateTime%`, recommend 3Day shield (5 sec Timeout & auto),5 ; 5
			vRet := MsgBoxGetResult()
			if (vRet = "Yes") || if (vRet = "Timeout") ; || if (vRet = "No")
			Goto, Shield_for_3Day
		}
		else if (Shield_Expires_Day = "Saturday" && Shield_Expires_Hour >= 19)
		{
			MsgBox, 4, ,Shield expires on %Shield_Expires_Day%`, recommend 24hour shield (5 sec Timeout & auto),5 ; 5
			vRet := MsgBoxGetResult()
			if (vRet = "Yes") || if (vRet = "Timeout") ; || if (vRet = "No")
			Goto, Shield_for_24hour
		}
		else if (Shield_Expires_Day = "Sunday" && Shield_Expires_Hour <= 19)
		{
			MsgBox, 4, ,Shield expires on %Shield_Expires_DateTime%`, recommend 24hour shield (5 sec Timeout & auto),5 ; 5
			vRet := MsgBoxGetResult()
			if (vRet = "Yes") || if (vRet = "Timeout") ; || if (vRet = "No")
			Goto, Shield_for_24hour
		}
		else
		{
			MsgBox, 4, ,Shield expires on %Shield_Expires_DateTime%`, No shield needed.`nPlace shield anyway? (5 sec Timeout & auto),5 ; 5
			vRet := MsgBoxGetResult()
			if (vRet = "Yes")
				goto Activate_Shield
			else if (vRet = "No") || if (vRet = "Timeout")
				goto Peace_Shield_END
		}
	}

	MsgBox, 4, , Shield Already Active`, %Capture_Screen_Text%`,  Select new shield anyway? (5 second Timeout & skip),5 ; 5
	vRet := MsgBoxGetResult()
	if (vRet = "Yes")
		goto Activate_Shield
	else if (vRet = "No") || if (vRet = "Timeout")
		goto Peace_Shield_END

	Activate_Shield:
	Mouse_Click(Click_X,Click_Y) ; Click first box to enable shield
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

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
	MsgBox, 4, , Shield not selected:"%Capture_Screen_Text%"`, Try again? (5 second Timeout & skip),5 ; 5
	vRet := MsgBoxGetResult()
	if (vRet = "Yes")
		Goto, Shield_Open_Base
	else if (vRet = "No") || if (vRet = "Timeout")
		Goto, Peace_Shield_END

	Shield_Purchase:
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

	loop, 30
	{
		oGraphicSearch := new graphicsearch()	
		resultObj := oGraphicSearch.search(B22412_Replace_OK_Button_Graphic, optionsObjCoords)
		if (resultObj)
		{
			Click_X := resultObj[1].x
			Click_Y := resultObj[1].y
			Mouse_Click(Click_X,Click_Y) ;  Left, 1} ; Tap Get & Use button, to confirm buying shield
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		}
	}
	; MsgBox, Shield_Purchase Failed
	goto Peace_Shield_END

	Peace_Shield_END:
	MsgBox, 4, , Pause script to place shield? (5 Second Timeout & skip), 5 ; 5
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		MsgBox, 0, Pause, Activate Peace Shield, Press OK to resume (No Timeout)

	if !Go_Back_To_Home_Screen()
		Reload_MEmu()

	return
}

; collect collisions
Collect_Collisions:
{
	Subroutine_Running := "Collect_Collisions"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	loop, 2
	{
		Mouse_Click(430,280) ; Tap Command Center
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		Mouse_Click(515,375) ; Tap Collision
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
			
		oGraphicSearch := new graphicsearch()	
		resultObj := oGraphicSearch.search(B3450_Collision_Title_Graphic, optionsObjCoords)
		if (resultObj)
			goto Collect_Collisions_Found
		if !Go_Back_To_Home_Screen()
			Reload_MEmu()
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	}
	goto Collect_Collisions_END
	Collect_Collisions_Found:
	{
		Mouse_Click(180,1130) ; Tap Collide
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		goto Collect_Collisions_END
		Loop, 3
		{
			Mouse_Click(450,1180) ; Tap "OK"
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		}
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	Collect_Collisions_END:
	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
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
	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
	return
}

; collect Equipment Crafting
Collect_Equipment_Crafting:
{
	Subroutine_Running := "Collect_Equipment_Crafting"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	loop, 2
	{
		Mouse_Click(430,280) ; Tap Command Center
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		Mouse_Click(430,390) ; Tap Craft
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
		oGraphicSearch := new graphicsearch()	
		resultObj := oGraphicSearch.search(B3440_Craft_Title_Graphic, optionsObjCoords)
		if (resultObj)
			goto Collect_Equipment_Found
		if !Go_Back_To_Home_Screen()
			Reload_MEmu()
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	}
	goto Collect_Equipment_END
	Collect_Equipment_Found:
	{
		Mouse_Click(180,1180, {Timeout: Delay_Medium+0}) ; Tap Craft or Recruit or Extract
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		goto Collect_Equipment_END
		Loop, 3
		{
			Mouse_Click(450,1180) ; Tap "OK"
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		}
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	Collect_Equipment_END:
	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
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
	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
	return
}

; Collect Recruits
Collect_Recruits:
{
	Subroutine_Running := "Collect_Recruits"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	loop, 2
	{
		Mouse_Click(430,280) ; Tap Command Center
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		Mouse_Click(350,375) ; Tap Recruit
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
		oGraphicSearch := new graphicsearch()	
		resultObj := oGraphicSearch.search(B3430_Recruit_Title_Graphic, optionsObjCoords)
		if (resultObj)
			goto Collect_Recruits_Found
		if !Go_Back_To_Home_Screen()
			Reload_MEmu()
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	}
	goto Collect_Recruits_END
	Collect_Recruits_Found:
	{
		Mouse_Click(160,1180) ; Tap Recruit 1 times
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		goto Collect_Recruits_END
		Loop, 3
		{
			Mouse_Click(450,1180) ; Tap "OK"
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		}
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	Collect_Recruits_END:
	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
	return

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	;loop, 2
		Mouse_Click(430,280) ; Tap Command Center
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Mouse_Click(430,280) ; Tap Recruit ; Mouse_Click(200,1160) ; Tap Recruit
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	loop, 3
		Mouse_Click(180,1180, {Timeout: Delay_Medium+0}) ; Tap Craft or Recruit or Extract
	; Mouse_Click(460,1180) ; Tap "OK"
	loop, 3
		Mouse_Click(460,1180, {Timeout: Delay_Medium+0}) ; Tap "OK"
	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Mouse_Click(450,1180, {Timeout: Delay_Medium+0}) ; Tap "OK"
	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
	return
}

; Collect Runes
Collect_Runes:
{
	Subroutine_Running := "Collect_Runes"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	loop, 2
	{
		Mouse_Click(430,280) ; Tap Command Center
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		Mouse_Click(570,340) ; Rune Extraction
		DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
		oGraphicSearch := new graphicsearch()	
		resultObj := oGraphicSearch.search(B3460_RuneExtract_Title_Graphic, optionsObjCoords)
		if (resultObj)
			goto Collect_Runes_Found
		if !Go_Back_To_Home_Screen()
			Reload_MEmu()
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	}
	goto Collect_Runes_END
	Collect_Runes_Found:
	{
		Mouse_Click(180,1180) ; Tap Craft or Recruit or Extract
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		goto Collect_Runes_END
		Loop, 3
		{
			Mouse_Click(450,1180) ; Tap "OK"
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		}
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	Collect_Runes_END:
	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
	return
}

Collect_Red_Envelopes:
{
	Subroutine_Running := "Collect_Red_Envelopes"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
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

		if !Go_Back_To_Home_Screen()
			Reload_MEmu()
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
				Reload_MEmu()
			Mouse_Drag(200, 350, 332, 350, {EndMovement: T, SwipeTime: 500})
			; Mouse_Drag(110, 536, 262, 537, {EndMovement: T, SwipeTime: 500})
			Mouse_Click(137,580) ; Tap activity center
			
			; Mouse_Drag(82, 536, 335, 536, {EndMovement: T, SwipeTime: 500})
			; Mouse_Click(180,600) ; Tap Activity Center

			Loop, 5
			{
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
				resultObj := oGraphicSearch.search(910_ActivityCtr_Title_Graphic, optionsObjCoords)
				if (resultObj)
					return 1
			}
		}
		Gosub Reset_Posit
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
		loop, 10
		{
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
			resultObj := oGraphicSearch.search(917_DesertWonder_Button_Graphic, optionsObjCoords)
			if (resultObj)
			{
				Click_X := resultObj[1].x
				Click_Y := resultObj[1].y
				Mouse_Click(Click_X,Click_Y) ; Tap Desert Wonder
				goto Desert_Wonder_Continue_Tab
			}
		}
		Mouse_Drag(350, 1100, 350, 500, {EndMovement: T, SwipeTime: 500})
	}
	goto Desert_Wonder_END

	Desert_Wonder_Continue_Tab:
	; MsgBox, 0, , Capture_Screen_Text:"%Capture_Screen_Text%"`nSearch_Text_Array:"%Search_Text_Array%"

	Loop, 10
	{
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		; Find single occurence of image, return true or false
		oGraphicSearch := new graphicsearch()	
		resultObj := oGraphicSearch.search(9170_DesertWonder_Title_Graphic, optionsObjCoords)
		if (resultObj)
			goto Desert_Wonder_Continue_Claim
	}
	goto Desert_Wonder_END

	Desert_Wonder_Continue_Claim:
	; MsgBox, 0, , Capture_Screen_Text:"%Capture_Screen_Text%"`nSearch_Text_Array:"%Search_Text_Array%"
	Mouse_Click(259, 144) ; Tap Activity Tab
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
	
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
		Mouse_Click(Click_X,Click_Y) ; Tap Wonder reward boxes
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Mouse_Click(330,1000) ; Tap Collect Rewards
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		loop, 2
			Mouse_Click(330,70, {Clicks: 2,Timeout: Delay_Medium+0})
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
		Mouse_Click(Click_X,Click_Y) ; Tap "Receive Rewards"
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		Mouse_Click(330,1000) ; Tap Collect Rewards
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
		loop, 2
			Mouse_Click(330,70, {Clicks: 2,Timeout: Delay_Medium+0})
		if ((Click_Y <= Max_Y) && (Click_Y >= Min_Y))
			Click_Y += Click_Y_Delta
		else
			Click_Y := Min_Y
	}
	return
	
	Desert_Wonder_END:
	; MsgBox, 0, Pause, All rewards claimed? Press OK to return home (No Timeout)
	if !Go_Back_To_Home_Screen()
		Reload_MEmu()

	return
}

Benefits_Center:
{
	Subroutine_Running := "Benefits_Center"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Subroutines_Text_Array := {Battle_Honor_Collect : [921_BattleHonor_Button_Graphic, False]
	, Daily_Signin : [923_DailySignin_Button_Graphic, True]
	, Monthly_Package_Collect : [924_MonthlyPackage_Button_Graphic, True]
	, Monthly_Signin : [925_MonthlySignin_Button_Graphic, True]
	, Select_Reward : [926_SelectReward_Button_Graphic, True]
	, Selection_Chest : [927_SelectionChest_Button_Graphic, True]
	, Single_Cumulation : [928_SingleCumulation_Button_Graphic, True]
	, Warrior_Trial : [929_WarriorTrial_Button, True]
	, Claim_Buttons : [922_Claim_Button, True]}

	loop, 2
		Mouse_Click(625,310) ; Tap Benefits Center
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0)) ; wait for Benefits Center to load
	Gosub Benefits_Center_Reload
	
	Gosub Benefits_Check_Tabs_New
	Go_Back_To_Home_Screen()
	Gosub Benefits_Center_Reload
	
	loop, 8
	{
		loop, 4
			Gosub Benefits_Check_Tabs_New
		gosub Swipe_Right2
	}

	Goto Benefits_Center_END

	Benefits_Center_Reload:
	Subroutine_Running := "Benefits_Center_Reload"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	oGraphicSearch := new graphicsearch()	
	loop, 5
	{
		loop, 5
		{
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
			; Find single occurence of image, return true or false
			resultObj := oGraphicSearch.search(920_Benefits_Title_Graphic, optionsObjCoords)
			if (resultObj)
				return
		}

		; Gosub Get_Window_Geometry
		Gosub Check_Window_Geometry
		if !Go_Back_To_Home_Screen()
			Reload_MEmu()
		loop, 2
			Mouse_Click(625,310, {Timeout: Delay_Short}) ; Tap Benefits Center
		DllCall("Sleep","UInt",(rand_wait + 4*Delay_Long+0))
	}
	return

	Benefits_Center_END:
	Go_Back_To_Home_Screen()
		; Reload_MEmu()
	return
	
	Benefits_Check_Tabs_New:
	Subroutine_Running := "Benefits_Check_Tabs_New"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	{
		For Subroutine,Value in Subroutines_Text_Array
		{
			; GraphicSearch_Query := Value[1]
			; Run_Routine := (byref Value[2])

			If (Value[2])
			{
				oGraphicSearch := new graphicsearch()	
				resultObj := oGraphicSearch.search(Value[1], optionsObjCoords)
				if (resultObj)
				{
					Click_X := resultObj[1].x
					Click_Y := resultObj[1].y
					; MsgBox, %  "x:" resultObj.x " y:" resultObj.y "`n0 x:" resultObj[0].x " y:" resultObj[0].y "`n1 x:" resultObj[1].x " y:" resultObj[1].y "`n2 x:" resultObj[2].x " y:" resultObj[2].y "`n3 x:" resultObj[3].x " y:" resultObj[3].y
					loop, 3
						Mouse_Click(Click_X,Click_Y) ; Tap found Heading
					
					DllCall("Sleep","UInt",(rand_wait + 3*Delay_Long+0)) ; wait for tab to load
					if IsLabel(Subroutine)
						Gosub %Subroutine%
					Value[2] := False
					Gosub Benefits_Center_Reload
				}
			}
		}
		return
	}

	Swipe_Right:
	loop, 4
	{
		; Benefits Center Swipe Right One position
		Mouse_Drag(630, 187, 353, 187, {EndMovement: T, SwipeTime: 500})
	}
	return

	Swipe_Right2:
	{
		; Benefits Center Swipe Right One position
		; Mouse_Drag(580, 187, 116, 187, {EndMovement: T, SwipeTime: 500})
		; Mouse_Drag(580, 187, 90, 187, {EndMovement: T, SwipeTime: 500})
		; Mouse_Drag(500, 187, 120, 187, {EndMovement: T, SwipeTime: 500})
		Mouse_Drag(500, 187, 300, 187, {EndMovement: T, SwipeTime: 500}) ; 324 is half
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	}
	return

	Select_Reward:
	{
		; if !Select_Reward_Run
		; 	return

		Subroutine_Running := "Select_Reward"
		stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )

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
		; if !Monthly_Package_Collect_Run
		; 	return

		Subroutine_Running := "Monthly_Package_Collect"
		stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )

		Mouse_Click(500,1200) ; Tap Claim

		Monthly_Package_Collect_Run := False
		return
	}

	Warrior_Trial:
	{
		; if !Warrior_Trial_Run
		; 	return

		Subroutine_Running := "Warrior_Trial_Collect"
		stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
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
		; if !Single_Cumulation_Run
		; 	return

		Subroutine_Running := "Single_Cumulation"
		stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )

		Mouse_Click(560,550) ; Tap Claim

		Single_Cumulation_Run := False
		return
	}

	Claim_Buttons:
	{
		; if !Claim_Buttons_Run
		;	return

		Subroutine_Running := "Claim_Buttons"
		stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
		; Mouse_Click(180,1130, {Timeout: Delay_Short+0}) ; Tap Collide
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
		; if !Daily_Signin_Run
		; 	return

		Subroutine_Running := "Daily_Signin"
		stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
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
			Mouse_Click(320,70, {Timeout: (1*Delay_Micro+0)}) ; Tap top title bar

		loop, 7
			Mouse_Click(320,70, {Timeout: (1*Delay_Short+0)}) ; Tap top title bar

		return
	}

	Monthly_Signin:
	{
		; if !Monthly_Signin_Run
		; 	return

		Subroutine_Running := "Monthly_Signin"
		stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
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
		; if !Selection_Chest_Run
		; 	return

		Subroutine_Running := "Selection_Chest"
		stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )

		Mouse_Click(87,430) ; Tap Free Chest
		DllCall("Sleep","UInt",(rand_wait + 8*Delay_Short+0))

		Mouse_Click(52,682) ; Select 1,000 Diamonds
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		Mouse_Click(517,680) ; Select Silver Medal
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		; Swipe Up X times
		loop, 4
			Mouse_Drag(300, 1030, 300, 650, {EndMovement: F, SwipeTime: 1000})

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
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	{
		; if !Battle_Honor_Run
		; 	return

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
			Mouse_Click(260,800, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 03
			Mouse_Click(260,963, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 05
			Mouse_Click(260,1126, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 07
			Mouse_Click(260,720, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 02
			Mouse_Click(260,883, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 04
			Mouse_Click(260,1050, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 06
			Mouse_Click(260,1202, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 08
			Mouse_Click(260,636, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 01
			Mouse_Click(260,800, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 03
			Mouse_Click(260,963, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 05
			Mouse_Click(260,1126, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 07
			Mouse_Click(260,720, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 02
			Mouse_Click(260,883, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 04
			Mouse_Click(260,1050, {Clicks: 2,Timeout: Delay_Short}) ; Tap Battle Honor 06
			Mouse_Click(260,1202, {Clicks: 2,Timeout: Delay_Micro}) ; Tap Battle Honor 08

			return
		}

		Battle_Honor_Swipe:
		{
			Mouse_Drag(350, 1203, 360, 609, {EndMovement: T, SwipeTime: 500})
			Return
		}

		Battle_Honor_END:

		Battle_Honor_Run := False
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
		; Reload_MEmu()

	loop, 2
		Mouse_Click(630,1033) ; Tap speaker/help
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

	oGraphicSearch := new graphicsearch()
	loop, 3
	{
		resultObj := oGraphicSearch.search(71_Speaker_Claim_Button_Graphic, optionsObjCoords)
		if (resultObj)
		{
			Mouse_Click(resultObj[1].x,resultObj[1].y)
			break
		}
		Else
		{
			Mouse_Click(630,1033) ; Tap speaker/help
			DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		}
	}
	
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
	return
}

Drop_Zone:
{
	Subroutine_Running := "Drop_Zone"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(285,200) ; Tap On Drop Zone
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
	oGraphicSearch := new graphicsearch()
		
	loop, 20
	{
		resultObj := oGraphicSearch.search(allQueries_Account, optionsObjCoords)
		if (resultObj)
			loop, 20
				Mouse_Click(410,1050, {Clicks: 2,Timeout: (1*Delay_Short+0)}) ; Get Steel X Times
	}

	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
	return
}

Adventure_Missions:
{
	Subroutine_Running := "Adventure_Missions"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
	return
}

Collect_Cafeteria:
{
	Subroutine_Running := "Collect_Cafeteria"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(379,736) ; Collect Cafeteria
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	; if !Go_Back_To_Home_Screen()
		; Reload_MEmu()
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
		Mouse_Click(215,425) ; Active Skill tab #2 - Officer
	Gosub Active_Skill_Click_Button
	
	/*
	loop, 2
		Mouse_Click(340,425) ; Active Skill tab #3 - Combat
	Gosub Active_Skill_Click_Button
	*/

	loop, 2
		Mouse_Click(470,425) ; Active Skill tab #4 - Develop
	Gosub Active_Skill_Click_Button

	loop, 2
		Mouse_Click(600,425) ; Active Skill tab #5 - Support
	Gosub Active_Skill_Click_Button
	
	goto Active_Skill_END
	
	Active_Skill_Click_Button:
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
	oUse_ButtonSearch := new graphicsearch()
	{
		resultUse_Button := oUse_ButtonSearch.search(832_Green_Use_Button_Graphic, optionsObjCoords)
		if (resultUse_Button)
		{
			sortedUse_Button := oUse_ButtonSearch.resultSortDistance(resultUse_Button, Client_Area_X2, Client_Area_Y2)
			loop, % sortedUse_Button.Count()
			{
				Mouse_Click(sortedUse_Button[A_Index].x,sortedUse_Button[A_Index].y)
				gosub Active_Skill_Titles
				Mouse_Click(350,350, {Timeout: (1*Delay_Long+0)}) ; Tap Active skill title bar
			}
		}
		
		Gosub Active_Skill_Reload
		return
	}
	
	Active_Skill_Titles:
	{
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		oTitlesSearch := new graphicsearch()
		loop, 4
		{
			resultTitles := oTitlesSearch.search(831_Blue_Use_Button_Graphic, optionsObjCoords)
			if (resultTitles)
				Goto Active_Skill_Titles_Continue ; break
			Else
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		}
		return
		
		Active_Skill_Titles_Continue:
		oTitlesSearch := new graphicsearch()
		resultTitles := oTitlesSearch.search(OfficerSkills, optionsObjCoords)
		if (resultTitles)
			Mouse_Click(340,780, {Timeout: (3*Delay_Long+0)}) ; Tap Blue "Use" button

		; Mouse_Click(350,350, {Timeout: (1*Delay_Long+0)}) ; Tap Active skill title bar

		Gosub Active_Skill_Reload
		return
	}

	Active_Skill_Reload:
	loop, 2
	{
		; check to see if active skill is properly displayed x times
		
		oSkill_TitleSearch := new graphicsearch()
		loop, 6
		{
			resultSkill_Title := oSkill_TitleSearch.search(830_ActiveSkill_Title_Graphic, optionsObjCoords)
			if (resultSkill_Title)
			{
				Mouse_Click(resultSkill_Title[1].x,resultSkill_Title[1].y, {Clicks:2})
				return
			}
			Else
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
		}

		; Gosub Get_Window_Geometry
		Gosub Check_Window_Geometry
		if !Go_Back_To_Home_Screen()
			Reload_MEmu()
		Mouse_Click(195,1195) ; Tap Activate Skills
		; DllCall("Sleep","UInt",(rand_wait + 3*Delay_Medium+0))
	}
	return

	Active_Skill_END:
	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
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
		Reload_MEmu()
	return
}

; upgrade and ask for factory help during csb
Reserve_Factory:
{
	Subroutine_Running := "Reserve_Factory"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; if !Go_Back_To_Home_Screen()
		; Reload_MEmu()

	; *******************************
	; Collect Reserve supplies
	; *******************************

	Gosub Alliance_Help_Open

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
		Gosub Alliance_Help_Open

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

	Gosub Alliance_Help_Open

	loop, 2
	{
		Mouse_Click(320,405) ; Tap Instant Help
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		Mouse_Click(510,415) ; Tap Request Help
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	; Go_Back_Home_Delay_Long := True
	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
	return

	Alliance_Help_Open:
	{
		loop, 2
		{
			Mouse_Click(610,1200) ; Tap Alliance Menu
			DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
			loop, 4
				if Search_Captured_Text_OCR(["Alliance"]).Found
					break

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
				Reload_MEmu()
		}
		return
		; MsgBox, 0, Pause, Loop done. Press OK to resume (No Timeout)

		Alliance_Help_Continue:
		; Mouse_Click(355,825) ; Tap Alliance Help
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))		
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		Mouse_Click(480,140) ; Tap Reserve Factory Help
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))		
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

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
			Reload_MEmu()
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
				Mouse_Click(469,Tech_Click_Y) ; select tech
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

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
	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
	return
}

Depot_Rewards:
{
	Subroutine_Running := "Depot_Rewards"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )

	; set variables 
	oGraphicSearch := new graphicsearch()
	loop, 5
	{
		Mouse_Click(140,662, {Timeout: 1*Delay_Long+0}) ; Tap depot
		Mouse_Click(250,722, {Timeout: 1*Delay_Long+0}) ; Tap Alliance Treasures
		loop, 20
		{
			DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
			resultObj := oGraphicSearch.search(B350_Depot_Title_Graphic, optionsObjCoords)
			if (resultObj)
				goto Continue_Depot_Treasures
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
		Reload_MEmu()
	return

	Find_Rewards_FREE:
	oGraphicSearch := new graphicsearch()			
	; check if Free graphic is found
	loop, 8
	{
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
		resultObj := oGraphicSearch.search(B351_Free_Button_Graphic, optionsObjCoords)
		if (resultObj)
		{
			Mouse_Click(resultObj[1].x,resultObj[1].y)
			break
		}
	}
	return

	Find_Rewards_ALL:
	DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))
	; check if any graphic was found
	oGraphicSearch := new graphicsearch()			
	allQueries_Depot := B352_Help_Button_Graphic B353_Request_Button_Graphic B354_Reward_Button_Graphic
	loop, 8
	{
		resultObj := oGraphicSearch.search(allQueries_Depot, optionsObjCoords)
		if (resultObj)
		{
			sortedResults := oGraphicSearch.resultSortDistance(resultObj, 300, 1216)
			loop, % sortedResults.Count()
			{
				Mouse_Click(resultObj[A_Index].x,resultObj[A_Index].y)
				DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
				Mouse_Click(320,70) ; Tap top title bar
			}
		}
	}
	return
}

VIP_Shop:
{
	Subroutine_Running := "VIP_Shop"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Mouse_Click(156,90) ; Tap VIP Shop
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))


	loop, 2
	{
		loop, 2
			if Search_Captured_Text_OCR(["VIP Shop"]).Found
				goto Continue_VIP_Shop

		if !Go_Back_To_Home_Screen()
			Reload_MEmu()
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
	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
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
	return
}

Mail_Collection:
{
	Subroutine_Running := "Mail_Collection"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; if !Go_Back_To_Home_Screen()
		; Reload_MEmu()

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
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Subroutine_Running := "Single Player Arms Race"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	Mouse_Click(200,170) ; Tap Activities - SPAR (Single Player Arms Race)
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Subroutine_Running := "Alliance Arms Race"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	Mouse_Click(200,257) ; Tap Activities - AAR (Alliance Arms Race)
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Subroutine_Running := "Cross-State Battle"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	Mouse_Click(200,360) ; Tap Activities - CSB (Cross-State Battle)
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Subroutine_Running := "Desert Conflict"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	Mouse_Click(200,445) ; Tap Activities - Desert Conflict
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	Subroutine_Running := "Other Event Mail"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	Mouse_Click(200,540) ; Tap Activities - Other Event Mail
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	Gosub Mark_All_As_Read

	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
	return

	Mark_All_As_Read:
	Subroutine_Running := "Mark_All_As_Read"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	Loop, 2
	{
		if Search_Captured_Text_OCR(["MARK","READ"], {Pos: [273, 1185], Size: [142, 26]}).Found ; Is the Mark as Read button displayed?
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
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	loop, 2
	{
		loop, 5
		{
			; if mail loaded, return
			if Search_Captured_Text_OCR(["Mail"], {Pos: [309, 46], Size: [76, 50]}).Found
				return ; Gosub, Read_Mail_Open

			; if mail not loaded, tap on mail icon
			if Search_Captured_Text_OCR(["Mail"], {Pos: [466, 1222], Size: [56, 24]}).Found
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
		if !Go_Back_To_Home_Screen()
			Reload_MEmu()
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
			Mouse_Click(610,1200) ; Tap Alliance Menu
			DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))
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
				Reload_MEmu()
		}
}
*/

Alliance_Boss_Regular:
{
	Subroutine_Running := "Alliance_Boss"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; if !Go_Back_To_Home_Screen()
		; Reload_MEmu()

	Mouse_Click(610,1214) ; Tap Alliance
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	; Swipe up
	loop, 2
		Mouse_Drag(345, 1100, 409, 196, {EndMovement: F, SwipeTime: 500})

	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(273,540) ; Tap Alliance Boss regular play
	; Mouse_Click(273,630) ; Tap Alliance Boss desert oasis
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(525,1186) ; Tap Feed Boss
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(340,780) ; Tap Confirm Feed Boss

	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
	return
}

Alliance_Boss_Oasis:
{
	Subroutine_Running := "Alliance_Boss"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; if !Go_Back_To_Home_Screen()
		; Reload_MEmu()

	Mouse_Click(610,1214) ; Tap Alliance
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	; Swipe up
	loop, 2
		Mouse_Drag(345, 1100, 409, 196, {EndMovement: F, SwipeTime: 500})

	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	; Mouse_Click(273,540) ; Tap Alliance Boss regular play
	Mouse_Click(273,630) ; Tap Alliance Boss desert oasis
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(525,1186) ; Tap Feed Boss
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	Mouse_Click(340,780) ; Tap Confirm Feed Boss

	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
	return
}

Alliance_Wages:
{
	Subroutine_Running := "Alliance_Wages"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; if !Go_Back_To_Home_Screen()
		; Reload_MEmu()

	Goto Alliance_Menu_Wages

	Control_Desk_Alliance_Wages:
	{

		Mouse_Click(27,612) ; Tap to Expand Control Desk
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

		; Swipe Down (linear)
		loop, 2
			Mouse_Drag(326, 405, 326, 957, {EndMovement: F, SwipeTime: 500})

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
				if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H]}).Found
				{
					Mouse_Click(405,932) ; Tap Alliance Wages button
					goto Found_Alliance_Wages_Menu
				}

				OCR_Y := 1020
				if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H]}).Found
				{
					Mouse_Click(405,1044) ; Tap Alliance Wages button
					goto Found_Alliance_Wages_Menu
				}
			}

			if !Go_Back_To_Home_Screen()
				Reload_MEmu()
			Mouse_Click(605,1212) ; Tap Alliance Menu
		}
		goto Alliance_Wages_END

		Found_Alliance_Wages_Menu:
		Gosub Alliance_Wages_Continue

		Alliance_Wages_END:
		if !Go_Back_To_Home_Screen()
			Reload_MEmu()
		return
	}

	Alliance_Wages_Continue:
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	; Alliance Wages - Active (TAB 1)
	Alliance_Wages_Active_TAB_1:
	Subroutine_Running := "Alliance_Wages_Active_TAB_1"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
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

		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
		Gosub Click_Points_Boxes
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

		; MsgBox, 4, , Retry? (8 Second Timeout & skip), 5 ; 8
		; vRet := MsgBoxGetResult()
		; if (vRet = "No")
		; goto Alliance_Wages_Active_TAB_2

		TRY_MORE_02_Alliance_Wages_Active_TAB_1:
		Gosub Click_Through_Wage_Tabs
		; Swipe Left
		loop, 5
			Mouse_Drag(624, 647, 216, 647, {EndMovement: F, SwipeTime: 500})

		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))
		Gosub Click_Points_Boxes
		DllCall("Sleep","UInt",(rand_wait + 3*Delay_Short+0))

		END_Alliance_Wages_Active_TAB_1:
		; MsgBox, 4, , Retry? (8 Second Timeout & skip), 5 ; 8
		; vRet := MsgBoxGetResult()
		; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		; goto TRY_MORE_01_Alliance_Wages_Active_TAB_1
	}

	; Alliance Wages - Active (TAB 2)
	Alliance_Wages_Active_TAB_2:
	Subroutine_Running := "Alliance_Wages_Active_TAB_2"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
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
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
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
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; if !Go_Back_To_Home_Screen()
		; Reload_MEmu()

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

		if !Go_Back_To_Home_Screen()
			Reload_MEmu()

		return
	}
}

Gather_Resources:
{
	Subroutine_Running := "Gather_Resources"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; if !Go_Back_To_Home_Screen()
		; Reload_MEmu()

	Mouse_Click(76,1200) ; Tap World/home button
	DllCall("Sleep","UInt",(rand_wait + 8*Delay_Long+0))

	Gather_Fuel:
	Subroutine_Running := "Gather_Fuel"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
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

	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	MsgBox, 4, , Gather Oil Well? (8 Second Timeout & skip), 5 ; 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		{
			Mouse_Click(407,974) ; Tap Oil Well
			Gosub Search_And_Deploy_Resources
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		}

	Gather_Farm:
	Subroutine_Running := "Gather_Farm"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	MsgBox, 4, , Gather Farm? (8 Second Timeout & skip), 5 ; 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		{
			Mouse_Click(547,970) ; Tap Farm
			Gosub Search_And_Deploy_Resources
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		}

	Gather_Steel:
	Subroutine_Running := "Gather_Steel"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
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

	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	MsgBox, 4, , Gather Steel Mill? (8 Second Timeout & skip), 5 ; 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		{
			Mouse_Click(124,983) ; Tap Steel Mill
			Gosub Search_And_Deploy_Resources
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		}

	Gather_Alloy:
	Subroutine_Running := "Gather_Alloy"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; Swipe left x times
	loop, 2
		Mouse_Drag(600, 990, 100, 990, {EndMovement: F, SwipeTime: 500})

	; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	MsgBox, 4, , Gather Alloy Mine? (8 Second Timeout & skip), 5 ; 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		{
			Mouse_Click(270,970) ; Tap Alloy Mine
			Gosub Search_And_Deploy_Resources
			; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
		}

	MsgBox, 4, , Gather more? (10 Second Timeout & skip), 15 ; 0
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		Gosub Gather_Fuel

	End_Gathering:

	; Go_Back_Home_Delay_Long := True
	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
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
		return
	}
}

Desert_Oasis:
{
	Subroutine_Running := "Desert_Oasis"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )

	loop, 3
		if Enter_Coordinates_From_Home()
			gosub Desert_Oasis_Enter_Coordinates_Next

	goto END_Stealing

	Desert_Oasis_Enter_Coordinates_Next:
	Subroutine_Running := "Desert_Oasis_Enter_Coordinates_Next"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
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

		MsgBox, 4, , Steal from NW_Tower (595:599)? (8 Second Timeout & skip), 5 ; 8
		vRet := MsgBoxGetResult()
		if (vRet = "Yes")
			goto NW_Tower

		MsgBox, 4, , Steal from NE_Tower(599:595)? (8 Second Timeout & skip), 5 ; 8
		vRet := MsgBoxGetResult()
		if (vRet = "Yes")
			goto NE_Tower

		MsgBox, 4, , Steal from SW_Tower(600:604)? (8 Second Timeout & skip), 5 ; 8
		vRet := MsgBoxGetResult()
		if (vRet = "Yes")
			goto SE_Tower

		MsgBox, 4, , Steal from SE_Tower(604:599)? (8 Second Timeout & skip), 5 ; 8
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
		stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
		; NW_Tower Coordinates X: 595-596 Y: 599-600 (595,599) steal: 439, 681
		; NE_Tower Coordinates X: 599-600 Y: 595-596 (599,595) steal: 441, 681
		; SW_Tower Coordinates X: 599-600 Y: 604-605 (599,604) steal: 447, 678
		; SE_Tower Coordinates X: 604-605 Y: 599-600 (604,599) steal: 440, 680
		; MsgBox, 4, Coordinates, Are Desert_Tower_X`,Y %Desert_Tower_X% %Desert_Tower_X% Correct? (8 Second Timeout & auto),5 ; 8

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

		/*
		Desert_Oasis_Coordinates_Text := ["Steal"]
		OCR_X := 315
		OCR_Y := 1190
		OCR_W := 55
		OCR_H := 30
		*/
		loop, 2
		{
			loop, 5
				if Search_Captured_Text_OCR(["Steal"], {Pos: [315, 1190], Size: [55, 30]}).Found
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
	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
	return
}

; Functions to handle opening coordinates panel
Enter_Coordinates_From_Home()
{
	Subroutine_Running := "Enter_Coordinates_From_Home"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	Mouse_Click(73,1207) ; Tap on World Button
	DllCall("Sleep","UInt",(rand_wait + 3*Delay_Long+0))

	loop, 2
		if Enter_Coordinates_From_World()
			return 1

	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
	return 0
}

Enter_Coordinates_From_World()
{
	Subroutine_Running := "Enter_Coordinates_From_World"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
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
		; Reload_MEmu()

	Swipe_Up_Left_RSS:
	loop, 5
	{
		; Mouse_Drag(560, 900, 50, 600, {EndMovement: F, SwipeTime: 300})
		Mouse_Drag(560, 930, 50, 330, {EndMovement: F, SwipeTime: 200})
		; Mouse_Drag(480, 786, 143, 50, {EndMovement: F, SwipeTime: 500})
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(405,653) ; Plot # 50
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(396,553) ; Plot # 49
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(397,453) ; Plot # 47
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(350,374) ; Plot # 35
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(330,280) ; Plot # 34
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(239,233) ; Plot # 32
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	; inserts pause
	; Search_Captured_Text := ["Desert"]
	; Capture_Screen_Text := OCR([236, 40, 215, 57], "eng") ; check if
	; If (RegExMatch(Capture_Screen_Text,Search_Captured_Text))

	if Search_Captured_Text_OCR(["Desert"]).Found
		Goto END_Gather_Base_RSS

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(305,587) ; Plot # 48
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(292,509) ; Plot # 46
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(250,337) ; Plot # 33
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(160,282) ; Plot # 31
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(137,817) ; Plot # 40
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(36,760) ; Plot # 39 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	loop, 2 {
		Mouse_Click(29,726) ; Plot # 37 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}
	; DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	; inserts pause
	; Search_Captured_Text := ["Desert"]
	; Capture_Screen_Text := OCR([236, 40, 215, 57], "eng") ; check if
	; If (RegExMatch(Capture_Screen_Text,Search_Captured_Text))

	if Search_Captured_Text_OCR(["Desert"]).Found
		Goto END_Gather_Base_RSS

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(130,827) ; Plot # 38
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(40,770) ; Plot # 36 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(445,583) ; Plot # 45
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(367,542) ; Plot # 43
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(272,493) ; Plot # 41
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(485,510) ; Plot # 44
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(380,462) ; Plot # 42
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	Swipe_Right_RSS_02:
	Mouse_Drag(147, 854, 330, 649, {EndMovement: T, SwipeTime: 500})
	; Mouse_Drag(147, 854, 373, 649, {EndMovement: T, SwipeTime: 500})

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(307,424) ; Plot # 29
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(400,376) ; Plot # 30
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(360,293) ; Plot # 28
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(167,412) ; Plot # 26
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(273,354) ; Plot # 27
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(110,600) ; Plot # 24 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	loop, 2 {
		Mouse_Click(34,540) ; Plot # 22 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(160,680) ; Plot # 25
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(110,644) ; Plot # 23 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	loop, 2 {
		Mouse_Click(74,593) ; Plot # 21 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(167,826) ; Plot # 19
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(86,770) ; Plot # 17 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}
	DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	loop, 2 {
		Mouse_Click(530,1033) ; Tap next to speaker
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
	}

	loop, 2 {
		Mouse_Click(310,780) ; Plot # 20
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(202,710) ; Plot # 18
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}

	loop, 2 {
		Mouse_Click(114,665) ; Plot # 16 - screen moves
		DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))
	}
	; DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	END_Gather_Base_RSS:
	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
	return
}

; Claim Golden_Chest items
Golden_Chest:
{
	Subroutine_Running := "Golden_Chest"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; if !Go_Back_To_Home_Screen()
		; Reload_MEmu()

	if !Activity_Center_Open()
		goto Golden_Chest_END

	Golden_Chest_Next:
	Golden_Chest_Text := ["Golden"]
	loop, 3
	{
		; Capture_Screen_Text := OCR([181, 596, 80, 33], "eng") ; Check Activity Center item 01
		if Search_Captured_Text_OCR(["Golden"], {Pos: [180, 596], Size: [120, 33]}).Found
		{
			Mouse_Click(180, 596) ; Tap Activity Center item 01
			goto Golden_Chest_Open_for_free_button
		}

		; Capture_Screen_Text := OCR([181, 790, 80, 33], "eng") ; Check Activity Center item 02
		if Search_Captured_Text_OCR(["Golden"], {Pos: [180, 790], Size: [120, 33]}).Found
		{
			Mouse_Click(180, 793) ; Tap Activity Center item 02
			goto Golden_Chest_Open_for_free_button
		}

		; Capture_Screen_Text := OCR([181, 985, 80, 33], "eng") ; Check Activity Center item 03
		if Search_Captured_Text_OCR(["Golden"], {Pos: [180, 985], Size: [120, 33]}).Found
		{
			Mouse_Click(180, 989) ; Tap Activity Center item 03
			goto Golden_Chest_Open_for_free_button
		}

		; Capture_Screen_Text := OCR([181, 1182, 80, 33], "eng") ; Check Activity Center item 04
		if Search_Captured_Text_OCR(["Golden"], {Pos: [180, 1182], Size: [120, 33]}).Found
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
			if Search_Captured_Text_OCR(["Golden Chest"]).Found
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
	if Search_Captured_Text_OCR(["free"], {Pos: [150, 1182], Size: [40, 21]}).Found
		Mouse_Click(125, 1200) ; Tap "Open for free" button
	DllCall("Sleep","UInt",(rand_wait + 5*Delay_Medium+0))
	loop, 2
		Mouse_Click(320,70) ; Tap top title bar
		; Mouse_Click(585,250) ; Tap outside claim banner
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))
	Mouse_Click(357,495) ; Tap Silver tab
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Long+0))

	; Capture_Screen_Text := OCR([150, 1182, 85, 30], "eng") ; Check if "Open for free" button
	if Search_Captured_Text_OCR(Golden_Chest_Text, {Pos: [150, 1182], Size: [40, 21]}).Found
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
	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
	return
}

; Send in-game message to "BOSS" with retrieved info
Send_Mail_To_Boss:
{
	Subroutine_Running := "Send_Mail_To_Boss"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
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
	; if !Go_Back_To_Home_Screen()
		; Reload_MEmu()

	Open_Mail:

	Mouse_Click(492,1202) ; Tap mail
	; DllCall("Sleep","UInt",(rand_wait + 2*Delay_Long+0))

	loop, 2
	{
		loop, 5
			if Search_Captured_Text_OCR(["Mail"]).Found
				goto Compose_Message

		if !Go_Back_To_Home_Screen()
			Reload_MEmu()
		Mouse_Click(492,1202) ; Tap mail
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
	}

	; MsgBox, Capture_Screen_Text: %Capture_Screen_Text%
	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
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

	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
	return
}

; Send message via in-game chat interface
Send_Message_In_Chat:
{
	Subroutine_Running := "Send_Message_In_Chat"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
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

	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
	return
}

; OCR capture available and stored RSS levels
Get_Inventory:
{
	Subroutine_Running := "Get_Inventory"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
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

	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
	return
}

; OCR capture User info like VIP level, combat power, alliance and state
Get_User_Info:
{
	Subroutine_Running := "Get_User_Info"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
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

	if !Go_Back_To_Home_Screen()
		Reload_MEmu()

	; User_Diamonds := OCR([590, 90, 96, 30], "eng")
	User_Diamonds := OCR([590, 95, 90, 20], "eng")
	User_Diamonds := % Convert_OCR_Value(User_Diamonds)

	Message_To_The_Boss .= User_Name_Captured
	. "`,Alliance:`," . User_Found_Alliance
	. "`,State:`," . User_Found_State
	. "`,VIP:`," . User_VIP
	. "`,Power:`," . User_Power . "`,"
	. "`,Diamonds:`," . User_Diamonds . "`,"
	return
}

; OCR capture Map coordinates of base
Get_User_Location:
{
	Subroutine_Running := "Get_User_Location"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
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
	if !Go_Back_To_Home_Screen()
		Reload_MEmu()
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
				Mouse_Click(FoundPictureX,FoundPictureY) ; Tap Found Base
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
				MsgBox, 1 ErrorLevel: %ErrorLevel% - A %Base_Picture% found at X%FoundPictureX% Y%FoundPictureY%.
			}

			; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			ImageSearch, FoundPictureX, FoundPictureY, %PixelSearch_UpperX2%, %PixelSearch_UpperY2%, %PixelSearch_LowerX2%, %PixelSearch_LowerY2%, *145 *Trans0xF0F0F0 %Base_Picture%
			if !ErrorLevel ; (ErrorLevel = 0)
			{
				stdout.WriteLine(A_NowUTC ",A," Base_Picture " was found at X"FoundPictureX " Y" FoundPictureY )
				Mouse_Click(FoundPictureX,FoundPictureY) ; Tap Found Base
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
				MsgBox, 2 ErrorLevel: %ErrorLevel% - A %Base_Picture% found at X%FoundPictureX% Y%FoundPictureY%.
			}

			; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			ImageSearch, FoundPictureX, FoundPictureY, %PixelSearch_UpperX1%, %PixelSearch_UpperY1%, %PixelSearch_LowerX1%, %PixelSearch_LowerY1%, *145 *Trans0xFFFFFF %Base_Picture%
			if !ErrorLevel ; (ErrorLevel = 0)
			{
				stdout.WriteLine(A_NowUTC ",A," Base_Picture " was found at X"FoundPictureX " Y" FoundPictureY )
				Mouse_Click(FoundPictureX,FoundPictureY) ; Tap Found Base
				DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))
				MsgBox, 3 ErrorLevel: %ErrorLevel% - A %Base_Picture% found at X%FoundPictureX% Y%FoundPictureY%.
			}

			; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			ImageSearch, FoundPictureX, FoundPictureY, %PixelSearch_UpperX2%, %PixelSearch_UpperY2%, %PixelSearch_LowerX2%, %PixelSearch_LowerY2%, *145 *Trans0xFFFFFF %Base_Picture%
			if !ErrorLevel ; (ErrorLevel = 0)
			{
				stdout.WriteLine(A_NowUTC ",A," Base_Picture " was found at X"FoundPictureX " Y" FoundPictureY )
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
		Reload_MEmu()
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
		; Text_To_Screen("{Esc}")
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

F4::ExitApp

^F6::
Reload_MEmu:
{
	Reload_MEmu()
	Launch_LEWZ()
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

; Shortcut for claiming max items in inventory
; slides bar from left to right and presses OK
F3::
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Drag Slide Right to select all
	; Mouse_Drag(125, 687, 415, 703, {EndMovement: F, SwipeTime: 500}) ; original
	; Mouse_Click(382,774) ; Tap Use ; original

	Mouse_Drag(115, 680, 360, 680, {EndMovement: F, SwipeTime: 100}) ; Client start: 115, 680, end: 360, 680
	Mouse_Click(380,786) ; Tap Use ; 340, 786

	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Micro+0))
Return

; Terminate running routine
F9::
if !Go_Back_To_Home_Screen()
	Reload_MEmu()
Gosub, Exit_Sub
MsgBox, This MsgBox will never happen because of the EXIT.
return

Exit_Sub:
Exit ; Terminate this subroutine as well as the calling subroutine.

; Close running AHK
; #c:: OCR()
#g:: Vis2.OCR.google() ; Googles the text instead of saving it to clipboard.
#i:: ImageIdentify()