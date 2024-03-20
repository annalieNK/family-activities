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
    @Query(sort: \NewActivity.name) private var addedActivities: [NewActivity]
    
    @State private var path = [NewActivity]()
    @State private var showingAddActivity = false
    
//    let addedActivity: AddedActivity
    
    var body: some View {
//        NavigationStack { //(path: $path)
            VStack {
                List {
                    ForEach(activities.filter { $0.isSaved }) { activity in
//                        NavigationLink(value: activity) {
//                            VStack(alignment: .leading) {
//                                Text(activity.name)
//                            }
//                        }
                        NavigationLink(destination: ActivityDetailView(activity: activity)) {
                            Text(activity.name)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
//                .navigationDestination(for: Activity.self) { activity in
//                    ActivityDetailView(activity: activity)
//                }
                
                List {
                    ForEach(addedActivities) { addedActivity in
                        NavigationLink(value: addedActivity) {
                            Text(addedActivity.name)
                        }
                    }
                }
                //.navigationDestination(for: NewActivity.self, destination: AddActivityView.init)
//                .navigationDestination(for: AddedActivity.self) { addedActivity in
//                    AddActivityView(addedActivity: addedActivity)
//                }
            }
            .toolbar {
                //Button("Add Item", systemImage: "plus", action: addActivity)
                Button {
                    showingAddActivity = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddActivity) {
                //AddActivityView()
                Text("Add Activity here")
            }
//        }
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = activities[index]
            modelContext.delete(item)
        }
    }
    
    func addActivity() {
//        let addedActivity = AddedActivity()
//        modelContext.insert(addedActivity)
//        path = [addedActivity]
    }
}

#Preview {
    PersonalActivityListView()
}
