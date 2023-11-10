//
//  Player.swift
//  WarGame
//
//  Created by Zoe Cutler on 11/9/23.
//

import Foundation

/// A player playing War, with their stack/hand/pile of cards.
struct Player {
    /// The player's current stack/hand/pile of cards.
    var cards: [Card]
    
    /// Creates a new player, taking in the cards that are dealt to them before the game begins.
    init(unturnedCards: [Card]) {
        self.cards = unturnedCards
    }
    
    /// The score the player has, formatted for printing to the console with even character widths.
    var score: String {
        let score = cards.count
        if score < 10 {
            return "\(score) "
        } else {
            return "\(score)"
        }
    }
    
    /// Whether the player has run out of cards and loses.
    var hasLost: Bool {
        cards.count == 0
    }
    
    /// Errors that might occur during gameplay for a player.
    enum PlayError: Error {
        /// An error that occurs when a player wants to play a card but has none left.
        case noCardsLeft
    }
    
    
    /// Attempts to play the first card on the player's pile/hand/stack.
    ///
    /// - Returns: The card to be played.
    /// - Throws: If the player has no card left, this method will throw `PlayError.noCardsLeft`.
    mutating func play() throws -> Card {
        guard let card = cards.first else {
            throw PlayError.noCardsLeft
        }
        
        cards.removeAll(where: { $0.description == card.description })
        return card
    }
    
    /// Collects cards won during a round of War.
    ///
    /// - Parameter cards: The cards the player has won from the table.
    mutating func collect(_ cards: [Card]) {
        self.cards.append(contentsOf: cards)
    }
}
