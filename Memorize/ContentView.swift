//
//  ContentView.swift
//  Memorize
//
//  Created by Seamus Holland on 7/9/24.
//

import SwiftUI

struct ContentView: View {
    let themeMap = [
        "animals": ["🦔", "🐂", "🐖","🐃", "🦡", "🐘", "🦒", "🐅", "🦓", "🐒", "🐆", "🦍"],
        "plants": ["🌲", "🌵", "🍀", "🌳", "🌿", "🌱", "🍃", "🌴"],
        "magic": ["🪄", "🔮", "✨", "🧙‍♂️", "🧚‍♀️"]
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
            ForEach(0..<themeMap[theme]!.count, id: \.self) { index in
                CardView(content: themeMap[theme]![index], isFaceUp: true)
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.green)
    }
    
    var themeSelectors: some View {
        HStack {
            animalSelector
            Spacer()
            plantSelector
            Spacer()
            magicSelector
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func themeSelector(text: String) -> some View {
        Button(action: {
            theme = text
        }, label: {
            Text(text.uppercased())
        })
    }
    
    var animalSelector: some View {
        themeSelector(text: "animals")
    }
    
    var plantSelector: some View {
        themeSelector(text: "plants")
    }
    
    var magicSelector: some View {
        themeSelector(text: "magic")
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
    ContentView()
}
