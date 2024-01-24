//
//  EditPersonalView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/19/24.
//

import SwiftData
import SwiftUI

struct EditPersonalView: View {
    @Bindable var personal: Personal // make it editable
    
    var body: some View {
        Form {
            TextField("Name", text: $personal.name)
            TextField("Type", text: $personal.type, axis: .vertical)
        }
        .navigationTitle("Edit Personal")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    // make temporarily in memory storage for our data
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Personal.self, configurations: config)
        let example = Personal(name: "Example Personal", type: "Example details go here")
        return EditPersonalView(personal: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
