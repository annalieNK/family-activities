//
//  NewItinerary.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/21/24.
//

import Foundation
import SwiftData
import MapKit

@Model
class NewItinerary {
    var id: UUID
    var name: String
    
    @Relationship(deleteRule: .cascade) var locations = [Location]()
    
    static let example = NewItinerary(name: "Test name")
    
    init(name: String = "") {
        self.id = UUID()
        self.name = name
    }
}
