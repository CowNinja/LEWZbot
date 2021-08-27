	
#Include D:\Users\CowNi\Documents\GitHub\LEWZbot\graphicsearch.ahk\export.ahk
#Include D:\Users\CowNi\Documents\GitHub\LEWZbot\node_modules
#Include D:\Users\CowNi\Documents\GitHub\LEWZbot\unit-testing.ahk\export.ahk
#Include json.ahk\export.ahk

#NoTrayIcon
#NoEnv
#SingleInstance, force
SetBatchLines, -1

; variables
Button_ExcavationGraphic := "|<Button_Excavation>**50$57.zzU00000060A0000000nzU0000006zzXly3ySDq0yyzwzvlyk6qq1i3m9rynbbbbDPCErBhyxgvPk2QBAzzbCSzlX93z0hqq0AN81U5iqk1X9XdwYaq0NBAzBYpazyRwytwaAnznbbb66l60AqK1g4nMzzyyTszyT4"
Button_HelpGraphic := "|<Button_Help>**50$43.Y6k0AU0G3M06E091gDn/zYUqTxZzyEPQ7mU7DxgttFlY4wywdwk0SzCIXNzj07+FgUrU3Z8mEPrzmYP8BvbNGBY6wzwdwm3PDSIQN1hkD+0Q"
Button_RequestGraphic := "|<Button_Request>**50$44.0M00000Dn000003Sny7zj7VhtnnvlsPk7k2YHQxxtwd4yCPCP+F0DbngmYHnM0nAd4wqTwn+F9bjzAmYGNtbvgdgXCTyT+T8Plbn2l26T3i4i4U"
Button_RewardsGraphic := "|<Button_Rewards>**50$47.0s000001wM000003wlyQSDDwBjywyyzsPsD9Bj0lrbCSPQQzCTCwSvw0xyRutTs3s0tZqw7ak1nNhU9bjzouSTHDQtXkhqXCTt6XPx7SSnBanW6S1an8kI"

oGraphicSearch := new graphicsearch()
allQueries := Button_ExcavationGraphic Button_HelpGraphic Button_RequestGraphic Button_RewardsGraphic
resultObj := oGraphicSearch.search(allQueries)

loop
{
	if (resultObj) {
		loop, % resultObj.Count() {
			Click_X := resultObj[A_Index].x
			Click_Y := resultObj[A_Index].y
			msgbox, % "count:" resultObj.Count() "`nx: " Click_X ", y: " Click_Y
			SendEvent {Click, %Click_X%, %Click_Y%} ; Where to click
		}
	}
}

F4::ExitApp
