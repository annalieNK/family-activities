//
//  EditPersonalView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/19/24.
//

import SwiftData
import SwiftUI

struct PersonalRecommendationDetailView: View {
//    @Query var activities: [Activity]
    
    @Bindable var personalRecommendation: PersonalRecommendation // make it editable
    
    @State private var newItem = ""
    
    var body: some View {
        Form {
            TextField("Name", text: $personalRecommendation.name)
            
//            Section("Activities") {
//                List(personal.activityNames, id: \.self) { activityID in
//                    if let activity = activities.first(where: { $0.id == activityID }) {
//                        NavigationLink(destination: ActivityDetailView(activity: activity)) {
//                            Text(personal.name)//Text(activity.name)
//                        }
//                    }
//                }
//            }
        }
        .navigationTitle("\(personalRecommendation.name)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    // make temporarily in memory storage for our data
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: PersonalRecommendation.self, configurations: config)
//        let example = Personal(name: "Example name", type: "Example type", link: "Example link")
        return PersonalRecommendationDetailView(personalRecommendation: .example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
