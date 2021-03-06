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
            insertTheme(named: "Vehicles", content: ["π", "π", "π", "π", "π", "π", "π", "π»", "π", "π", "π", "π", "π", "π", "π", "βοΈ", "π«", "π¬", "π©", "π", "πΈ", "π²", "π", "πΆ", "β΅οΈ", "π€", "π₯", "π³", "β΄", "π’", "π", "π", "π", "π", "π", "π", "π", "πΊ", "π"], numPairsOfCards: 6, themeColor: .gray)
            insertTheme(named: "Sports", content: ["π", "βΎοΈ", "π", "β½οΈ", "πΎ", "π", "π₯", "π", "β³οΈ", "π₯", "π₯", "π", "β·", "π³"], numPairsOfCards: 6, themeColor: .red)
            insertTheme(named: "Music", content: ["πΌ", "π€", "πΉ", "πͺ", "π₯", "πΊ", "πͺ", "πͺ", "π»"], numPairsOfCards: 6, themeColor: .purple)
            insertTheme(named: "Animals", content: ["π₯", "π£", "π", "π", "π", "π", "π", "π", "π¦", "π", "π", "π", "π", "π", "π¦", "π¦", "π¦", "π¦", "π’", "π", "π¦", "π¦", "π¦", "π", "π", "π¦", "π¦", "π¦§", "π¦£", "π", "π¦", "π¦", "πͺ", "π«", "π¦", "π¦", "π¦¬", "π", "π¦", "π", "π¦", "π", "π©", "π¦?", "π", "π¦€", "π¦’", "π¦©", "π", "π¦", "π¦¨", "π¦‘", "π¦«", "π¦¦", "π¦₯", "πΏ", "π¦"], numPairsOfCards: 6, themeColor: .green)
            insertTheme(named: "Animal Faces", content: ["π΅", "π", "π", "π", "πΆ", "π±", "π­", "πΉ", "π°", "π¦", "π»", "πΌ", "π»ββοΈ", "π¨", "π―", "π¦", "π?", "π·", "πΈ", "π²"], numPairsOfCards: 6, themeColor: .black)
            insertTheme(named: "Flora", content: ["π²", "π΄", "πΏ", "βοΈ", "π", "π", "π", "πΎ", "π", "π·", "πΉ", "π₯", "πΊ", "πΈ", "πΌ", "π»"], numPairsOfCards: 6, themeColor: .pink)
            insertTheme(named: "Weather", content: ["βοΈ", "π€", "βοΈ", "π₯", "βοΈ", "π¦", "π§", "β", "π©", "π¨", "βοΈ", "π¨", "βοΈ", "π§", "π¦", "π", "βοΈ", "π«", "πͺ"], numPairsOfCards: 6, themeColor: .yellow)
            insertTheme(named: "COVID", content: ["π", "π¦ ", "π·", "π€§", "π€"], numPairsOfCards: 4, themeColor: .orange)
            insertTheme(named: "Faces", content: ["π", "π", "π", "π", "π", "π", "π", "π€£", "π₯²", "βΊοΈ", "π", "π", "π", "π", "π", "π", "π", "π₯°", "π", "π", "π", "π", "π", "π", "π", "π", "π€ͺ", "π€¨", "π§", "π€", "π", "π₯Έ", "π€©", "π₯³", "π", "π", "π", "π", "π", "π", "βΉοΈ", "π£", "π", "π«", "π©", "π₯Ί", "π’", "π­", "π€", "π ", "π‘", "π€―", "π³", "π₯Ά", "π₯", "π", "π€", "π€", "π€­", "π€«", "π€₯", "π¬", "π", "π―", "π§", "π₯±", "π΄", "π€?", "π·", "π€§", "π€", "π€ "], numPairsOfCards: 6, themeColor: .blue)
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
        // TEST for color issues
//        let color = RGBAColor(color: color)
//        print("Theme color: \(color)")
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
