//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Seamus Holland on 8/28/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static let emojis = ["🦔", "🐂", "🐖","🐃", "🦡", "🐘"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame(numberOfPairsOfCards: 6) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "Oops!"
            }
        }
    }
    
    @Published private var model = EmojiMemoryGame.createMemoryGame()
    

    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) {
        print("chose \(card.id)")
        model.choose(card: card)
    }
}
