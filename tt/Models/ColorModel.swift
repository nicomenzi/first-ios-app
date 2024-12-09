//
//  color.swift
//  colors
//
//  Created by Nico Menzi on 09.12.2024.
//

import SwiftUI

struct ColorModel: Decodable {
    let index: Int
    let name: String
    let slug: String
    let cmykArray: [Int]
    let rgbArray: [Int]
    let hex: String
    let combinations: [Int]
    let useCount: Int

    private enum CodingKeys: String, CodingKey {
        case index
        case name
        case slug
        case cmykArray = "cmyk_array"
        case rgbArray = "rgb_array"
        case hex
        case combinations
        case useCount = "use_count"
    }

    // Computed property to convert hex to SwiftUI.Color
    var swiftUIColor: SwiftUI.Color {
        return SwiftUI.Color(hex: hex)
    }
}

