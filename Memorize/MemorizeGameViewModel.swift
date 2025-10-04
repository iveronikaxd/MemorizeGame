//
//  MemorizeGameViewModel.swift
//  Memorize
//
//  Created by Veronika Horovenko on 02.10.2025.
//

import SwiftUI

class MemorizeGameViewModel {
    private static let emojis = ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
    
    private static func createMemoryGame() -> MemorizeGameModel<String> {
        return MemorizeGameModel(numberOfPairsOfCards: 4) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    private var model = createMemoryGame()
    
    
    var cards: Array<MemorizeGameModel<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: MemorizeGameModel<String>.Card) {
        model.choose(card)
    }
    
}
