//
//  Activity.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/10/24.
//

import Foundation

struct Activity: Codable, Identifiable {
    let id: Int
    let title: String
    let type: String
    let image: String
    
//    var image: String {
//        "activity\(id)"
//    }
    
    static let allActivities: [Activity] = Bundle.main.decode("activities.json")
    static let example = allActivities[0]
}
