//
//  PersonalItemDate.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/24/24.
//

import Foundation
import SwiftData

@Model
class PersonalListItem {
    var name: String
    
    init(name: String = "") {
        self.name = name
    }
}
