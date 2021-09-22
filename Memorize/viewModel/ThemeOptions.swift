//
//  ThemeOptions.swift
//  Memorize
//
//  Created by Emily Thorne on 7/21/21.
//

import Foundation

class ThemeStore: ObservableObject {
    let name: String
    
    @Published var themes = [Theme]() {
        didSet {
            storeInUserDefaults()
        }
    }
    
    private var userDefaultsKey: String {
        "ThemeStore:" + name
    }
    
    private func storeInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(themes), forKey: userDefaultsKey)
    }
    
    // array of themes of card content
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: userDefaultsKey),
           let decodedThemes = try? JSONDecoder().decode(Array<Theme>.self, from: jsonData) {
            themes = decodedThemes
        }
    }
    
    init(named name: String) {
        self.name = name
        restoreFromUserDefaults()
        if themes.isEmpty {
            // ASK BRAD
            insertTheme(named: "Vehicles", content: "🚙🚗🚘🚕🚖🏎🚚🛻🚛🚐🚓🚔🚑🚒🚀✈️🛫🛬🛩🚁🛸🚲🏍🛶⛵️🚤🛥🛳⛴🚢🚂🚝🚅🚆🚊🚉🚇🛺🚜", numPairsOfCards: <#T##Int#>, color: ThemeColors.royalBlue)
            insertTheme(named: "Sports", content: "🏈⚾️🏀⚽️🎾🏐🥏🏓⛳️🥅🥌🏂⛷🎳", numPairsOfCards: 14, color: ThemeColors.red)
            insertTheme(named: "Music", content: "🎼🎤🎹🪘🥁🎺🪗🪕🎻", numPairsOfCards: 12, color: ThemeColors.purple)
            insertTheme(named: "Animals", content: "🐥🐣🐂🐄🐎🐖🐏🐑🦙🐐🐓🐁🐀🐒🦆🦅🦉🦇🐢🐍🦎🦖🦕🐅🐆🦓🦍🦧🦣🐘🦛🦏🐪🐫🦒🦘🦬🐃🦙🐐🦌🐕🐩🦮🐈🦤🦢🦩🕊🦝🦨🦡🦫🦦🦥🐿🦔", numPairsOfCards: <#T##Int#>, color: ThemeColors.green)
            insertTheme(named: "Animal Faces", content: "🐵🙈🙊🙉🐶🐱🐭🐹🐰🦊🐻🐼🐻‍❄️🐨🐯🦁🐮🐷🐸🐲", numPairsOfCards: <#T##Int#>, color: ThemeColors.teal)
            insertTheme(named: "Flora", content: "🌲🌴🌿☘️🍀🍁🍄🌾💐🌷🌹🥀🌺🌸🌼🌻", numPairsOfCards: <#T##Int#>, color: ThemeColors.periwinkle)
            insertTheme(named: "Weather", content: "☀️🌤⛅️🌥☁️🌦🌧⛈🌩🌨❄️💨☔️💧💦🌊☂️🌫🌪", numPairsOfCards: <#T##Int#>, color: ThemeColors.yellow)
            insertTheme(named: "COVID", content: "💉🦠😷🤧🤒", numPairsOfCards: 3, color: ThemeColors.orange)
            insertTheme(named: "Faces", content: "😀😃😄😁😆😅😂🤣🥲☺️😊😇🙂🙃😉😌😍🥰😘😗😙😚😋😛😝😜🤪🤨🧐🤓😎🥸🤩🥳😏😞😔😟😕🙁☹️😣😖😫😩🥺😢😭😤😠😡🤯😳🥶😥😓🤗🤔🤭🤫🤥😬🙄😯😧🥱😴🤮😷🤧🤒🤠", numPairsOfCards: <#T##Int#>, color: ThemeColors.royalBlue)
        }
    }
    
    // MARK: - Intent
    
    func theme(at index: Int) -> Theme {
        let safeIndex = min(max(index, 0), themes.count - 1)
        return themes[safeIndex]
    }
    
    @discardableResult
    func removeTheme(at index: Int) -> Int {
        if themes.count > 1, themes.indices.contains(index) {
            themes.remove(at: index)
        }
        return index % themes.count
    }
    
    func insertTheme(named name: String, content: String? = nil, numPairsOfCards: Int, color: String, at index: Int = 0) {
        let unique = (themes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        // ASK BRAD
        let theme = Theme(name: name, content: content!, numPairsOfCards: numPairsOfCards, color: color, id: unique)
        let safeIndex = min(max(index, 0), themes.count)
        themes.insert(theme, at: safeIndex)
    }
}

//struct ThemeOptions {
//    static var themeOptions: Array<ThemeMemoryGame> =
//    [
//        ThemeMemoryGame(name: ThemeName.animals, content: EmojiConstants.animalEmojis, numPairsOfCards: 10, color: ThemeColors.green),
//        ThemeMemoryGame(name: ThemeName.clothing, content: EmojiConstants.clothingEmojis, numPairsOfCards: 8, color: ThemeColors.teal),
//        ThemeMemoryGame(name: ThemeName.faces, content: EmojiConstants.facesEmojis, numPairsOfCards: 10, color: ThemeColors.orange),
//        ThemeMemoryGame(name: ThemeName.food, content: EmojiConstants.foodEmojis, numPairsOfCards: 8, color: ThemeColors.purple),
//        ThemeMemoryGame(name: ThemeName.holidays, content: EmojiConstants.holidaysEmojis, numPairsOfCards: 6, color: ThemeColors.red),
//        ThemeMemoryGame(name: ThemeName.household, content: EmojiConstants.householdEmojis, numPairsOfCards: 10, color: ThemeColors.periwinkle),
//        ThemeMemoryGame(name: ThemeName.ocean, content: EmojiConstants.oceanEmojis, numPairsOfCards: 10, color: ThemeColors.royalBlue)
//    ]
//}
