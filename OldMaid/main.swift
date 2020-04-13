//
//  main.swift
//  AlternateCommandLineWar
//
//  Created by Gordon, Russell on 2020-02-12.
//  Copyright © 2020 Gordon, Russell. All rights reserved.
//

import Foundation

extension Hand {
    // Function to check if pair exist & remove
    func removePairs() {
        var numberOfCardsChecked = 0
        // check every card in the deck to see if pair exist
        while numberOfCardsChecked < self.cards.count {
            // The card selected to compare to the whole deck
            var pairingCard = 0
            // The card that is comparing to the selected card
            var comparedCard = 0
            var stillPairing : Bool = true
            
            // compare
            while stillPairing == true && comparedCard < self.cards.count - 1 {
                //If challenging card is greater than or less than compared card, then it move up to compare to the next card
                comparedCard = pairingCard + 1
                if self.cards[pairingCard].rank.rawValue > self.cards[comparedCard].rank.rawValue ||  self.cards[pairingCard].rank.rawValue < self.cards[comparedCard].rank.rawValue{
                    //Simple description to show the status of cards
//                    print(pairingCard)
//                    print(comparedCard)
//                    print(self.cards[pairingCard].simpleDescription())
//                    print("VS.")
//                    print(self.cards[comparedCard].simpleDescription())
//                    print("--------------------------------------")
                    // move the comparing card up by one inorder to compare to the next card`
                    let element = self.cards[pairingCard]
                    self.cards.remove(at: pairingCard)
                    self.cards.insert(element, at: comparedCard)
                    pairingCard += 1
                    
                    //  If challenging card and compared card is the same, both get removed
                } else {
                    //simple description of card remove
//                    print(pairingCard)
//                    print(comparedCard)
//                    print(self.cards[pairingCard].simpleDescription())
//                    print(self.cards[comparedCard].simpleDescription())
//                    print("\(cards[pairingCard].simpleDescription()) and \(cards[comparedCard].simpleDescription()) get removed")
//                    print("--------------------------------------")
                    //remove card
                    self.cards.remove(at: comparedCard)
                    self.cards.remove(at: pairingCard)
                    stillPairing = false
                    
                }
            }
            numberOfCardsChecked += 1
        }
    }
    
    func randomlyDealACard() -> Card {
        let numberOfCards = self.cards.count - 1
        let cardIndex = Int.random(in: 0...numberOfCards)
        let cardDealt = self.cards[cardIndex]
        self.cards.remove(at: cardIndex)
        return cardDealt
    }
}

class OldMaid {
    // Properties
    
    // Deck of cards, rank and suit
    var deck : Deck
    
    //Hands of each player
    var playerHand : Hand
    var computerHand : Hand
    
    // Status of the players
    var pairingSide : Hand
    var dealingSide : Hand
    
    // Statistics of the game
    var gameIsOver = false
    
    //Initialize all the variables
    init() {
        
        //initialize the deck
        self.deck = Deck()
        
        // Initialize players
        playerHand = Hand(description: "player")
        computerHand = Hand(description: "computer")
        
        //Set who is pairing first
        pairingSide = playerHand
        dealingSide = computerHand
        
        //Remove a queen
        let itemToRemove = 12
        var checkingCard = 0
        while deck.cards.count != 51 {
            if deck.cards[checkingCard].rank.rawValue == itemToRemove {
                deck.cards.remove(at: itemToRemove)
            }
            checkingCard += 1
            //print(checkingCard)
        }
        
        //Deal out the card
        //Player has 26
        if let newCards = self.deck.randomlyDealOut(thisManyCards: 26){
            self.playerHand.cards = newCards
            print("Player has \(newCards.count) cards")
        }
         //remove pairs from player's hand
        playerHand.removePairs()
        print("The player has \(playerHand.cards.count) cards left after pairing")
        
        //Computer has 25
        if let newCards = self.deck.randomlyDealOut(thisManyCards: 25){
            self.computerHand.cards = newCards
            print("Computer has \(newCards.count) cards")
        }
        // Remove pairs frm computer's hand
        computerHand.removePairs()
        print("The computer has \(computerHand.cards.count) cards left after pairing")
        
        // Start the game
        play()
    }
    
    func play() {
        while gameIsOver != true && dealingSide.cards.count > 0 {
            let pairingCard = dealingSide.randomlyDealACard()
            pairingSide.cards.append(pairingCard)
            print("The \(pairingSide.description) deals a \(pairingCard.simpleDescription()) from \(dealingSide.description)")
            if check(the: pairingCard) == true {
                print("The cards got cancelled")
                print("The \(pairingSide.description) has \(pairingSide.cards.count) card(s) left in hand")
            } else {
                print("The \(pairingCard.simpleDescription()) did not got cancelled")
            }
            siwtchWhoOnIsPairing()
        }
    }
    
    func check(the: Card) -> Bool {
        var checkedCard = 0
        while checkedCard < pairingSide.cards.count - 1{
                if pairingSide.cards[0].rank.rawValue > pairingSide.cards[checkedCard].rank.rawValue || pairingSide.cards[0].rank.rawValue < pairingSide.cards[checkedCard].rank.rawValue {
                    checkedCard += 1
                } else {
                    pairingSide.cards.remove(at: 0)
                    pairingSide.cards.remove(at: checkedCard)
                    return true
            }
        }
        return false
    }
    
    func siwtchWhoOnIsPairing() {
        if pairingSide === playerHand {
            pairingSide = computerHand
            dealingSide = playerHand
        } else {
            pairingSide = playerHand
            dealingSide = computerHand
        }
    }
}

OldMaid()
