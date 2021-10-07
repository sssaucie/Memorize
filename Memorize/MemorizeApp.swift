//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Emily Thorne on 6/29/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var themeOptions = ThemeOptions(named: "Default")

    var body: some Scene {
        WindowGroup {
            ThemeChooser()
                .environmentObject(themeOptions)
        }
    }
}
