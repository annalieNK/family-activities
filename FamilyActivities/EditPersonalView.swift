//
//  EditPersonalView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/19/24.
//

import SwiftData
import SwiftUI

struct EditPersonalView: View {
    @Bindable var personalItem: PersonalItem // make it editable
    
    var body: some View {
        Form {
            TextField("Name", text: $personalItem.name)
        }
        .navigationTitle("Edit Personal")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    // make temporarily in memory storage for our data
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: PersonalItem.self, configurations: config)
        let example = PersonalItem(name: "Example Name")
        return EditPersonalView(personalItem: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
