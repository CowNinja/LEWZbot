
; Click Memu Title Bar
Memu_Title_Bar:
{
	Subroutine_Running := "Memu_Title_Bar"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; Click Memu Title Bar ; SendEvent {Click, 423, 25}
	Mouse_Click(423,25)

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Launch_Lewz:
{
	Subroutine_Running := "Launch_Lewz"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
		
	; Launch Lewz ; SendEvent {Click, 67, 844}
	Mouse_Click(67,844)

	DllCall("Sleep","UInt",rand_wait + (10*Delay_Long))
	
	Gosub Enter_Login_Password_PIN
	
	;Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Quit_LEWZ:
{
	Subroutine_Running := "Quit_LEWZ"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Quit LEWZ
	; Gosub Reset_Posit
	;Gosub Go_Back_To_Home_Screen
	;DllCall("Sleep","UInt",rand_wait + (8*Delay_Long))

	Text_To_Screen("{F5}")
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	; Click OK ; SendEvent {Click, 327, 769}
	Mouse_Click(327,769)
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
		
	Text_To_Screen("{F8}") ; Home screen button
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	
	; close LEWZ and/or other app tabs
	Loop, 5
	{
		SendEvent {Click, 283, 5}
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))
	}

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

; Clear in-game splash pages
Game_Start_popups:
{
	Subroutine_Running := "Game_Start_popups"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Clear first pop-up by pressing back
	Text_To_Screen("{F5}")
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	; Check No More Prompts Today On Today'S Hot Sale ; SendEvent {Click, 256, 978}
	Mouse_Click(256,978)
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	; Click X On Today'S Hot Sale ; SendEvent {Click, 631, 322}
	Mouse_Click(631,322)
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	; Collect Cafeteria ; SendEvent {Click, 378, 736}
	; Mouse_Click(378,736)

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

; reset position
Reset_Posit:
{
	Subroutine_Running := "Reset_Posit"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; go back x times

	; Go_Back_Home_Delay_Long := True
	Gosub Go_Back_To_Home_Screen
	;Gosub Speaker_Help

	; click World/home button x times
		; SendEvent {Click, 76, 1200}
		loop, 2
	{
		Mouse_Click(76,1200)
		DllCall("Sleep","UInt",rand_wait + (8*Delay_Long))
	}
	; Go_Back_Home_Delay_Long := True
	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Go_Back_To_Home_Screen:
{
	; Subroutine_Running := "Go_Back_To_Home_Screen"
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Go back
	loop, 10
		Text_To_Screen("{F5}")
	;DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

	Gosub Go_Back_To_Home_Screen_OCR_Quit
	loop, 2
		Gosub Go_Back_To_Home_Screen_OCR_NOT_Quit

	DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
	return

	Go_Back_To_Home_Screen_OCR_Quit:	
	Go_Back_To_Home_Text := ["Quit the game","Quit","the","game"]
	loop, 10
	{
		loop, 3
			if Search_Captured_Text_OCR(Go_Back_To_Home_Text, {Size: [252, 155], Pos: [141, 515], Timeout: 0})
				return
		
		Text_To_Screen("{F5}")
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
		Gosub Get_Window_Geometry
		Gosub Check_Window_Geometry
	}
	Gosub Reload_LEWZ_routine
	return
	
	Go_Back_To_Home_Screen_OCR_NOT_Quit:
	Go_Back_To_Home_Text := ["Quit the game","Quit","the","game"]
	loop, 5
	{
		loop, 3
			if !Search_Captured_Text_OCR(Go_Back_To_Home_Text, {Size: [252, 155], Pos: [141, 515], Timeout: 0})
				return
		
		Text_To_Screen("{F5}")
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
		Gosub Get_Window_Geometry
		Gosub Check_Window_Geometry
	}
	Gosub Reload_LEWZ_routine
	return

	Reload_LEWZ_routine:
	{
		Gosub Quit_LEWZ
		Gosub Launch_Lewz
		;Gosub Switch_Account
		Gosub Enter_Login_Password_PIN
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
	Gui, Status:show, x731 y0 w300 h500
	loop, 2
		GUI_Count++

	Switch_Account_START:
	; loop, 2
	Gosub Go_Back_To_Home_Screen
	;DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
		
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	SendEvent {Click, 50, 70} ; Click Commander Info
	DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
	
	Search_Captured_Text := ["Commander"]
	loop, 3
		if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0})
			break

	Switch_Account_Commander:
	loop,2
		SendEvent {Click, 600, 1200} ; Click Settings
	; DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))

	Search_Captured_Text := ["Settings"]
	loop, 2
		if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0})
			break

	loop,2
		SendEvent {Click, 100, 300} ; Click Account
	DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))

	Search_Captured_Text := ["Account"]
	loop, 2
		if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0})
			break
		
	loop,2
		SendEvent {Click, 350, 875} ; Click Switch Account
	DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))

	Search_Captured_Text := ["Switch Account"]
	loop, 2
		if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0})
			break

	loop,2
		SendEvent {Click, 350, 700} ; Click WarZ Account
	DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))

	Search_Captured_Text := ["War Z Account"]
	loop, 2
		if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0})
			break
		
	SendEvent {Click, 475, 1150} ; Click Other Account.
	DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))

	Switch_Account_Login:
	Search_Captured_Text := ["Log In","Email","Password"]
	loop, 5
	{
		if Search_Captured_Text_OCR(Search_Captured_Text, {Size: [290, 210], Pos: [100, 45], Timeout: 0})
			goto Switch_Account_Other_Account
			
		if Search_Captured_Text_OCR(Search_Captured_Text, {Size: [60, 320], Pos: [135, 35], Timeout: 0})
			goto Switch_Account_Other_Account
			
		if Search_Captured_Text_OCR(Search_Captured_Text, {Size: [60, 465], Pos: [135, 35], Timeout: 0})
			goto Switch_Account_Other_Account
	}

	Switch_Account_Retry:
	Gosub Go_Back_To_Home_Screen
	goto Switch_Account_START
	
	Switch_Account_Other_Account:
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	SendEvent {Click, 219, 382} ; Click inside Email Text Box
	DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
	Text_To_Screen(User_Email)
	DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
	Text_To_Screen("{Enter}")
	DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))

	SendEvent {Click, 208, 527} ; Click inside Password text box
	DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
	Text_To_Screen(User_Pass)
	DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
	Text_To_Screen("{Enter}")
	DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))

	SendEvent {Click, 208, 527} ; Click Use your email to log in
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	SendEvent {Click, 455, 738} ; Click OK to previous game progress found
	DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))

	SendEvent {Click, 336, 779} ; Click OK to Are you sure to log in and overwrite the current game?
	DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))

	SendEvent {Click, 336, 779}
	DllCall("Sleep","UInt",rand_wait + (4*Delay_Long))

	Gosub Enter_Login_Password_PIN

	MsgBox, 4, User PIN, user PIN: %User_PIN% - Pause script? (10 second timout), 10
	vRet := MsgBoxGetResult()
	if (vRet = "No")
		DllCall("Sleep","UInt",rand_wait + (5*Delay_Long))
	else if (vRet = "Yes")
		MsgBox, 0, Pause, User PIN: %User_PIN% Press OK to resume (No Timeout)

	Switch_Account_END:
	
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	
	return
}

Enter_Login_Password_PIN:
{
	Subroutine_Running := "Enter_Login_Password_PIN"
	Search_Captured_Text := ["Enter","login","password"]
	
	Enter_Login_Password_PIN_Search:
	loop, 30
	{
		WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [190, 250], Size: [300, 50], Timeout: 0})
			Goto Enter_Login_Password_PIN_Dialog
	}
	return	
		
	Enter_Login_Password_PIN_Search_old:
	{
		Capture_Screen_Text := OCR([190, 250, 300, 50], "eng")
		Capture_Screen_Text := RegExReplace(Capture_Screen_Text,"[\r\n\h]+")		
		
		For index, value in Enter_Login_Password_PIN_Text_Array
			If (RegExMatch(Capture_Screen_Text,value))
				Goto Enter_Login_Password_PIN_Dialog
	}
	return
	
	Enter_Login_Password_PIN_Dialog:
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; SendEvent {Click, 577, 1213} ; Click backspace
	loop, 6
		Mouse_Click(577,1213)
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

	Enter_User_PIN := StrSplit(User_PIN)
	Loop % Enter_User_PIN.MaxIndex()
	{
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))

		if Enter_User_PIN[A_Index] = 0
			SendEvent {Click, 340, 1200} ; Click 0
		if Enter_User_PIN[A_Index] = 1
			SendEvent {Click, 120, 920} ; Click 1
		if Enter_User_PIN[A_Index] = 2
			SendEvent {Click, 340, 920} ; Click 2
		if Enter_User_PIN[A_Index] = 3
			SendEvent {Click, 560, 920} ; Click 3
		if Enter_User_PIN[A_Index] = 4
			SendEvent {Click, 120, 1000} ; Click 4
		if Enter_User_PIN[A_Index] = 5
			SendEvent {Click, 340, 1000} ; Click 5
		if Enter_User_PIN[A_Index] = 6
			SendEvent {Click, 560, 1000} ; Click 6
		if Enter_User_PIN[A_Index] = 7
			SendEvent {Click, 120, 1100} ; Click 7
		if Enter_User_PIN[A_Index] = 8
			SendEvent {Click, 340, 1100} ; Click 8
		if Enter_User_PIN[A_Index] = 9
			SendEvent {Click, 560, 1100} ; Click 9
	}
	return
}

