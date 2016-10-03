#Include gbfscriptConfigUtilities.ahk
;#Include PokerUtils.ahk

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
		determinePokerState := [deal_button, ok_button, start_button, high_button, low_button, no_button, yes_button]
		searchResult := MultiImageSearchPoker(coordX, coordY, determinePokerState, 0, 0, gbf_winWidth, gbf_winHeight)

		
		if InStr(searchResult, deal_button)
		{
			updateLog("Deal button found, clicking")
			RandomClick(coordX, coordY, clickVariance) 
			continue
		}
		else if InStr(searchResult, ok_button)
		{
			updateLog("OK button found")
			
			cardsFound := SearchAllCards()
			updateLog("cardsFound 1: " . cardsFound[1])
			updateLog("cardsFound 2: " . cardsFound[2])
			updateLog("cardsFound 3: " . cardsFound[3])
			updateLog("cardsFound 4: " . cardsFound[4])
			updateLog("cardsFound 5: " . cardsFound[5])
			
			
			
			;RandomClick(coordX, coordY, clickVariance) 
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

SearchAllCards()
{
	cardsOnScreen := Object()
	allCards := Object()
	
	allCards.Insert(02c)
	allCards.Insert(02d)
	allCards.Insert(02h)
	allCards.Insert(02s)
	
	allCards.Insert(03c)
	allCards.Insert(03d)
	allCards.Insert(03h)
	allCards.Insert(03s)
	
	allCards.Insert(04c)
	allCards.Insert(04d)
	allCards.Insert(04h)
	allCards.Insert(04s)
	
	allCards.Insert(05c)
	allCards.Insert(05d)
	allCards.Insert(05h)
	allCards.Insert(05s)
	
	allCards.Insert(06c)
	allCards.Insert(06d)
	allCards.Insert(06h)
	allCards.Insert(06s)
	
	allCards.Insert(07c)
	allCards.Insert(07d)
	allCards.Insert(07h)
	allCards.Insert(07s)
	
	allCards.Insert(08c)
	allCards.Insert(08d)
	allCards.Insert(08h)
	allCards.Insert(08s)
	
	allCards.Insert(09c)
	allCards.Insert(09d)
	allCards.Insert(09h)
	allCards.Insert(09s)
	
	allCards.Insert(10c)
	allCards.Insert(10d)
	allCards.Insert(10h)
	allCards.Insert(10s)
	
	allCards.Insert(11c)
	allCards.Insert(11d)
	allCards.Insert(11h)
	allCards.Insert(11s)
	
	allCards.Insert(12c)
	allCards.Insert(12d)
	allCards.Insert(12h)
	allCards.Insert(12s)
	
	allCards.Insert(13c)
	allCards.Insert(13d)
	allCards.Insert(13h)
	allCards.Insert(13s)
	
	allCards.Insert(14c)
	allCards.Insert(14d)
	allCards.Insert(14h)
	allCards.Insert(14s)
	
	allCards.Insert(00x)
	
	;Searching Card Location 1
	searchResult := MultiImageSearchPoker(coordX, coordY, allCards, keepCard1_X1, keepCard_Y1, keepCard1_X2, keepCard_Y2)
	for index, card in allCards
	{
		if InStr(searchResult, card)
		{
			updatelog("Adding to array")
			
			;truncating .png
			tmpArray := StrSplit(card, ".")							
			cardsOnScreen[1] := tmpArray[1]

			updateLog("index to Remove " . index)
			allCards.Remove(index, "")
			continue
		}
	}
	
	;Searching Card Location 2
	searchResult := MultiImageSearchPoker(coordX, coordY, allCards, keepCard2_X1, keepCard_Y1, keepCard2_X2, keepCard_Y2)
	for index, card in allCards
	{
		if InStr(searchResult, card)
		{
			updatelog("Adding to array")
			
			;truncating .png
			tmpArray := StrSplit(card, ".")							
			cardsOnScreen[2] := tmpArray[1]

			updateLog("index to Remove " . index)
			allCards.Remove(index, "")
			continue
		}
	}
	
	;Searching Card Location 3
	searchResult := MultiImageSearchPoker(coordX, coordY, allCards, keepCard3_X1, keepCard_Y1, keepCard3_X2, keepCard_Y2)
	for index, card in allCards
	{
		if InStr(searchResult, card)
		{
			updatelog("Adding to array")
			
			;truncating .png
			tmpArray := StrSplit(card, ".")							
			cardsOnScreen[3] := tmpArray[1]

			updateLog("index to Remove " . index)
			allCards.Remove(index, "")
			continue
		}
	}
	
	;Searching Card Location 4
	searchResult := MultiImageSearchPoker(coordX, coordY, allCards, keepCard4_X1, keepCard_Y1, keepCard4_X2, keepCard_Y2)
	for index, card in allCards
	{
		if InStr(searchResult, card)
		{
			updatelog("Adding to array")
			
			;truncating .png
			tmpArray := StrSplit(card, ".")							
			cardsOnScreen[4] := tmpArray[1]

			updateLog("index to Remove " . index)
			allCards.Remove(index, "")
			continue
		}
	}
	
	;Searching Card Location 5
	searchResult := MultiImageSearchPoker(coordX, coordY, allCards, keepCard5_X1, keepCard_Y1, keepCard5_X2, keepCard_Y2)
	for index, card in allCards
	{
		if InStr(searchResult, card)
		{
			updatelog("Adding to array")
			
			;truncating .png
			tmpArray := StrSplit(card, ".")							
			cardsOnScreen[5] := tmpArray[1]

			updateLog("index to Remove " . index)
			allCards.Remove(index, "")
			continue
		}
	}

	return cardsOnScreen 
}


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

