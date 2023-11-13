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
        }.shuffled()
    }
    
    func deal(to numberOfPlayers: Int) -> [[Card]] {
        var hands = Array(repeating: Array<Card>(), count: numberOfPlayers)
        for index in 0..<cards.count {
            let card = cards[index]
            hands[index % numberOfPlayers].append(card)
        }
        return hands
    }
}

final class DeckTests: XCTestCase {
    var deck: Deck = Deck()
    
    override func setUp() {
        deck = Deck()
    }
    
    func test_init_newlyCreatedDeckHas52Cards() throws {
        let count = deck.cards.count
        
        XCTAssertEqual(count, 52)
    }
    
    func test_init_deckIncludes4OfEachValue() throws {
        for value in Value.allCases {
            let numberOfCardsWithValue = deck.cards.filter { $0.value == value }.count
            XCTAssertEqual(numberOfCardsWithValue, 4)
        }
    }
    
    func test_init_deckIncludes13OfEachSuit() throws {
        for suit in Suit.allCases {
            let numberOfCardsWithSuit = deck.cards.filter { $0.suit == suit }.count
            XCTAssertEqual(numberOfCardsWithSuit, 13)
        }
    }
    
    func test_init_allCardsAreUnique() throws {
        for suit in Suit.allCases {
            for value in Value.allCases {
                let numberOfCardsMatchingSuitAndValue = deck.cards.filter { card in
                    card.value == value && card.suit == suit
                }.count
                XCTAssertEqual(numberOfCardsMatchingSuitAndValue, 1)
            }
        }
    }
    
    func test_init_deckShuffles() throws {
        // Note: there is a 1 in 80 unvingintillion chance that this test will not pass, if the two decks shuffle exactly the same.
        let anotherDeck = Deck()
        XCTAssertNotEqual(deck.cards, anotherDeck.cards)
    }
    
    func test_deal_dealingToPlayersYieldsEquivalentSizeHands() throws {
        for numberOfPlayers in 2...5 {
            let hands = deck.deal(to: numberOfPlayers)
            
            let expectedNumberOfCardsPerHand = deck.cards.count / numberOfPlayers
            
            for hand in hands {
                XCTAssert(hand.count == expectedNumberOfCardsPerHand || hand.count == expectedNumberOfCardsPerHand + 1)
            }
        }
    }
}
