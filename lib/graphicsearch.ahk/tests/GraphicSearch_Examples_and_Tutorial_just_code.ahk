; In your code:

#Include %A_ScriptDir%\node_modules
#Include graphicsearch.ahk\export.ahk

oGraphicSearch := new graphicsearch()
result := oGraphicSearch.search("|<HumanReadableTag>*165$22.03z")
; => [{1: 1215, 2: 407, 3: 22, 4: 10, id: "HumanReadableTag", x: 1226, y: 412}]

; In the first example, we search for an image and click on it.

oGraphicSearch := new graphicsearch()

resultObj := oGraphicSearch.search("|<Pizza>*165$22.03z")
; check if any graphic was found
if (resultObj) {
    ; click on the first graphic in the object
    Click, % resultObj[1].x, resultObj[1].y
}

; In the next example, we search for two graphics; if more than four or more found, sort them and mouseover all of them in order

oGraphicSearch := new graphicsearch()

resultObj := oGraphicSearch.search("|<Pizza>*165$22.03z|<HumanReadableTag>*165$22.03z")
; check if more than one graphic was found
if (resultObj.Count() >= 4) {
    ; re-sort the result object
    resultObj2 := oGraphicSearch.resultSort(resultObj)
    ; Mouseover each of the graphics found
    for _, object in resultObj2 {
        MouseMove, % object.x, object.y, 50
        Sleep, 1000
    }
}

; For the last example, search for two images in a specific area. If four or more found, sort them by the closest to the center of the monitor and click the third one.

/*
Default Window search:
[options.x1:=0] (number), [options.y1:=0] (number) ; the search scope's upper left corner coordinates
[options.x2:=A_ScreenWidth] (number), [options.y2:=A_ScreenHeight] (number) ; the search scope's lower right corner coordinates
[options.err1:=1] (number), [options.err0:=0] (number) ; Fault tolerance of graphic and background (0.1=10%)
[options.screenshot:=1] (boolean) ; Wether or not to capture a new screenshot or not. If the value is 0, the last captured screenshot will be used
[options.findall:=1] (boolean) ; Wether or not to find all instances or just one.
[options.joinqueries:=1] (boolean) ; Join all GraphicsSearch queries for combination lookup.
[options.offsetx:=1] (number), [options.offsety:=0] (number) ; Set the Max offset for combination lookup

optionsObj := {   x1: 0
                , y1: 0
                , x2: A_ScreenWidth
                , y2: A_ScreenHeight
                , err1: 0
                , err0: 0
                , screenshot: 1
                , findall: 1
                , joinqueries: 1
                , offsetx: 1
                , offsety: 1 }

oGraphicSearch.search("|<tag>*165$22.03z", optionsObj)
oGraphicSearch.search("|<tag>*165$22.03z", {x2: 100, y2: 100})
*/

oGraphicSearch := new graphicsearch()

resultObj := oGraphicSearch.search("|<Pizza>*165$22.03z|<spaghetti>*125$26.z", [{x2:A_ScreenWidth},{y2:A_ScreenHeight}])
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

; These GraphicSearch queries should match many, but probably not all 16:9 ratio screens

spaghettiGraphic :=  "|<Spaghetti>#153@0.61$44.Dzzzzzy3zzzzzzVzzzzzzszzzzzzkDzzzzzw3zzzzzz0zzzzzU0Dzszzs03zyDzy00zzXzzU0Dk7zk003w1ks003z0QC000k073U0003zks07s0zwC01z8"
pizzaGraphic :=      "|<Pizza>#391@0.61$41.TzXyDzy3z7wDzw7yTwDzsDzzs3XkSDzy07UwTzy071szzz023lzzs00zzzzU0tlzzz03rVszy07j7zzw0zzDzzzzzyTzUDzzwzz0Tzzzzy0zzzzzw1zzzzzs7zzzzzsDzz"
beerGraphic :=       "|<Beer>#418@0.61$44.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz3zzzzzzkzzzzzzsDzzzzw03zzzzz00zzzzzk0DzzzzkTzzzzzkDzzzzzw3zzzzzy0Tw7zzU03j1zzs001kTzy000Q1zy00070000001s"

