//
//  AddedActivity.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/4/24.
//

import Foundation
import SwiftData

@Model
class AddedActivity { //: Codable, Identifiable, Equatable, ObservableObject
    var name: String
    var type: String
    //let latitude: Double
    //let longitude: Double
    //var links: [String]

    static let example = AddedActivity(name: "Test Name", type: "Test Type") //, latitude: 37.77, longitude: -122.42, links: ["swift", "apple"]
    
   init(name: String = "", type: String = "") { //, latitude: Double, longitude: Double, links: [String]
        self.name = name
        self.type = type
        //self.latitude = latitude
        //self.longitude = longitude
        //self.links = links
    }
}
