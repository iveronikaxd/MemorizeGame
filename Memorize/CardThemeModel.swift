//
//  CardThemeModel.swift
//  Memorize
//
//  Created by Veronika Horovenko on 02.10.2025.
//

import Foundation

struct CardThemeModel {
    
    private(set) var currentTheme: Theme
    private(set) var level: Int = 1
    var numberOfPairs: Int {
        return currentTheme.numberOfPairs(for: level)
    }
    
    private let themes: [Theme] = [.halloween, .flowers, .fruits, .enimals, .cars, .countries]
    
    init() {
        currentTheme = themes.randomElement() ?? .halloween
    }
    
    mutating func changeTheme() {
        currentTheme = themes.randomElement() ?? .halloween
    }
    
    mutating func nextLevel(for score: Int) {
        level = max(1, level + (score > 0 ? 1 : -1))
    }
    
    enum Theme {
        case halloween
        case flowers
        case fruits
        case enimals
        case cars
        case countries
        
        var title: String {
            switch self {
            case .halloween: return "Halloween"
            case .flowers: return "Flowers"
            case .fruits: return "Fruits"
            case .enimals: return "Enimals"
            case .cars: return "Cars"
            case .countries: return "Countries"
            }
        }
        
        var emojis: [String] {
            switch self {
            case .halloween: return ["👻", "🎃", "🕷️", "😈", "💀", "🕸️", "🧙‍♀️", "🙀", "👹", "😱", "☠️", "🍭"]
            case .flowers: return ["🌹", "🌸", "💐", "🌺", "🌷", "🌻", "🥀", "🌼", "💮", "🪷", "🪻", "🏵", "🌾"]
            case .fruits: return ["🍏", "🍎", "🍐", "🍊", "🍋", "🍋‍🟩", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑"]
            case .enimals: return ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸"]
            case .cars: return ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎️", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛵"]
            case .countries: return ["🇩🇪", "🇨🇦", "🇺🇦", "🇬🇧", "🇬🇷", "🇫🇷", "🇮🇹", "🇯🇵", "🇺🇸", "🇸🇪", "🇨🇭", "🇱🇹", "🇵🇱", "🇪🇸", "🇦🇹"]
            }
        }
        
        func numberOfPairs(for level: Int) -> Int {
            return self.emojis.indices.contains(level) ? max(2, level + 1) : self.emojis.count
        }
    }
    
    
}
