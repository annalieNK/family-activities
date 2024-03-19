//
//  FamilyActivitiesApp.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/10/24.
//

import SwiftData
import SwiftUI

@main
struct FamilyActivitiesApp: App {
    var body: some Scene {
        WindowGroup {
            TabPageView()
        }
        .modelContainer(for: [Activity.self, NewActivity.self, Recommendation.self, Journal.self])
    }
}
