//
//  AddJournalView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/6/24.
//

import SwiftData
import SwiftUI

struct AddJournalView: View {
    @Bindable var journal: Journal
    
    @State private var newItem = ""
    
    var body: some View {
        Form {
            TextField("Name", text: $journal.name)
            
            Section("Items Visited") {
                ForEach(journal.locations) { location in
                    Text(location.name)
                }
                
                HStack {
                    TextField("Add a new item in ", text: $newItem)
                    Button("Add", action: addItem)
                }
            }
        }
    }
    
    func addItem() {
        guard newItem.isEmpty == false else { return }
        
        withAnimation {
            let location = Location(name: newItem)
            journal.locations.append(location)
            newItem = ""
        }
    }
}

#Preview {
    // make temporarily in memory storage for our data
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: PersonalActivity.self, configurations: config)
//        let example = Personal(name: "Example name", type: "Example type", link: "Example link")
        return AddJournalView(journal: .example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
