//
//  Personal.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/18/24.
//

import Foundation
import SwiftData

@Model
class Personal {
    var name: String
    var type: String
    var link: String
    @Relationship(deleteRule: .cascade) var visitedDates = [PersonalItemDate]()
    //@Relationship(deleteRule: .cascade) var sights = [Sight]()
    
    init(name: String = "", type: String = "", link: String = "") {
        self.name = name
        self.type = type
        self.link = link
    }
}
