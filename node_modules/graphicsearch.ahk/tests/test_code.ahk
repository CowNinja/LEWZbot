





/*

	Global Client_Area_X := 1
	Global Client_Area_Y := 32
	Global Client_AreaWidth := 689
	Global Client_AreaHeight := 1216
	Global Client_Area_X2 := (Client_Area_X + Client_AreaWidth)
	Global Client_Area_Y2 := (Client_Area_Y + Client_AreaHeight)
*/

Active_Skill:
{
	Subroutine_Running := "Active_Skill"
	stdout.WriteLine(A_NowUTC ",Subroutine_Running," Subroutine_Running ",A_ThisLabel," A_ThisLabel ",StartTime," A_TickCount )
	; WinActivate, %FoundAppTitle% ; Automatically uses the window found above.

	OfficerSkills :=  8331_Instructor_Title_Graphic 8332_Magic_Title_Graphic 8333_WildHarvest_Title_Graphic 8341_Bumper_Title_Graphic 8351_AbilityRsrch_Title_Graphic 8352_FirstRiches_Title_Graphic 8353_FullofStrength_Title_Graphic 8354_Promotion_Title_Graphic 8355_SkillfulWork_Title_Graphic 8356_SpecTrain_Title_Graphic 

	loop, 2
		Mouse_Click(215,425) ; Active Skill tab #2 - Officer
	Gosub Active_Skill_Click_Button
	
	/*
	loop, 2
		Mouse_Click(340,425) ; Active Skill tab #3 - Combat
	Gosub Active_Skill_Click_Button
	*/

	loop, 2
		Mouse_Click(470,425) ; Active Skill tab #4 - Develop
	Gosub Active_Skill_Click_Button

	loop, 2
		Mouse_Click(600,425) ; Active Skill tab #5 - Support
	Gosub Active_Skill_Click_Button
	
	
	Active_Skill_Click_Button:
	oUse_ButtonSearch := new graphicsearch()
	{
		loop, 2
		{
			resultUse_Button := oUse_ButtonSearch.search(832_Green_Use_Button_Graphic , optionsObjCoords)
			if (resultUse_Button)
			{
				sortedUse_Button := oUse_ButtonSearch.resultSortDistance(resultUse_Button, Client_Area_X2, Client_Area_Y2)
				loop, % sortedUse_Button.Count()
				{
					Mouse_Click(resultUse_Button[A_Index].x,resultUse_Button[A_Index].y)
					DllCall("Sleep","UInt",rand_wait + (1*Delay_Medium))
					gosub Active_Skill_Titles
					Mouse_Click(320,70) ; Tap top title bar
				}
			}
		}
		return
	}
	
	Active_Skill_Titles:
	oTitlesSearch := new graphicsearch()
	{
		resultTitles := oTitlesSearch.search(OfficerSkills, optionsObjCoords)
		if (resultTitles)
		{
			Mouse_Click(340,780) ; Tap Blue "Use" button
			DllCall("Sleep","UInt",(rand_wait + 3*Delay_Medium+0))
			Gosub Active_Skill_Reload
		}
		return
	}
	
	
/*
Network failure:
OK button:
GraphicSearch_query := "|<>*90$24.U7lw03ls7VlkDllVDsl3Dsl7TskDTsk7Tsk7DslXDsllDllk7lls03lwU7lyU"

Feedback button:
GraphicSearch_query := "|<>*90$22.03zw0DzlzzzDzzwzzUnzw1DzV00wS01lw0700zw03zk0Dz7wzwTnzkwDzU0zz08"


*/