//
//  ContentView.swift
//  Memorize
//
//  Created by Veronika Horovenko on 25.09.2025.
//

import SwiftUI

struct MemorizeGameView: View {
    
    enum CardTheme: CaseIterable {
        case halloween
        case flowers
        case fruits
        case enimals
        
        var title: String {
            switch self {
            case .halloween: return "Halloween"
            case .flowers: return "Flowers"
            case .fruits: return "Fruits"
            case .enimals: return "Enimals"
            }
        }
        
        var emojis: [String] {
            switch self {
            case .halloween: return ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
            case .flowers: return ["🌹", "🌸", "💐", "🌺", "🌷", "🌻", "🥀", "🌼", "💮", "🪷", "🪻", "🏵", "🌾"]
            case .fruits: return ["🍏", "🍎", "🍐", "🍊", "🍋", "🍋‍🟩", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑"]
            case .enimals: return ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸"]
            }
        }
        
        var themeColor: Color {
            switch self {
            case .halloween: return .orange
            case .flowers: return .green
            case .fruits: return .yellow
            case .enimals: return .blue
            }
        }
    }
    
    @State var cardCount = 4
    @State var cardTheme: CardTheme = .enimals
    
    var body: some View {
        VStack {
            cardCountAdjusters
            ScrollView {
                cards
            }
            Spacer()
            cardThemes
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            let currentCards = cardTheme.emojis.shuffled().prefix(cardCount)
            let shuffledEmojis = (currentCards + currentCards).shuffled()
            ForEach(0..<shuffledEmojis.count, id: \.self) { index in
                CardView(content: shuffledEmojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundStyle(cardTheme.themeColor)
    }
    
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            Text("Memorize!")
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    var cardRemover: some View {
        cardCountAdjuster(by: -1, symbol: "rectangle.stack.fill.badge.minus")
    }
    
    var cardAdder: some View {
        cardCountAdjuster(by: 1, symbol: "rectangle.stack.fill.badge.plus")
    }
    
    var cardThemes: some View {
        HStack(spacing: 30) {
            ForEach(CardTheme.allCases, id: \.self) { theme in
                Button {
                    cardTheme = theme
                } label: {
                    VStack {
                        Text(theme.emojis.first ?? "?")
                            .shadow(color: theme.themeColor, radius: cardTheme == theme ? 20 : 0)
                            .font(.largeTitle)
                        Text(theme.title).lineLimit(1)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
    
    func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
        Button {
            cardCount += offset
        } label: {
            Image(systemName: symbol)
        }
        .disabled(cardCount + offset < 4 || cardCount + offset > cardTheme.emojis.count)
    }
    
}

struct CardView: View {
    let content: String
    @State var isFaceUp = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    MemorizeGameView()
}
