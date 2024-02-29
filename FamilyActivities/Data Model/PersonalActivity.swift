//
//  Personal.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/18/24.
//

import Foundation
import SwiftData
import MapKit

@Model
class PersonalActivity {
    var id: UUID
    var name: String
    var type: String
    var link: String
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
            CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        }
    
    @Relationship(deleteRule: .cascade) var visitedItems = [PersonalListItem]()
    var date: Date//?
    
    var shortDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM yyyy"
        return formatter.string(from: date)
    }
    
    static let example = PersonalActivity(name: "Test name", type: "Test Type", link: "Test Link", latitude: 37.33, longitude: -122.42, date: Date.now) //latitude: 37.77, longitude: -122.42,
    
    init(name: String = "", type: String = "", link: String = "", latitude: Double = 37.33, longitude: Double = -122.42, date: Date = .distantFuture) {//}, date: Date) { //id: String = "" //latitude: Double = 0.0, longitude: Double = 0.0,
        self.id = UUID()
        self.name = name
        self.type = type
        self.link = link
        self.latitude = latitude
        self.longitude = longitude
        self.date = date
    }
}
