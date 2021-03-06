	
#Include D:\Users\CowNi\Documents\GitHub\LEWZbot\graphicsearch.ahk\export.ahk
#Include D:\Users\CowNi\Documents\GitHub\LEWZbot\node_modules
#Include D:\Users\CowNi\Documents\GitHub\LEWZbot\unit-testing.ahk\export.ahk
#Include json.ahk\export.ahk

; #NoTrayIcon
#NoEnv
#SingleInstance, force
SetBatchLines, -1

optionsObjAll := {   x1: 1
                , y1: 32
                , x2: 689
                , y2: 1216
                , err1: 0
                , err0: 0
                , screenshot: 1
                , findall: 1}
				
optionsObjOne := {   x1: 1
                , y1: 32
                , x2: 689
                , y2: 1216
                , err1: 0
                , err0: 0
                , screenshot: 1
                , findall: 0}
				
      B350_Depot_Title_Graphic := "|<B350_Depot_Title>**50$58.zzy0000003zzw000000000k0000000030000003yTw0000000NU00000001a1zszs3zU6M6tb1kw7UNUE2k1X061a11yD6My86M4TtyBbMkNUFX6Arsn1a1AAzlTzA6M4klz4TskNUH300HU31a1AA01MTA6M4knzxbwkNUH3A04Mn1a1AAMSF3A6M4klrh7skNUH1XwoD31a1A707M046M4kC0skAM"
      B351_Free_Button_Graphic := "|<B351_Free_Button>*200$38.07zzzznzzzzzxzzzzzzTzzzzzrzUw7w5zsyQwQDyTDjTU3brtrsztwQMwTyT0607zbrzbxztxztzTyTDzDrzbtvllztz1z1U"
      B352_Help_Button_Graphic := "|<B352_Help_Button>*200$41.DwzztzyTtzznzwznzzbztzbwzDsnzDUSS0bySSQww00twtvw01nxnrsznU3bjlzb7zDTXzCTySz7yQzwxyDwwyttsTtslnlUznwDbcTzzzzzTzzzzzyzk"
      B353_Request_Button_Graphic := "|<B353_Request_Button>*200$67.0DzzzzzzzzzbXzzzzzzzzzrwzzzzzzzzzvyTzzzzzzzzxzD0z0SzT1y0zbDDCDTjCSQTbjbDbjrDbD07bvbnrvbnbk7ltntvxk1kvts0twxys0y5wwzwySzQzzszCTyTDTiTzyTbbzDbjbDyTDtlnnXnXnrbbww3w1w1w3s4"
      B354_Reward_Button_Graphic := "|<B354_Reward_Button>*200$68.0Dzzzzzzzzz3lzzzzzzzzzlzDzzzzzzzzwTnzzzzzrzzz7ww3brnkD1k1zCQNswtllssTbjbCDSyQyT03nxnfbzbDjk1w0SmNy1nnwTT07hqyAQwz7nnzvRjDbDDlywzy73ntnvwTbjznswyQyT7wttwyT67DnVzD0zDbs9nw0U"


WinActivate, LEWZ003 ahk_class Qt5QWindowIcon
oGraphicSearch := new graphicsearch()			
allQueries_Example := B352_Help_Button_Graphic B353_Request_Button_Graphic B354_Reward_Button_Graphic

gosub Click_Single_Instance

SendEvent {Click, 340,150} ; Tap Tab 2 My Treasures
gosub Click_ALL_Instances

SendEvent {Click, 570,150} ; Tap Tab 3 Help_List
gosub Click_ALL_Instances

MsgBox, Done ski!
return


Find_Single_Instance()
{
	; Find single occurence of image, return true or false
	oGraphicSearch := new graphicsearch()	
	resultObj := oGraphicSearch.search(B351_Free_Button_Graphic, optionsObjOne)
	if (resultObj)
		return 1
	Else
		return 0
}

Click_Single_Instance:
; Click single occurence of image
loop, 8
{
	oGraphicSearch := new graphicsearch()			
	resultObj := oGraphicSearch.search(B351_Free_Button_Graphic, optionsObjOne)
	if (resultObj)
	{
		Click_X := resultObj[A_Index].x
		Click_Y := resultObj[A_Index].y
		SendEvent {Click, %Click_X%, %Click_Y%}
		; msgbox, % "count:" A_Index "`nx: " Click_X ", y: " Click_Y
	}
}
return

Click_ALL_Instances:
; All occuring images, sort by closest to bottom of App, do it X number of times it loops

loop, 8
{
	resultObj := oGraphicSearch.search(allQueries_Example, optionsObjAll)
	if (resultObj)
	{
		sortedResults := oGraphicSearch.resultSortDistance(resultObj, 300, 1216)
		loop, % sortedResults.Count()
		{
			Click_X := resultObj[A_Index].x
			Click_Y := resultObj[A_Index].y
			SendEvent {Click, %Click_X%, %Click_Y%}
			Sleep, 300
			SendEvent {Click, 320,70} ; Tap top title bar
			; msgbox, % "count:" A_Index "`nx: " Click_X ", y: " Click_Y
		}
	}
}
return

F4::ExitApp

Pause:: ; Pressing pause once will pause the script. Pressing it again will unpause.
Pause,,1	; read the documentation on Pause to understand the consequences of this 1. It seems to matter where this hotkey is in the script.
Return
