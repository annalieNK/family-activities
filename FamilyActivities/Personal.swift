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
    var id: UUID//String
    var name: String
    var type: String
    var link: String
    @Relationship(deleteRule: .cascade) var visitedItems = [PersonalListItem]()
    var date: Date//?
    
    init(name: String = "", type: String = "", link: String = "", date: Date = .now) {//}, date: Date) { //id: String = ""
        self.id = UUID()//id
        self.name = name
        self.type = type
        self.link = link
        self.date = date
    }
}
