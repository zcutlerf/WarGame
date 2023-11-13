//
//  DeckTests.swift
//  WarGameTests
//
//  Created by Zoe Cutler on 11/13/23.
//

import XCTest

struct Deck {
    var cards: [Card]
    
    init() {
        self.cards = Value.allCases.reduce([]) { partialDeck, value in
            return partialDeck + Suit.allCases.map { suit in
                Card(value: value, suit: suit)
            }
        }
    }
}

final class DeckTests: XCTestCase {
    func test_init_newlyCreatedDeckHas52Cards() throws {
        let deck = Deck()
        let count = deck.cards.count
        
        XCTAssertEqual(count, 52)
    }
    
    func test_init_deckIncludes4OfEachValue() throws {
        let deck = Deck()
        for value in Value.allCases {
            let numberOfCardsWithValue = deck.cards.filter { $0.value == value }.count
            XCTAssertEqual(numberOfCardsWithValue, 4)
        }
    }
    
    func test_init_deckIncludes13OfEachSuit() throws {
        let deck = Deck()
        for suit in Suit.allCases {
            let numberOfCardsWithSuit = deck.cards.filter { $0.suit == suit }.count
            XCTAssertEqual(numberOfCardsWithSuit, 13)
        }
    }
}
