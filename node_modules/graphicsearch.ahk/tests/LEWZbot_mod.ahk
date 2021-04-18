	
#Include D:\Users\CowNi\Documents\GitHub\LEWZbot\graphicsearch.ahk\export.ahk
#Include D:\Users\CowNi\Documents\GitHub\LEWZbot\node_modules
#Include D:\Users\CowNi\Documents\GitHub\LEWZbot\unit-testing.ahk\export.ahk
#Include json.ahk\export.ahk

#NoTrayIcon
#NoEnv
#SingleInstance, force
SetBatchLines, -1

oGraphicSearch := new graphicsearch()
assert := new unittesting()
; A := new biga()

; this testing should be performed with image.png open

; variables
Button_RewardsGraphic :="|<Button_Rewards>**50$47.0s000001wM000003wlyQSDDwBjywyyzsPsD9Bj0lrbCSPQQzCTCwSvw0xyRutTs3s0tZqw7ak1nNhU9bjzouSTHDQtXkhqXCTt6XPx7SSnBanW6S1an8kI"

Button_RequestGraphic := "|<Button_Request>**50$44.0M00000Dn000003Sny7zj7VhtnnvlsPk7k2YHQxxtwd4yCPCP+F0DbngmYHnM0nAd4wqTwn+F9bjzAmYGNtbvgdgXCTyT+T8Plbn2l26T3i4i4U"

Button_HelpGraphic := "|<Button_Help>**50$43.Y6k0AU0G3M06E091gDn/zYUqTxZzyEPQ7mU7DxgttFlY4wywdwk0SzCIXNzj07+FgUrU3Z8mEPrzmYP8BvbNGBY6wzwdwm3PDSIQN1hkD+0Q"

centerPoint :=  "|<center>*193$17.zzzzzzzzzzzzzzzzzzzzzzzzzzzzjzzTzwzztzzXzy3zU1s0E"
centerObj := {"x": 1328, "y": 752}

; Perform the searches
sleep, 400
result1 := oGraphicSearch.search(Button_RewardsGraphic)
result2 := oGraphicSearch.scan(Button_RequestGraphic, 0, 0, A_ScreenWidth, A_ScreenHeight, 0, 0)
resultlegacyfind := oGraphicSearch.find(0, 0, A_ScreenWidth, A_ScreenHeight, 0, 0, Button_RequestGraphic)


searchAgainResults := oGraphicSearch.searchAgain()
scanAgainResults := oGraphicSearch.scanAgain()
scanAgainResults2 := oGraphicSearch.scanAgain(,,,10000000000000,100000000000)

threeResults := oGraphicSearch.search(Button_RewardsGraphic Button_RequestGraphic Button_HelpGraphic)

assert.test(searchAgainResults, result1)
assert.test(scanAgainResults, result2)
assert.test(scanAgainResults2, result2)
if (result1) {
	; test number of results
	assert.label("search")
	assert.test(result1.Count(), 5)
	assert.test(result2.Count(), 2)

	; test three searches combined
	assert.label("multiple searches combined")
	assert.test(threeResults.Count(), 8)
	assert.test(threeResults[1].id, "Button_Rewards")
	assert.test(threeResults[2].id, "Button_Rewards")
	assert.test(threeResults[3].id, "Button_Rewards")
	assert.test(threeResults[4].id, "Button_Rewards")
	assert.test(threeResults[5].id, "Button_Rewards")
	assert.test(threeResults[6].id, "Button_Request")
	assert.test(threeResults[7].id, "Button_Request")
	assert.test(threeResults[8].id, "Button_Help")

	assert.label("find")
	assert.test(result2, resultlegacyfind)

	; test resultSort
	assert.label("resultSort")
	sortedCoords := oGraphicSearch.resultSort(result1)
	assert.test(sortedCoords.Count(), 5)
	assert.test(sortedCoords[5].id, "Button_Rewards")
	; assert.test(sortedCoords, [{1:1215,2:407,3:22,4:10,"id":"Button_Rewards","x":1226,"y":412},{1:1457,2:815,3:22,4:10,"id":"Button_Rewards","x":1468,"y":820},{1:852,2:891,3:22,4:10,"id":"Button_Rewards","x":863,"y":896},{1:1565,2:949,3:22,4:10,"id":"Button_Rewards","x":1576,"y":954},{1:1847,2:1261,3:22,4:10,"id":"Button_Rewards","x":1858,"y":1266}])


	; test resultSortDistance
	assert.label("resultSortDistance")
	resultsObj := [ {1: 2000, 2: 2000, 3: 22, 4: 10, "id": "HumanReadableTag", "x" :2000, "y" :2000}
				  , {1: 1215, 2: 407, 3: 22, 4: 10, "id": "HumanReadableTag", "x" :1226, "y" :412}]
	resultsObj := oGraphicSearch.resultSortDistance(resultsObj)
	assert.test(resultsObj[1].distance, "1292.11")
	assert.test(resultsObj[2].distance, "2838.33")
	

	distanceCoords := oGraphicSearch.resultSortDistance(result1, A_ScreenWidth, A_ScreenHeight)
	assert.test(sortedCoords.Count(), 5)
	assert.test(sortedCoords[5].id, "Button_Rewards")
	; assert.test(distanceCoords, [{1:1847,2:1261,3:22,4:10,"distance":"723.24","id":"Button_Rewards","x":1858,"y":1266},{1:1565,2:949,3:22,4:10,"distance":"1097.48","id":"Button_Rewards","x":1576,"y":954},{1:1457,2:815,3:22,4:10,"distance":"1255.73","id":"Button_Rewards","x":1468,"y":820},{1:1215,2:407,3:22,4:10,"distance":"1684.14","id":"Button_Rewards","x":1226,"y":412},{1:852,2:891,3:22,4:10,"distance":"1782.06","id":"Button_Rewards","x":863,"y":896}])

	
	; test some partial argument objects
	assert.label("Argument objects")
	result3 := oGraphicSearch.search(Button_RequestGraphic, {"x2": 100, "y2": 100})
	assert.test(result3, 0)


	; test resultSortDistance with static data
	assert.label("resultSortDistance")
	resultsObj := [ {1: 2000, 2: 2000, 3: 22, 4: 10, id: "HumanReadableTag", x: 2000, y: 2000}
				, {1: 1215, 2: 407, 3: 22, 4: 10, id: "HumanReadableTag", x: 1226, y: 412}]
	resultsObj0 := oGraphicSearch.resultSortDistance(resultsObj)
	assert.test(resultsObj0[1].distance, "1292.11")
	assert.test(resultsObj0[2].distance, "2838.33")

	resultsObj1 := oGraphicSearch.resultSortDistance(resultsObj, 2000, 2000)
	assert.test(resultsObj1[1].distance, "12.08")
	assert.test(resultsObj1[2].distance, "1766.58")



	assert.fullreport()
} else {
	msgbox, "There was no graphic found, testing could not take place"
}
ExitApp
