//
//  MemorizeGameViewModel.swift
//  Memorize
//
//  Created by Veronika Horovenko on 02.10.2025.
//

import SwiftUI
import Combine

class MemorizeGameViewModel: ObservableObject {
    
    private static func createMemoryGame(with themeModel: CardThemeModel) -> MemorizeGameModel<String> {
        return MemorizeGameModel(numberOfPairsOfCards: themeModel.currentTheme.numberOfPairs) { pairIndex in
            if themeModel.currentTheme.emojis.indices.contains(pairIndex) {
                return themeModel.currentTheme.emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    init(themeModel: CardThemeModel = .init()) {
        self.themeModel = themeModel
        self.model = MemorizeGameViewModel.createMemoryGame(with: themeModel)
    }
    
    @Published private var model: MemorizeGameModel<String>
    @Published private var themeModel: CardThemeModel {
        didSet { model = MemorizeGameViewModel.createMemoryGame(with: themeModel) }
    }
    
    
    var cards: Array<MemorizeGameModel<String>.Card> {
        return model.cards
    }
    
    var theme: CardThemeModel.Theme {
        return themeModel.currentTheme
    }
    
    var themeColor: Color {
        switch themeModel.currentTheme {
        case .halloween: return .orange
        case .flowers: return .green
        case .fruits: return .yellow
        case .enimals: return .blue
        case .cars: return .red
        case .countries: return .purple
        }
    }
    
    var score: Int {
        return model.score
    }
    
    func newGame() {
        themeModel = .init()
    }
    
    func choose(_ card: MemorizeGameModel<String>.Card) {
        model.choose(card)
    }
    
}
