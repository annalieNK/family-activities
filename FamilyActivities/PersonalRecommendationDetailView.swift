//
//  EditPersonalView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/19/24.
//

import SwiftData
import SwiftUI

struct PersonalRecommendationDetailView: View {
    @Query var activities: [Activity]
    
    @Bindable var personalRecommendation: PersonalRecommendation // make it editable
    
    @State private var newItem = ""
    
    var body: some View {
        Form {
            Section("Name") {
                TextField("Name", text: $personalRecommendation.name)
                    .padding(.vertical)
            }
            
            Section("Activities") {
                List(personalRecommendation.activityNames, id: \.self) { activityID in
                    if let activity = activities.first(where: { $0.id == activityID }) {
                        NavigationLink(destination: ActivityDetailView(activity: activity)) {
                            Text(activity.name)
                        }
                    }
                }
            }
            
            Section("Add Activities") {
//                List(personalRecommendation.addedActivities) { addedActivity in
//                    Text(addedActivity.name)
//                }
                List(personalRecommendation.addedActivities) { activityID in
                    if let activity = activities.first(where: { $0.name == activityID.name }) {
                        NavigationLink(destination: ActivityDetailView(activity: activity)) {
                            Text(activity.name)
                        }
                    }
                }
                
                HStack {
                    TextField("Add a new item in ", text: $newItem)
                    Button("Add", action: addItem)
                }
            }
        }
        .navigationTitle("\(personalRecommendation.name)")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addItem() {
        guard newItem.isEmpty == false else { return }
        
        withAnimation {
            let addedActivity = PersonalListItem(name: newItem)
            personalRecommendation.addedActivities.append(addedActivity)
            newItem = ""
        }
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
