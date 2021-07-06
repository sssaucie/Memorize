//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Emily Thorne on 6/29/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    private let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(gameViewModel: game)
        }
    }
}
