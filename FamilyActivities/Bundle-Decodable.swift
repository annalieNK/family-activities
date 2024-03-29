//
//  Bundle-Decodable.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/10/24.
//

import Foundation

extension Bundle {
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        // store the file in the app's Documents Directory
//        guard let url = documentsDirectoryURL?.appendingPathComponent(file).appendingPathExtension("json") else {
//            fatalError("Failed to locate \(file) in bundle.")
//        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        
        // format dates
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
//        formatter.timeZone
        decoder.dateDecodingStrategy = .formatted(formatter)

//        guard let loaded = try? decoder.decode([String: Astronaut].self, from: data) else {
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }

        return loaded
    }
    
    var documentsDirectoryURL: URL? {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    }
}

