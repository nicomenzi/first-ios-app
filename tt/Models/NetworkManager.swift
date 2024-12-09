//
//  NetworkManager.swift
//  tt
//
//  Created by Nico Menzi on 09.12.2024.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager() // Singleton instance
    
    private init() {} // Private initializer to prevent instantiation

    // Fetch colors from URL and decode the JSON
    func loadColorsFromURL(completion: @escaping ([ColorModel]?, String?) -> Void) {
        guard let url = URL(string: "https://sanzo-wada.dmbk.io/assets/colors.json") else {
            completion(nil, "Invalid URL")
            return
        }

        // Start the network request
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Handle errors
            if let error = error {
                completion(nil, "Error fetching data: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                completion(nil, "No data received")
                return
            }

            let decoder = JSONDecoder()
            do {
                let response = try decoder.decode(ColorResponse.self, from: data)
                completion(response.colors, nil) // Return the colors array
            } catch {
                completion(nil, "Decoding error: \(error.localizedDescription)")
            }
        }

        task.resume() // Start the data task
    }
}
