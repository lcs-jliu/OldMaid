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
                    print(pairingCard)
                    print(comparedCard)
                    print(self.cards[pairingCard].simpleDescription())
                    print(self.cards[comparedCard].simpleDescription())
                    print("\(cards[pairingCard].simpleDescription()) and \(cards[comparedCard].simpleDescription()) get removed")
                    print("--------------------------------------")
                    //remove card
                    self.cards.remove(at: comparedCard)
                    self.cards.remove(at: pairingCard)
                    
                    
                    stillPairing = false
                    
                }
            }
            numberOfCardsChecked += 1
        }
    }
}

class OldMaid {
    // Properties
    
    // Deck of cards, rank and suit
    var deck : Deck
    
    //Hands of each player
    var playerHand : Hand
    var computerHand : Hand
    
    //Initialize all the variables
    init() {
        
        //initialize the deck
        self.deck = Deck()
        
        // Initialize players
        playerHand = Hand(description: "player")
        computerHand = Hand(description: "computer")
        
        //Remove a queen
        let itemToRemove = 12
        var checkingCard = 0
        while deck.cards.count != 51 {
            if deck.cards[checkingCard].rank.rawValue == itemToRemove {
                deck.cards.remove(at: itemToRemove)
            }
            checkingCard += 1
            print(checkingCard)
        }
        
        
        
        //Deal out the card
        //Player has 26
        if let newCards = self.deck.randomlyDealOut(thisManyCards: 26){
            self.playerHand.cards = newCards
            print("Player has \(newCards.count) cards")
        }
         //remove pairs from player's hand
        playerHand.removePairs()
        
        //Computer has 25
        if let newCards = self.deck.randomlyDealOut(thisManyCards: 25){
            self.computerHand.cards = newCards
            print("Computer has \(newCards.count) cards")
        }
        //remove pairs frm computer's hand
        computerHand.removePairs()
        
    }
    
    
    
    
    
    
    //    // This function implements the primary logic for the game of War
    //    private func play() {
    //
    //        // Game is about to start
    //        print("==========")
    //        print("Game start")
    //        print("==========")
    //
    //        // This loop will repeat until the player either loses or wins by having all or no cards
    //        while player.hasNotWon() {
    //
    //            // Track result
    //            hands += 1
    //
    //            // Report on hand starting
    //            print("-----------------------------")
    //            print("Now starting hand \(hands)...")
    //
    //            // Show player's regular hand
    //            player.status(verbose: debugMode)
    //
    //            // Show computer's regular hand
    //            computer.status(verbose: debugMode)
    //
    //            // Compare the top cards of the two players
    //            compareTopCards()
    //
    //        }
    //
    //        // Show player's hand
    //        player.status(verbose: debugMode)
    //
    //        // Show computer's hand
    //        computer.status(verbose: debugMode)
    //
    //        // Determine who won in the end
    //        if player.cards.count == 0 {
    //            print("Computer wins (end of game)")
    //        } else {
    //            print("Player wins (end of game)")
    //        }
    //
    //        // Print game rseults
    //        report()
    //    }
    //
    //
    //    // This function handles a war
    //    private func aWarHappens() {
    //
    //        // It's a war!
    //        print("It's a war!")
    //
    //        // First, check to see that another war is even playable...
    //
    //        // If both players have at least four cards, a war is possible
    //        if player.cards.count >= 4 && computer.cards.count >= 4 {
    //
    //            // Play a war
    //
    //            // Build the bounty
    //            for _ in 0...2 {
    //                bounty.cards.append(player.dealTopCard()!)
    //                bounty.cards.append(computer.dealTopCard()!)
    //            }
    //
    //            // Report
    //            if debugMode {
    //                bounty.status(verbose: debugMode)
    //            }
    //
    //            // Compare top cards
    //            compareTopCards()
    //
    //        } else if player.cards.count > computer.cards.count {
    //
    //            // Player gets all cards, wins, game is over
    //            player.cards.append(contentsOf: computer.cards)
    //            computer.cards.removeAll()
    //            player.cards.append(contentsOf: bounty.cards)
    //            bounty.cards.removeAll()
    //
    //        } else if computer.cards.count > player.cards.count {
    //
    //            // Computer gets all cards, wins, game is over
    //            computer.cards.append(contentsOf: player.cards)
    //            player.cards.removeAll()
    //            computer.cards.append(contentsOf: bounty.cards)
    //            bounty.cards.removeAll()
    //
    //        } else {
    //
    //            // Special cases... when players have same number of cards
    //            if player.cards.count == 0 {
    //
    //                // Both players have no cards
    //                fatalError("Both players have no cards, this shouldn't be possible.")
    //
    //            } else if player.cards.count == 1 {
    //
    //                // Both players have a single card
    //                if player.topCard!.beats(computer.topCard!) {
    //
    //                    // Add remaining cards to bounty
    //                    addTopCardsToBounty()
    //
    //                    // Player gets bounty
    //                    player.cards.append(contentsOf: bounty.cards)
    //
    //                    // Clear the bounty
    //                    bounty.cards.removeAll()
    //
    //                    // Track result
    //                    playerWins += 1
    //
    //                } else {
    //
    //                    // Add remaining cards to bounty
    //                    addTopCardsToBounty()
    //
    //                    // Computer gets bounty
    //                    computer.cards.append(contentsOf: bounty.cards)
    //
    //                    // Clear the bounty
    //                    bounty.cards.removeAll()
    //
    //                }
    //
    //            } else {
    //
    //                // Each player has two cards, or each player has three cards...
    //
    //                // Add all but final card to the bounty
    //                for _ in 0...player.cards.count - 1 {
    //                    bounty.cards.append(player.dealTopCard()!)
    //                    bounty.cards.append(computer.dealTopCard()!)
    //                }
    //
    //                // Compare the top card to see who wins
    //                compareTopCards()
    //
    //            }
    //
    //        }
    //
    //        // War is over
    //        return
    //
    //    }
    //
    //    // Adds the top cards for both players to the bounty
    //    func addTopCardsToBounty() {
    //        bounty.cards.append(player.dealTopCard()!)
    //        bounty.cards.append(computer.dealTopCard()!)
    //    }
    //
    //    // Compares the two top cards and takes action as needed
    //    func compareTopCards() {
    //
    //        // Compare the two top cards
    //        if player.topCard!.beats(computer.topCard!) {
    //
    //            // Player wins...
    //            print("Player won, player top card was \(player.topCard!.simpleDescription()) and computer top card was \(computer.topCard!.simpleDescription()).")
    //
    //            // Add top cards to the bounty
    //            addTopCardsToBounty()
    //
    //            // Player gets entire bounty
    //            player.cards.append(contentsOf: bounty.cards)
    //
    //            // Clear the bounty
    //            bounty.cards.removeAll()
    //
    //            // Track result
    //            playerWins += 1
    //
    //        } else if computer.topCard!.beats(player.topCard!) {
    //
    //            // Computer wins...
    //            print("Computer won, computer top card was \(computer.topCard!.simpleDescription()) and player top card was \(player.topCard!.simpleDescription()).")
    //
    //            // Add top cards to the bounty
    //            addTopCardsToBounty()
    //
    //            // Computer gets entire bounty
    //            computer.cards.append(contentsOf: bounty.cards.reversed())
    //
    //            // Clear the bounty
    //            bounty.cards.removeAll()
    //
    //        } else {
    //
    //            // Tie...
    //
    //            // Cards that caused war go in the bounty
    //            addTopCardsToBounty()
    //
    //            // It's a war!
    //            aWarHappens()
    //        }
    //
    //    }
    //
    //    // Report results
    //    func report() {
    //        print("===================")
    //        print("Game results are...")
    //        print("\(self.hands) total hands played")
    //        print("Player won \(self.playerWins) hands")
    //        print("Computer won \(self.hands - self.playerWins) hands")
    //    }
    //}
    //
    //War(debugMode: false)
    
    
}

OldMaid()
