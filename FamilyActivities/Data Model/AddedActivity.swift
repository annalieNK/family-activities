//
//  AddedActivity.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/4/24.
//

import Foundation
import SwiftData
import MapKit

@Model
class AddedActivity: Equatable { //: Codable, Identifiable, Equatable, ObservableObject
    
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
    
    static let example = Activity(id: String(), name: "Test Name", type: "Test Type", links: ["swift", "apple"], latitude: 37.77, longitude: -122.42)
 
    init(id: String = "", name: String = "", type: String = "", links: [String], latitude: Double, longitude: Double) {
        self.id = id
        self.name = name
        self.type = type
        self.links = links
        self.latitude = latitude
        self.longitude = longitude
    }
    
    // write a comparison function to make sure locations are unique (according to the Identifiable and Equatable protocols)
    static func ==(lhs: AddedActivity, rhs: AddedActivity) -> Bool {
        lhs.id == rhs.id
    }
    
    static func <(lhs: AddedActivity, rhs: AddedActivity) -> Bool {
        lhs.name < rhs.name
    }
}