Peace_Shield:
{
	Subroutine_Running := "Peace_Shield"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; SendEvent {Click, 289, 404} ; Click on base
	Mouse_Click(289,404)
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	SendEvent {Click, 358, 487} ; Click On City Buffs
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	SendEvent {Click, 302, 235} ; Click on Peace shield
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

	MsgBox, 4, , Pause script to place shield? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		MsgBox, 0, Pause, Activate Peace Shield, Press OK to resume (No Timeout)

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

; collect collisions
Collect_Collisions:
{
	Subroutine_Running := "Collect_Collisions"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Click Command Center ; SendEvent {Click, 412, 255}
	;FoundPictureX := 412
	;FoundPictureY := 255
	loop, 2
		SendEvent {Click, 412, 255}
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

	; Click Collide ; SendEvent {Click, 540, 367}
	Mouse_Click(540,367)
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	; Click Collide x Times ; SendEvent {Click, 181, 1132}
	loop, 2
		Mouse_Click(181,1132)

	; Click Ok ; SendEvent {Click, 447, 1181}
	Mouse_Click(447,1181)

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

; collect Equipment Crafting
Collect_Equipment_Crafting:
{
	Subroutine_Running := "Collect_Equipment_Crafting"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Click Command Center ; SendEvent {Click, 412, 255}
	;FoundPictureX := 412
	;FoundPictureY := 255
	loop, 2
		SendEvent {Click, 412, 255}
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

	; Click craft ; SendEvent {Click, 475, 388}
	Mouse_Click(475,388)
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	; Click Craft x Times ; SendEvent {Click, 181, 1132}
	loop, 2
		Mouse_Click(180,1180)

	; Click Ok ; SendEvent {Click, 447, 1181}
	Mouse_Click(450,1190)

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

; Collect Recruits
Collect_Recruits:
{
	Subroutine_Running := "Collect_Recruits"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Click Command Center ; SendEvent {Click, 412, 255}
	;FoundPictureX := 412
	;FoundPictureY := 255
	loop, 2
		SendEvent {Click, 412, 255}
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

	; Click Recruit ; SendEvent {Click, 366, 395}
	Mouse_Click(366,395)
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	; Click Recruit x Times ; SendEvent {Click, 200, 1155}
	loop, 3
		Mouse_Click(180,1180)

	; Click OK x times ; SendEvent {Click, 460, 1182}
	loop, 3
		Mouse_Click(460,1182)

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Collect_Red_Envelopes:
{
	Subroutine_Running := "Collect_Red_Envelopes"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	loop, 3
	{
		; Click on Chat Bar ; SendEvent {Click, 316, 1122}
		Mouse_Click(316,1122)
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

		SendEvent {Click, 33, 62} ; Click back Button
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

		SendEvent {Click, 288, 165} ; Click on first Chat Room "Alliance"
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

		SendEvent {Click, 227, 1215} ; Click in Message Box
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

		; Shake phone
		Text_To_Screen("!{F2}")
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

		Gosub Get_Window_Geometry
		Gosub Check_Window_Geometry

		SendEvent {Click, 33, 62} ; Click back Button
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

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
			; click World/home button x times
			; SendEvent {Click, 76, 1200}
			SendEvent {Click, 76, 1200}
	
			MsgBox, 0, Pause, Check location`, Press OK to return home (No Timeout)
	
			Go_Back_Home_Delay_Long := True
			Gosub Go_Back_To_Home_Screen
		}
	*/

	MsgBox, 4, Wonder Rewards, Wonder Rewards? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") ; || if (vRet = "No")
		Gosub Activity_Center_Wonder

	/*
	;MsgBox, 4, SVIP, check SVIP? (8 Second Timeout & skip), 8
	;vRet := MsgBoxGetResult()
	;if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
	;	{
	;		; click SVIP
	;		SendEvent {Click, 157, 102}
	;
	;		MsgBox, 0, Pause, Check SVIP`, Press OK to return home (No Timeout)
	;
	;		Gosub Go_Back_To_Home_Screen
	;	}

	MsgBox, 4, Benefits, Benefits_Center_Monthly? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") ; || if (vRet = "No")
		Gosub Benefits_Center_Monthly

	;MsgBox, 4, Activate Skills, Activate Skills? (8 Second Timeout & skip), 8
	;vRet := MsgBoxGetResult()
	;if (vRet = "Yes") ; || if (vRet = "Timeout") ; || if (vRet = "No")
	;	{
	;		; click Activate Skills
	;		SendEvent {Click, 192, 1196}
	;
	;		MsgBox, 0, Pause, Check Activate Skills`, Press OK to return home (No Timeout)
	;
	;		Gosub Go_Back_To_Home_Screen
	;	}
	
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

	Activity_Center_Wonder:
	{
		Click, 108, 536 Left, Down  ; drag home screen to right
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		Click, 131, 536, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		Click, 138, 536, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		Click, 149, 536, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		Click, 158, 536, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		Click, 262, 536, 0
		DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
		Click, 262, 536 Left, Up
		SendEvent {Click, 137, 581} ; Click activity center
		DllCall("Sleep","UInt",rand_wait + (3*Delay_Long))
		SendEvent {Click, 170, 140} ; Click on "in progress" tab
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
		Click, 329, 1194 Left, Down  ; drag activity center list up
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		Click, 337, 848, 0
		DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
		Click, 337, 848 Left, Up
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
		SendEvent {Click, 297, 1095} ; Click on desert wonder
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))
		SendEvent {Click, 250, 150} ; Click on second tab "wonder"
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
		SendEvent {Click, 244, 592} ; Click and open reward box number 1
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
		SendEvent {Click, 339, 987} ; Click Collect Button
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
		SendEvent {Click, 250, 150} ; Click Outside reward popup
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
		SendEvent {Click, 438, 593} ; Click and open reward box number 2
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
		SendEvent {Click, 329, 994} ; Click Collect Button
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
		SendEvent {Click, 250, 150} ; Click Outside reward popup
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
		SendEvent {Click, 641, 598} ; Click and open reward box number 3
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
		SendEvent {Click, 340, 1000} ; Click Collect Button
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
		SendEvent {Click, 250, 150} ; Click Outside reward popup

		MsgBox, 0, Pause, All rewards claimed? Press OK to return home (No Timeout)
		Gosub Go_Back_To_Home_Screen

		return
	}
}

Benefits_Center_Monthly:
{
	Subroutine_Running := "Benefits_Center_Monthly"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen
	; Click Benefits Center x times ; SendEvent {Click, 618, 311}
	SendEvent {Click, 625, 280}
	Mouse_Click(625,280)
	DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))

	;Gosub Click_through_benefits_tabs
	;loop, 4
	;{
	;	Gosub Swipe_Right_trial
	;	Gosub Click_through_benefits_tabs
	;}

	MsgBox, 0, Pause, Collect Warrior Trials and monthly package`, Press OK to resume (No Timeout)

	Gosub Go_Back_To_Home_Screen
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return


	; loop through benefits tabs to clear any new ones
	Click_through_benefits_tabs:
	{
		; Click Tab 1 Benefits Center ; SendEvent {Click, 71, 166}
		SendEvent {Click, 75, 166}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
		SendEvent {Click, 155, 166}
		DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
		; Click Tab 2 Benefits Center ; SendEvent {Click, 244, 179}
		SendEvent {Click, 235, 166}
		DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
		SendEvent {Click, 315, 166}
		DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
		; Click Tab 3 Benefits Center ; SendEvent {Click, 396, 175}
		SendEvent {Click, 395, 166}
		DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
		SendEvent {Click, 475, 166}
		DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
		; Click Tab 4 Benefits Center ; SendEvent {Click, 553, 172}
		SendEvent {Click, 560, 166}
		DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
		return
	}

	Swipe_Right_trial:
	loop, 4
	{
		; Benefits Center Swipe Right One position
		Click, 630, 187 Left, Down
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 530, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 430, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 375, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 363, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 355, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 354, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		Click, 353, 187 Left, Up
	}
	return

}

Benefits_Center:
{
	Subroutine_Running := "Benefits_Center"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; Initialize text to search for
	Battle_Honor_text := "BattleHonor"
	Daily_Signin_text := "Sign"
	Daily_Signin_text2 := "LOGIN"
	Monthly_Package_text := "Monthly—Package"
	Monthly_Signin_text := "MonthlySign"
	Select_Reward_text := "SelectReward"
	Selection_Chest_text := "SelectionChest"
	Single_Cumulation_text := "Cumulation"
	Claim_text := "Claim"
	
	; "ReactionFurnace"
	; "Warriortrial"
	; "WarZAccountbindrewards"
	; "MonthlySign-In"


	; Set tabs = True (1) to completed or False (0) to be skipped.
	Battle_Honor_Run := False
	Daily_Signin_Run := True
	Monthly_Package_Collect_Run := True
	Monthly_Signin_Run := True
	Select_Reward_Run := True
	Selection_Chest_Run := True
	Single_Cumulation_Run := True
	Claim_Buttons_Run := True

	; SendEvent {Click, 618, 311} ; Click Benefits Center x times
	Mouse_Click(625,280)
	
	Gosub Benefits_Center_Reload

	Gosub Benefits_Check_Four_Tabs
	loop, 4
		Gosub Benefits_swipe_and_Check_Four_Tabs
	
	Goto Benefits_Center_END
	
	Benefits_Center_Reload:	
	loop, 5
	{
		Search_Captured_Text := ["Benefits Center"]
		loop, 3
			if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0})
				return
		
		Gosub Get_Window_Geometry
		Gosub Check_Window_Geometry
		Gosub Go_Back_To_Home_Screen
		loop, 2
			SendEvent {Click, 625, 280} ; Click Benefits Center x times
		DllCall("Sleep","UInt",rand_wait + (3*Delay_Medium))
	}
	
	Benefits_Center_END:
	Gosub Go_Back_To_Home_Screen
	
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return	

	Benefits_swipe_and_Check_Four_Tabs:
	{
		;Gosub Swipe_Right
		Gosub Swipe_Right2
		Gosub Benefits_Check_Four_Tabs
		return
	}

	Benefits_Check_Four_Tabs:
	{
		
		X_Min := 0
		X_Max := 408
		OCR_X := X_Min
		OCR_Y := 184
		OCR_W := 272
		OCR_H := 72
		X_Delta := 136
		Click_X := (OCR_X + X_Delta)
		Click_Y := 170
		; X=0-684, 684/5=136, and 136*2=272, 0,136,272,408,544,680
		; 684/4=171, 684/3=228 
		; or 484/3=161
		
		loop, 4
		{
			SendEvent {Click, 645, 248} ; Click to clear scrolling messages
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Long)) ; wait for tab to load
			Capture_Screen_Text := OCR([OCR_X, OCR_Y, OCR_W, OCR_H], "eng") ; benefit tab 1
			loop, 2
				SendEvent {Click, %Click_X%, %Click_Y%} ; Click Tab 1 Benefits Center
			Gosub Benefits_Selection_and_Run
			OCR_X += X_Delta
			Click_X := (OCR_X + X_Delta)
		}
		
		/*
		OCR_X := 136
		Click_X := (OCR_X + 136)
		;Capture_Screen_Text := OCR([171, 184, 161, 72], "eng") ; benefit tab 2
		Capture_Screen_Text := OCR([OCR_X, OCR_Y, OCR_W, OCR_H], "eng") ; benefit tab 2
		loop, 2
			SendEvent {Click, %Click_X%, %Click_Y%} ; Click Tab 2 Benefits Center
		Gosub Benefits_Selection_and_Run

		OCR_X := 272
		Click_X := (OCR_X + 136)
		;Capture_Screen_Text := OCR([342, 184, 161, 72], "eng") ; benefit tab 3
		Capture_Screen_Text := OCR([OCR_X, OCR_Y, OCR_W, OCR_H], "eng") ; benefit tab 3
		loop, 2
			SendEvent {Click, %Click_X%, %Click_Y%} ; Click Tab 3 Benefits Center
		Gosub Benefits_Selection_and_Run

		OCR_X := 408
		Click_X := (OCR_X + 136)
		;Capture_Screen_Text := OCR([513, 184, 161, 72], "eng") ; benefit tab 4
		Capture_Screen_Text := OCR([OCR_X, OCR_Y, OCR_W, OCR_H], "eng") ; benefit tab 4
		loop, 2
			SendEvent {Click, %Click_X%, %Click_Y%} ; Click Tab 4 Benefits Center
		Gosub Benefits_Selection_and_Run
		*/

		return
	}

	Benefits_Selection_and_Run:
	{
		Subroutine_Running := Benefits_Selection_and_Run
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Long)) ; wait for tab to load
		
		loop, 5
		{
			if (Capture_Screen_Text = "")
				Capture_Screen_Text = OCR([OCR_X, OCR_Y, OCR_W, OCR_H], "eng")
			else
				break
		}
		
		loop, 5
		{
			if (Capture_Screen_Text = "")
				Capture_Screen_Text .= OCR([0, 288, 300, 112], "eng")
			else
				break
		}
			
		Capture_Screen_Text := RegExReplace(Capture_Screen_Text,"[\r\n\h]+")
		
		;MsgBox, Text Found:%Capture_Screen_Text%
		
		If (RegExMatch(Capture_Screen_Text,Monthly_Signin_text))
			Gosub Monthly_Signin
		If (RegExMatch(Capture_Screen_Text,Daily_Signin_text))
			Gosub Daily_Signin
		If (RegExMatch(Capture_Screen_Text,Claim_text))
			Gosub Claim_Buttons
		If (RegExMatch(Capture_Screen_Text,Daily_Signin_text2))
			Gosub Daily_Signin
		If (RegExMatch(Capture_Screen_Text,Select_Reward_text))
			Gosub Select_Reward
		If (RegExMatch(Capture_Screen_Text,Single_Cumulation_text))
			Gosub Single_Cumulation
		If (RegExMatch(Capture_Screen_Text,Selection_Chest_text))
			Gosub Selection_Chest
		If (RegExMatch(Capture_Screen_Text,Battle_Honor_text))
			Gosub Battle_Honor_Collect
		If (RegExMatch(Capture_Screen_Text,Monthly_Package_text))
			Gosub Monthly_Package_Collect
			
			
		;else
		;	MsgBox, 4, Text Not Found, Text Not Found in %Capture_Screen_Text% (4 Second Timeout), 4
		
		Gosub Benefits_Center_Reload

		Benefits_Text_Found:
		Capture_Screen_Text := ""
		;DllCall("Sleep","UInt",rand_wait + (1*Delay_Long)) ; wait to read next tab

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
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	Gosub Swipe_Right
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

	; Click Tab 4 Benefits Center ; SendEvent {Click, 553, 172}
	Mouse_Click(553,172)
	DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))

	; MsgBox, 4, , Battle_Honor_Collect (8 Second Timeout & skip), 8
	; vRet := MsgBoxGetResult()
	; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
	; 	Gosub Battle_Honor_Collect

	; **************************
	; END unused section below
	; **************************

	Swipe_Right:
	loop, 4
	{
		; Benefits Center Swipe Right One position
		Click, 630, 187 Left, Down
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 530, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 430, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 375, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 363, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 353, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 353, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		Click, 353, 187 Left, Up
	}
	return

	Swipe_Right2:
	; 0,136,272,408,544,680
	loop, 2
	{
		; Benefits Center Swipe Right One position
		Click, 544, 187 Left, Down
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 450, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 350, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 250, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 150, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 131, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 132, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 133, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 134, 187 Left, Up
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 135, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 136, 187, 0
	}
	return

	Swipe_Left:
	{
		; Benefits Center Swipe Right One position
		Click, 353, 187 Left, Down
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 376, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 388, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 412, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 459, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 553, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 553, 187, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 553, 187 Left, Up

		return
	}

	Select_Reward:
	{
		if !Select_Reward_Run
			return

		Subroutine_Running := "Select_Reward"

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
		; Select Reward - Drop Down Menu ; SendEvent {Click, 644, 512}
		Mouse_Click(644,512)

		; Select Reward - Selet Tech ; SendEvent {Click, 570, 696}
		FoundPictureX := 570
		FoundPictureY := 696

		; Select Reward - Selet Desert ; SendEvent {Click, 578, 602}
		;Mouse_Click(570,602)

		; Claim Strengthening also silver medals ; SendEvent {Click, 343, 749}
		Mouse_Click(343,749)

		; Click Outside Congrats Popup ; SendEvent {Click, 378, 1172}
		Mouse_Click(378,1172)

		Select_Reward_Run := False

		return
	}
	
	Monthly_Package_Collect:
	{
		if !Monthly_Package_Collect_Run
			return

		Subroutine_Running := "Monthly_Package_Collect"

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
		; Click Claim ; SendEvent {Click, 500, 1200}
		Mouse_Click(500,1200)

		Monthly_Package_Collect_Run := False

		return
	}

	Single_Cumulation:
	{
		if !Single_Cumulation_Run
			return

		Subroutine_Running := "Single_Cumulation"

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
		; Click Claim ; SendEvent {Click, 561, 551}
		Mouse_Click(561,551)

		Single_Cumulation_Run := False

		return
	}

	Claim_Buttons:
	{
		; if !Claim_Buttons_Run
		; 	return

		Subroutine_Running := "Claim_Buttons"

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
		if (OCR([530, 478, 150, 60], "eng") = "Claim") ; Search for "Claim" Text on Button #1
			Mouse_Click(600,500)
			Mouse_Click(300,50)
		if (OCR([530, 633, 150, 60], "eng") = "Claim") ; Search for "Claim" Text on Button #2
			Mouse_Click(600,660)
		if (OCR([530, 788, 150, 60], "eng") = "Claim") ; Search for "Claim" Text on Button #3
			Mouse_Click(600,800)
		if (OCR([530, 943, 150, 60], "eng") = "Claim") ; Search for "Claim" Text on Button #4
			Mouse_Click(600,970)
		if (OCR([530, 1098, 150, 60], "eng") = "Claim") ; Search for "Claim" Text on Button #5
			Mouse_Click(600,1130)

		; Claim_Buttons_Run := False

		return
	}

	Daily_Signin:
	{
		if !Daily_Signin_Run
			return

		Subroutine_Running := "Daily_Signin"

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
		; Daily Sign-In Click Day 1
		SendEvent {Click, 103, 553}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(103,553)

		; Daily Sign-In Click Day 2
		SendEvent {Click, 343, 561}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(343,561)

		; Select B Reward
		SendEvent {Click, 561, 551}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(561,551)

		; Select B Reward
		SendEvent {Click, 561, 551}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(561,551)

		; Click Ok
		SendEvent {Click, 343, 1125}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(343,1125)

		; Click Bottom Middle
		SendEvent {Click, 329, 1231}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(329,1231)

		; Daily Sign-In Click Day 3
		SendEvent {Click, 561, 551}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(561,551)

		; Select B Reward
		SendEvent {Click, 561, 551}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(561,551)

		; Click Ok
		SendEvent {Click, 343, 1125}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(343,1125)

		; Click Bottom Middle
		SendEvent {Click, 329, 1231}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(329,1231)

		; Daily Sign-In Click Day 4
		SendEvent {Click, 556, 818}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(556,818)

		; Click Bottom Middle
		SendEvent {Click, 329, 1231}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(329,1231)

		; Daily Sign-In Click Day 5
		SendEvent {Click, 334, 818}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(334,818)

		; Click Bottom Middle
		SendEvent {Click, 329, 1231}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(329,1231)

		; Daily Sign-In Click Day 6
		SendEvent {Click, 108, 808}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(108,808)

		; Click Bottom Middle
		SendEvent {Click, 329, 1231}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(329,1231)

		; Daily Sign-In Click Day 7
		SendEvent {Click, 331, 1035}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(331,1035)

		; Select B Reward
		SendEvent {Click, 561, 551}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(561,551)

		; Click Ok
		SendEvent {Click, 343, 1125}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(343,1125)

		; Click Bottom Middle
		loop, 12
		{
			SendEvent {Click, 329, 1231}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		}

		loop, 7
		{
			SendEvent {Click, 329, 1231}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		}

		; loop, 12
		; 	Mouse_Click(329,1231)

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
			SendEvent {Click, 342, 1215}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))

		; loop, 2
		;	Mouse_Click(342,1215)

		; Claim 5 Days
		SendEvent {Click, 153, 323}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(153,323)
		Gosub Collect_and_Clear

		; Claim 10 Days
		SendEvent {Click, 266, 323}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(266,323)
		Gosub Collect_and_Clear

		; Claim 15 Days
		SendEvent {Click, 380, 323}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(380,323)
		Gosub Collect_and_Clear

		; Claim 20 Days
		SendEvent {Click, 504, 323}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(504,323)
		Gosub Collect_and_Clear

		; Claim 25 Days
		SendEvent {Click, 633, 323}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(633,323)
		Gosub Collect_and_Clear

		Monthly_Signin_Run := False

		return
	}

	Collect_and_Clear:
	{
		; Collect 5 Days
		SendEvent {Click, 338, 1000}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(338,1000)

		; Clear 5 Days
		SendEvent {Click, 342, 1215}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; Mouse_Click(342,1215)

		return
	}

	Selection_Chest:
	{
		if !Selection_Chest_Run
			return

		Subroutine_Running := "Selection_Chest"

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
		; Click Free Chest ; SendEvent {Click, 87, 431}
		Mouse_Click(87,431)
		DllCall("Sleep","UInt",rand_wait + (8*Delay_Short))

		; Select 1,000 Diamonds ; SendEvent {Click, 52, 682}
		Mouse_Click(52,682)

		; Select Silver Medal ; SendEvent {Click, 517, 680}
		Mouse_Click(517,680)

		; Swipe Up X times
		loop, 4
		{
			Click, 133, 1027 Left, Down
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 115, 598, 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 115, 522 Left, Up
		}
		DllCall("Sleep","UInt",rand_wait + (8*Delay_Short))

		; Select 1,000 Vip Points X 10 ; SendEvent {Click, 206, 770}
		Mouse_Click(206,770)

		; Select 500K Strength Abilities Exp ; SendEvent {Click, 519, 960}
		Mouse_Click(519,960)

		; Select Super Officer ; SendEvent {Click, 60, 961}
		;Mouse_Click(60,961)

		; Click Collect ; SendEvent {Click, 348, 1207}
		Mouse_Click(348,1207)

		; Click Collect ; SendEvent {Click, 348, 1207}
		Mouse_Click(348,1207)

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
			Gosub Battle_Honor_Swipe
		}
		Gosub Battle_Honor_Click
		goto Battle_Honor_END
		return

		Battle_Honor_Click:
		{
			SendEvent {Click, 268, 636}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			SendEvent {Click, 268, 636}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			SendEvent {Click, 260, 721}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			SendEvent {Click, 260, 721}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			SendEvent {Click, 269, 799}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			SendEvent {Click, 269, 799}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			SendEvent {Click, 265, 883}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			SendEvent {Click, 265, 883}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			SendEvent {Click, 261, 963}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			SendEvent {Click, 261, 963}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			SendEvent {Click, 267, 1050}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			SendEvent {Click, 267, 1050}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			SendEvent {Click, 263, 1126}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			SendEvent {Click, 263, 1126}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			SendEvent {Click, 261, 1202}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			SendEvent {Click, 261, 1202}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			return
		}

		Battle_Honor_Swipe:
		{
			Click, 351, 1203 Left, Down
			Click, 351, 1191 , 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 356, 1135 , 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 365, 1041 , 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 368, 957 , 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 369, 820 , 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 366, 767 , 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 364, 716 , 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 362, 688 , 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 360, 661 , 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 360, 635 , 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 360, 614 , 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 360, 601 , 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 360, 608, 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
			Click, 360, 608, 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
			Click, 360, 608 Left, Up
			Return
		}

		Battle_Honor_END:

		Battle_Honor_Run := False

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
		return
	}

}

