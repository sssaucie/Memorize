//
//  ThemeOptions.swift
//  Memorize
//
//  Created by Emily Thorne on 7/21/21.
//

import Foundation
import SwiftUI

class ThemeOptions: ObservableObject {
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
            insertTheme(named: "Vehicles", content: ["🚙", "🚗", "🚘", "🚕", "🚖", "🏎", "🚚", "🛻", "🚛", "🚐", "🚓", "🚔", "🚑", "🚒", "🚀", "✈️", "🛫", "🛬", "🛩", "🚁", "🛸", "🚲", "🏍", "🛶", "⛵️", "🚤", "🛥", "🛳", "⛴", "🚢", "🚂", "🚝", "🚅", "🚆", "🚊", "🚉", "🚇", "🛺", "🚜"], numPairsOfCards: 6, themeColor: .gray)
            insertTheme(named: "Sports", content: ["🏈", "⚾️", "🏀", "⚽️", "🎾", "🏐", "🥏", "🏓", "⛳️", "🥅", "🥌", "🏂", "⛷", "🎳"], numPairsOfCards: 14, themeColor: .red)
            insertTheme(named: "Music", content: ["🎼", "🎤", "🎹", "🪘", "🥁", "🎺", "🪗", "🪕", "🎻"], numPairsOfCards: 6, themeColor: .purple)
            insertTheme(named: "Animals", content: ["🐥", "🐣", "🐂", "🐄", "🐎", "🐖", "🐏", "🐑", "🦙", "🐐", "🐓", "🐁", "🐀", "🐒", "🦆", "🦅", "🦉", "🦇", "🐢", "🐍", "🦎", "🦖", "🦕", "🐅", "🐆", "🦓", "🦍", "🦧", "🦣", "🐘", "🦛", "🦏", "🐪", "🐫", "🦒", "🦘", "🦬", "🐃", "🦙", "🐐", "🦌", "🐕", "🐩", "🦮", "🐈", "🦤", "🦢", "🦩", "🕊", "🦝", "🦨", "🦡", "🦫", "🦦", "🦥", "🐿", "🦔"], numPairsOfCards: 6, themeColor: .green)
            insertTheme(named: "Animal Faces", content: ["🐵", "🙈", "🙊", "🙉", "🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮", "🐷", "🐸", "🐲"], numPairsOfCards: 6, themeColor: .black)
            insertTheme(named: "Flora", content: ["🌲", "🌴", "🌿", "☘️", "🍀", "🍁", "🍄", "🌾", "💐", "🌷", "🌹", "🥀", "🌺", "🌸", "🌼", "🌻"], numPairsOfCards: 6, themeColor: .pink)
            insertTheme(named: "Weather", content: ["☀️", "🌤", "⛅️", "🌥", "☁️", "🌦", "🌧", "⛈", "🌩", "🌨", "❄️", "💨", "☔️", "💧", "💦", "🌊", "☂️", "🌫", "🌪"], numPairsOfCards: 6, themeColor: .yellow)
            insertTheme(named: "COVID", content: ["💉", "🦠", "😷", "🤧", "🤒"], numPairsOfCards: 4, themeColor: .orange)
            insertTheme(named: "Faces", content: ["😀", "😃", "😄", "😁", "😆", "😅", "😂", "🤣", "🥲", "☺️", "😊", "😇", "🙂", "🙃", "😉", "😌", "😍", "🥰", "😘", "😗", "😙", "😚", "😋", "😛", "😝", "😜", "🤪", "🤨", "🧐", "🤓", "😎", "🥸", "🤩", "🥳", "😏", "😞", "😔", "😟", "😕", "🙁", "☹️", "😣", "😖", "😫", "😩", "🥺", "😢", "😭", "😤", "😠", "😡", "🤯", "😳", "🥶", "😥", "😓", "🤗", "🤔", "🤭", "🤫", "🤥", "😬", "🙄", "😯", "😧", "🥱", "😴", "🤮", "😷", "🤧", "🤒", "🤠"], numPairsOfCards: 6, themeColor: .blue)
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
    
    func insertTheme(named name: String, content: [String]? = nil, numPairsOfCards pairs: Int, themeColor color: Color, at index: Int = 0) {
        let unique = (themes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        // ASK BRAD
        let theme = Theme(name: name, content: content!, numPairsOfCards: pairs, color: RGBAColor(color: color), id: unique)
        let safeIndex = min(max(index, 0), themes.count)
        themes.insert(theme, at: safeIndex)
    }
    
//    func insertTheme(named name: String, content: [String]? = nil, numPairsOfCards: Int, color: Color, at index: Int = 0) {
//        let unique = (themes.max(by: { $0.id < $1.id })?.id ?? 0) + 1
//        let theme = Theme(name: name, content: content!, numPairsOfCards: numPairsOfCards, color: color, id: unique)
//        let safeIndex = min(max(index, 0), themes.count)
//        themes.insert(theme, at: safeIndex)
//    }
}
