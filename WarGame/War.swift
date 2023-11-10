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
        while players.filter({ $0.score != 0 }).count != 1 {
            playRound()
        }
        
        if let winningPlayer = players.filter({ $0.score != 0 }).first {
            print("~~~PLAYER \(winningPlayer.number) WON~~~")
        } else {
            print("There was no winner for some reason.")
        }
    }
    
    /// Plays one round of war.
    ///
    /// This function is recursive if the played cards are the same.
    ///
    /// - Throws: If one player runs out of cards, the function will throw.
    func playRound(with cardsOnTable: [Card] = []) {
        var newCardsOnTable = cardsOnTable
        
        if !cardsOnTable.isEmpty {
            let hiddenCards = playCards(isHidden: true)
            newCardsOnTable += hiddenCards.compactMap { $0 }
        }
        
        let newCards = playCards()
        
        newCardsOnTable += newCards.compactMap { $0 }
        
        guard let maxValueOnTable = newCards.compactMap({$0}).sorted(by: { $0 > $1 }).first else {
            fatalError("How is it possible we are here, with no maximum value?")
        }
        let allCardsSatisfyingMax = newCards.compactMap({$0}).filter { $0 == maxValueOnTable }
        
        if allCardsSatisfyingMax.count == 1 {
            let winningPlayerIndex = newCards.firstIndex(where: { $0?.description == allCardsSatisfyingMax.first!.description })!
            players[winningPlayerIndex].collect(newCardsOnTable)
            printScore()
        } else {
            playRound(with: newCardsOnTable)
        }
    }
    
    /// Attempts to play a card from each player's hand, and print out the results.
    func playCards(isHidden: Bool = false) -> [Card?] {
        let playedCards = players.indices.map { playerIndex in
            try? players[playerIndex].play()
        }
        
        printCardPlay(playedCards, isHidden: isHidden)
        return playedCards
    }
    
    /// Prints cards to the console in a human-readable format.
    func printCardPlay(_ cards: [Card?], isHidden: Bool = false) {
        if isHidden {
            for (index, card) in cards.enumerated() {
                if (index % 2) == 0 {
                    print("       \(index + 1) -> \(card?.description ?? "__")", terminator: " | ")
                } else {
                    print("\(card?.description ?? "__") <- \(index + 1)")
                }
            }
        } else {
            for (index, card) in cards.enumerated() {
                if (index % 2) == 0 {
                    print("Player \(index + 1) -> \(card?.description ?? "__")", terminator: " | ")
                } else {
                    print("\(card?.description ?? "__") <- Player \(index + 1)")
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
