//
//  main.swift
//  WarGame
//
//  Created by Zoe Cutler on 11/9/23.
//

import Foundation

// Make a deck of shuffled cards
let deck = Deck()

// Deal the cards by dividing the deck in half
let dividedCards = deck.divide()

// Make two players and give them their cards
var player1 = Player(unturnedCards: dividedCards.firstPlayersCards)
var player2 = Player(unturnedCards: dividedCards.secondPlayersCards)

// Make a War game to represent game state
var war = War(player1: player1, player2: player2)

// Play the War game
war.playGame()
