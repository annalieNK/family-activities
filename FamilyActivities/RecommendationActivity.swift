//
//  RecommendationActivity.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 2/1/24.
//

import Foundation

class RecommendationActivity: Codable, Hashable, Identifiable {
    let id: String
    var name: String
    var type: String
    var links: [String]
    
    static let example = RecommendationActivity(id: String(), name: "Test Name", type: "Test Type", links: ["swift", "apple"])

    
    init(id: String, name: String, type: String, links: [String]) {
        self.id = id
        self.name = name
        self.type = type
        self.links = links
    }
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(name)
            hasher.combine(type)
        }
    
    static func ==(lhs: RecommendationActivity, rhs: RecommendationActivity) -> Bool {
            lhs.id == rhs.id
        }
}
