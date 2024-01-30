//
//  Recommendation.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/29/24.
//

import Foundation
import SwiftData

@Model
class Recommendation: Codable { //Identifiable
    enum CodingKeys: CodingKey {
        case id, name, text//, activities
    }
    
    let id: Int//UUID
    var name: String
    var text: String
    //@Relationship(inverse: \Activity.recommendations) var activities: [Activity]
    
    static let example = Recommendation(id: Int(), name: "Text Name", text: "Test Text")//, activities: []) //UUID()
    
    init(id: Int, name: String, text: String) {//}, activities: [Activity]) { //UUID
        self.id = id
        self.name = name
        self.text = text
        //self.activities = activities
    }
    
    // conform to Codable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id) //UUID
        name = try container.decode(String.self, forKey: .name)
        text = try container.decode(String.self, forKey: .text)
        //activities = try container.decode([Activity].self, forKey: .activities)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(text, forKey: .text)
        //try container.encode(activities, forKey: .activities)
    }
}
