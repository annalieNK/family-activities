//
//  AddedActivity.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/4/24.
//

import Foundation
import SwiftData

@Model
class AddedActivity: Equatable, Identifiable { //: , Codable, Identifiable, ObservableObject
    let id: String
    var name: String
    var type: String
    
    var latitude: Double
    var longitude: Double
    //var links: [String]
    
    static let example = AddedActivity(id: String(), name: "Test Name", type: "Test Type", latitude: 37.77, longitude: -122.42) //, links: ["swift", "apple"]
    
    init(id: String, name: String = "", type: String = "", latitude: Double, longitude: Double) { //, links: [String]
        self.id = id
        self.name = name
        self.type = type
        self.latitude = latitude
        self.longitude = longitude
        //self.links = links
    }
    
    // write a comparison function to make sure locations are unique (according to the Identifiable and Equatable protocols)
    static func ==(lhs: AddedActivity, rhs: AddedActivity) -> Bool {
        lhs.id == rhs.id
    }
    
    static func <(lhs: AddedActivity, rhs: AddedActivity) -> Bool {
        lhs.name < rhs.name
    }
}
