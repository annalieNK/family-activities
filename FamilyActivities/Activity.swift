//
//  Activity.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/10/24.
//

import Foundation
import SwiftData

@Model
class Activity: Codable { //Identifiable
    enum CodingKeys: CodingKey {
        case id, name, type, links
    }
    
    let id: String //Int//UUID
    var name: String
    var type: String
    var links: [String]
    //@Relationship var recommendations: [Recommendation]
    
    static let example = Activity(id: String(), name: "Test Name", type: "Test Type", links: ["swift", "apple"])//, recommendations: []) //Int() // UUID()
    
    init(id: String, name: String, type: String, links: [String]) {//}, recommendations: [Recommendation]) { //UUID
        self.id = id
        self.name = name
        self.type = type
        self.links = links
        //self.recommendations = recommendations
    }
    
    // conform to Codable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id) //UUID //Int
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(String.self, forKey: .type)
        links = try container.decode([String].self, forKey: .links)
        //recommendations = try container.decode([Recommendation].self, forKey: .recommendations)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(links, forKey: .links)
        //try container.encode(recommendations, forKey: .recommendations)
    }
}

