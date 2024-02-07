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
    
    @State private var newItem = ""
    
    var body: some View {
        Form {
            TextField("Name", text: $personal.name)
            TextField("Type", text: $personal.type, axis: .vertical)
            TextField("Link", text: $personal.link)
            
            Section("Items Visited") {
                ForEach(personal.visitedItems) { visitedItem in
                    Text(visitedItem.name)
                }
                
                HStack {
                    TextField("Add a new sight in ", text: $newItem) //\(personal.name)
                    Button("Add", action: addItem)
                }
            }
            
            Section("Add month to visit") {
                DatePicker("", selection: $personal.date, displayedComponents: .date)
                    .labelsHidden()
                    .datePickerStyle(WheelDatePickerStyle())
            }

        }
        .navigationTitle("Edit Personal")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func addItem() {
        guard newItem.isEmpty == false else { return }
        
        withAnimation {
            let visitedItem = PersonalListItem(name: newItem)
            personal.visitedItems.append(visitedItem)
            newItem = ""
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
