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
class Location { //: Equatable
//    var latitude: Double
//    var longitude: Double
//    
//    var coordinate: CLLocationCoordinate2D {
//            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//        }
//    
//    init(latitude: Double, longitude: Double) {
//        self.latitude = latitude
//        self.longitude = longitude
//    }
    var name: String
    
    init(name: String = "") {
        self.name = name
    }
}
