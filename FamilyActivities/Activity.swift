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
        case id, name, email
    }
    
    let id: UUID
    var name: String
    var email: String
    
    static let example = Activity(id: UUID(), name: "Test Name", email: "Test Type")
    
    init(id: UUID, name: String, email: String) {
        self.id = id
        self.name = name
        self.email = email
    }
    
    // conform to Codable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(email, forKey: .email)
    }
}

