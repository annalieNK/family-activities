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
    @Query(sort: \AddedActivity.name) private var addedActivities: [AddedActivity]
    
    @State private var path = [AddedActivity]()
    
    var body: some View {
        NavigationStack { //(path: $path)
            VStack {
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
                
                List {
                    ForEach(addedActivities) { addedActivity in
                        NavigationLink(value: addedActivity) {
                            Text(addedActivity.name)
                        }
                    }
                }
                .navigationDestination(for: AddedActivity.self, destination: AddActivityView.init)
            }
            .toolbar {
                Button("Add Item", systemImage: "plus", action: addActivity)
            }
        }
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = activities[index]
            modelContext.delete(item)
        }
    }
    
    func addActivity() {
        let addedActivity = AddedActivity()
        modelContext.insert(addedActivity)
        path = [addedActivity]
    }
}

#Preview {
    PersonalActivityListView()
}
