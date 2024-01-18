//
//  Activity.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/10/24.
//

import Foundation
import SwiftData

@Model
class Activity: Codable {
    enum CodingKeys: CodingKey {
        case id, name, type
    }
    
    let id: Int//UUID
    var name: String
    var type: String
    
    static let example = Activity(id: Int(), name: "Test Name", type: "Test Type") //UUID()
    
    init(id: Int, name: String, type: String) { //UUID
        self.id = id
        self.name = name
        self.type = type
    }
    
    // conform to Codable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id) //UUID
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(String.self, forKey: .type)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
    }
}