; Click Speaker/help
Speaker_Help:
{
	Subroutine_Running := "Speaker_Help"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	Search_Captured_Text := ["Claim"]
	loop, 2
	{
		; Click speaker/help ; SendEvent {Click, 630, 1033}
		Mouse_Click(630,1033)
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

		loop, 2
			if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [290, 550], Size: [110, 60], Timeout: 0})
			{
				SendEvent {Click, 357, 570} ; Click Claim
				DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
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
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; Click On Drop Zone ; SendEvent {Click, 285, 200}
	Mouse_Click(285,200)
	DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))


	; Get Steel X Times ; SendEvent {Click, 409, 1051}
	; Search_Captured_Text := ["Click"]
	; loop, 20
	; {
	; 	Capture_Screen_Text := OCR([358, 1020, 146, 57], "eng")
	; 	If (RegExMatch(Capture_Screen_Text,Search_Captured_Text))
	; 	{
	; 		loop, 5
	; 			SendEvent {Click, 409, 1051}
	; 	}
	; 	else
	; 		break
	; }
	
	; Get Steel X Times ; SendEvent {Click, 409, 1051}
	Search_Captured_Text := ["Click"]
	loop, 20
	{
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [358, 1020], Size: [146, 57], Timeout: 0}) 
		{
			loop, 20
			{
				SendEvent {Click, 409, 1051, 4}
				DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			}
		}
		else
			break
	}
	

	; FoundPictureX := 409
	; FoundPictureY := 1051
	;loop, 40
	;{
	;	SendEvent {Click, 409, 1051}
	;	DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
	;}

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Adventure_Missions:
{
	Subroutine_Running := "Adventure_Missions"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Collect_Cafeteria:
{
	Subroutine_Running := "Collect_Cafeteria"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	
	; Collect Cafeteria ; SendEvent {Click, 378, 736}
	Mouse_Click(378,736)
	
	;Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Active_Skill:
{
	Subroutine_Running := "Active_Skill"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; SendEvent {Click, 195, 1195} ; Click Active_Skill 
	Mouse_Click(195,1195)
	DllCall("Sleep","UInt",rand_wait + (3*Delay_Medium))
	
	Gosub Active_Skill_Reload

	;if !Active_Skill_Detected

	Continue_Active_Skill:
	; set variables
	Max_X := 480
	Max_Y := 815
	Min_X := 70
	Min_Y := 600
	
	OCR_X := Max_X ; delta 71-276-481 = 205
	OCR_Y := Max_Y ; delta 600-815 = 215
	OCR_W := 130
	OCR_H := 60
	OCR_X_Delta := 205
	OCR_Y_Delta := 215 ; original 215
	Click_X_Delta := 60
	Click_Y_Delta := 30
	Click_X := (OCR_X + Click_X_Delta)
	Click_Y := (OCR_Y + Click_Y_Delta)
	Active_Skills_Text := ["Harvest", "Special", "Skillful", "Workman", "Ability", "First", "Riches", "Magic", "Clown", "Promotion", "Instructor"]
	Active_Skill_Button_text := ["Use"]
	
	loop, 2
		SendEvent {Click, 215, 425} ; Active Skill tab #2 - Officer
	Gosub Active_Skill_Click_Button
	
	;loop, 2
	;	SendEvent {Click, 340, 425} ; Active Skill tab #3 - Combat
	;Gosub Active_Skill_Click_Button
	
	loop, 2
		SendEvent {Click, 470, 425} ; Active Skill tab #4 - Develop
	Gosub Active_Skill_Click_Button
	
	loop, 2
		SendEvent {Click, 600, 425} ; Active Skill tab #5 - Support
	Gosub Active_Skill_Click_Button
	
	goto Active_Skill_END

	; Capture_Screen_Text := OCR([70, 600, 124, 60], "eng") ; Button 01
	; Capture_Screen_Text := OCR([275, 600, 124, 60], "eng") ; Button 02
	; Capture_Screen_Text := OCR([480, 600, 124, 60], "eng") ; Button 03
	; Capture_Screen_Text := OCR([70, 815, 124, 60], "eng") ; Button 04
	; Capture_Screen_Text := OCR([275, 815, 124, 60], "eng") ; Button 05
	; Capture_Screen_Text := OCR([480, 815, 124, 60], "eng") ; Button 06


	Active_Skill_Click_Button:
	DllCall("Sleep","UInt",rand_wait + (3*Delay_Medium))
	loop, 6
	{				
		; Looking for green use buttons on main active skill interface
		Look_For_Use_Button:
		if !Search_Captured_Text_OCR(Active_Skill_Button_text, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0})
			Goto Active_Skill_Click_Button_Next

		Active_Skill_Click_Button_NOW:
		SendEvent {Click, %Click_X%, %Click_Y%} ; click Use button found
		; DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

		; Looking for Skill titles that match list
		loop, 5
			if Search_Captured_Text_OCR(Active_Skills_Text, {Pos: [179, 445], Size: [331, 36], Timeout: 0})
				goto Active_Skill_Skill_Opened
			
		goto Active_Skill_Click_Button_Next ; No matching title found, examin next button
		
		Active_Skill_Skill_Opened:
		loop, 3
			SendEvent {Click, 340, 780} ; Click Use button
		DllCall("Sleep","UInt",rand_wait + (3*Delay_Medium))	

		Active_Skill_Click_Button_Next:		
		Gosub Active_Skill_Reload
		SendEvent {Click, 333, 355} ; Click title bar
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

		if (OCR_X <= Min_X)
		{
			OCR_X := Max_X
			if (OCR_Y <= Min_Y)
				OCR_Y := Max_Y
			else
				OCR_Y -= OCR_Y_Delta
		}
		else
			OCR_X -= OCR_X_Delta

		Click_X := (OCR_X + Click_X_Delta)
		Click_Y := (OCR_Y + Click_Y_Delta)
	}
	return
	
	Active_Skill_Reload:	
	loop, 5
	{
		Search_Captured_Text := ["Active Skill"]
		;check to see if active skill is properly displayed x times
		loop, 10
			if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [259, 337], Size: [174, 46], Timeout: 0})
				return
		
		Gosub Get_Window_Geometry
		Gosub Check_Window_Geometry
		Gosub Go_Back_To_Home_Screen
		SendEvent {Click, 195, 1195} ; Click Active_Skill
		DllCall("Sleep","UInt",rand_wait + (3*Delay_Medium))
	}
	
	Active_Skill_END:
	Gosub Go_Back_To_Home_Screen
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

}

Collect_Chips_Underground:
{
	Subroutine_Running := "Collect_Chips_Underground"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; Click underground
	; Click Misslie Silo
	; Click underground Construsction Center
	; Hit F5 for back button
	; Swipe from lower right to upper left
	; Click on each Chip Plant
	; Hit F5 for back button

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Reserve_Factory:
{
	Subroutine_Running := "Reserve_Factory"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	; Click Alliance Menu ; SendEvent {Click, 610, 1199}
	Mouse_Click(610,1199)
	DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))

	; Click Alliance Help ; SendEvent {Click, 355, 825}
	Mouse_Click(355,825)
	DllCall("Sleep","UInt",rand_wait + (3*Delay_Medium))

	; Click Reserve Factory Help ; SendEvent {Click, 479, 140}
	Mouse_Click(479,140)
	DllCall("Sleep","UInt",rand_wait + (3*Delay_Medium))

	if Pause_Script
		MsgBox, 0, Pause, Press OK to resume (No Timeout)

	; Click Reserve Factory Icon ; SendEvent {Click, 111, 339}
	Mouse_Click(111,339)
	DllCall("Sleep","UInt",rand_wait + (6*Delay_Long))

	; Click Reserve Factory On World Map ; SendEvent {Click, 344, 589}
	loop, 3
	{
		Mouse_Click(344,589)
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	}

	; Click Alliance Menu ; SendEvent {Click, 608, 1186}
	Mouse_Click(608,1186)
	DllCall("Sleep","UInt",rand_wait + (3*Delay_Long))

	; Click Alliance Help ; SendEvent {Click, 383, 835}
	Mouse_Click(383,835)
	DllCall("Sleep","UInt",rand_wait + (3*Delay_Medium))

	; Click Reserve Factory Help ; SendEvent {Click, 479, 140}
	Mouse_Click(479,140)
	DllCall("Sleep","UInt",rand_wait + (3*Delay_Medium))

	; Click Reserve Factory Icon ; SendEvent {Click, 118, 336}
	Mouse_Click(118,336)
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	; Click Info Menu On Reserve Factory On World Map ; SendEvent {Click, 241, 613}
	Mouse_Click(241,613)
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	; Click Upgrade, Add Energy, Use, Etc, X Times ; SendEvent {Click, 324, 797}
	FoundPictureX := 324
	FoundPictureY := 797
	loop, 10
	{
		SendEvent {Click, 324, 797}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
	}

	Text_To_Screen("{F5}")
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	; Click Alliance Menu ; SendEvent {Click, 596, 1196}
	Mouse_Click(596,1196)
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	; Click Alliance Help ; SendEvent {Click, 440, 817}
	Mouse_Click(440,817)
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	; Click Reserve Factory Help ; SendEvent {Click, 479, 140}
	Mouse_Click(479,140)
	DllCall("Sleep","UInt",rand_wait + (3*Delay_Medium))

	; Click Instant Help ; SendEvent {Click, 321, 404}
	Mouse_Click(321,404)

	; Click Request Help ; SendEvent {Click, 509, 415}
	Mouse_Click(509,415)

	Go_Back_Home_Delay_Long := True
	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Donate_Tech:
{
	Subroutine_Running := "Donate_tech"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	;WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen
	
	;Gosub Donate_Tech_Control_Desk_Expand

	; Search_Captured_Text := ["Wages"]
	; Capture_Screen_Text := OCR([236, 41, 215, 57], "eng") ; check if
	; If (RegExMatch(Capture_Screen_Text,Search_Captured_Text))
	;	goto Donations_OVER
	
	Search_Captured_Text := ["Technology"]
	loop, 3
	{
		Gosub Donate_Tech_Control_Desk_Expand
		Loop, 3
		{
			Gosub Click_Top_Tech
			if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0})
				goto Donate_Tech_Open
		}
		Gosub Go_Back_To_Home_Screen	
	}	
	goto Donations_OVER
	
	Donate_Tech_Open:
	Search_Captured_Text := ["Rank"]
	loop, 5
	{
		Gosub Click_Top_Tech
		if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [70, 215], Size: [60, 40], Timeout: 0})
			goto Donate_Tech_Open_NEXT
	}	
	; goto Donations_OVER
	
	Donate_Tech_Open_NEXT:
	global Tech_Click_Initial := 350
	global Tech_Click_Inc := 139
	global Tech_Click_Y := Tech_Click_Initial

	; skip to next
	SearchTerm_003 := "Only R4 and R5"
	SearchTerm_004 := "Technology" ; 160, 630 to 337, 657 = {Pos: [160, 620], Size: [200, 30], Timeout: 0})
	; end donations
	SearchTerm_001 := "4\:\d+\:\d"
	SearchTerm_002 := "clear"
	
	Donate_Tech_Text_Skip_Donations_Array := ["OnlyR4andR5","Technology","Locked"]
	Donate_Tech_Text_End_Donations_Array := ["4\:\d+\:\d","Clear","donations","awesome"]
	
	Gosub Donate_Tech_Collapse_Tech_Short
	
	;Gosub Donate_Tech_Find_And_Click
	
	Goto Donations_OVER
	
	; Gosub Click_Top_Tech
	; Gosub Donate_Tech_Collapse_Tech_Old ; Contribute to 2nd tier tech
	
	loop,2
		SendEvent {Click, 342, 878}
	
	Gosub Donate_Tech_Collapse_Tech_Old ; Contribute to 2nd tier tech
	
	
	; SendEvent {Click, 468, 350} ; Click Tech #1 Y = 275-375 / Rank #2 Y = 340-440 / #3 405-505 RankDelta = 65 (deltaY = 140)
	; SendEvent {Click, 468, 489} ; Click Tech #2 Y = 415-515 (deltaY = 140)
	; SendEvent {Click, 468, 628} ; Click Tech #3 Y = 555-655
	; SendEvent {Click, 468, 767} ; Click Tech #4
	; SendEvent {Click, 468, 906} ; Click Tech #5
	; SendEvent {Click, 468, 1045} ; Click Tech #6
	; SendEvent {Click, 468, 1184} ; Click Tech #7
	; DllCall("Sleep","UInt",rand_wait + (4*Delay_Short))

	Donate_Tech_Find_And_Click:
	Tech_Click_Y := Tech_Click_Initial
	{
		
		Outer_Loop_Donation:
		loop, 7
		{
			Subroutine_Running := "Donate_tech #" . Round(1+(Tech_Click_Y - Tech_Click_Initial)/Tech_Click_Inc, 0)
			WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

			SendEvent {Click, 468, %Tech_Click_Y%} ; select tech
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

			Inner_Loop_Donation:
			;loop, 2
			{
				;Check_If_Max_Donations:
				
				WinActivate, %FoundAppTitle% ; Automatically uses the window found above.							
				Capture_Screen_Text := OCR([295, 730, 105, 40], "eng")
				Capture_Screen_Text .= OCR([160, 620, 200, 60], "eng")
				Capture_Screen_Text .= OCR([80, 870, 140, 40], "eng")
				Capture_Screen_Text := RegExReplace(Capture_Screen_Text,"[\r\n\h]+")

				;MsgBox, OCR:(%OCR_X%:%OCR_Y%) Click:(%Click_X%:%Click_Y%) text:%Capture_Screen_Text%
				
				For index, value in Donate_Tech_Text_End_Donations_Array
					If (RegExMatch(Capture_Screen_Text,value))
					{
						;OCR_Y := Max_Y
						;Click_Y := Min_Y
						Gosub Click_Top_Tech
						return
						; goto Outer_Loop_Donation_Break
						; Break Outer_Loop_Donation
					}
				
				For index, value in Donate_Tech_Text_Skip_Donations_Array
					If (RegExMatch(Capture_Screen_Text,value))
						goto Inner_Loop_Donation_Break
						; Break Inner_Loop_Donation


				; MsgBox, !BREAK Donate_Text_Combo: %Donate_Text_Combo%

				Donate_tech_Click:
				loop, 21
				{
					SendEvent {Click, 420, 1000, 2} ; Click On Donation Box 3
					SendEvent {Click, 260, 1000, 2} ; Click On Donation Box 2
					SendEvent {Click, 100, 1000, 2} ; Click On Donation Box 1
				}
							
				if Pause_Script
					MsgBox, 0, Pause, Press OK to resume (No Timeout)
			}
			Inner_Loop_Donation_Break:
			Tech_Click_Y += Tech_Click_Inc
			Gosub Click_Top_Tech
		}
		Outer_Loop_Donation_Break:
		Gosub Click_Top_Tech
		return
	}

	Donate_Tech_Control_Desk_Expand:
	{
		WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
		; Click Expand Control Desk ; SendEvent {Click, 27, 612}
		Mouse_Click(7,637)
		DllCall("Sleep","UInt",rand_wait + (9*Delay_Short))
		SendEvent {Click, 7, 637} ; Click to Expand Control Desk
		DllCall("Sleep","UInt",rand_wait + (9*Delay_Short))

		; Swipe Down (linear)
		loop, 2
		{
			Click, 326, 405 Left, Down
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 326, 474, 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 326, 543, 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 326, 681, 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 326, 957 Left, Up
			; DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
	
		; Click Goto Alliance Donation ; SendEvent {Click, 468, 959}
		SendEvent {Click, 468, 959}

		; Click Goto Alliance Donation (Alt button) ; SendEvent {Click, 468, 999}
		SendEvent {Click, 468, 999}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
		
		return
	}
	
	Donate_Tech_Collapse_Tech_Short:
	{
		WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
		Capture_Screen_Text := ""
		Min_Y := 215
		Max_Y := 455 ; Rank 1: 215, 2: 275, 3: 335, 4: 395, 5: 455, 6: 515
		Min_X := Max_X := OCR_X := Click_X := 66
		; OCR_X := 66
		OCR_Y := Min_Y
		OCR_W := 100
		OCR_H := 50
		; Click_X := 200
		Click_Y := (OCR_Y + 25)
		OCR_Y_Delta := 60
		
		while (OCR_Y <= Max_Y)
		{
			WinActivate, %FoundAppTitle% ; Automatically uses the window found above.							
			Capture_Screen_Text := OCR([OCR_X, OCR_Y, OCR_W, OCR_H], "eng")
			Capture_Screen_Text := RegExReplace(Capture_Screen_Text,"[\r\n\h]+")
				
			If (RegExMatch(Capture_Screen_Text,"Rank"))
				goto Donate_Tech_Collapse_Tech_Next
			If !(RegExMatch(Capture_Screen_Text,"Rank"))
				goto Donate_Tech_Collapse_Tech_END
			If (RegExMatch(Capture_Screen_Text,"Needed"))
				goto Donate_Tech_Collapse_Tech_END
			If (RegExMatch(Capture_Screen_Text,""))
				goto Donate_Tech_Collapse_Tech_END
				
			goto Donate_Tech_Collapse_Tech_Next
			
			Donate_Tech_Collapse_Tech_END:
			if (Click_Y >= Min_Y)
				Click_Y -= OCR_Y_Delta
			Tech_Click_Initial := (Click_Y + 110)
			SendEvent {Click, %Click_X%, %Click_Y%} ; Click To expand previous Rank Tech
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
			Gosub Donate_Tech_Find_And_Click
			return
			
			Donate_Tech_Collapse_Tech_Next:
			{
				Tech_Click_Initial := (Click_Y + 110)
				SendEvent {Click, %Click_X%, %Click_Y%} ; Click To Collapse Rank Tech
				DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
			}
				
			if (OCR_Y >= Max_Y)
				break
				
			if (OCR_Y < Max_Y)
				OCR_Y += OCR_Y_Delta
			
			Click_Y := (OCR_Y + 25)
			Gosub Click_Top_Tech
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
			Capture_Screen_Text := ""
			
		}
		return
	}
	
	Donate_Tech_Collapse_Tech_Long:
	{
		loop, 6
		{
			if Search_Captured_Text_OCR("Rank 1", {Pos: [66, 215], Size: [100, 50], Timeout: 0})
				SendEvent {Click, 200, 240} ; Click To Collapse Rank 1 Tech
			if Search_Captured_Text_OCR("Rank 2", {Pos: [66, 275], Size: [100, 50], Timeout: 0})
				SendEvent {Click, 200, 300} ; Click To Collapse Rank 2 Tech
			if Search_Captured_Text_OCR("Rank 3", {Pos: [66, 335], Size: [100, 50], Timeout: 0})
				SendEvent {Click, 200, 360} ; Click To Collapse Rank 3 Tech
			if Search_Captured_Text_OCR("Rank 4", {Pos: [66, 395], Size: [100, 50], Timeout: 0})
				SendEvent {Click, 200, 420} ; Click To Collapse Rank 4 Tech
			if Search_Captured_Text_OCR("Rank 5", {Pos: [66, 455], Size: [100, 50], Timeout: 0})
				SendEvent {Click, 200, 480} ; Click To Collapse Rank 5 Tech
			if Search_Captured_Text_OCR("Rank 6", {Pos: [66, 515], Size: [100, 50], Timeout: 0})
				SendEvent {Click, 200, 540} ; Click To Collapse Rank 6 Tech
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
		}
		return
	}

	Click_Top_Tech:
	; Click top of alliance tech list
	loop, 3
	{
		;Mouse_Click(397,151)
		SendEvent {Click, 397, 151}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
	}
	return

	Donate_Tech_Collapse_Tech_Old:
	{
		; Click To Collapse Rank 1 Tech ; SendEvent {Click, 393, 252} ; Click To Collapse Rank 1 Tech 
		FoundPictureX := 393
		FoundPictureY := 252

		; Click To Collapse Rank 2 Tech ; SendEvent {Click, 393, 295} ; Click To Collapse Rank 2 Tech 
		; FoundPictureX := 393
		; FoundPictureY := 295

		; Click To Collapse Rank 3 Tech ; SendEvent {Click, 393, 358} ; Click To Collapse Rank 3 Tech 
		; Mouse_Click(393,358)
		;DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
		return
	}

	Donations_OVER:
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	
	Gosub Go_Back_To_Home_Screen
	return
}

