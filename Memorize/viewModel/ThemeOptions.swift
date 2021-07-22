//
//  ThemeOptions.swift
//  Memorize
//
//  Created by Emily Thorne on 7/21/21.
//

import Foundation

struct ThemeOptions {
    static var themeOptions: Array<ThemeMemoryGame> =
    [
        ThemeMemoryGame(name: ThemeName.animals, content: EmojiConstants.animalEmojis, numPairsOfCards: 10, color: ThemeColors.green),
        ThemeMemoryGame(name: ThemeName.clothing, content: EmojiConstants.clothingEmojis, numPairsOfCards: 8, color: ThemeColors.teal),
        ThemeMemoryGame(name: ThemeName.faces, content: EmojiConstants.facesEmojis, numPairsOfCards: 10, color: ThemeColors.orange),
        ThemeMemoryGame(name: ThemeName.food, content: EmojiConstants.foodEmojis, numPairsOfCards: 8, color: ThemeColors.purple),
        ThemeMemoryGame(name: ThemeName.holidays, content: EmojiConstants.holidaysEmojis, numPairsOfCards: 6, color: ThemeColors.red),
        ThemeMemoryGame(name: ThemeName.household, content: EmojiConstants.householdEmojis, numPairsOfCards: 10, color: ThemeColors.periwinkle),
        ThemeMemoryGame(name: ThemeName.ocean, content: EmojiConstants.oceanEmojis, numPairsOfCards: 10, color: ThemeColors.royalBlue)
    ]
}
