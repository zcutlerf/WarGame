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
            let newCards = Array(repeating: Card(value: value, suit: .spades), count: 4)
            return partialDeck + newCards
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
}
