//
//  PersonalItem.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/24/24.
//

import Foundation
import SwiftData

@Model
class PersonalItem {
    var name: String
    //var link: String
    //var activities: [Activity]
    @Relationship(deleteRule: .cascade) var activities = [Activity]()
    
    init(name: String, activities: [Activity] = [Activity]()) {
        self.name = name
        //self.link = link
        self.activities = activities
    }
//    init(activities: [Activity]) {
//        self.activities = activities
//    }
    
//    init(name: String = "", type: String = "") {
//        self.name = name
//        self.type = type
//    }
}