; The following are all functionally identical, They search a region of the screen (0,0 -> 600,600) and only return one found match (the first match)

oGraphicSearch := new graphicsearch()
oGraphicSearch.search(pizzaGraphic, {x2: 600, y2: 600, findall: false})
oGraphicSearch.scan(pizzaGraphic, 0, 0, 600, 600, false)
oGraphicSearch.find(0, 0, 600, 600, 0, 0, pizzaGraphic, 1, false)

; If we want to search for all the pizzas we can perform the following to msgbox the x,y location of each match

oGraphicSearch := new graphicsearch()
resultObj := oGraphicSearch.search(pizzaGraphic)

if (resultObj) {
    loop, % resultObj.Count() {
        msgbox, % "x: " result[A_Index].x ", y: " result[A_Index].y
    }
}

; If we wanted to search for two (or more) items in one search that can be accomplished by joining both queries into one long string and performing the same search

oGraphicSearch := new graphicsearch()
allQueries := pizzaGraphic beerGraphic 
resultObj := oGraphicSearch.search(allQueries)

if (resultObj) {
    loop, % resultObj.Count() {
        msgbox, % "x: " resultObj[A_Index].x ", y: " resultObj[A_Index].y
    }
}

/*
There may be things we want to search for repeatedly but don't want to juggle arguments constantly, you can create instances of GraphicSearch that are responsible for finding individual graphics.

.searchAgain is a method that performs the same search with the arguments supplied the last time .search was used. Lets create a pizza GraphicSearch and a beer GraphicSearch. Our script will loop and search till they are both found simultaneously.
*/

oPizzaSearch := new graphicsearch()
oBeerSearch := new graphicsearch()
oPizzaSearch.search(pizzaGraphic)
oBeerSearch.search(oBeerSearch)

foundBothGate := false
while (foundBothGate != true) {
    resultPizzaObj := oPizzaSearch.searchAgain()
    resultBeerObj := oBeerSearch.searchAgain()
    if (resultPizzaObj && resultBeerObj) {
        msgbox, % "Found both Pizza and Beer! Let's Eat!"
        foundBothGate := true
    }
}

; Since we're not doing anything with the result objects we can simplify the code even further. GraphicSearch can fit comfortably in logic code because it doesn't require many arguments

foundBothGate := false
while (foundBothGate != true) {
    if (oPizzaSearch.searchAgain() && oBeerSearch.searchAgain()) {
        msgbox, % "Found both Pizza and Beer! Let's Eat!"
        foundBothGate := true
    }
}

/*
Let's imagine we want to click the pizza closet to the center, .resultSortDistance will sort a resultsObject by proximity to an x,y coord. A real smart app might even use GraphicSearch to find the center 

For example simplicity we'll say we already know the center is at 300,300

Note: Graphicsearch doesn't mutate arguments it's given, notice that the sorted and unsorted ResultObjects are different variables in this example.
*/

oGraphicSearch := new graphicsearch()

resultObj := oGraphicSearch.search(pizzaGraphic)
if (resultObj) {
    sortedResults := oGraphicSearch.resultSortDistance(resultObj, 300, 300)
    loop, % sortedResults.Count() {
        msgbox, % "x: " sortedResults[A_Index].x ", y: " sortedResults[A_Index].y
    }
    MouseClick, % sortedResults[1].x, sortedResults[1].y
}

/*
.resultSortDistance returns a Result Object with an additional a property "distance" for each match element. That may be useful for calculating how close things are to each other. Let's msgbox on any pizza's found outside the circle. We'll perform the check if (sortedResults[A_Index].distance > 350) which will return true for anything greater than the radius of the circle (350ish)
*/

oGraphicSearch := new graphicsearch()

resultObj := oGraphicSearch.search(pizzaGraphic)
if (resultObj) {
    sortedResults := oGraphicSearch.resultSortDistance(resultObj)
    loop, % sortedResults.Count() {
        if (sortedResults[A_Index].distance > 350) {
            msgbox, % "x: " sortedResults[A_Index].x ", y: " sortedResults[A_Index].y " is outside the circle"
        }
    }
}

; graphicsearch.ahk is a fork of FindText (https://www.autohotkey.com/boards/viewtopic.php?f=6&t=17834)