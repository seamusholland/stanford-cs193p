//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Seamus Holland on 7/9/24.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var ViewModel: EmojiMemoryGame
    
    let themeMap = [
        "animals": ["🦔", "🐂", "🐖","🐃", "🦡", "🐘"],
        "plants": ["🌲", "🌵", "🍀", "🌳", "🌿"],
        "magic": ["🪄", "🔮", "✨", "🧙‍♂️"]
    ]
    
    let themeIcons = [
        "animals": Image(systemName: "pawprint"),
        "plants" : Image(systemName: "leaf"),
        "magic" : Image(systemName: "moon.stars")
    ]
    
    @State var theme: String = "animals"
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            themeSelectors
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 90))]) {
            let randomArray = pairifyAndRandomizeTheme(themeArray: themeMap[theme]!)
            ForEach(0..<randomArray.count, id: \.self) { index in
                CardView(content: randomArray[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.blue)
    }
    
    var themeSelectors: some View {
        HStack {
            themeSelector(text: "animals")
            Spacer()
            themeSelector(text: "plants")
            Spacer()
            themeSelector(text: "magic")
        }
        .imageScale(.large)
        .font(.body)
        .padding(.horizontal)
    }
    
    func pairifyAndRandomizeTheme(themeArray: [String]) -> [String] {
        let pairifiedArray = themeArray.flatMap { [$0, $0] }
        return pairifiedArray.shuffled()
    }
    
    func themeSelector(text: String) -> some View {
        Button(action: {
            theme = text
        }, label: {
            VStack(content: {
                themeIcons[text]!
                Text(text.capitalized)
            })
        })
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base
                    .fill(.white)
                base
                    .strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }.onTapGesture {
            isFaceUp.toggle()
        }
    }
}


#Preview {
    EmojiMemoryGameView()
}
