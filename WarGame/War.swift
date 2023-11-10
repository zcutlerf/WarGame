//
//  War.swift
//  WarGame
//
//  Created by Zoe Cutler on 11/9/23.
//

import Foundation

/// Represents the game state during a game of war.
class War {
    /// The first player.
    var player1: Player
    /// The second player.
    var player2: Player
    
    /// Creates a new game of war with each player. Players should have their cards before we initialize a War.
    init(player1: Player, player2: Player) {
        self.player1 = player1
        self.player2 = player2
    }
    
    /// Plays a game of war.
    func playGame() {
        while player1.cards.count != 0 && player2.cards.count != 0 {
            do {
                try playRound()
                
                print("  score  \(player1.score)    |    \(player2.score)")
                print()
            } catch {
                break
            }
        }
        
        if player1.hasLost {
            print("~~~PLAYER 2 WINS~~~")
        } else {
            print("~~~PLAYER 1 WINS~~~")
        }
    }
    
    /// Plays one round of war.
    ///
    /// This function is recursive if the played cards are the same.
    ///
    /// - Throws: If one player runs out of cards, the function will throw.
    func playRound(with cardsOnTable: [Card] = []) throws {
        var newCardsOnTable = cardsOnTable
        
        if !cardsOnTable.isEmpty {
            let (player1sHiddenCard, player2sHiddenCard) = try playCards(isHidden: true)
            newCardsOnTable += [player1sHiddenCard, player2sHiddenCard]
        }
        
        let (player1sCard, player2sCard) = try playCards()
        
        newCardsOnTable += [player1sCard, player2sCard]
        
        if player1sCard == player2sCard {
            // If the cards are the same value, play another round before continuing (recursion)
            try playRound(with: newCardsOnTable)
        } else if player1sCard > player2sCard {
            player1.collect(newCardsOnTable)
        } else {
            player2.collect(newCardsOnTable)
        }
    }
    
    /// Attempts to play a card from each player's hand, and print out the results.
    func playCards(isHidden: Bool = false) throws -> (player1sCard: Card, player2sCard: Card) {
        let player1sCard = try player1.play()
        let player2sCard = try player2.play()
        
        printCardPlay(player1sCard, and: player2sCard, isHidden: isHidden)
        return (player1sCard, player2sCard)
    }
    
    /// Prints cards to the console in a human-readable format.
    func printCardPlay(_ card1: Card, and card2: Card, isHidden: Bool = false) {
        if isHidden {
            print("        (-> \(card1.description) | \(card2.description) <-)")
        } else {
            print("Player 1 -> \(card1.description) | \(card2.description) <- Player 2")
        }
    }
}
