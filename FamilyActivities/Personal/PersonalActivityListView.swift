//
//  PersonalListingView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/19/24.
//

import MapKit
import SwiftData
import SwiftUI

struct PersonalActivityListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Activity.name) private var activities: [Activity]
    
    @State private var path = [AddedActivity]()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(activities.filter { $0.isSaved }) { activity in
                    NavigationLink(value: activity) {
                        VStack(alignment: .leading) {
                            Text(activity.name)
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationDestination(for: Activity.self) { activity in
                ActivityDetailView(activity: activity)
            }
            .toolbar {
                Button("Add Item", systemImage: "plus", action: addItem)
            }
        }
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = activities[index]
            modelContext.delete(item)
        }
    }
    
    func addItem() {
        let newActivity = AddedActivity()
        modelContext.insert(newActivity)
        path = [newActivity]
    }
}

#Preview {
    PersonalActivityListView()
}