Depot_Rewards:
{
	Subroutine_Running := "Depot_Rewards"
	
	; set variables
	Depot_Button_text01 := "Free"
	Depot_Button_text02 := "Reward"
	Depot_Button_text03 := "Request"
	Depot_Button_text04 := "Help"
	
	Depot_Rewards_Button_Text_Array := ["Free","Reward","Request","Help"]
	
	; set variables
	Max_X := Min_X := 500
	Max_Y := 1200
	; Min_X := 500
	Min_Y := 400	
	
	OCR_X := Min_X ; delta 71-276-481 = 205
	OCR_Y := Min_Y ; delta 600-815 = 215
	OCR_W := 150 ; X = 510-650
	OCR_H := 50 ; Y = 400-450
	OCR_X_Delta := 0
	OCR_Y_Delta := 200
	Click_X_Delta := 75
	Click_Y_Delta := 25
	Click_X := (OCR_X + Click_X_Delta)
	Click_Y := (OCR_Y + Click_Y_Delta)
	
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; Click Depot ; SendEvent {Click, 139, 662} ; click depot
	Mouse_Click(139,662)
	DllCall("Sleep","UInt",rand_wait + (9*Delay_Short))

	SendEvent {Click, 250, 722} ; Click Alliance Treasures
	; DllCall("Sleep","UInt",rand_wait + (3*Delay_Medium))

	Search_Captured_Text := ["Treasures"]
	loop, 5
	{
		loop, 3
			if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0})
				goto Continue_Depot_Treasures
		
		Gosub Go_Back_To_Home_Screen
		SendEvent {Click, 139, 662} ; click depot
		DllCall("Sleep","UInt",rand_wait + (9*Delay_Short))
		SendEvent {Click, 250, 722} ; Click Alliance Treasures
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))
	}
	goto Depot_Rewards_END

	Continue_Depot_Treasures:	

	SendEvent {Click, 105, 150} ; Click Tab 1 Treasure list	
	Gosub Depot_Click_Button

	SendEvent {Click, 340, 150} ; Click Tab 2 My Treasures
	loop, 2
		Gosub Depot_Click_Button

	SendEvent {Click, 570, 150} ; Click Tab 3 Help_List
	loop, 2
		Gosub Depot_Click_Button

	Depot_Rewards_END:
	Gosub Go_Back_To_Home_Screen
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

	Depot_Click_Button:	
	DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))
	OCR_X := Min_X ; delta 71-276-481 = 205
	OCR_Y := Min_Y ; delta 600-815 = 215
	Click_X := (OCR_X + Click_X_Delta)
	Click_Y := (OCR_Y + Click_Y_Delta)
	loop, 5
	{
		; Looking for Rewards Button titles that match list
		if !Search_Captured_Text_OCR(Depot_Rewards_Button_Text_Array, {Pos: [OCR_X, OCR_Y], Size: [OCR_W, OCR_H], Timeout: 0})
			goto Next_Depot_Button

		Depot_Rewards_Click_Found_Item:
		SendEvent {Click, %Click_X%, %Click_Y%}
		DllCall("Sleep","UInt",rand_wait + (4*Delay_Short))
		SendEvent {Click, 341, 1054}; Click Outside Rewards Box
		DllCall("Sleep","UInt",rand_wait + (4*Delay_Short))

		Next_Depot_Button:
		Capture_Screen_Text := ""
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
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; Click VIP_Shop ; SendEvent {Click, 156, 91}
	Mouse_Click(156,91)
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	
	Search_Captured_Text := ["VIP Shop"]
	loop, 2
	{
		loop, 2
			if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0})
				goto Continue_VIP_Shop
		
		Gosub Go_Back_To_Home_Screen
		SendEvent {Click, 156, 91} ; click VIP Shop
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	}
	goto VIP_Shop_END

	Continue_VIP_Shop:
	OCR_X := 480 ; delta 145-480 = 335
	OCR_Y := 815 ; delta 145-480 = 170
	Click_X := (OCR_Y + 80)
	Click_Y := (OCR_Y + 100)
	; Button01 := 225, 575 ; (delta X:80, Y:100)
	; Button02 := 560, 575 ; (delta X:80, Y:100)
	; Button03 := 225, 745 ; (delta X:80, Y:100)
	; Button04 := 560, 745 ; (delta X:80, Y:100)
	VIP_Shop_Button_text01 := "VIPRaffle"
	VIP_Shop_Button_text02 := "BasicTransport"
	VIP_Shop_Button_text03 := VIP_Shop_Button_text01 ;"WildHarvest"
	VIP_Shop_Button_text04 := VIP_Shop_Button_text02 ;"SilverMedal"

	Gosub VIP_Shop_Click_Button

	VIP_Shop_END:
	Gosub Go_Back_To_Home_Screen
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

	VIP_Shop_Click_Button:
	Search_Captured_Text := ["VIP Raffle","Basic Transport"]
	;DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
	loop, 6
	{
		; Looking for VIP items that match list
		if !Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [OCR_X, OCR_Y], Size: [200, 80], Timeout: 0})
			goto VIP_Shop_Click_Button_Next

		VIP_Shop_Click_Found_Item:
		SendEvent {Click, %Click_X%, %Click_Y%} ; click VIP item to purchase
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
		SendEvent {Click, 350, 890} ; confirm purchase
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
		SendEvent {Click, 350, 1150} ; Click Outside Rewards Box
		DllCall("Sleep","UInt",rand_wait + (3*Delay_Medium))

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
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	; Click Mail ; SendEvent {Click, 474, 1186}
	Mouse_Click(474,1186)
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

	; Click Alliance ; SendEvent {Click, 194, 272}
	Mouse_Click(194,272)
	;DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
	Gosub Mark_All_As_Read

	; Click Last Empire - War Z Studios ; SendEvent {Click, 186, 547}
	Mouse_Click(186,547)
	;DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
	Gosub Mark_All_As_Read

	; Click System ; SendEvent {Click, 181, 633}
	Mouse_Click(181,633)
	;DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
	Gosub Mark_All_As_Read

	; Click Activities ; SendEvent {Click, 188, 446}
	Mouse_Click(188,446)
	;DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
	; Click Activities - SPAR (Single Player Arms Race) ; SendEvent {Click, 259, 171}
	Mouse_Click(259,171)
	;DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
	Gosub Mark_All_As_Read

	; Click Activities ; SendEvent {Click, 188, 446}
	Mouse_Click(188,446)
	;DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
	; Click Activities - AAR (Alliance Arms Race) ; SendEvent {Click, 242, 257}
	Mouse_Click(242,257)
	;DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
	Gosub Mark_All_As_Read

	; Click Activities ; SendEvent {Click, 188, 446}
	Mouse_Click(188,446)
	;DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
	; Click Activities - CSB (Cross-State Battle) ; SendEvent {Click, 206, 361}
	Mouse_Click(206,361)
	;DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
	Gosub Mark_All_As_Read

	; Click Activities ; SendEvent {Click, 188, 446}
	Mouse_Click(188,446)
	;DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
	; Click Activities - Desert Conflict ; SendEvent {Click, 186, 442}
	Mouse_Click(186,442)
	;DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
	Gosub Mark_All_As_Read

	; Click Activities ; SendEvent {Click, 188, 446}
	Mouse_Click(188,446)
	;DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
	; Click Activities - Other Event Mail ; SendEvent {Click, 174, 543}
	Mouse_Click(174,543)
	;DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
	Gosub Mark_All_As_Read

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

	Mark_All_As_Read:
	{
		; Click Mark All As Read ; SendEvent {Click, 334, 1190}
		Mouse_Click(334,1190)
		;DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))

		; Click Confirm Marking All As Read ; SendEvent {Click, 194, 695}
		Mouse_Click(194,695)
		;DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))

		; Click Mark All As Read ; SendEvent {Click, 334, 1190}
		Mouse_Click(334,1190)
		;DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))

		; Click Message back ; SendEvent {Click, 631, 75}
		loop, 2
		{
			Mouse_Click(51,63)
			;DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		}

		Gosub Go_Back_To_Home_Screen
		; ;DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

		; Click Mail ; SendEvent {Click, 474, 1186}
		Mouse_Click(474,1186)
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

		Text_To_Screen("{F5}")
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

		; Click Mail ; SendEvent {Click, 474, 1186}
		Mouse_Click(474,1186)
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

		; Gosub Go_Back_To_Home_Screen

		return
	}
}

Alliance_Boss_Regular:
{
	Subroutine_Running := "Alliance_Boss"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	; Click Alliance ; SendEvent {Click, 611, 1214}
	Mouse_Click(611,1214)
	DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))

	; Swipe up
	loop, 2
	{
		Click, 345, 1101 Left, Down
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		Click, 370, 1003, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		Click, 408, 196 Left, Up
	}
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	; Click Alliance Boss ; SendEvent {Click, 273, 541} ; regular play
	Mouse_Click(273,541)
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	; Click Feed Boss ; SendEvent {Click, 525, 1186}
	Mouse_Click(525,1186)
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	; Click Confirm Feed Boss ; SendEvent {Click, 339, 779}
	Mouse_Click(339,779)

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Alliance_Boss_Oasis:
{
	Subroutine_Running := "Alliance_Boss"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	; Click Alliance ; SendEvent {Click, 611, 1214}
	Mouse_Click(611,1214)
	DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))

	; Swipe up
	loop, 2
	{
		Click, 345, 1101 Left, Down
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		Click, 370, 1003, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		Click, 408, 196 Left, Up
	}
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	; Click Alliance Boss ; SendEvent {Click, 273, 630} ; desert oasis
	Mouse_Click(273,630)
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	; Click Feed Boss ; SendEvent {Click, 525, 1186}
	Mouse_Click(525,1186)
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	; Click Confirm Feed Boss ; SendEvent {Click, 339, 779}
	Mouse_Click(339,779)

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Alliance_Wages:
{
	Subroutine_Running := "Alliance_Wages"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	Goto Alliance_Menu_Wages

	Control_Desk_Alliance_Wages:
	{
		; Click Expand Control Desk ; SendEvent {Click, 27, 612}
		Mouse_Click(27,612)
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

		; Swipe Down (linear)
		loop, 2
		{
			Click, 326, 405 Left, Down
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 326, 474, 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 326, 543, 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 326, 681, 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 326, 957 Left, Up
			; DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

		; Click Goto Alliance Wages ; SendEvent {Click, 468, 959}
		SendEvent {Click, 468, 959}

		; Click Goto Alliance Wages ; SendEvent {Click, 468, 959}
		SendEvent {Click, 468, 959}

		Goto Alliance_Wages_Continue
	}

	Alliance_Menu_Wages:
	{
		; Click Alliance Menu ; SendEvent {Click, 604, 1212}
		Mouse_Click(604,1212)
		;DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

		Search_Captured_Text := ["Wages"]
		loop, 5
		{
			loop, 3
			{
				if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [230, 920], Size: [100, 60], Timeout: 0})
				{
					SendEvent, {Click, 405, 932}  ; Click Alliance Wages button
					goto Found_Alliance_Wages_Menu
				}
				
				if Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [230, 1020], Size: [100, 60], Timeout: 0})
				{
					SendEvent, {Click, 405, 1044}  ; Click Alliance Wages button
					goto Found_Alliance_Wages_Menu
				}
			}
			
			Gosub Go_Back_To_Home_Screen
			SendEvent {Click, 604, 1212} ; Click Alliance Menu
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
	DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))

	; Alliance Wages - Active (TAB 1)
	Alliance_Wages_Active_TAB_1:
	Subroutine_Running := "Alliance_Wages_Active_TAB_1"
	{
		; Gosub Click_Through_Wage_Tabs
		Gosub Click_Points_Boxes
		; DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

		goto END_Alliance_Wages_Active_TAB_1

		TRY_MORE_01_Alliance_Wages_Active_TAB_1:
		Gosub Click_Through_Wage_Tabs
		;Swipe Right
		loop, 5
		{
			Click, 216, 647 Left, Down
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 275, 647, 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 324, 647, 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 424, 647, 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 624, 647 Left, Up
			; DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		}
		DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
		Gosub Click_Points_Boxes
		DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))

		; MsgBox, 4, , Retry? (8 Second Timeout & skip), 8
		; vRet := MsgBoxGetResult()
		; if (vRet = "No")
		;	goto Alliance_Wages_Active_TAB_2

		TRY_MORE_02_Alliance_Wages_Active_TAB_1:
		Gosub Click_Through_Wage_Tabs
		; Swipe Left
		loop, 5
		{
			Click, 624, 647 Left, Down
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 424, 647, 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 324, 647, 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 275, 647, 0
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Click, 216, 647 Left, Up
			; DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		}
		DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
		Gosub Click_Points_Boxes
		DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))

		END_Alliance_Wages_Active_TAB_1:
		; MsgBox, 4, , Retry? (8 Second Timeout & skip), 8
		; vRet := MsgBoxGetResult()
		; if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		;	goto TRY_MORE_01_Alliance_Wages_Active_TAB_1
	}

	; Alliance Wages - Active (TAB 2)
	Alliance_Wages_Active_TAB_2:
	Subroutine_Running := "Alliance_Wages_Active_TAB_2"
	{
		; Click Alliance Wages - Attendance (TAB 2)
		SendEvent {Click, 336, 391}
		; Mouse_Click(336,391)
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

		; Click Attendance 1
		loop, 3
		{
			SendEvent {Click, 134, 725}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		}

		; loop, 3
			; Mouse_Click(134,725)
		; DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))

		; Click Attendance 30
		loop, 3
		{
			SendEvent {Click, 281, 730}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		}

		; loop, 3
			; Mouse_Click(281,730)
		; DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))

		; Click Attendance 50
		loop, 3
		{
			SendEvent {Click, 615, 726}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		}

		; loop, 3
			; Mouse_Click(615,726)
		; DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
	}

	; Alliance Wages - Active (TAB 3)
	Alliance_Wages_Active_TAB_3:
	Subroutine_Running := "Alliance_Wages_Active_TAB_3"
	{
		; Click Alliance Wages - Contribution (TAB 3)
		loop, 2
			SendEvent {Click, 562, 391}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

		; Click Alliance Contribution Box 1
		loop, 3
		{
			SendEvent {Click, 140, 726}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		}

		; Click Alliance Contribution Box 2
		loop, 3
		{
			SendEvent {Click, 275, 726}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		}

		; Click Alliance Contribution Box 3
		loop, 3
		{
			SendEvent {Click, 410, 726}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		}

		; Click Alliance Contribution Box 4
		loop, 3
		{
			SendEvent {Click, 622, 726}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		}
	}
	return

	Click_Through_Wage_Tabs:
	{
		; Click Alliance Wages - Attendance (TAB 2)
		SendEvent {Click, 336, 390}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))

		; Click Alliance Wages - Contribution (TAB 3)
		SendEvent {Click, 562, 390}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))

		; Click Alliance Wages - Active (TAB 1)
		SendEvent {Click, 112, 390}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))

		return
	}

	Click_Points_Boxes:
	{
		; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
		; Click Points Box 30
		SendEvent {Click, 40, 650}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; FoundPictureX := 40
		; FoundPictureY := 650
		Gosub Click_Collect_Daily_Rewards_Chest
		; Click Points Box 30
		SendEvent {Click, 100, 650}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; FoundPictureX := 100
		; FoundPictureY := 650
		Gosub Click_Collect_Daily_Rewards_Chest
		; Click Points Box 70
		SendEvent {Click, 160, 650}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; FoundPictureX := 160
		; FoundPictureY := 650
		Gosub Click_Collect_Daily_Rewards_Chest
		; Click Points Box 70
		SendEvent {Click, 220, 650}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; FoundPictureX := 220
		; FoundPictureY := 650
		Gosub Click_Collect_Daily_Rewards_Chest
		; Click Points Box 120
		SendEvent {Click, 280, 650}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; FoundPictureX := 280
		; FoundPictureY := 650
		Gosub Click_Collect_Daily_Rewards_Chest
		; Click Points Box 120
		SendEvent {Click, 340, 650}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; FoundPictureX := 340
		; FoundPictureY := 650
		Gosub Click_Collect_Daily_Rewards_Chest
		; Click Points Box 180
		SendEvent {Click, 400, 650}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; FoundPictureX := 400
		; FoundPictureY := 650
		Gosub Click_Collect_Daily_Rewards_Chest
		; Click Points Box 180
		SendEvent {Click, 460, 650}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; FoundPictureX := 460
		; FoundPictureY := 650
		Gosub Click_Collect_Daily_Rewards_Chest
		; Click Points Box 260
		SendEvent {Click, 520, 650}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; FoundPictureX := 520
		; FoundPictureY := 650
		Gosub Click_Collect_Daily_Rewards_Chest
		; Click Points Box 260
		SendEvent {Click, 580, 650}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; FoundPictureX := 580
		; FoundPictureY := 650
		Gosub Click_Collect_Daily_Rewards_Chest
		; Click Points Box 340
		SendEvent {Click, 640, 650}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		; FoundPictureX := 640
		; FoundPictureY := 650
		Gosub Click_Collect_Daily_Rewards_Chest

		return
	}

	Click_Collect_Daily_Rewards_Chest:
	{
		; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

		; Gosub Click_Wait

		; Click Collect Daily Rewards Chest ;
		SendEvent {Click, 352, 982}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))

		; Click Outside Chest ;
		SendEvent {Click, 366, 175}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))

		return
	}

}

