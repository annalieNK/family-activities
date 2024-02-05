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
        case id, name, type, links
    }
    
    let id: String
    var name: String
    var type: String
    var links: [String]
    
    static let example = Activity(id: String(), name: "Test Name", type: "Test Type", links: ["swift", "apple"])
    
    init(id: String, name: String, type: String, links: [String]) {
        self.id = id
        self.name = name
        self.type = type
        self.links = links
    }
    
    // conform to Codable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(String.self, forKey: .type)
        links = try container.decode([String].self, forKey: .links)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(links, forKey: .links)
    }
}

