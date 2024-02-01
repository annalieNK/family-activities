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
        case id, name, text, activityNames, activities
    }
    
    let id: Int//UUID
    var name: String
    var text: String
    var activityNames: [String]
    var activities: [Activity]
    
//    var activityTypes: [Activity] {
//            // map each facility to its name
//        activities.map(Activity.init)
//        }
    //@Relationship(inverse: \Activity.recommendations) var activities: [Activity]
    
    static let example = Recommendation(id: Int(), name: "Text Name", text: "Test Text", activityNames: [], activities: []) //UUID()
    
    init(id: Int, name: String, text: String, activityNames: [String], activities: [Activity]) { //UUID
        self.id = id
        self.name = name
        self.text = text
        self.activityNames = activityNames
        self.activities = activities
    }
    
    // conform to Codable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id) //UUID
        name = try container.decode(String.self, forKey: .name)
        text = try container.decode(String.self, forKey: .text)
        activityNames = try container.decode([String].self, forKey: .activityNames)
        activities = try container.decode([Activity].self, forKey: .activities)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(text, forKey: .text)
        try container.encode(activityNames, forKey: .activityNames)
        try container.encode(activities, forKey: .activities)
    }
}
