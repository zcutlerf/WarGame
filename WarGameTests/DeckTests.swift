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
        self.cards = Array(repeating: Card(value: .ace, suit: .spades), count: 52)
    }
}

final class DeckTests: XCTestCase {
    func test_init_newlyCreatedDeckHas52Cards() throws {
        let deck = Deck()
        let count = deck.cards.count
        
        XCTAssertEqual(count, 52)
    }
}
