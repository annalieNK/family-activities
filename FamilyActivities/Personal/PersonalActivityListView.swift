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
    @Query(sort: \NewActivity.name) private var newActivities: [NewActivity]
    
    @State private var isAddActivity = false
        
    var body: some View {
            VStack {
                List {
                    ForEach(activities.filter { $0.isSaved }) { activity in
                        NavigationLink(destination: ActivityDetailView(activity: activity)) {
                            Text(activity.name)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }

                List {
                    ForEach(newActivities) { newActivity in
                        NavigationLink(destination: NewActivityDetailView(newActivity: newActivity)) {
                            Text(newActivity.name)
                        }
                    }
                }
            }
            .navigationBarTitle("Activities", displayMode: .inline)
            .toolbar {
                Button {
                    isAddActivity = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $isAddActivity) {
                AddActivityView()
                //Text("Add Activity here")
            }
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = activities[index]
            modelContext.delete(item)
        }
    }
}

#Preview {
    PersonalActivityListView()
}
