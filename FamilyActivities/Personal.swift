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
    var id: UUID
    var name: String
    var type: String
    var link: String
    @Relationship(deleteRule: .cascade) var visitedItems = [PersonalListItem]()
    var date: Date//?
    
    var shortDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM yyyy"
        return formatter.string(from: date)
    }
    
    init(name: String = "", type: String = "", link: String = "", date: Date = .distantFuture) {//}, date: Date) { //id: String = ""
        self.id = UUID()
        self.name = name
        self.type = type
        self.link = link
        self.date = date
    }
}
