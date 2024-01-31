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
    struct ActivitiesType: Codable {
        let name: String
        let type: String
    }
    
    enum CodingKeys: CodingKey {
        case id, name, text, activities, activityNames
    }
    
    let id: Int//UUID
    var name: String
    var text: String
    var activities: [String]
    var activityNames: [ActivitiesType]
    //var activities: [Activity]
    
//    var activityTypes: [Activity] {
//            // map each facility to its name
//        activities.map(Activity.init)
//        }
    //@Relationship(inverse: \Activity.recommendations) var activities: [Activity]
    
    static let example = Recommendation(id: Int(), name: "Text Name", text: "Test Text", activities: [], activityNames: [])//, activities: []) //UUID()
    
    init(id: Int, name: String, text: String, activities: [String], activityNames: [ActivitiesType]) { //UUID
        self.id = id
        self.name = name
        self.text = text
        self.activities = activities
        self.activityNames = activityNames
    }
    
    // conform to Codable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id) //UUID
        name = try container.decode(String.self, forKey: .name)
        text = try container.decode(String.self, forKey: .text)
        activities = try container.decode([String].self, forKey: .activities)
        activityNames = try container.decode([ActivitiesType].self, forKey: .activityNames)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(text, forKey: .text)
        try container.encode(activities, forKey: .activities)
        try container.encode(activityNames, forKey: .activityNames)
    }
}
