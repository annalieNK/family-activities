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
    
    init(name: String = "", type: String = "") {
        self.name = name
        self.type = type
    }
}
