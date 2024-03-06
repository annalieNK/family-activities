//
//  Activity.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/10/24.
//

import Foundation
import SwiftData
import MapKit

@Model
class Activity: Codable, Identifiable, Equatable, ObservableObject {
    enum CodingKeys: CodingKey {
        case id, name, type, links, latitude, longitude
    }
    
    let id: String
    var name: String
    var type: String
    var links: [String]
    let latitude: Double
    let longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    
    // prevent this property to be changed outside this file (through the use of the toggle function)
    var isSaved = false //fileprivate(set) var isSaved = false
    
    var symbol: String {
        switch type {
        case "beach": return "beach.umbrella.fill"
        case "hiking": return "figure.hiking"
        case "family activity": return "figure.and.child.holdinghands"
        default: return "star"
        }
    }
    
    static let example = Activity(id: String(), name: "Test Name", type: "family activity", links: ["swift", "apple"], latitude: 37.77, longitude: -122.42)
    
    init(id: String, name: String, type: String, links: [String], latitude: Double, longitude: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.links = links
        self.latitude = latitude
        self.longitude = longitude
    }
    
    // conform to Codable
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(String.self, forKey: .type)
        links = try container.decode([String].self, forKey: .links)
        latitude = try container.decode(Double.self, forKey: .latitude)
        longitude = try container.decode(Double.self, forKey: .longitude)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        try container.encode(links, forKey: .links)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
    
    // write a comparison function to make sure locations are unique (according to the Identifiable and Equatable protocols)
    static func ==(lhs: Activity, rhs: Activity) -> Bool {
        lhs.id == rhs.id
    }
    
    static func <(lhs: Activity, rhs: Activity) -> Bool {
        lhs.name < rhs.name
    }
}

