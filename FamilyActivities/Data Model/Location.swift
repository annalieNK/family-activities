//
//  Location.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/6/24.
//

import Foundation
import MapKit
import SwiftData

@Model
class Location: Identifiable, Equatable { //: Equatable
    var name: String
    var latitude: Double
    var longitude: Double

    var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    
    init(name: String = "", latitude: Double, longitude: Double) { //name: String = "", 
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.coordinate.latitude == rhs.coordinate.latitude && lhs.coordinate.longitude == rhs.coordinate.longitude
    }
}