Train_Daily_Requirement:
{
	Subroutine_Running := "Train_Daily_Requirement"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	Gosub Reset_Posit
	DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))

	; Zoom out
	loop, 10
	{
		Text_To_Screen("{F2}")
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
	}

	loop, 2
	{
		; Click Mail ; SendEvent {Click, 474, 1186}
		Mouse_Click(474,1186)
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))

		; Click Message back ; SendEvent {Click, 631, 75}
		Mouse_Click(51,63)
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))

		; Zoom out
		loop, 10
		{
			Text_To_Screen("{F2}")
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
		}
	}

	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; Zoom out
	loop, 10
	{
		Text_To_Screen("{F2 2}")
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
	}

	; Swipe Right
	; SendEvent {Click, 250, 650}
	; DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
	; Click, 400, 650, 0
	; DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
	; Click, 475, 650, 0
	; DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
	; Click, 512, 650, 0
	; DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
	; Click, 531, 650, 0
	; DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
	; Click, 550, 650 Left, Up

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Click Vehicle Factory
	; SendEvent {Click, 393, 985}
	loop, 2
	{
		Mouse_Click(391,940)
		Gosub Click_Middle_Screen
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	}
	; Click Train Button
	; SendEvent {Click, 531, 986}
	Mouse_Click(531,964)
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	Gosub Training_Number

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Click Warrior Camp
	; SendEvent {Click, 183, 852}
	loop, 2
	{
		Mouse_Click(219,845)
		Gosub Click_Middle_Screen
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	}
	; Click Train Button
	; SendEvent {Click, 324, 872}
	Mouse_Click(354,878)
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	Gosub Training_Number

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Click Shooter Camp
	; SendEvent {Click, 63, 769}
	loop, 2
	{
		Mouse_Click(100,800)
		Gosub Click_Middle_Screen
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	}
	; Click Train Button
	; SendEvent {Click, 271, 833}
	Mouse_Click(239,850)
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	Gosub Training_Number

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Click Biochemical Center
	; SendEvent {Click, 10, 730}
	loop, 2
		{
		Mouse_Click(11,717)
		Gosub Click_Middle_Screen
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	}
	; Click Train Button
	; SendEvent {Click, 275, 732}
	Mouse_Click(249,755)
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	Gosub Training_Number

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

	Training_Number:
	{
		; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

		; Click Troop Number Box
		; SendEvent {Click, 551, 1099}
		Mouse_Click(551,1099)
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

		loop, 8
		{
			Text_To_Screen("{Backspace}")
			DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
		}
		Text_To_Screen("{3}")
		DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
		Text_To_Screen("{0}")
		DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
		Text_To_Screen("{0}")
		DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
		Text_To_Screen("{Enter}")
		DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))

		; Click Train Now
		; SendEvent {Click, 508, 1188}
		Mouse_Click(508,1188)

		Gosub Go_Back_To_Home_Screen

		return
	}
}

Gather_Resources:
{
	Subroutine_Running := "Gather_Resources"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	; click World button
	; SendEvent {Click, 76, 1200}
	Mouse_Click(76,1200)
	DllCall("Sleep","UInt",rand_wait + (8*Delay_Long))

	Gather_Fuel:
	Subroutine_Running := "Gather_Fuel"
	; click search button x times
	loop, 2
	{
		; SendEvent {Click, 627, 1034}
		Mouse_Click(627,1068)
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
	}
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

	; Swipe right x times
	loop, 2
	{
		; World search Swipe Right One position
		Click, 100, 990 Left, Down
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 350, 990, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 475, 990, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 562, 990, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 600, 990 Left, Up
		; DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
	}
	; DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	MsgBox, 4, , Gather Oil Well? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		{
			; Click Oil Well
			; SendEvent {Click, 407, 974}
			Mouse_Click(407,974)
			Gosub Search_And_Deploy_Resources
			; DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
		}

	Gather_Farm:
	Subroutine_Running := "Gather_Farm"
	MsgBox, 4, , Gather Farm? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		{
			; Click Farm
			; SendEvent {Click, 547, 970}
			Mouse_Click(547,970)
			Gosub Search_And_Deploy_Resources
			; DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
		}

	Gather_Steel:
	Subroutine_Running := "Gather_Steel"
	; click search button x times
	loop, 2
	{
		; SendEvent {Click, 627, 1034}
		Mouse_Click(627,1068)
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
	}
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

	; Swipe left x times
	loop, 2
	{
		; World search Swipe Right One position
		Click, 600, 990 Left, Down
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 562, 990, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 475, 990, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 350, 990, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 100, 990 Left, Up
		; DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
	}
	; DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	MsgBox, 4, , Gather Steel Mill? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		{
			; Click Steel Mill
			; SendEvent {Click, 124, 983}
			Mouse_Click(124,983)
			Gosub Search_And_Deploy_Resources
			; DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
		}

	Gather_Alloy:
	Subroutine_Running := "Gather_Alloy"
	; Swipe left x times
	loop, 2
	{
		; World search Swipe Right One position
		Click, 600, 990 Left, Down
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 562, 990, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 475, 990, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 350, 990, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 100, 990 Left, Up
		; DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
	}
	; DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	MsgBox, 4, , Gather Alloy Mine? (8 Second Timeout & skip), 8
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		{
			; Click Alloy Mine
			; SendEvent {Click, 269, 971}
			Mouse_Click(269,971)
			Gosub Search_And_Deploy_Resources
			; DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
		}

	MsgBox, 4, , Gather more? (10 Second Timeout & skip), 10
	vRet := MsgBoxGetResult()
	if (vRet = "Yes") ; || if (vRet = "Timeout") || if (vRet = "No")
		Gosub Gather_Fuel

	End_Gathering:

	Go_Back_Home_Delay_Long := True
	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

	Search_And_Deploy_Resources:
	{
		; Click Level Box
		; SendEvent {Click, 637, 1112}
		Mouse_Click(637,1112)
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		Text_To_Screen("{6}")
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		Text_To_Screen("{Enter}")
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))

		; Click Search Button
		; SendEvent {Click, 346, 1199}
		Mouse_Click(346,1199)
		DllCall("Sleep","UInt",rand_wait + (3*Delay_Medium))

		; Click Gather Button
		; SendEvent {Click, 440, 640}
		Mouse_Click(440,640)

		DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

		Select_Gather_Officers:
		{
			; Click Officer 5
			SendEvent {Click, 525, 437}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			; Click Above Officer In Case Already Marching
			SendEvent {Click, 318, 350}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))

			; Click Officer 4
			SendEvent {Click, 407, 434}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			; Click Above Officer In Case Already Marching
			SendEvent {Click, 318, 350}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))

			; Click Officer 3
			SendEvent {Click, 300, 435}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			; Click Above Officer In Case Already Marching
			SendEvent {Click, 318, 350}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))

			; Click Officer 2
			SendEvent {Click, 180, 441}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			; Click Above Officer In Case Already Marching
			SendEvent {Click, 318, 350}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))

			; Click Officer 1
			SendEvent {Click, 54, 436}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			; Click Above Officer In Case Already Marching
			SendEvent {Click, 318, 350}
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		}
		; DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

		; Click March; SendEvent {Click, 480, 1186}
		Mouse_Click(480,1186)
		DllCall("Sleep","UInt",rand_wait + (8*Delay_Short))

		; ; Click Do Not Remind Me Again; SendEvent {Click, 54, 965}
		; Mouse_Click(54,965)
		; DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

		; Click Deploy; SendEvent {Click, 560, 1020}
		Mouse_Click(560,1020)
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

		; click search button x times
		loop, 2
		{
			; SendEvent {Click, 627, 1034}
			Mouse_Click(627,1068)
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
		return
	}
}

