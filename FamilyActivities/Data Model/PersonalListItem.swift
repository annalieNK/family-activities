//
//  PersonalItemDate.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/24/24.
//

import Foundation
import SwiftData

@Model
class PersonalListItem { //: Equatable
    var name: String
    
    init(name: String = "") {
        self.name = name
    }
    
//    static func ==(lhs: PersonalListItem, rhs: PersonalListItem) -> Bool {
//        lhs.id == rhs.id
//    }
}
