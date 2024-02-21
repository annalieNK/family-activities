//
//  EditPersonalView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/19/24.
//

import SwiftData
import SwiftUI

struct PersonalActivityDetailView: View { 
    @Bindable var personalActivity: PersonalActivity // make it editable
    
    @State private var newItem = ""
    
    var body: some View {
        Form {
            TextField("Name", text: $personalActivity.name)
            TextField("Type", text: $personalActivity.type, axis: .vertical)
            TextField("Link", text: $personalActivity.link)
            
//            Section("Activities") {
//                List(personal.activityNames, id: \.self) { activityID in
//                    if let activity = activities.first(where: { $0.id == activityID }) {
//                        NavigationLink(destination: ActivityDetailView(activity: activity)) {
//                            Text(personal.name)//Text(activity.name)
//                        }
//                    }
//                }
//            }
            
            Section("Items Visited") {
                ForEach(personalActivity.visitedItems) { visitedItem in
                    Text(visitedItem.name)
                }
                
                HStack {
                    TextField("Add a new item in ", text: $newItem) //\(personal.name)
                    Button("Add", action: addItem)
                }
            }
            
            Section("Add month to visit") {
                DatePicker("", selection: $personalActivity.date, displayedComponents: .date)
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
            personalActivity.visitedItems.append(visitedItem)
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
        return PersonalActivityDetailView(personalActivity: .example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
