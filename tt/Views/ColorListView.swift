//
//  ColorListView.swift
//  colors
//
//  Created by Nico Menzi on 09.12.2024.
//
import SwiftUI

struct ColorListView: View {
    @State private var colors: [ColorModel] = []
    @State private var isLoading = false
    @State private var errorMessage: String? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                if isLoading {
                    ProgressView("Loading colors...") // Show a loading indicator
                        .progressViewStyle(CircularProgressViewStyle())
                } else if let errorMessage = errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else {
                    List(colors, id: \.index) { color in
                        NavigationLink(destination: ColorDetailView(color: color)) {
                            HStack {
                                Circle()
                                    .fill(Color(hex: color.hex))  // Convert hex to SwiftUI color
                                    .frame(width: 30, height: 30)
                                Text(color.name)
                            }
                        }
                    }
                }
            }
            .onAppear {
                loadColors()  // Fetch data from the URL when the view appears
            }
            .navigationTitle("Colors")
        }
    }

    func loadColors() {
        isLoading = true
        errorMessage = nil
        
        // Call NetworkManager to fetch data
        NetworkManager.shared.loadColorsFromURL { colors, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = error
                }
            } else if let colors = colors {
                DispatchQueue.main.async {
                    self.colors = colors // Update the colors state with the fetched data
                }
            }
        }
    }
}
