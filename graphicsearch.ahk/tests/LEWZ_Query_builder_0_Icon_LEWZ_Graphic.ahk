	
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
                , findall: 1
                , joinqueries: 1
                , offsetx: 1
                , offsety: 1 }
				
optionsObjOne := {   x1: 1
                , y1: 32
                , x2: 689
                , y2: 1216
                , err1: 0
                , err0: 0
                , screenshot: 1
                , findall: 0
                , joinqueries: 1
                , offsetx: 1
                , offsety: 1 }
				
0_Icon_LEWZ_Graphic := "|<0_Icon_LEWZ>*200$48.Dzzzzzz0DzzzzbzDDzzzzbzDDzjyzbzDDy1sC3zDDwtnbbzDDxtnrjz0Dzxnzjz0Dz1szjzDDw9wDjzDDwxz7jzDDxxzbjzDDxtnrbzD0AFlbbz00C5sDXz0U"
			
oGraphicSearch := new graphicsearch()
allQueries := 0_Icon_LEWZ_Graphic


; check if any graphic was found
loop
{
	resultObj := oGraphicSearch.search(allQueries, optionsObj)
	if (resultObj)
	{
		loop, % resultObj.Count()
		{
			Click_X := resultObj[A_Index].x
			Click_Y := resultObj[A_Index].y
			SendEvent {Click, %Click_X%, %Click_Y%}
			msgbox, % "count:" A_Index "`nx: " Click_X ", y: " Click_Y
		}
	}
}
return

F4::ExitApp

Pause:: ; Pressing pause once will pause the script. Pressing it again will unpause.
Pause,,1	; read the documentation on Pause to understand the consequences of this 1. It seems to matter where this hotkey is in the script.
Return
