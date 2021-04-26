
; 50x12 title matching default: X:115, Y:30, W:560, H:75

; #Include <GraphicSearch>

 t1 := A_TickCount, X := Y := ""


; ******************************************
; System, ICON
; ******************************************

GraphicSearch_query := "|<Icon_Last_Empire_Game>*195$35.DzzzzyTzzzzAzzzzyNzwznwnzUS1U7yQtnnDwxnnaTzvbzAzw7XyNzljlwnzDTttbySztnDwxnna0MVXD40sHUz4"

GraphicSearch_query := "|<Last_Empire_Game_Icon>**50$36.s0000080000w80000Y80M10Y83jCzb82186184tPbb84xHmY87xnyY831ssY86BiAY84xjaY84hzmYDwxnma0AFtaX0C4wAlzvzjsTU"



; ******************************************
; Titles
; ******************************************

GraphicSearch_query := "|<Title_Collect_Equipment_Craft>*133$54.U0Tzzzzzt00Dzzzzzs00Dzzzzzs7zzzzzzzz7zzzzzzzz7zzzzzzzz7zzUNwzXs7zz01szXs7zy7VszXs7zyDlszXs00wDtszXs00wTtszXs7zwTtszXs7zwTtszXs7zwTtszXs7zwTtszXs7zwTtwzXs7zwTtwzXs7zyDlwTXs7zy7VwC3s00D01y03s00DU1z0XsU"

GraphicSearch_query := "|<Title_Collect_Recruit>*118$57.01zzzzzzzs03zzzzzzz7sDzzzzzzszVzzzzzzz7yDzzzzzzszkzUzy3yM7z7k1z07k0zlw07kES07yD3syDVkszVsz3XyCD00T7wQTlls07kzXXzyD01y00QzzlsyDk037zyD7sy7zwzzlsz7lzzXzyD7wT7zwTtlszVszzXyCD7yD3wSDXlszkw07k0SD7z7k1z07ltzszUzy3yTU"

GraphicSearch_query := "|<Title_Collect_Collision>*130$47.z0zzzzXls0Tzzz7XU0TzzyD67sTzzwSATszzzswFzlzzzlsXzly0zXl7zzs0z7UTzzVkyD0zzy7swS1zzwTlsw3zzszlls7zzXzXXkDzz7z77UDzyDyCD4TyATwQS8zwQTsswEzlszXlslzXlz7XlUwDksT7XU0Tk0yD7k3zk7wS8"

GraphicSearch_query := "|<Title_Collect_Rune>*129$65.U7zzzzzzzzy01zzzzzzzzw01zzzzzzzzszVzzzzzzzzlzVzzzzzzzzXzXzzzzzzzz7z77wTA3zkCDyCDsw03y0ATwQTls63sQ8zkszXkz7lw1z3lz7VyD7w00DXyD7wSDs00z7wSDswDU03yDswTls00TXwTlszXk00z7szXlz7Xzlz7lz7XyD7zXy7XyD7wSDz7yDXwSDsyDuDwD3UwTlwD0TwS01szXw08zsS0Xlz7w0s"



GraphicSearch_query := "|<Title_Collect_Alliance_Treasures>**50$58.zzy0000003zzw000000000k0000000030000003yTw0000000NU00000001a1zszs3zU6M6tb1kw7UNUE2k1X061a11yD6My86M4TtyBbMkNUFX6Arsn1a1AAzlTzA6M4klz4TskNUH300HU31a1AA01MTA6M4knzxbwkNUH3A04Mn1a1AAMSF3A6M4klrh7skNUH1XwoD31a1A707M046M4kC0skAM"


GraphicSearch_query := "|<Button_Collect_Alliance_Treasures_Excavation>**50$57.zzU00000060A0000000nzU0000006zzXly3ySDq0yyzwzvlyk6qq1i3m9rynbbbbDPCErBhyxgvPk2QBAzzbCSzlX93z0hqq0AN81U5iqk1X9XdwYaq0NBAzBYpazyRwytwaAnznbbb66l60AqK1g4nMzzyyTszyT4"

GraphicSearch_query := "|<Button_Collect_Alliance_Treasures_Rewards>**50$47.0s000001wM000003wlyQSDDwBjywyyzsPsD9Bj0lrbCSPQQzCTCwSvw0xyRutTs3s0tZqw7ak1nNhU9bjzouSTHDQtXkhqXCTt6XPx7SSnBanW6S1an8kI"

GraphicSearch_query := "|<Button_Collect_Alliance_Treasures_Request>**50$44.0M00000Dn000003Sny7zj7VhtnnvlsPk7k2YHQxxtwd4yCPCP+F0DbngmYHnM0nAd4wqTwn+F9bjzAmYGNtbvgdgXCTyT+T8Plbn2l26T3i4i4U"

GraphicSearch_query := "|<Button_Collect_Alliance_Treasures_Help>**50$43.Y6k0AU0G3M06E091gDn/zYUqTxZzyEPQ7mU7DxgttFlY4wywdwk0SzCIXNzj07+FgUrU3Z8mEPrzmYP8BvbNGBY6wzwdwm3PDSIQN1hkD+0Q"

; ******************************************
; Dialog
; ******************************************

GraphicSearch_query := "|<Dialog_Quit>**50$46.1z0007U0Tz000z03kC003BwAAQ00AqlXws00zN6QtjVvzbn1ayDjwDA3P8mn0QkAgX/Dbm0mmAgqP83/8mnNAUAgX/BYm0mmAgqHA3/8mnNAkRgX/BYnVanAgqFbQPBmnNbDXAy/BbC0QM0gq4Q1tkmnAEzlXzvwzU"










 resultObj := graphicsearch.search(GraphicSearch_query)
 if (resultObj) {
   X := resultObj.1.x, Y := resultObj.1.y, Comment := resultObj.1.id
   ; Click, %X%, %Y%
 }

 MsgBox, 4096, Tip, % "Found :`t" Round(resultObj.MaxIndex())
   . "`n`nTime  :`t" (A_TickCount-t1) " ms"
   . "`n`nPos   :`t" X ", " Y
   . "`n`nResult:`t" (resultObj ? "Success !" : "Failed !")

 for i,v in resultObj
   if (i<=2)
     graphicsearch.mouseTip(resultObj[i].x, resultObj[i].y)


	
/*
Network failure:
OK button:
GraphicSearch_query := "|<>*90$24.U7lw03ls7VlkDllVDsl3Dsl7TskDTsk7Tsk7DslXDsllDllk7lls03lwU7lyU"

Feedback button:
GraphicSearch_query := "|<>*90$22.03zw0DzlzzzDzzwzzUnzw1DzV00wS01lw0700zw03zk0Dz7wzwTnzkwDzU0zz08"


*/