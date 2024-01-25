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
            TabPageView(viewModel: ViewController("https://www.nps.gov/alca/index.htm"))
        }
        .modelContainer(for: [Activity.self, Personal.self])
    }
}
