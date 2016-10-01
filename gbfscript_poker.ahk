#Include gbfscriptConfigUtilities.ahk

SetTimer, ForceExitApp, 5000000 ; 1h20 minutes

global maxAttackTurns := 999
global maxBattleNonActions := 2

Gui, Add, ListView, x6 y6 w400 h500 vLogbox LVS_REPORT, %A_Now%|Activity
 LV_ModifyCol(1, 60)
 GuiControl, -Hdr, Logbox
 Gui, Show, w410 h505, GBF Bot Log

;----------------------------------------------
;Main Loop
;----------------------------------------------

global globalTimeout := 0

CoordMode Pixel, Relative
CoordMode Mouse, Relative

Loop{
Sleep, 1000
globalTimeout := globalTimeout + 1
updateLog("Timeout: " . globalTimeout)

;Seek browser URL
sURL := GetActiveChromeURL()
WinGetClass, sClass, A
If (sURL != "")
{
	;updateLog("The URL is : " . sURL)

	if InStr(sURL, searchStage)
	{
		updateLog("-----In Stage-----")
		continue
	}
	if InStr(sURL, searchBattle)
	{
		updateLog("-----In Battle-----")	
		continue
	}
	else if InStr(sURL, searchResults)
	{
		updateLog("-----In Results Screen-----")
		continue
	}
	else if InStr(sURL, searchCoopJoin)
	{
		updateLog("-----In Coop Join-----")
		continue
	}
	else if InStr(sURL, searchCoopRoom)
	{
		updateLog("-----In Coop Room-----")
		continue
	}
	else if InStr(sURL, searchCoop)
	{
		updateLog("-----In Coop Home-----")
		continue
	}
	else if InStr(sURL, searchSelectSummon)
	{
		updateLog("-----In Select Summon-----")
		continue
	}
	else if InStr(sURL, searchQuest)
	{
		updateLog("-----In Quests Screen-----")
		continue
	}	
	else if InStr(sURL, searchMypage)
	{
		updateLog("-----In Home Page-----")
		continue
	}
	
	else if InStr(sURL, searchPoker)
	{
		updateLog("-----In Poker-----")
		determinePokerState := [deal_button, ok_button, start_button, high_button, low_button, no_button, yes_button, Xx]
		searchResult := MultiImageSearchPoker(coordX, coordY, determinePokerState)
		
		if InStr(searchResult, deal_button)
		{
			updateLog("Deal button found, clicking")
			RandomClick(coordX, coordY, clickVariance) 
			continue
		}
		else if InStr(searchResult, ok_button)
		{
			updateLog("OK button found")
			
			;TODO search all cards
			;
			;TODO keep cards logic
			;
			
			
			
			RandomClick(coordX, coordY, clickVariance) 
			continue
		}
		else if (InStr(searchResult, no_button) or InStr(searchResult, yes_button))
		{
			updateLog("Yes/No button found")
			RandomClick(poker_button_right_X, poker_button_Y, clickVariance) 
			continue
		}
		else if (InStr(searchResult, high_button) or InStr(searchResult, low_button))
		{
			updateLog("High/Low button found")
			
			;
			;TODO search all cards
			;
			
			RandomClick(poker_button_right_X, poker_button_Y, clickVariance) 
			continue
		}
		
	}
	
	else
	{
		updateLog("URL not identified")
		continue
	}
}
Else
	updateLog("Chrome not detected (" . sClass . ")")


}

Return




;----------------------------------------------
;Keybinds
;----------------------------------------------


F12::Pause

GuiClose:
ExitApp

Esc::
ExitApp

ForceExitApp:
SetTimer,  ForceExitApp, Off
ExitApp

