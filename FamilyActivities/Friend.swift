//
//  Friend.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/31/24.
//

import Foundation
import SwiftData

@Model
class Friend: Codable {
    enum CodingKeys: CodingKey {
        case id, name
    }

    let id: String
    var name: String

    init(id: String, name: String) {
        self.id = id
        self.name = name
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
}