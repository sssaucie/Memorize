//
//  ThemeOptions.swift
//  Memorize
//
//  Created by Emily Thorne on 7/21/21.
//

import Foundation

struct ThemeOptions {
    static let themeOptions: [Int: ThemeMemoryGame<String>] =
    [
        0: ThemeMemoryGame(numPairsOfCards: 10, name: ThemeName.animals, color: ThemeColors.green, content: EmojiConstants.animalEmojis),
        1: ThemeMemoryGame(numPairsOfCards: 8, name: ThemeName.clothing, color: ThemeColors.teal, content: EmojiConstants.clothingEmojis),
        2: ThemeMemoryGame(numPairsOfCards: 10, name: ThemeName.faces, color: ThemeColors.orange, content: EmojiConstants.facesEmojis),
        3: ThemeMemoryGame(numPairsOfCards: 8, name: ThemeName.food, color: ThemeColors.purple, content: EmojiConstants.foodEmojis),
        4: ThemeMemoryGame(numPairsOfCards: 7, name: ThemeName.holidays, color: ThemeColors.red, content: EmojiConstants.holidaysEmojis),
        5: ThemeMemoryGame(numPairsOfCards: 10, name: ThemeName.household, color: ThemeColors.periwinkle, content: EmojiConstants.householdEmojis),
        6: ThemeMemoryGame(numPairsOfCards: 10, name: ThemeName.ocean, color: ThemeColors.royalBlue, content: EmojiConstants.oceanEmojis),
    ]
}
