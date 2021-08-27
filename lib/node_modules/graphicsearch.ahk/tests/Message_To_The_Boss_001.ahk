Jack := {profession: "teacher"
         , height: "tall"
         , country: "USA"
         , city: "New York"}

Paul := {profession: "cook"
         , height: "short"
         , country: "UK"
         , city: "London"}

Bill := {profession: "designer"
         , height: "short"
         , country: "Canada"
         , city: "Toronto"}

Max := {profession: "driver"
        , height: "tall"
        , country: "USA"
        , city: "Dallas"}

Bill := {profession: "policeman"
         , height: "tall"
         , country: "Australia"
         , city: "Canberra"}

Person := {Jack: Jack
           , Paul: Paul
           , Bill: Bill
           , Max: Max
           , Bill: Bill}


MsgBox, % Person.Jack.city





fileDB =
(
Name| DOB| Address| City| Zip
Jake|01/01/2020|123 Main| NY City| 11001
Mike|03/04/2001|30 south| MIAMI |2404
)

Headers := []
Base_Array := []
Loop, parse, LEWZ_User_Logins.ini
{
	if (A_Index = 1)
		Headers := StrSplit(HeadStr:=A_LoopField, "|", " ")
	else if A_LoopField
	{
		obj := new CaseSenseList
		for k, v in StrSplit(A_LoopReadLine, ",")
		{
			cHead := Headers[k]
			obj[cHead] := v
			; MsgBox, % "key: " cHead " val = " v
			; obj.Push(o) ;doesn't work
		}
		; MsgBox, % Obj2Str2(o)
		; obj[A_Index-1] := o
		Base_Array.Push(obj)
	}
}


Base_Array := {}
Loop, Read, LEWZ_User_Logins.ini
{
	row := StrSplit(A_LoopReadLine, ",")
	User_Name_Input := row[1]
	Base_Array[User_Name_Input] := {User_Name_new : row[1], User_Name_old: row[2], User_Email: row[3], User_Pass: row[4], User_PIN: row[5]}
	Base_Array.Push(Value, Value2, ...)
	row.RemoveAt(1)
}





arrayObj := [{"name": "bob", "age": 22}, {"name": "tom", "age": 51}]
arrayObj.map(func("get_name")) 
; => ["bob", "tom"]


Examples:

Retrieve a property:
Value := Base_Array.email

Set a property:
Base_Array.email := Value

Retrieve an item:
Value := Base_Array[email]

Assign an item:
Base_Array[email] := Value

Remove an item using the Delete method:
RemovedValue := Base_Array.Delete(email)


	Base_Array := {}
	User_Name := {}
	
	User_Name := {user_old: User_Name_old, 
	email: User_Email,
	PW: User_Pass,
	PIN: User_PIN,
	email: User_Name_Captured, 
	routine: Routine, 
	location: User_City_Location_Array,
	alliance: User_Found_Alliance,
	state: User_Found_State,
	vip: User_VIP,
	power: User_Power,
	diamonds: User_Diamonds,
	fuel_out: Available_Fuel
	fuel_store: Inventory_Fuel
	food_out: Available_Food
	food_store: Inventory_Food
	steel_out: Available_Steel
	steel_store: Inventory_Steel
	alloy_out: Available_Alloy
	alloy_store: Inventory_Alloy}]
	
	Base_Array.User_Name := User_Name
	Base_Array := {User_Name: User_Name}
	
	Base_Array := [ User_Email: {"user": User_Name, 
	"email": User_Name_Captured, 
	"routine": Routine, 
	"location": User_City_Location_Array,
	"alliance": User_Found_Alliance,
	"state": User_Found_State,
	"vip": User_VIP,
	"power": User_Power,
	"diamonds": User_Diamonds,
	"fuel_out": Available_Fuel
	"fuel_store": Inventory_Fuel
	"food_out": Available_Food
	"food_store": Inventory_Food
	"steel_out": Available_Steel
	"steel_store": Inventory_Steel
	"alloy_out": Available_Alloy
	"alloy_store": Inventory_Alloy}]

				Message_To_The_Boss := User_Name . " " . Routine . " Routine,"
				; if (Routine = "New_Day") || if (Routine = "End_Of_Day")
				Gosub Get_User_Location
				
				if (Routine = "New_Day") || if (Routine = "End_Of_Day")
					Gosub Get_User_Info
					Gosub Get_Inventory
				Gosub Send_Mail_To_Boss
				; Gosub Send_Message_In_Chat

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