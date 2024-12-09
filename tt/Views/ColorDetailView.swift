//
//  ColorDetailView.swift
//  colors
//
//  Created by Nico Menzi on 09.12.2024.
//
import SwiftUI

struct ColorDetailView: View {
    let color: ColorModel

    var body: some View {
        VStack {
            Circle()
                .fill(Color(hex: color.hex))
                .frame(width: 100, height: 100)
                .padding()

            Text(color.name)
                .font(.title)

            Text("CMYK: \(color.cmykArray.map { String($0) }.joined(separator: ", "))")
            Text("RGB: \(color.rgbArray.map { String($0) }.joined(separator: ", "))")
            Text("Hex: \(color.hex)")

            Divider()

            Text("Combinations")
                .font(.headline)
                .padding()

            List {
                ForEach(color.combinations, id: \.self) { combinationIndex in
                    if let combination = ColorDataManager.shared.getColor(byIndex: combinationIndex) {
                        HStack {
                            Circle()
                                .fill(combination.swiftUIColor)
                                .frame(width: 30, height: 30)
                            Text(combination.name)
                        }
                    }
                }
            }
        }
        .padding()
        .navigationTitle(color.name) // Optional: Add the color name as the title
    }
}
