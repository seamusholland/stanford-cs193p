//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Seamus Holland on 8/28/24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    private static func createMemoryGame(previousTheme: MemoryGame<String>.Theme.ThemeName?) -> MemoryGame<String> {
        MemoryGame(previousTheme: previousTheme)
    }
    
    @Published private var model = EmojiMemoryGame.createMemoryGame(previousTheme: nil)
    

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
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame(previousTheme: model.theme.name)
    }
    
    func getColor() -> Color {
        return model.theme.color
    }
}