Desert_Oasis:
{
	Subroutine_Running := "Desert_Oasis"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	; SendEvent {Click, 73, 1207} ; Click on World Button
	Mouse_Click(73,1207)
	DllCall("Sleep","UInt",rand_wait + (15*Delay_Long))

	SendEvent {Click, 337, 1001} ; Click on Enter Coordinates Button
	DllCall("Sleep","UInt",rand_wait + (5*Delay_Medium))
	SendEvent {Click, 242, 526} ; Click inside X Coordinate Text box
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

	; NW_Tower Coordinates X: 595-596 Y: 599-600 (595,599) steal: 439, 681
	; NE_Tower Coordinates X: 599-600 Y: 595-596 (599,595) steal: 441, 681
	; SW_Tower Coordinates X: 599-600 Y: 604-605 (599,604) steal: 447, 678
	; SE_Tower Coordinates X: 604-605 Y: 599-600 (604,599) steal: 440, 679

	; if none selected, auto steel from:
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

	; if none selected, auto steel from:
	; goto NW_Tower
	; goto NE_Tower
	; goto SW_Tower
	goto SE_Tower
	goto END_Stealing

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

	goto END_Stealing

	Desert_Oasis_Tower:
	Subroutine_Running := "Desert_Oasis_Tower"
	; NW_Tower Coordinates X: 595-596 Y: 599-600 (595,599) steal: 439, 681
	; NE_Tower Coordinates X: 599-600 Y: 595-596 (599,595) steal: 441, 681
	; SW_Tower Coordinates X: 599-600 Y: 604-605 (599,604) steal: 447, 678
	; SE_Tower Coordinates X: 604-605 Y: 599-600 (604,599) steal: 440, 679
	; MsgBox, 4, Coordinates, Are Desert_Tower_X`,Y %Desert_Tower_X% %Desert_Tower_X% Correct? (8 Second Timout & auto),8

	SendEvent {Click, 242, 526} ; Click inside X Coordinate Text box
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
	Text_To_Screen(Desert_Tower_X)
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
	Text_To_Screen("{Enter}")
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

	loop, 2
	{
		SendEvent {Click, 484, 530} ; Click inside Y Coordinate Text box
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
	}
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
	Text_To_Screen(Desert_Tower_Y)
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
	Text_To_Screen("{Enter}")
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

	SendEvent {Click, 340, 620} ; Click Go to Coordinates
	DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))
	SendEvent {Click, 340, 680} ; Click on Holy Tower
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	SendEvent {Click, 440, 680} ; Click Holy Tower Steal button
	DllCall("Sleep","UInt",rand_wait + (4*Delay_Long))
	SendEvent {Click, 342, 1200} ; Click Steal

	END_Stealing:

	if Pause_Script
		MsgBox, 0, Pause, Press OK to resume (No Timeout)

	DllCall("Sleep","UInt",rand_wait + (5*Delay_Long))

	Go_Back_Home_Delay_Long := True
	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Gather_On_Base_RSS:
{
	Subroutine_Running := "Gather_On_Base_RSS"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	Swipe_Up_Left_RSS:
	loop, 4 {
		WinActivate, LEWZ001 ahk_class Qt5QWindowIcon
		;DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
		Click, 481, 786 Left, Down
		;DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
		Click, 467, 755, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 434, 678, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 371, 482, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 365, 459, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 143, 0 Left, Up
	}

	loop, 2 {
		SendEvent {Click, 405, 653} ; Plot # 50
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 396, 553} ; Plot # 49
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 397, 453} ; Plot # 47
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 530, 1033} ; Click next to speaker
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
	}

	loop, 2 {
		SendEvent {Click, 350, 374} ; Plot # 35
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 329, 281} ; Plot # 34
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 238, 233} ; Plot # 32
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	Search_Captured_Text := ["Desert"]
	Capture_Screen_Text := OCR([236, 41, 215, 57], "eng") ; check if
	If (RegExMatch(Capture_Screen_Text,Search_Captured_Text))
		Goto END_Gather_Base_RSS

	loop, 2 {
		SendEvent {Click, 530, 1033} ; Click next to speaker
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
	}

	loop, 2 {
		SendEvent {Click, 305, 587} ; Plot # 48
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 292, 508} ; Plot # 46
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 530, 1033} ; Click next to speaker
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
	}

	loop, 2 {
		SendEvent {Click, 251, 337} ; Plot # 33
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 159, 282} ; Plot # 31
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 530, 1033} ; Click next to speaker
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
	}

	loop, 2 {
		SendEvent {Click, 137, 817} ; Plot # 40
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 36, 760} ; Plot # 39 - screen moves
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	}

	loop, 2 {
		SendEvent {Click, 28, 726} ; Plot # 37 - screen moves
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
		;DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	}

	; inserts pause
	Search_Captured_Text := ["Desert"]
	Capture_Screen_Text := OCR([236, 41, 215, 57], "eng") ; check if
	If (RegExMatch(Capture_Screen_Text,Search_Captured_Text))
		Goto END_Gather_Base_RSS

	loop, 2 {
		SendEvent {Click, 530, 1033} ; Click next to speaker
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
	}

	loop, 2 {
		SendEvent {Click, 130, 827} ; Plot # 38
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 40, 769} ; Plot # 36 - screen moves
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	}

	loop, 2 {
		SendEvent {Click, 530, 1033} ; Click next to speaker
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
	}

	loop, 2 {
		SendEvent {Click, 445, 583} ; Plot # 45
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 367, 542} ; Plot # 43
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 272, 493} ; Plot # 41
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 530, 1033} ; Click next to speaker
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
	}

	loop, 2 {
		SendEvent {Click, 485, 511} ; Plot # 44
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 381, 462} ; Plot # 42
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 530, 1033} ; Click next to speaker
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
	}

	Swipe_Right_RSS_02:
	{
		Click, 147, 854 Left, Down
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 263, 728, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 268, 726, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 270, 724, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 326, 697, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 346, 679, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 346, 676, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 349, 676, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 349, 674, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 351, 674, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 373, 648, 0
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		Click, 373, 648 Left, Up
	}

	loop, 2 {
		SendEvent {Click, 530, 1033} ; Click next to speaker
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
	}

	loop, 2 {
		SendEvent {Click, 307, 424} ; Plot # 29
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 399, 376} ; Plot # 30
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 359, 293} ; Plot # 28
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 530, 1033} ; Click next to speaker
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
	}

	loop, 2 {
		SendEvent {Click, 167, 412} ; Plot # 26
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 273, 354} ; Plot # 27
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 530, 1033} ; Click next to speaker
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
	}

	loop, 2 {
		SendEvent {Click, 110, 601} ; Plot # 24 - screen moves
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	}

	loop, 2 {
		SendEvent {Click, 34, 540} ; Plot # 22 - screen moves
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	}

	loop, 2 {
		SendEvent {Click, 530, 1033} ; Click next to speaker
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
	}

	loop, 2 {
		SendEvent {Click, 160, 679} ; Plot # 25
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 110, 644} ; Plot # 23 - screen moves
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	}

	loop, 2 {
		SendEvent {Click, 74, 593} ; Plot # 21 - screen moves
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	}

	loop, 2 {
		SendEvent {Click, 530, 1033} ; Click next to speaker
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
	}

	loop, 2 {
		SendEvent {Click, 167, 826} ; Plot # 19
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 86, 769} ; Plot # 17 - screen moves
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 530, 1033} ; Click next to speaker
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
	}

	loop, 2 {
		SendEvent {Click, 309, 781} ; Plot # 20
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 202, 711} ; Plot # 18
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
	}

	loop, 2 {
		SendEvent {Click, 114, 665} ; Plot # 16 - screen moves
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	}

	END_Gather_Base_RSS:
	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Golden_Chest:
{
	Subroutine_Running := "Golden_Chest"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen
	SendEvent {Click, 630, 530} ; Click Activity Center
	DllCall("Sleep","UInt",rand_wait + (5*Delay_Medium))
	SendEvent {Click, 333, 666} ; Click Golden Chest
	DllCall("Sleep","UInt",rand_wait + (4*Delay_Long))

	if Pause_Script
		MsgBox, 0, Pause, Press OK to resume (No Timeout)

	SendEvent {Click, 125, 1200} ; Click open for Free
	DllCall("Sleep","UInt",rand_wait + (5*Delay_Medium))
	loop, 2
		SendEvent {Click, 585, 250} ; Click outside claim banner
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	SendEvent {Click, 357, 495} ; Click Silver tab
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	SendEvent {Click, 118, 1201} ; Click open for Free
	DllCall("Sleep","UInt",rand_wait + (5*Delay_Medium))
	loop, 2
		SendEvent {Click, 585, 250} ; Click outside claim banner
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	SendEvent {Click, 633, 598} ; Click rankings
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	SendEvent {Click, 157, 367} ; Click Open box
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	SendEvent {Click, 330, 1000} ; click collect rewards
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

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

	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	; Gosub Go_Back_To_Home_Screen

	Open_Mail:
	; SendEvent {Click, 492, 1202} ; Click mail
	Mouse_Click(492,1202)
	;DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))

	Search_Captured_Text := ["Mail"]
	loop, 2
	{
		loop, 5
			if Search_Captured_Text_OCR(Search_Captured_Text, {Timeout: 0})
				goto Compose_Message
		
		Gosub Go_Back_To_Home_Screen
		SendEvent {Click, 492, 1202} ; Click mail
		; DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
	}
	
	; MsgBox, Capture_Screen_Text: %Capture_Screen_Text%
	Gosub Go_Back_To_Home_Screen
	return

	Compose_Message:
	SendEvent {Click, 636, 55} ; Click new Message
	DllCall("Sleep","UInt",rand_wait + (7*Delay_Short))
	SendEvent {Click, 498, 173} ; Click User Name Text Box
	DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
	Text_To_Screen(Boss_User_name) ; Type user name to send message to
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
	SendEvent {Click, 433, 327} ; Click Message text body
	DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
	Text_To_Screen(Message_To_The_Boss) ; Type Message to user
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	;MsgBox, 0, Pause, Press OK to resume (No Timeout)

	SendEvent {Click, 352, 1174} ; Click Send button
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Send_Message_In_Chat:
{
	Subroutine_Running := "Send_Message_In_Chat"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	SendEvent {Click, 316, 1122} ; Click on Chat Bar
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	SendEvent {Click, 33, 62} ; Click back Button
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	SendEvent {Click, 228, 388} ; Click on third Chat Room "Hack Root"
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	SendEvent {Click, 227, 1215} ; Click in Message Box
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

	Chat_Message = % GetRandom(Chat_Message_List,"`n","`r")

	;MsgBox, SendInput
	; SendEvent {Click, 227, 1215} ; Click in Message Box
	; DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
	; Text_To_Screen(Chat_Message) ; Type message to send")
	; SendEvent {Click, 227, 1215} ; Click in Message Box
	; DllCall("Sleep","UInt",rand_wait + (5*Delay_Long))
	; SendEvent {Click, 651, 1213} ; Click Send
	; DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	;MsgBox, SendRaw
	SendEvent {Click, 227, 1215} ; Click in Message Box
	DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
	SendRaw, %Chat_Message% ; Type message to send
	; SendEvent {Click, 227, 1215} ; Click in Message Box
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
	SendEvent {Click, 651, 1213} ; Click Send
	DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Get_Inventory:
{
	Subroutine_Running := "Get_Inventory"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; SendEvent {Click, 168, 41} ; Click Fuel on upper menu bar
	Mouse_Click(168,41)

	DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	Available_Food := OCR([244, 132, 90, 25], "eng") ; capture Available Food number
	Available_Steel := OCR([414, 132, 90, 25], "eng") ; capture Available Steel number
	Available_Alloy := OCR([584, 132, 90, 25], "eng") ; capture Available Alloy number
	; DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))

	SendEvent {Click, 95, 141} ; Click Fuel tab
	DllCall("Sleep","UInt",rand_wait + (7*Delay_Short))
	Inventory_Fuel := OCR([87, 180, 521, 39], "eng") ; capture Reserve Fuel number
	;DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))

	SendEvent {Click, 248, 139} ; Click Food tab
	DllCall("Sleep","UInt",rand_wait + (7*Delay_Short))
	Inventory_Food := OCR([87, 180, 521, 39], "eng") ; capture Reserve Food number
	;DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))

	SendEvent {Click, 442, 136} ; Click Steel tab
	DllCall("Sleep","UInt",rand_wait + (7*Delay_Short))
	Inventory_Steel := OCR([87, 180, 521, 39], "eng") ; capture Reserve Steel number
	;DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))

	SendEvent {Click, 594, 141} ; Click Alloy tab
	DllCall("Sleep","UInt",rand_wait + (7*Delay_Short))
	Inventory_Alloy := OCR([87, 180, 521, 39], "eng") ; capture Reserve Alloy number
	Available_Fuel := OCR([70, 132, 90, 25], "eng") ; capture Available Fuel number
	;DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))

	;
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

	;Message_To_The_Boss .= "Fuel: " . Available_Fuel . " += " . Inventory_Fuel
	;. ", Food: " . Available_Food . " += " . Inventory_Food
	;. ", Steel: " . Available_Steel . " += " . Inventory_Steel
	;. ", Alloy: " . Available_Alloy . " += " . Inventory_Alloy . ", "

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
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; SendEvent {Click, 47, 80} ; Click commander info on upper menu bar
	Mouse_Click(47,80)

	; capture text from commander info screen
	DllCall("Sleep","UInt",rand_wait + (7*Delay_Short))
	User_Name_Captured := OCR([196, 183, 270, 29], "eng")
	User_State_Alliance := OCR([292, 145, 222, 32], "eng")
	User_VIP := OCR([183, 138, 116, 44], "eng")
	User_Power := OCR([497, 362, 122, 27], "eng")

	;DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))

	; MsgBox, % "1. before trim "  User_Name_Captured ", " User_State_Alliance ", " User_VIP ", " User_Power
	; MsgBox, % User_Name_Captured ", " User_State_Alliance ", " User_VIP ", " User_Power

	; Extract User_Found_Alliance from User_State_Alliance
	RegExMatch(User_State_Alliance, "`[[A-Za-z]+`]" , User_Found_Alliance)
	User_Found_Alliance := % RegExReplace(User_Found_Alliance,"[^A-Za-z0-9 ]+")

	; Extract User_Found_State from User_State_Alliance
	RegExMatch(User_State_Alliance, "\d\d\d" , User_Found_State)

	; Clean up User_VIP
	User_VIP := StrReplace(User_VIP, " ", "")
	User_VIP := StrReplace(User_VIP, "VIF", "VIP")
	User_VIP := StrReplace(User_VIP, "VIPS", "VIP9")

	; Clean up User_Power
	;User_Power := StrReplace(User_Power, ", ", "")
	;User_Power := % RegExReplace(User_Power,"[^0-9]+")
	
	User_Power := % Convert_OCR_Value(User_Power)

	;MsgBox, % "User_State_Alliance:" User_State_Alliance " and User_Found_Alliance: " User_Found_Alliance " User_Found_State: " User_Found_State

	;User_Name_Captured := trim(User_Name_Captured)
	;User_VIP := trim(User_VIP)
	;User_State_Alliance := trim(User_State_Alliance)
	;User_Power := trim(User_Power)
	; MsgBox, % "2. after trim "  User_Name_Captured ", " User_State_Alliance ", " User_VIP ", " User_Power

	Gosub Go_Back_To_Home_Screen
	
	User_Diamonds := OCR([590, 90, 96, 31], "eng")
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
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; SendEvent {Click, 76, 1200} ; Click World/home button
	Mouse_Click(76,1200)
	DllCall("Sleep","UInt",rand_wait + (5*Delay_Long))

	SendEvent {Click, 347, 600} ; Click My City on World Map
	DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))
	User_City_Location := OCR([300, 664, 120, 43], "eng")
	;User_City_Location := Trim(User_City_Location)
	User_City_Location := % RegExMatch(User_City_Location,"X:\d+[^\d]*Y:\d+[^\d]*", User_City_Location_XY)
	User_City_Location_XY := % RegExReplace(User_City_Location_XY,"[^0-9,]+")
	User_City_Location_XY := StrReplace(User_City_Location_XY, ",", ":")

	; MsgBox, % "User_City_Location: " . User_City_Location . " User_City_Location_XY: " . User_City_Location_XY

	Message_To_The_Boss .= "Location:`,""(" . User_City_Location_XY . ")""`,"

	;DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
	;User_City_Location := OCR([304, 663, 85, 22], "eng")
	;User_City_Location_Array := StrSplit(User_City_Location, "`,","XY: ")  ; Omits X, Y, : and space.

	; MsgBox, % "1. before split X`,Y:" User_City_Location " 2. after split X:Y" User_City_Location_Array[1] ":" User_City_Location_Array[2]
	;Message_To_The_Boss .= "Location:`,""" . User_City_Location_Array[1] . ":" . User_City_Location_Array[2] . """`,"

	Go_Back_Home_Delay_Long := True
	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Base_Search_World_Map:
{
	Subroutine_Running := "Base_Search_World_Map"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

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
		; App_Window_Width := 730
		; App_Window_Height := 1249
		; first area X = 4-562, Y = 144-657
		Global X1 := 150
		Global Y1 := 264
		Global X2 := App_Window_Width - (App_Window_Width - 484)
		Global Y2 := App_Window_Height - (App_Window_Height - 468)
		Global PixelSearch_UpperX1 := (UpperX + X1) ; initialize upper left X coord of PixelSearch area
		Global PixelSearch_UpperY1 := (UpperY + Y1) ; initialize upper left Y coord of PixelSearch area
		Global PixelSearch_LowerX1 := (LowerX - X2) ; initialize lower right X coord of PixelSearch area
		Global PixelSearch_LowerY1 := (LowerY - Y2) ; initialize lower right Y coord of PixelSearch area

		; second area X = 90-654 Y = 657-934
		X1 := 200
		Y1 := 468
		X2 := App_Window_Width - (App_Window_Width - 609)
		Y2 := App_Window_Height - (App_Window_Height - 930)
		PixelSearch_UpperX2 := (UpperX + X1) ; initialize upper left X coord of PixelSearch area
		PixelSearch_UpperY2 := (UpperY + Y1) ; initialize upper left Y coord of PixelSearch area
		PixelSearch_LowerX2 := (LowerX - X2) ; initialize lower right X coord of PixelSearch area
		PixelSearch_LowerY2 := (LowerY - Y2) ; initialize lower right Y coord of PixelSearch area

		; Global Base_Color := "0x1D1D1D"
		Global PixelSearch_Variation := 0
		Global PixelSearch_Mode := "Fast"
		Global Map_X := "{Raw}560"
		Global Map_Y := "{Raw}578"

		; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
		return
	}

	Enter_Search_Coordinates:
	{
		WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
		SendEvent {Click 220, 1000}  ; Click Map Coordinate button
		; SendEvent {Click, 188, 869}
		DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))

		SendEvent {Click 200, 530} ; Click inside X coordinate Box
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
		Text_To_Screen(Map_X)
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
		Text_To_Screen("{Enter}")
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
		SendEvent {Click 448, 530}  ; Click inside Y coordinate Box
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
		Text_To_Screen(Map_Y)
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
		Text_To_Screen("{Enter}")
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))
		; SendEvent {Click 196, 467}
		SendEvent {Click 350, 620}  ; Click Go To Coordinates2
		DllCall("Sleep","UInt",rand_wait + (2*Delay_Short))

		return
	}

	Maximize_Viewing_Area:
	{
		WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
		PixelSearch, Px, Py, 598, 595, 657, 623, 0xFFFFFF, PixelSearch_Variation, Fast
		if ErrorLevel
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		else
		{
			SendEvent {Click %Px%, %Py%} ; Click to shrink activity bar
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
		}
		return
	}

	Swipe_LL_To_UR:
	{
		SendEvent {Click 112, 897, Down}
		SendEvent {Click 168, 869, 0}
		SendEvent {Click 183, 861, 0}
		SendEvent {Click 212, 847, 0}
		SendEvent {Click 279, 813, 0}
		SendEvent {Click 375, 764, 0}
		SendEvent {Click 445, 729, 0}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		SendEvent {Click 497, 703, 0}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		SendEvent {Click 497, 703, 0}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		SendEvent {Click 497, 703, Up}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		SendEvent {Click 497, 703, 0}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		SendEvent {Click 497, 703, 0}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		SendEvent {Click 497, 703, 0}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		SendEvent {Click 497, 703, 0}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
		SendEvent {Click 497, 703, 0}

		return
	}

	Search_Base_Pictures:
	{
		For Base,Val in Base_Colors
		{
			Base_Picture := Base

			WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			ImageSearch, FoundPictureX, FoundPictureY, %PixelSearch_UpperX1%, %PixelSearch_UpperY1%, %PixelSearch_LowerX1%, %PixelSearch_LowerY1%, *145 *Trans0xF0F0F0 %Base_Picture%
			if ErrorLevel = 0
			{
				stdout.WriteLine(A_Now "A " Base_Picture " was found at X"FoundPictureX " Y" FoundPictureY )
				SendEvent {Click %FoundPictureX%, %FoundPictureY%}
				DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
				MsgBox, 1 ErrorLevel: %ErrorLevel% - A %Base_Picture% found at X%FoundPictureX% Y%FoundPictureY%.
			}

			WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			ImageSearch, FoundPictureX, FoundPictureY, %PixelSearch_UpperX2%, %PixelSearch_UpperY2%, %PixelSearch_LowerX2%, %PixelSearch_LowerY2%, *145 *Trans0xF0F0F0 %Base_Picture%
			if ErrorLevel = 0
			{
				stdout.WriteLine(A_Now "A " Base_Picture " was found at X"FoundPictureX " Y" FoundPictureY )
				SendEvent {Click %FoundPictureX%, %FoundPictureY%}
				DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
				MsgBox, 2 ErrorLevel: %ErrorLevel% - A %Base_Picture% found at X%FoundPictureX% Y%FoundPictureY%.
			}

			WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			ImageSearch, FoundPictureX, FoundPictureY, %PixelSearch_UpperX1%, %PixelSearch_UpperY1%, %PixelSearch_LowerX1%, %PixelSearch_LowerY1%, *145 *Trans0xFFFFFF %Base_Picture%
			if ErrorLevel = 0
			{
				stdout.WriteLine(A_Now "A " Base_Picture " was found at X"FoundPictureX " Y" FoundPictureY )
				SendEvent {Click %FoundPictureX%, %FoundPictureY%}
				DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
				MsgBox, 3 ErrorLevel: %ErrorLevel% - A %Base_Picture% found at X%FoundPictureX% Y%FoundPictureY%.
			}

			WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			ImageSearch, FoundPictureX, FoundPictureY, %PixelSearch_UpperX2%, %PixelSearch_UpperY2%, %PixelSearch_LowerX2%, %PixelSearch_LowerY2%, *145 *Trans0xFFFFFF %Base_Picture%
			if ErrorLevel = 0
			{
				stdout.WriteLine(A_Now "A " Base_Picture " was found at X"FoundPictureX " Y" FoundPictureY )
				SendEvent {Click %FoundPictureX%, %FoundPictureY%}
				DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
				MsgBox, 4 ErrorLevel: %ErrorLevel% - A %Base_Picture% found at X%FoundPictureX% Y%FoundPictureY%.
			}
		}
			MsgBox, Search Completed
			WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
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

			WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			PixelSearch, Px, Py, %PixelSearch_UpperX1%, %PixelSearch_UpperY1%, %PixelSearch_LowerX1%, %PixelSearch_LowerY1%, %Base_Color%, PixelSearch_Variation, %PixelSearch_Mode%
			if ErrorLevel
				DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			else
				goto Get_Base_Info

			; MsgBox, 1. X1 %X1% Y1 %Y1% X2 %X2% Y2 %Y2% PixelSearch_UpperX1 %PixelSearch_UpperX1% PixelSearch_UpperY1 %PixelSearch_UpperY1% PixelSearch_LowerX1 %PixelSearch_LowerX1% PixelSearch_LowerY1 %PixelSearch_LowerY1%

			PixelSearch, Px, Py, %PixelSearch_UpperX2%, %PixelSearch_UpperY2%, %PixelSearch_LowerX2%, %PixelSearch_LowerY2%, %Base_Color%, PixelSearch_Variation, %PixelSearch_Mode%
			if ErrorLevel
				DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
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

				;DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
				;Found_City_Info1 := OCR([OCR_X, OCR_Y, OCR_W, OCR_H], "eng")
				;Found_City_Info1 := % RegExReplace(Found_City_Info1,"[\r\n\h]+")
				;Found_City_Info1 := trim(Found_City_Info1)

				; msgBox, 1. Base_Color: %Base_Color% Found_City_Info1: %Found_City_Info1%

				; MsgBox, 1. OCR X,Y %OCR_X%,%OCR_Y% Px,Py: %Px%,%Py% Found_City_Info1: %Found_City_Info1%


				SendEvent {Click %Px%, %Py%} ; click on potential city
				DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

				;if Check_For_Zombie_Popup() ; check for rover zombie popup
				;	goto Next_Coord_Search

				DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
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
				; DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))

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

				;if (PixelSearch_UpperY1 < Py)
				;	PixelSearch_UpperY1 := (Py + 1)
				;if (PixelSearch_UpperY2 < Py)
				;	PixelSearch_UpperY2 := (Py + 1)
			}
			End_Of_Color_Search:
			; SendEvent {Click, 549, 1037} ; Click next to speaker
			;Check_For_Zombie_Popup()
		}
		return
	}

	Go_Back_Home_Delay_Long := True
	Gosub Go_Back_To_Home_Screen

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Check_For_Zombie_Popup()
{
	Gosub Get_Window_Geometry
	; Red Attack button
	; 210, 887 to 473, 938 - red 0x830D01 Attack zombie button
	; 162, 838 to 523, 890 - red 0x720D06 attack rover button
	; 162, 838 to 523, 938 - red 0x720D06 attack combined button
	X1 := 162
	Y1 := 838
	X2 := App_Window_Width - (App_Window_Width - 523)
	Y2 := App_Window_Height -(App_Window_Height - 938)
	Attack_UpperX := (UpperX + X1) ; initialize upper left X coord of PixelSearch area
	Attack_UpperY := (UpperY + Y1) ; initialize upper left Y coord of PixelSearch area
	Attack_LowerX := (LowerX - X2) ; initialize lower right X coord of PixelSearch area
	Attack_LowerY := (LowerY - Y2) ; initialize lower right Y coord of PixelSearch area

	; MsgBox, X1 %X1% Y1 %Y1% X2 %X2% Y2 %Y2% Attack_UpperX %Attack_UpperX% Attack_UpperY %Attack_UpperY% Attack_LowerX %Attack_LowerX% Attack_LowerY %Attack_LowerY%

	Attack_Color := "0x4e1610" ; 25
	;Attack_Color := "0x810f09"
	;Attack_Color := "0x381410"
	;Attack_Color := "0xbc140e"
	;Attack_Color := "0x970D03"
	Attack_Variation := 25

	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; if Rover or zombie pop-up, click next to speaker
	PixelSearch, Px, Py, %Attack_UpperX%, %Attack_UpperY%, %Attack_LowerX%, %Attack_LowerY%, %Attack_Color%, Attack_Variation, Fast
	if ErrorLevel
	{
		;MsgBox, No Zombie or Rover return 0
		return 0
	}
	else
	{
		SendEvent {Click, 549, 1037} ; Click next to speaker
		; Text_To_Screen("{Esc}")
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
		;MsgBox, Zombie or Rover return 1
		return 1
	}

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Convert_OCR_Value(RSS_VAR_OLD)
{	
	RSS_VAR_OLD := % RegExReplace(RSS_VAR_OLD,"[^\d\.MKG]+")
	RSS_VAR_NEW := % RegExReplace(RSS_VAR_OLD,"[^\d\.]+")
	;MsgBox, BEGIN: RSS_VAR_OLD:%RSS_VAR_OLD% RSS_VAR_NEW:%RSS_VAR_NEW%

	If (RegExMatch(RSS_VAR_OLD,"[\d\.]+K"))
		RSS_VAR_NEW := (RSS_VAR_NEW * 1000)
	else If (RegExMatch(RSS_VAR_OLD,"[\d\.]+M"))
		RSS_VAR_NEW := (RSS_VAR_NEW * 1000000)
	else If (RegExMatch(RSS_VAR_OLD,"[\d\.]+G"))
		RSS_VAR_NEW := (RSS_VAR_NEW * 1000000000)
	else
		RSS_VAR_NEW := RSS_VAR_OLD
	
	;SetFormat Integer, %RSS_VAR_NEW%
	RSS_VAR_NEW := Format("{:u}",RSS_VAR_NEW)
	;MsgBox, END 1: RSS_VAR_OLD:%RSS_VAR_OLD% RSS_VAR_NEW:%RSS_VAR_NEW%
	
	RSS_VAR_NEW := """" . RSS_VAR_NEW . """"
	
	;MsgBox, END 2: RSS_VAR_OLD:%RSS_VAR_OLD% RSS_VAR_NEW:%RSS_VAR_NEW%
	
	return RSS_VAR_NEW

}

isEmptyOrEmptyStringsOnly(inputArray)
{
	for index, value in inputArray
	{
		if !(value == "")
		{
			return false ;one of the values is not an empty string therefore the array is not empty or empty strings only
		}
	}
	return true ;all the values have passed the test or no values where inside the array
}

; example: Search_Captured_Text_OCR("Wages", {Pos: [115, 30], Size: [560, 75], Timeout: 8}) 
Search_Captured_Text_OCR(Search_Text_Array, Options := "") ; long version
{
	if (isEmptyOrEmptyStringsOnly(Search_Text_Array))
	{
		Timeout := 8
		goto Search_Captured_Text_MessageBox
	}
	
	OCR_Capture_X := (Options.HasKey("Pos")) ? Options.Pos[1] : "115"
	OCR_Capture_Y := (Options.HasKey("Pos")) ? Options.Pos[2] : "30"
	OCR_Capture_W := (Options.HasKey("Size")) ? Options.Size[1] : "560"
	OCR_Capture_H := (Options.HasKey("Size")) ? Options.Size[2] : "75"
	Timeout := (Options.HasKey("Timeout")) ? Options.Timeout : "8"
	OCR_X1 := OCR_Capture_X
	OCR_Y1 := OCR_Capture_Y
	OCR_X2 := (OCR_Capture_X + OCR_Capture_W)
	OCR_Y2 := (OCR_Capture_Y + OCR_Capture_H)
	
	Search_Captured_Text_Begin:
	ClipSaved := ClipboardAll
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
	;Gosub Capture2Text_CLI
	;Gosub Capture2Text_EXE
	Capture_Screen_Text := OCR([OCR_Capture_X, OCR_Capture_Y, OCR_Capture_W, OCR_Capture_H], "eng")
	For index, value in Search_Text_Array
	{	
		;MsgBox, index:%index% value:%value% Capture_Screen_Text:%Capture_Screen_Text%
		if !( value == "" ) 
		{
			;MsgBox, Found index:%index% value:%value% Capture_Screen_Text:%Capture_Screen_Text%
			If (RegExMatch(Capture_Screen_Text,value))
				return 1
		}
		;else
			;MsgBox, NOTFound index:%index% value:%value% Capture_Screen_Text:%Capture_Screen_Text%
	}
	Goto Search_Captured_Text_END
	
	Capture2Text_CLI:
	{
		Capture2TextRUN := Capture2TextPATH . Capture2TextCLI
		Capture_Screen_Text := Clipboard := ""
		Capture2Text_Coords := """" . OCR_X1 . " " . OCR_Y1 . " " . OCR_X2 . " " . OCR_Y2 . """"
		
		Process, Exist, %Capture2TextCLI% ; check to see if running
		If (ErrorLevel != 0) ; If is running, close
			Process, Close, %ErrorLevel%	
		
		; full_command := "%Capture2TextRUN% --screen-rect %Capture2Text_Coords% --clipboard"
		full_command := Capture2TextRUN . " --screen-rect " . Capture2Text_Coords . "  --clipboard"
		; full_command := Capture2TextRUN . " --screen-rect " . Capture2Text_Coords
		
		Capture_Screen_Text := % RunWaitOne(full_command)
		; RunWait, %comspec% /c %full_command%, , hide
		;msgbox, 1. %ErrorLevel%: Capture_Screen_Text:"%Capture_Screen_Text%" Clipboard:"%Clipboard%"

		;DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
		Capture_Screen_Text := Clipboard
		
		;msgbox, 2. %ErrorLevel%: Capture_Screen_Text:"%Capture_Screen_Text%" Clipboard:"%Clipboard%"
	
		;Capture_Screen_Text := RunWaitOne(full_command)		
		;msgbox, 2. Capture_Screen_Text:"%Capture_Screen_Text%" Clipboard:"%Clipboard%"
		;Capture_Screen_Text := Clipboard
		
		; MsgBox, runwait, %comspec% /c %full_command%		
		return
	}
	
	Capture2Text_EXE_old:
	{		
		Capture2TextRUN := Capture2TextPATH . Capture2TextEXE
		Capture_Screen_Text :=
		Process, Exist, %Capture2TextEXE% ; check to see if running
		If (ErrorLevel = 0) ; If not running
			RunNoWaitOne(Capture2TextRUN)
			
		;MsgBox, ErrorLevel:%ErrorLevel% RunNoWaitOne(%Capture2TextRUN%)
			
		; 1. Position your mouse pointer at the top-left corner of the text that you want to OCR.
		SendEvent {Click, %OCR_X1%, %OCR_Y1%, 0}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))

		; 2. Press the OCR hotkey (Windows Key + Q) to begin an OCR capture.
		; SendEvent, ^!Q
		; Text_To_Screen("^!Q")
		Text_To_Screen("^!Q")
		; Control, EditPaste, ^!Q, Qt5QWindowIcon38, LEWZ001
		; ControlSetText, Qt5QWindowIcon38, ^!Q, LEWZ001
			
		; 3. Move your mouse to resize the blue capture box over the text that you want to OCR. You may hold down the right mouse button and drag to move the entire capture box.
		;SendEvent {Click, Down}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		SendEvent {Click, %OCR_X2%, %OCR_Y2% Left, 1}
		DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
		;SendEvent {Click, Up}
		;DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))

		; 4. Press the OCR hotkey again (or left-click or press ENTER) to complete the OCR capture. The OCR'd text will be placed in the clipboard and a popup showing the captured text will appear (the popup may be disabled in the settings).
		; SendEvent, #Q
		;Text_To_Screen("#Q")
		;SendEvent, {Enter}
		;DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
				
		Capture_Screen_Text := %Clipboard%			
		; msgbox, 1. Capture_Screen_Text:"%Capture_Screen_Text%" Clipboard:"%Clipboard%"
		return
	}
	
	Capture2Text_EXE:
	{		
		Capture2TextRUN := Capture2TextPATH . Capture2TextEXE
		Process, Exist, %Capture2TextEXE% ; check to see if running
		If (ErrorLevel = 0) ; If not running
		{
			Run, %Capture2TextRUN%,,, PID
			; RunNoWaitOne(Capture2TextRUN)
			WinWait, ahk_pid %PID%  ; Wait for it to appear.
		}
			
			
		;Gosub Capture2Text_ControlSend
		;Gosub Capture2Text_Control
		;Gosub Capture2Text_ControlSetText
		Gosub Capture2Text_Send
		return
		
		Capture2Text_ControlSend:
		{
			Gosub, Move_Mouse_Start
			
			Sub_Name := "Capture2Text_ControlSend"
			Text_To_Screen("^!Q")
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
			
			Gosub, Move_Mouse_Finish
			Return
		}

		Capture2Text_Control:
		{
			Gosub, Move_Mouse_Start
			
			Sub_Name := "Capture2Text_Control"
			Control, EditPaste, ^!Q, Qt5QWindowIcon38, LEWZ001
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
			
			Gosub, Move_Mouse_Finish
			Return
		}

		Capture2Text_ControlSetText:
		{
			Gosub, Move_Mouse_Start
			
			Sub_Name := "Capture2Text_ControlSetText"
			ControlSetText, Qt5QWindowIcon38, ^!Q, LEWZ001
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
			
			Gosub, Move_Mouse_Finish
			Return
		}
		
		Capture2Text_Send_old:
		{
			Gosub, Move_Mouse_Start
			
			Sub_Name := "Capture2Text_Send"			
			Text_To_Screen("{Control Down}{Alt Down}")
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Text_To_Screen("{q}")
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Micro))
			Text_To_Screen("{Alt Up}{Control Up}")
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
			
			Gosub, Move_Mouse_Finish
			Return
		}
		
		Capture2Text_Send:
		{
			Sub_Name := "Capture2Text_Send"	
			Capture_Screen_Text := 
			clipboard := ""
			; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			MsgBox, 0, , (%OCR_X1%:%OCR_Y1%) to (%OCR_X2%:%OCR_Y2%)
			SendEvent {Click, %OCR_X1%, %OCR_Y1%, 0}
					
			Gosub Control_Alt_Q
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
			SendEvent {Click, %OCR_X2%, %OCR_Y2%)
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
			Gosub Control_Alt_Q
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
			ClipWait, 3
			Capture_Screen_Text := clipboard
			MsgBox, 0, , Sub_Name:%Sub_Name% Capture_Screen_Text:"%Capture_Screen_Text%" ClipBoard:"%ClipBoard%"
			Return
		}
		
		Control_Alt_Q:
		{		
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
			Text_To_Screen("{Control Down}{Alt Down}")
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
			Text_To_Screen("{q}")
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Short))
			Text_To_Screen("{Alt Up}{Control Up}")
			DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
			Return
		}

		Move_Mouse_Start:
		{
			Capture_Screen_Text := 
			clipboard := ""
			WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			SendEvent {Click, %OCR_X1%, %OCR_Y1%, 0}
			Return
		}
			
		Move_Mouse_Finish:
		{
			;Click, %OCR_X2%, %OCR_Y2% Left, 1
			;DllCall("Sleep","UInt",rand_wait + (1*Delay_Long))
			ClipWait, 3
			Capture_Screen_Text := clipboard
			MsgBox, 0, , Sub_Name:%Sub_Name% Capture_Screen_Text:"%Capture_Screen_Text%" ClipBoard:"%ClipBoard%"
			; Click, %OCR_X1%, %OCR_Y1%, 0
			Return
		}
		return
	}


	Search_Captured_Text_Begin_old:
	For index, value in Search_Text_Array
	{
		; MsgBox, index:%index% value:%value% Capture_Screen_Text:%Capture_Screen_Text%
		if !(value == "")
		{
			WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
			Capture_Screen_Text := OCR([OCR_Capture_X, OCR_Capture_Y, OCR_Capture_W, OCR_Capture_H], "eng")
			; MsgBox, index:%index% value:%value% Capture_Screen_Text:%Capture_Screen_Text%
			If (RegExMatch(Capture_Screen_Text,value))
				return 1
		}
	}
	Goto Search_Captured_Text_END
	
	Search_Captured_Text_END:
	Clipboard := ClipSaved
	ClipSaved := ""
	
	if (Timeout = 0)
		return 0

	Search_Captured_Text_MessageBox:
	MsgBox, 4, , %Search_Captured_Text% not detected`, try again? (%Timeout% Second Timeout & skip), %Timeout%
	vRet := MsgBoxGetResult()
	if (vRet = "Timeout") || if (vRet = "No")
		return 0
	if (vRet = "Yes")
		goto Search_Captured_Text_Begin
		
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return 0
}

GetRandom(p_Input,p_Delim="",p_Omit="")
{
	StringSplit, loc_Array, p_Input, %p_Delim%, %p_Omit%
	If ( loc_Array0 < 2 )
		Return loc_Array1
	Random, loc_Rand, 1, %loc_Array0%
	Return loc_Array%loc_Rand%
}

MsgBoxGetResult()
{
	Loop, Parse, % "Timeout,OK,Cancel,Yes,No,Abort,Ignore,Retry,Continue,TryAgain", % ","
		IfMsgBox, % vResult := A_LoopField
			break
	return vResult
}

Elivate_program:
{
	Subroutine_Running := "Elivate_program"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	stdout.WriteLine(A_Now " Elivate_program, " image_name " Main_Loop_Counter: " Main_Loop_Counter " Restart_Loops: " Restart_Loops " Reset_App_Yes: " Reset_App_Yes)

	; PERC := Chr(37)
	; wmic process where "Name like '%PERC%MEmu%PERC%' OR Name like '%PERC%MEmu%PERC%'" CALL setpriority "above normal"
	; wmic process where "Name like '`%MEmu`%' OR Name like '`%MEmu`%'" CALL setpriority "above normal"
	; wmic process where "Name like '`%MEmu`%' OR Name like '`%MEmu`%'" CALL setpriority 128
	commands=
	(join&
	wmic process where "Name like '`%MEmu`%' OR Name like '`%MEmu`%'" CALL setpriority 128
	)
	runwait, %comspec% /c %commands%
	; run .\tools\Time_Sync.bat
	; exitapp

	cmdWindow := "C:\Program Files\AutoHotkey\AutoHotkey.exe"

	loop
	{
		WinWait, %cmdWindow%, , 0
		if ErrorLevel = 0
		{
			WinMinimize ; Minimize the window found by WinWait.
			break
		}
	}

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

Get_Window_Geometry:
{
	Subroutine_Running := "Get_Window_Geometry"
	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,Start time:`,%A_NOW%`r`n, %AppendCSVFile%
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	stdout.WriteLine(A_Now " Get_Window_Geometry, " image_name " Main_Loop_Counter: " Main_Loop_Counter " Restart_Loops: " Restart_Loops " Reset_App_Yes: " Reset_App_Yes)
	WinGetPos, FoundAppX, FoundAppY, FoundAppWidth, FoundAppHeight, %FoundAppTitle%
	UpperX := FoundAppX
	UpperY := FoundAppY
	WinWidth := FoundAppWidth ; initialize Width of app window
	WinHeight := FoundAppHeight ; initialize Height of app window
	LowerX := FoundAppWidth + UpperX ; compute lower right X coord of app window
	LowerY := FoundAppHeight + UpperY ; compute lower right X coord of app window
	; MsgBox, %FoundAppTitle% Upper: %FoundAppX%, %FoundAppY% %FoundAppWidth%x%FoundAppHeight% Lower: %LowerX%, %LowerY%
	stdout.WriteLine(A_Now " Found App info: (X,Y) " FoundAppX ", " FoundAppY " " FoundAppWidth "x" FoundAppHeight " Title: " FoundAppTitle)
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
	If WinExist(FoundAppTitle)
		WinActivate ; Automatically uses the window found above.

	; stdout.WriteLine(A_Now " Inside Check_Window_Geometry, image_name: " image_name)

	WinGetPos, FoundAppX, FoundAppY, FoundAppWidth, FoundAppHeight, %FoundAppTitle%
	stdout.WriteLine(A_Now " Found App info: (X,Y) " FoundAppX ", " FoundAppY " " FoundAppWidth "x" FoundAppHeight " Title: " FoundAppTitle)

	if FoundAppX = App_Window_X
		if FoundAppY = App_Window_Y
			if FoundAppWidth = App_Window_Width
				if FoundAppHeight = App_Window_Height
					return

	; Changes the position and/or size of the specified window.
	; WinMove, X, Y
	; WinMove, FoundAppTitle, WinText, X, Y [, Width, Height, ExcludeTitle, ExcludeText]
	if FoundAppTitle contains MEmu
		WinMove, %FoundAppTitle%, , App_Window_X, App_Window_Y, MEmu_Window_Width, MEmu_Window_Height ; Move the window to the top left corner.
	else
		WinMove, %FoundAppTitle%, , App_Window_X, App_Window_Y, App_Window_Width, App_Window_Height ; Move the window to the top left corner.
	; MsgBox, %FoundAppTitle% Upper: %FoundAppX%, %FoundAppY% %FoundAppWidth%x%FoundAppHeight% Lower: %LowerX%, %LowerY%

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return

	MEmu_Operation_Recorder_X := App_Window_X
	MEmu_Operation_Recorder_Y := (App_Window_Y+App_Window_Height+1)

	IfWinNotExist, MEmu
	{
		IfWinNotExist, %Operation_Recorder_Window%
		{
			MsgBox, 3, , Please open Operation Recorder. Try auto launch?
			IfMsgBox Yes
			{
				WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
				SendEvent {Click, 338, 14} ; Click MEmu App header
				DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))

				;WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
				SendEvent {Click, 708, 384} ; Click to expand More menu
				DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))

				;WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
				SendEvent {Click, 631, 382} ; Click Operations Recorder
				DllCall("Sleep","UInt",rand_wait + (2*Delay_Long))
			}

			MsgBox, Click to expand More menu --> Click Operations Recorder

			loop, 10
			{
				WinWait, MEmu, , 0
				if ErrorLevel = 0
					goto Operation_Recorder_Position

				WinWait, %Operation_Recorder_Window%, , 0
				if ErrorLevel = 0
					goto Operation_Recorder_Position
			}
		}
	}

	Operation_Recorder_Position:
	; MsgBox, Operation_Recorder_Window = %Operation_Recorder_Window%, FoundAppTitle = %FoundAppTitle%
	IfWinExist, MEmu
	{
		WinActivate, MEmu
		WinSetTitle, %Operation_Recorder_Window%
		goto Operation_Recorder_Position
	}

	; MsgBox, Operation_Recorder_Window = %Operation_Recorder_Window%, FoundAppTitle = %FoundAppTitle%

	IfWinExist, %Operation_Recorder_Window%
	{
		WinActivate, %Operation_Recorder_Window% ; The above "IfWinNotExist" also set the "last found" window for us.
		WinMove, %Operation_Recorder_Window%, , FoundAppX, MEmu_Operation_Recorder_Y ; Move it to a new position.
	}

	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

;click in the middle of the screen
Click_Middle_Screen:
{
	Subroutine_Running := "Click_Middle_Screen"
	FoundPictureX := (LowerX-UpperX)/2+UpperX
	FoundPictureY := (LowerY-UpperY)/2+(UpperY-100)
	Mouse_Click(FoundPictureX,FoundPictureY)
}

RunWaitOne(command) {
    ; WshShell object: http://msdn.microsoft.com/en-us/library/aew9yb99
    shell := ComObjCreate("WScript.Shell")
    ; Execute a single command via cmd.exe
    exec := shell.Exec(ComSpec " /C " command)
    ; Read and return the command's output
    return exec.StdOut.ReadAll()
}

RunNoWaitOne(command) 
{
    Run, %command%
    return
}

RunWaitMany(commands) {
    shell := ComObjCreate("WScript.Shell")
    ; Open cmd.exe with echoing of commands disabled
    exec := shell.Exec(ComSpec " /Q /K echo off")
    ; Send the commands to execute, separated by newline
    exec.StdIn.WriteLine(commands "`nexit")  ; Always exit at the end!
    ; Read and return the output of all commands
    return exec.StdOut.ReadAll()
}

/*
Click_Wait:
{
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; MsgBox, Click_Wait
	Random, rand_pixel, %Min_Pix%, %Max_Pix%
	X_Pixel := FoundPictureX + rand_pixel + X_Pixel_offset
	Y_Pixel := FoundPictureY + rand_pixel + Y_Pixel_offset
	; SendEvent {Click, %X_Pixel%, %Y_Pixel%} ; Where to click
	
	; ControlClick, Control-or-Pos, WinTitle, WinText, WhichButton, ClickCount, Options, ExcludeTitle, ExcludeText
	ControlClick, x%X_Pixel% y%Y_Pixel%, %FoundAppTitle%,,,, Pos NA
	

	; generate a new random number between %rand_min% and %rand_max%
	Random, rand_wait, %rand_min%, %rand_max%
	; DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))
	DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))

	if GUI_Count++>13
	{
		Gui, Status:new, , Status
		Gui, Status:Margin, 0, 0
		Gui, Status:add,text,, Account %User_Name%
		Gui, Status:add,text,, Routine: %Routine_Running%
		Gui, Status:show, x731 y0 w300 h500
		GUI_Count := 0
	}

	if (Subroutine_Running = Last_Subroutine_Running)
	{
		; MsgBox, if equal: GUI_Count: %GUI_Count%, Subroutine_Running:%Subroutine_Running%, Last_Subroutine_Running: %Last_Subroutine_Running%
		GUI_Count--
	}
	Else
	{
		; MsgBox, else: GUI_Count: %GUI_Count%, Subroutine_Running:%Subroutine_Running%, Last_Subroutine_Running: %Last_Subroutine_Running%
		Last_Subroutine_Running := Subroutine_Running

		; Gui, Status:add,text,, Click %image_name%
		; Gui, Status:add,text,, Click %X_Pixel%, %Y_Pixel%

		Gui, Status:add,text,, %Subroutine_Running% Running
		Gui, Status:show, x731 y0 w300 h500
	}

	stdout.WriteLine(A_Now " Executing Click_Wait for FoundAppTitle " FoundAppTitle " Subroutine " Subroutine_Running " at " FoundPictureX "," FoundPictureY " (X,Y_Pixel: " X_Pixel "," Y_Pixel ") (rand_pixel: " rand_pixel ") (X,Y_Pixel_offset:" X_Pixel_offset "," Y_Pixel_offset ")" )

	; stdout.WriteLine(A_Now " Found " image_name " at " FoundPictureX "," FoundPictureY)

	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

; examples: Mouse_Click(155,299, {Clicks: 2, Timeout: 300})
; Mouse_Click(100,1000, {Clicks: 2, Timeout: 0}) ; Click On Donation Box 1
Mouse_Click(X,Y, Options := "")
{
	; generate a new random number between %rand_min% and %rand_max%
	Random, rand_wait, %rand_min%, %rand_max%

	Clicks := (Options.HasKey("Clicks")) ? Options.Clicks : "1"
	Timeout := (Options.HasKey("Timeout")) ? Options.Timeout : (rand_wait + (5*Delay_Short))
	; ; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	;MsgBox, Timeout:"%Timeout%", Clicks:"%Clicks%"

	Random, rand_pixel, %Min_Pix%, %Max_Pix%
	;MsgBox, 1. Mouse_Click input:(%X%:%Y%) initial:(%X_Pixel%:%Y_Pixel%) Rand_pixel:%rand_pixel% min-max(%Min_Pix%-%Max_Pix%)
	X_Pixel := (X + rand_pixel + X_Pixel_offset)
	Y_Pixel := (Y + rand_pixel + Y_Pixel_offset)
	; SendEvent {Click, %X_Pixel%, %Y_Pixel%} ; Where to click
	;MsgBox, 3. Mouse_Click input:(%X%:%Y%) incremented:(%X_Pixel%:%Y_Pixel%) Rand_pixel:%rand_pixel% min-max(%Min_Pix%-%Max_Pix%)

	; ControlClick, Control-or-Pos, WinTitle, WinText, WhichButton, ClickCount, Options, ExcludeTitle, ExcludeText
	; ControlClick, x%X_Pixel% y%Y_Pixel%, %FoundAppTitle%,,,, Pos NA
	;ControlClick, Qt5QWindowIcon25, %FoundAppTitle%,, Left, 1, x%X_Pixel% y%Y_Pixel% NA
	;ControlClick, Qt5QWindowIcon25, LEWZ001,,,, x%X_Pixel% y%Y_Pixel% NA

	; ; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	SetControlDelay -1
	ControlClick, Qt5QWindowIcon25, %FoundAppTitle%,,,%Clicks%, x%X_Pixel% y%Y_Pixel% NA
	;ControlClick,, %FoundAppTitle%,,,%Clicks%, x%X_Pixel% y%Y_Pixel% NA
	DllCall("Sleep","UInt",Timeout)

	; MsgBox, Mouse_Click input:(%X%:%Y%) math:(%X_Pixel%:%Y_Pixel%) Rand_pixel:%rand_pixel% min-max(%Min_Pix%-%Max_Pix%) Clicks:"%Clicks%" Timeout:"%Timeout%"

	; DllCall("Sleep","UInt",rand_wait + (3*Delay_Short))

	if GUI_Count++>13
	{
		Gui, Status:new, , Status
		Gui, Status:Margin, 0, 0
		Gui, Status:add,text,, Account %User_Name%
		Gui, Status:add,text,, Routine: %Routine_Running%
		Gui, Status:show, x731 y0 w300 h500
		GUI_Count := 0
	}

	if (Subroutine_Running = Last_Subroutine_Running)
	{
		; MsgBox, if equal: GUI_Count: %GUI_Count%, Subroutine_Running:%Subroutine_Running%, Last_Subroutine_Running: %Last_Subroutine_Running%
		GUI_Count--
	}
	Else
	{
		; MsgBox, else: GUI_Count: %GUI_Count%, Subroutine_Running:%Subroutine_Running%, Last_Subroutine_Running: %Last_Subroutine_Running%
		Last_Subroutine_Running := Subroutine_Running

		; Gui, Status:add,text,, Click %image_name%
		; Gui, Status:add,text,, Click %X_Pixel%, %Y_Pixel%

		Gui, Status:add,text,, %Subroutine_Running% Running
		Gui, Status:show, x731 y0 w300 h500
	}

	stdout.WriteLine(A_Now " Executing Mouse_Click for FoundAppTitle " FoundAppTitle " Subroutine " Subroutine_Running " at " FoundPictureX "," FoundPictureY " (X,Y_Pixel: " X_Pixel "," Y_Pixel ") (rand_pixel: " rand_pixel ") (X,Y_Pixel_offset:" X_Pixel_offset "," Y_Pixel_offset ")" )

	; stdout.WriteLine(A_Now " Found " image_name " at " FoundPictureX "," FoundPictureY)

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

*/

; ****************************************************************************
; ****************************************************************************
; Function Parameters-Return Values
; ****************************************************************************
; examples:
; InputBox1("Title", "User Prompt", {Hide: False|True, Size: [600, 300], Pos: [700, 1000], Timeout: 10, Default: "Type here"})
; or
; MsgBox, 0, password, % "user_password " InputBox1("InputBox1.1"`, "Please input your password."`, {Hide:True,Size:[300,200],Pos:[700,1000],Timeout:10,Default:"Type here"})
; MsgBox, 0, password, user_password %user_password%
; or
; user_password := InputBox1("InputBox1.2", "Please input your password.", {Hide: False, Size: [600, 300], Pos: [700, 1000], Timeout: 10, Default: "password"})
; MsgBox, 0, password, user_password %user_password%
; ****************************************************************************
InputBox1(Title, Prompt, Options := "") ; long version
{
	HIDE := (Options.HasKey("Hide") && Options.Hide = True) ? "HIDE" : ""
	Width := (Options.HasKey("Size")) ? Options.Size[1] : ""
	Height := (Options.HasKey("Size")) ? Options.Size[2] : ""
	X := (Options.HasKey("Pos")) ? Options.Pos[1] : ""
	Y := (Options.HasKey("Pos")) ? Options.Pos[2] : ""
	Locale := (Options.HasKey("Locale")) ? Options.Locale : ""
	Timeout := (Options.HasKey("Timeout")) ? Options.Timeout : ""
	Default := (Options.HasKey("Default")) ? Options.Default : ""
	InputBox, Out, % Title, % Prompt, % HIDE, % Width, % Height, % X, % Y, , % Timeout, % Default
	Return Out
}

; ****************************************************************************
; ****************************************************************************
; Function Parameters-Return Values - more Straightforward!
; ****************************************************************************
; example:
; InputBox2("Title", "User Prompt", {Input:"Show|Hide", Width:300, Height:150, x:700, y:1000, Timeout: 10, Default:"Type here"})
; or
; user_password := InputBox2("InputBox2.1", "Please input your password.", {Input:"Show", Width:300, Height:150, x:700, y:1000, Timeout: 10, Default:"Type here"})
; MsgBox, 0, password, user_password %user_password%
; ****************************************************************************
InputBox2(Title, Prompt, o := "")
{
	InputBox, Out, % Title, % Prompt, % o["Input"], % o["Width"], % o["Height"], % o["X"], % o["Y"], , % o["Timeout"], % o["Default"]
	Return Out
}

; ****************************************************************************
; ****************************************************************************
; allow users to use objects with the function and return the data they want.
; ****************************************************************************
; Examples:
; Data := MouseGetPos()
; MsgBox, 0, MouseGetPos, % " MouseGetPos " Data.X " " Data.Y " " Data.Win " " Data.Ctrl
; or
; MsgBox, 0, MouseGetPos, % " MouseGetPos.X " MouseGetPos().X " MouseGetPos.Y " MouseGetPos().Y
; ****************************************************************************
MouseGetPos(Options := 3)
{
	MouseGetPos, X, Y, Win, Ctrl, % Options
	Return {X: X, Y: Y, Win: Win, Ctrl: Ctrl}
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

Key_Menu:
{
	Gui, Keys:New, , Keys
	Gui, Keys:Margin, 0, 0
	Gui, Keys:add,text,, F3 Quick Collect
	Gui, Keys:add,text,, F4 Exit Script
	Gui, Keys:add,text,, F5 Reload MEmu
	Gui, Keys:add,text,, F6 Reload Script
	; Gui, Keys:add,text,, F7 Reset_Posit = %Resetting_Posit% ; or (%Resetting_Posit% ? "True" : "False")
	Gui, Keys:add,text,, % "F7 Reset_Posit = " (Resetting_Posit ? "Yes" : "No")
	Gui, Keys:add,text,, % "Pause Script = " (A_IsPaused ? "Yes" : "No")
	Gui, Keys:show, x731 y700 w150 h250

	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

F6::
Reload_Script:
{
	Subroutine_Running := "Reload_Script"
	Gui, Status:new, , Status
	Gui, Status:Margin, 0, 0
	Gui, Status:add,text,, Script reloading... Loop %Main_Loop_Counter%
	Gui, Status:show, x731 y0 w300 h500
	Reload
	Random, rand_wait, %rand_min%, %rand_max%
	DllCall("Sleep","UInt",rand_wait + (8*Delay_Short)) ; If successful, the reload will close this instance during the Sleep, so the line below will never be reached.
	MsgBox, 4,, The script could not be reloaded. Would you like to open it for editing?
	IfMsgBox, Yes, Edit

	; FileAppend, %A_NOW%`,A_ThisLabel`,%A_ThisLabel%`,Subroutine`,%Subroutine_Running%`,End time:`,%A_NOW%`r`n, %AppendCSVFile%
	return
}

F7::
	Resetting_Posit := True
	Gosub Key_Menu
	Gosub Reset_Posit
	Resetting_Posit := False
	Gosub Key_Menu
return

Check_AppWindows_Timer:
	Gosub Get_Window_Geometry
	Gosub Check_Window_Geometry
	Gosub Key_Menu
	WinActivate, %FoundAppTitle% ; Automatically uses the window found above.
return
