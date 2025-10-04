//
//  CardThemeModel.swift
//  Memorize
//
//  Created by Veronika Horovenko on 02.10.2025.
//

import Foundation

struct CardThemeModel {
    
    var currentTheme: Theme
    
    private let themes: [Theme] = [.halloween, .flowers, .fruits, .enimals, .cars, .countries]
    
    init() {
        currentTheme = themes.randomElement() ?? .halloween
    }
    
    mutating func changeTheme() {
        currentTheme = themes.randomElement() ?? .halloween
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
        
        var numberOfPairs: Int {
            return Int.random(in: 2...self.emojis.count)
//            switch self {
//            case .halloween: return 12
//            case .flowers: return 10
//            case .fruits: return 8
//            case .enimals: return 12
//            case .cars: return 8
//            case .countries: return 10
//            }
        }
    }
    
    
}
