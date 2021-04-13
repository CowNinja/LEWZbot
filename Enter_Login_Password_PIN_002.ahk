; Login_Password_PIN_Find() <--> Login_Password_PIN_Taps
; Login_Password_PIN_BruteForce() <--> Login_Password_PIN_Taps

; Login_Password_PIN_Find() returns true if PIN text found, OR false if PIN text not found
Login_Password_PIN_Enter() ; FMR Enter_Login_Password_PIN:
{
	if Login_Password_PIN_Find()
		Login_Password_PIN_Taps()
}

Login_Password_PIN_Find()
{
	; Subroutine_Running := "Login_Password_PIN_Find"
	
	Global Text_Found := True
	RunDependent("Login_Password_PIN_Find.ahk")
	if Text_Found
		return 1 ; true if PIN text found
	Else
		return 0 ; false if PIN text not found
	

	/*
	Search_Captured_Text := ["Enter","login","password"]
	PIN_X := 190
	PIN_Y := 250
	PIN_W := 300
	PIN_H := 50
	OCR_PIN := Search_Captured_Text_OCR(Search_Captured_Text, {Pos: [PIN_X, PIN_Y], Size: [PIN_W, PIN_H]})
	*/
	
	/*	
	; Is PIN text present on Screen?
	;	If true, continue
	; 	If False, return 0
	loop, 2
	{
		OCR_PIN := Search_Captured_Text_OCR(["Enter","login","password"], {Pos: [190, 250], Size: [300, 50]})
		if OCR_PIN.Found
			return 1 ; true if PIN text found
	}
	return 0 ; false if PIN text not found
	*/
}

Login_Password_PIN_Taps() ; FMR Enter_Login_PIN_Dialog:
{
	; tap backspace X times
	loop, 6
		Mouse_Click(577,1213, {Timeout: Delay_Micro+0}) ; Tap backspace
	DllCall("Sleep","UInt",(rand_wait + 1*Delay_Medium+0))

	; Split PIN and tap each corrsponding number
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

Login_Password_PIN_BruteForce(User_PIN_INIT := "000000", Check_After_Loops := 100) ; FMR BruteForcePIN:
{
	; MsgBox, incorrect PIN: %User_PIN%
	loop, 1000000
	{
		User_PIN := (User_PIN_INIT + A_Index)
		; MsgBox, PIN: %User_PIN%

		loop, 5
		if StrLen(User_PIN) < 6
			User_PIN := "0" . User_PIN

		if StrLen(User_PIN) > 6
			User_PIN := "000000"

		; MsgBox, sub:"%Subroutine_Running%" PIN:"%User_PIN%"
		Login_Password_PIN_Taps() ; Login_Password_PIN_Find
		; DllCall("Sleep","UInt",(rand_wait + 1*Delay_Short+0))

		if (Mod(A_Index, %Check_After_Loops%) == 0)
		{
			Subroutine_Running := "User_PIN " . User_PIN
			if !Login_Password_PIN_Find()
			
			Resolved_PIN_Range := (User_PIN-Check_After_Loops)
			stdout.WriteLine(A_NowUTC " PIN discovered for account:" User_Email " Range:" Resolved_PIN_Range " and " User_PIN )
			
			MsgBox, 3, , % " PIN discovered for account:" User_Email " Range:" Resolved_PIN_Range " and " User_PIN "`nDid " User_PIN " work? (10 second Timeout & auto)",10
				vRet := MsgBoxGetResult()
				if (vRet = "Yes")
					break			
		}
	}

	PIN_Start := (User_PIN-100)
	MsgBox, correct PIN between: %PIN_Start% and %User_PIN%
	return
}
