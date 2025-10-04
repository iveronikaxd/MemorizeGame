//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Veronika Horovenko on 25.09.2025.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = MemorizeGameViewModel()
    
    var body: some Scene {
        WindowGroup {
            MemorizeGameView(viewModel: game)
        }
    }
}
