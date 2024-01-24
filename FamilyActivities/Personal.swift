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
    //var date: Date
    
    init(name: String = "", type: String = "") { //date: Date = .now
        self.name = name
        self.type = type
        //self.date = date
    }
}
