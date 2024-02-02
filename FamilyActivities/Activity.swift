//
//  Activity.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/10/24.
//

import Foundation
import SwiftData

@Model
class Activity: Codable, Identifiable {
    enum CodingKeys: CodingKey {
        case id, name, descript
    }
    
    let id: String
    let name: String
    let descript: String
    
    static let example = Activity(id: String(), name: "Test Name", descript: "Test Description")
    
    init(id: String, name: String, descript: String) {
        self.id = id
        self.name = name
        self.descript = descript
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        descript = try container.decode(String.self, forKey: .descript)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(descript, forKey: .descript)
    }
}

