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
        case id, name, someText
    }

    let id: String
    var name: String
    var someText: String

    init(id: String, name: String, someText: String) {
        self.id = id
        self.name = name
        self.someText = someText
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        someText = try container.decode(String.self, forKey: .someText)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(someText, forKey: .someText)
    }
}
