//
//  AddActivityView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/4/24.
//

import SwiftData
import SwiftUI

struct AddActivityView: View {
    @Bindable var addedActivity: AddedActivity // make it editable
    
    var body: some View {
        Form {
            TextField("Name", text: $addedActivity.name)
            TextField("Name", text: $addedActivity.type)
            
        }
        .navigationTitle("Add Activity")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    // make temporarily in memory storage for our data
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: AddedActivity.self, configurations: config)
        let example = AddedActivity(name: "Test Name", type: "Test Type", links: ["swift", "apple"], latitude: 37.77, longitude: -122.42)
        return AddActivityView(addedActivity: .example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
