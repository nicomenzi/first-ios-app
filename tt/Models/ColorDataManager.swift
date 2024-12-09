//
//  ColorDataManager.swift
//  tt
//
//  Created by Nico Menzi on 09.12.2024.
//

import Foundation

class ColorDataManager {
    static let shared = ColorDataManager()
    private init() {}

    var colors: [ColorModel] = []

    func getColor(byIndex index: Int) -> ColorModel? {
        return colors.first { $0.index == index }
    }
}
