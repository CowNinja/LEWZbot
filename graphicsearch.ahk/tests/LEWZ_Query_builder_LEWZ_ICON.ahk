	
#Include D:\Users\CowNi\Documents\GitHub\LEWZbot\graphicsearch.ahk\export.ahk
#Include D:\Users\CowNi\Documents\GitHub\LEWZbot\node_modules
#Include D:\Users\CowNi\Documents\GitHub\LEWZbot\unit-testing.ahk\export.ahk
#Include json.ahk\export.ahk

; #NoTrayIcon
#NoEnv
#SingleInstance, force
SetBatchLines, -1

optionsObj := {   x1: 1
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
				
0_Icon_LEWZ_Graphic := "|<0_Icon_LEWZ>*200$48.Dzzzzzz0DzzzzbzDDzzzzbzDDzjyzbzDDy1sC3zDDwtnbbzDDxtnrjz0Dzxnzjz0Dz1szjzDDw9wDjzDDwxz7jzDDxxzbjzDDxtnrbzD0AFlbbz00C5sDXz0U"
			
oGraphicSearch := new graphicsearch()


; check if any graphic was found
loop
{
	resultObj := oGraphicSearch.search(0_Icon_LEWZ_Graphic, optionsObj)
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


/*Search := new graphicsearch()
allQueries := pizzaGraphic beerGraphic

resultObj := oGraphicSearch.search("|<Pizza>*165$22.03z|<spaghetti>*125$26.z", optionsObj)
; check if more than one graphic was found
if (resultObj.Count() >= 4) {
    ; find the center of the screen by dividing the width and height by 2
    centerX := A_ScreenWidth / 2
    centerY := A_ScreenHeight / 2

    ; create a new result object sorted by distance to the center
    resultObj2 := oGraphicSearch.resultSortDistance(resultObj, centerX, centerY)

    ; click the third closest to the center
    Click, % resultObj2[3].x, resultObj2[3].y
}
*/

F4::ExitApp

Pause:: ; Pressing pause once will pause the script. Pressing it again will unpause.
Pause,,1	; read the documentation on Pause to understand the consequences of this 1. It seems to matter where this hotkey is in the script.
Return
