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
        case id, name, text, activities, friends, items
    }
    
    let id: Int//UUID
    var name: String
    var text: String
    var activities: [String]
    var friends: [Friend]
    var items: [Activity]
    
//    var activityTypes: [Activity] {
//            // map each facility to its name
//        activities.map(Activity.init)
//        }
    //@Relationship(inverse: \Activity.recommendations) var activities: [Activity]
    
    static let example = Recommendation(id: Int(), name: "Text Name", text: "Test Text", activities: [], friends: [], items: []) //UUID()
    
    init(id: Int, name: String, text: String, activities: [String], friends: [Friend], items: [Activity]) { //UUID
        self.id = id
        self.name = name
        self.text = text
        self.activities = activities
        self.friends = friends
        self.items = items
    }
    
    // conform to Codable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id) //UUID
        name = try container.decode(String.self, forKey: .name)
        text = try container.decode(String.self, forKey: .text)
        activities = try container.decode([String].self, forKey: .activities)
        friends = try container.decode([Friend].self, forKey: .friends)
        items = try container.decode([Activity].self, forKey: .items)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(text, forKey: .text)
        try container.encode(activities, forKey: .activities)
        try container.encode(friends, forKey: .friends)
        try container.encode(items, forKey: .items)
    }
}
