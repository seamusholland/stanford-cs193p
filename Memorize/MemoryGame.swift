//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Seamus Holland on 8/28/24.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = []
        
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let content = cardContentFactory(pairIndex)
            cards.append(Card(id: "\(pairIndex)a", content: content))
            cards.append(Card(id: "\(pairIndex)b", content: content))
        }
    }
    
    mutating func choose(card: Card) {
        let chosenIndex = cards.firstIndex(where: {
            $0.id == card.id
        })!
        cards[chosenIndex].isFaceUp.toggle()
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "unmatched")"
        }
        
        var id: String
        
        var isFaceUp  = true
        var isMatched = false
        let content: CardContent
    }
}
