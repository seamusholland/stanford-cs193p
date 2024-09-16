//
//  MemorizeGame.swift
//  Memorize
//
//  Created by Seamus Holland on 8/28/24.
//

import Foundation
import SwiftUI

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    private(set) var theme: Theme
    
    init(previousTheme: Theme.ThemeName?) {
        cards = []
        
        // randomly select a new! theme
        var newTheme = Theme.ThemeName.allCases.randomElement()
        
        while newTheme == previousTheme {
            newTheme = Theme.ThemeName.allCases.randomElement()
        }
        
        theme = Theme(name: newTheme ?? Theme.ThemeName.animals)
        
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<theme.numPairs {
            let content = theme.emojis[pairIndex]
            cards.append(Card(id: "\(pairIndex)a", content: content as! CardContent))
            cards.append(Card(id: "\(pairIndex)b", content: content as! CardContent))
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
    
    mutating func faceDown() {
        for index in cards.indices {
            cards[index].isFaceUp = false
        }
    }
    
    struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
        var debugDescription: String {
            "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "unmatched")"
        }
        
        var id: String
        
        var isFaceUp  = false
        var isMatched = false
        let content: CardContent
    }
    
    // perhaps there's a better way of modeling this...
    struct Theme {
        var name: ThemeName
        var emojis: [String]
        var numPairs: Int
        var color: Color
        
        init(name selected: ThemeName) {
            // TODO check for valid theme
            self.name = selected
            self.emojis = themeMojis[selected] ?? []
            self.numPairs = themePairs[selected] ?? 0
            self.color = themeColors[selected] ?? Color.black
        }
        
        enum ThemeName: CaseIterable {
            case animals
            case plants
            case magic
            case food
            case transport
            case emotions
        }
    
        private var themeMojis: [ThemeName : [String]] = [
            ThemeName.animals: ["🦔", "🐂", "🐖", "🐃", "🦡", "🐘"],
            ThemeName.plants: ["🌲", "🌵", "🍀", "🌳", "🌿"],
            ThemeName.magic: ["🪄", "🔮", "✨", "🧙‍♂️"],
            ThemeName.food: ["🍎", "🍕", "🍔", "🍣", "🍪", "🍉"],
            ThemeName.transport: ["🚗", "✈️", "🚀", "🚲", "🚁", "🚢"],
            ThemeName.emotions: ["😀", "😢", "😡", "😱", "😍", "🤔"]
        ]
        
        private var themePairs: [ThemeName : Int] = [
            ThemeName.animals: 4,
            ThemeName.plants: 3,
            ThemeName.magic: 4,
            ThemeName.food: 5,
            ThemeName.transport: 6,
            ThemeName.emotions: 5
        ]
        
        private var themeColors = [
            ThemeName.animals: Color.orange,
            ThemeName.plants: Color.green,
            ThemeName.magic: Color.purple,
            ThemeName.food: Color.red,
            ThemeName.transport: Color.blue,
            ThemeName.emotions: Color.pink
        ]
    }
}
