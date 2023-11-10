//
//  War.swift
//  WarGame
//
//  Created by Zoe Cutler on 11/9/23.
//

import Foundation

/// Represents the game state during a game of war.
class War {
    /// The players
    var players: [Player]
    
    /// Creates a new game of war with each player. Players should have their cards before we initialize a War.
    init(players: [Player]) {
        self.players = players
    }
    
    /// Plays a game of war.
    func playGame() {
        while players.allSatisfy({ $0.cards.count != 0 }) {
            do {
                try playRound()
            } catch {
                break
            }
        }
        
        let playersWhoLost = players.filter({ $0.score == 0 })
        for player in playersWhoLost {
            print("~~~PLAYER \(player.number) LOST~~~")
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
            let hiddenCards = try playCards(isHidden: true)
            newCardsOnTable += hiddenCards
        }
        
        let newCards = try playCards()
        
        newCardsOnTable += newCards
        
        guard let maxValueOnTable = newCards.sorted(by: { $0 > $1 }).first else {
            fatalError("idk what happens here")
        }
        let allCardsSatisfyingMax = newCards.filter { $0 == maxValueOnTable }
        
        if allCardsSatisfyingMax.count == 1 {
            let winningPlayerIndex = newCards.firstIndex(where: { $0.description == allCardsSatisfyingMax.first!.description })!
            players[winningPlayerIndex].collect(newCardsOnTable)
            printScore()
        } else {
            try playRound(with: newCardsOnTable)
        }
    }
    
    /// Attempts to play a card from each player's hand, and print out the results.
    func playCards(isHidden: Bool = false) throws -> [Card] {
        let playedCards = try players.indices.map { playerIndex in
            try players[playerIndex].play()
        }
        
        printCardPlay(playedCards, isHidden: isHidden)
        return playedCards
    }
    
    /// Prints cards to the console in a human-readable format.
    func printCardPlay(_ cards: [Card], isHidden: Bool = false) {
        if isHidden {
            for (index, card) in cards.enumerated() {
                if (index % 2) == 0 {
                    print("       \(index + 1) -> \(card.description)", terminator: " | ")
                } else {
                    print("\(card.description) <- \(index + 1)")
                }
            }
        } else {
            for (index, card) in cards.enumerated() {
                if (index % 2) == 0 {
                    print("Player \(index + 1) -> \(card.description)", terminator: " | ")
                } else {
                    print("\(card.description) <- Player \(index + 1)")
                }
            }
        }
        if (cards.count % 2) != 0 {
            print()
        }
    }
    
    func printScore() {
        let playerNumbers = players.map { "\($0.number) | " }.joined()
        print("                                 players: \(playerNumbers)")
        print("                                   score: ", terminator: "")
        for player in players {
            print("\(player.score)", terminator: " | ")
        }
        print()
        print()
    }
}
