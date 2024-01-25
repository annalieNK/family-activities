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
    
    @State private var newDate = ""
    
    var body: some View {
        Form {
            TextField("Name", text: $personal.name)
            TextField("Type", text: $personal.type, axis: .vertical)
            TextField("Link", text: $personal.link)
            
            Section("Dates Visited") {
                ForEach(personal.visitedDates) { visitedDate in
                    Text(visitedDate.name)
                }
                
                HStack {
                    TextField("Add a new sight in \(personal.name)", text: $newDate)
                    
                    Button("Add", action: addItem)
                }
            }
        }
        .navigationTitle("Edit Personal")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addItem() {
        guard newDate.isEmpty == false else { return }
        
        withAnimation {
            let visitedDate = PersonalItemDate(name: newDate)
            personal.visitedDates.append(visitedDate)
            newDate = ""
        }
    }
}

#Preview {
    // make temporarily in memory storage for our data
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Personal.self, configurations: config)
        let example = Personal(name: "Example name", type: "Example type", link: "Example link")
        return EditPersonalView(personal: example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
