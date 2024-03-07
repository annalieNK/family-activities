//
//  Journal.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/6/24.
//

import Foundation
import SwiftData
import MapKit

@Model
class Journal {
    var id: UUID
    var name: String
    
    @Relationship(deleteRule: .cascade) var locations = [Location]()
    
    static let example = Journal(name: "Test name")
    
    init(name: String = "") {
        self.id = UUID()
        self.name = name
    }
}

