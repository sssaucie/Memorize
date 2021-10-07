//
//  RGBAColor.swift
//  Memorize
//
//  Created by Emily Thorne on 9/27/21.
//

import SwiftUI

struct RGBAColor: Codable, Hashable, Equatable {
    let red: Double
    let green: Double
    let blue: Double
    let opacity: Double
}

extension Color {
    init(rgbaColor rgba: RGBAColor) {
        self.init(.sRGB, red: rgba.red, green: rgba.green, blue: rgba.blue, opacity: rgba.opacity)
    }
}

extension RGBAColor {
    init(color: Color) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var opacity: CGFloat = 0
        
        if let cgColor = color.cgColor {
            UIColor(cgColor: cgColor).getRed(&red, green: &green, blue: &blue, alpha: &opacity)
        }
        self.init(red: Double(red), green: Double(green), blue: Double(blue), opacity: Double(opacity))
    }
}
