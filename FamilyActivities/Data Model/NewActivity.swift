//
//  NewActivity.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/19/24.
//

import Foundation
import MapKit
import SwiftData

@Model
class NewActivity: Equatable, Identifiable { //: , Codable, Identifiable, ObservableObject
    //let id: String
    var name: String
    var type: String
    
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = NewActivity(name: "Test Name", type: "Test Type", latitude: 37.77, longitude: -122.42) //id: String(), 
    
    init(name: String = "", type: String = "", latitude: Double, longitude: Double) { //id: String = "",
        //self.id = id
        self.name = name
        self.type = type
        self.latitude = latitude
        self.longitude = longitude
        //self.links = links
    }
    
    // write a comparison function to make sure locations are unique (according to the Identifiable and Equatable protocols)
    static func ==(lhs: NewActivity, rhs: NewActivity) -> Bool {
        lhs.id == rhs.id
    }
    
    static func <(lhs: NewActivity, rhs: NewActivity) -> Bool {
        lhs.name < rhs.name
    }
}
