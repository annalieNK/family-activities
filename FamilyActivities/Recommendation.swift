//
//  Recommendation.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/29/24.
//

import Foundation
import SwiftData

@Model
class Recommendation: Codable {
    
    enum CodingKeys: CodingKey {
        case id, name, text, activityNames
    }
    
    let id: Int//UUID
    var name: String
    var text: String
    var activityNames: [String]
    
    static let example = Recommendation(id: Int(), name: "Text Name", text: "Test Text", activityNames: []) //UUID()
    
    init(id: Int, name: String, text: String, activityNames: [String]) { //UUID
        self.id = id
        self.name = name
        self.text = text
        self.activityNames = activityNames
    }
    
    // conform to Codable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id) //UUID
        name = try container.decode(String.self, forKey: .name)
        text = try container.decode(String.self, forKey: .text)
        activityNames = try container.decode([String].self, forKey: .activityNames)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(text, forKey: .text)
        try container.encode(activityNames, forKey: .activityNames)
    }
}
