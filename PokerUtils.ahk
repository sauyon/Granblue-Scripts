global count := 0

Suit(card) {
	return SubStr(card, 2)
}

Val(card) {
	return SubStr(card, 0, 2)
}

; selects cards from space and returns a binary array
Select(cards, space) {

}

PickCards(byref cards) {
	oldcards := cards
	Sort cards
	
	matchingCards := Object() ; potential cards to keep that are consecutive
	matchingCount := 0 ; if 2 or greater, the hand is a winning hand with pairs/etc
	
	suit0 := "" ; first encountered suit
	suit0Count := 0 ; number of cards matching suit0
	suit1 := "" ; second encountered suit
	suit1Count := 0 ; number of cards matching suit1
	prev := "" ; previous card
	consecutive := 0 ; number of cards in a row seen with the same value
	straight := 0 ; number of cards in a straight
	straightStart := 0 ; start of the straight
	For i, card in cards {
		If (i != 0) {
			If (Val(card) == Val(prev)) {
				consecutive++
				If (consecutive == 2) {
					matchingCards.Insert(prev)
					matchingCards.Insert(card)
					matchingCount += 1 ; if this happens twice, it's a 2 pair, a winning hand
				} Else If (consecutive > 2) {
					matchingCards.Insert(card)
					matchingCount := 2 ; there is a triple, so this is a winning hand
				}
			} Else {
				consecutive := 1
				If (Val(card) == Val(prev) + 1) {
					straight++
				} Else If (straight < 4) {
					; Only reset if straight < 4 because I want to save a 4-straight
					straight := 1
					straightStart := i
				}
			}
		} Else {
			suit0 := Suit(card)
			suit0Count := 1
			consecutive := 1
			straight := 1
		}
		prev := card
	}
	
	ret := Object()
	Loop 5 { ret.Insert(false) }
	If (matchingCount > 1) {
		for i, card in cards {
			for j, sp in space {
				if (card == sp) 
					ret[j] := true
			}
		}
	} Else If (suit0Count == 5 || straight == 5) {
		; keep the whole hand
		Loop, 5 { ret.Insert(true) }
		return ret
	} Else If (suit0Count == 4) {
		for i, card in oldcards {
			if (Suit(card) == suit0) 
				ret[i] := true
		}
	} Else If (suit1Count == 4) {
		for i, card in oldcards {
			if (Suit(card) == suit1) 
				ret[i] := true
		}
	} Else If (straight == 4) {
		curr := Val(cards[straightStart])
		Loop, 4 {
			For i, card in oldcards {
				if (Val(card) == curr) {
					ret[i] := true
					Break
				}
			}
			curr++
		}
	} Else If (matchingCount == 1) {
		return Select(matchingCards, oldcards)
	}
	updateLog(" return: " . ret[1])
	return ret
}