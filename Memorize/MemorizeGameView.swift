//
//  MemorizeGameView.swift
//  Memorize
//
//  Created by Veronika Horovenko on 25.09.2025.
//

import SwiftUI

struct MemorizeGameView: View {
    
    @ObservedObject var viewModel: MemorizeGameViewModel
    
    @State var cardCount = 4
    
    var body: some View {
        VStack {
            Text("\(viewModel.theme.title)")
                .imageScale(.large)
                .font(.largeTitle)
            Text("Points: \(viewModel.score)").animation(.default)
            ScrollView {
                cards.animation(.default, value: viewModel.cards)
            }
            Spacer()
            Button("New Game") {
                viewModel.newGame()
            }
            .font(.title)
            .buttonStyle(.borderless)
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing:  0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(1/1, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundStyle(viewModel.themeColor)
    }
    
}

struct CardView: View {
    var card: MemorizeGameModel<String>.Card
    
    init(_ card: MemorizeGameModel<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    MemorizeGameView(viewModel: MemorizeGameViewModel())
}
