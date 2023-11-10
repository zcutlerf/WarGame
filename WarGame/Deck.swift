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
//        stackTheDeck()
    }
    
    /// Shuffles the cards in place.
    private mutating func shuffle() {
        cards.shuffle()
    }
    
    /// Rather than shuffling the cards, we might prefer to stack the deck, to ensure one player's success.
    private mutating func stackTheDeck() {
        let firstHalf = cards.filter { $0.suit == .spades || $0.suit == .clubs }
        let secondHalf = cards.filter { $0.suit == .hearts || $0.suit == .diamonds }
        self.cards = firstHalf + secondHalf
        self.cards.removeLast(3)
        self.cards.append(Card(value: .five, suit: .spades))
        self.cards.append(Card(value: .six, suit: .hearts))
        self.cards.append(Card(value: .seven, suit: .clubs))
    }
    
    /// Divides the deck in half, returning two arrays of cards to give to the players.
    func divide() -> (firstPlayersCards: [Card], secondPlayersCards: [Card]) {
        let firstHalf = cards[0..<(cards.count / 2)]
        let secondHalf = cards[(cards.count / 2)..<cards.count]
        return (Array(firstHalf), Array(secondHalf))
    }
}
