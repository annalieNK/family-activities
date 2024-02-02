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
        case id, crew, descript }
    
    struct CrewRole: Codable {
            let name: String
            let role: String
        }
    
    let id: Int
    let crew: [CrewRole]
    var descript: String

    static let example = Recommendation(id: Int(), crew: [], descript: "Text Name")
    
    init(id: Int, crew: [CrewRole], descript: String) {
        self.id = id
        self.crew = crew
        self.descript = descript
    }
    
    // conform to Codable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        crew = try container.decode([CrewRole].self, forKey: .crew)
        descript = try container.decode(String.self, forKey: .descript)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(crew, forKey: .crew)
        try container.encode(descript, forKey: .descript)
    }
}
