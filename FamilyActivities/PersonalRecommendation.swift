//
//  Personal.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/18/24.
//

import Foundation
import SwiftData

@Model
class PersonalRecommendation {
    var id: UUID
    var name: String
    var text: String
    var activityNames: [String]
    var date: Date//?
    
    var shortDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM yyyy"
        return formatter.string(from: date)
    }
    
    static let example = PersonalRecommendation(name: "Test name", text: "Test text", activityNames: [], date: Date.now)
    
    init(name: String = "", text: String = "", activityNames: [String], date: Date = .distantFuture) {//}, date: Date) { //id: String = ""
        self.id = UUID()
        self.name = name
        self.text = text
        self.activityNames = activityNames
        self.date = date
    }
}
