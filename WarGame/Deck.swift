//
//  Deck.swift
//  WarGame
//
//  Created by Zoe Cutler on 11/9/23.
//

import Foundation

/// The deck of cards, before gameplay begins.
struct Deck {
    /// All of the cards in the deck.
    var cards: [Card] = []
    
    /// Creates a new deck of all possible cards and shuffles them.
    init() {
        self.cards = Value.allCases.reduce([]) { partialDeck, value in
            partialDeck + Suit.allCases.map { suit in
                Card(value: value, suit: suit)
            }
        }
        
        shuffle()
    }
    
    /// Shuffles the cards in place.
    private mutating func shuffle() {
        cards.shuffle()
    }
    
    /// Divides the deck into hands based on the number of players.
    func dealTo(_ numberOfPlayers: Int) -> [[Card]] {
        let cardsPerPlayer = cards.count / numberOfPlayers
        
        return (0..<numberOfPlayers).map { index in
            let start = cardsPerPlayer * index
            let end = cardsPerPlayer * (index + 1)
            return Array(cards[start..<end])
        }
    }
}
