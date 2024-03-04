//
//  TestAddActivityView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/4/24.
//

import SwiftData
import SwiftUI

struct TestAddActivityView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \AddedActivity.name) private var addedActivities: [AddedActivity]
    
    @State private var path = [AddedActivity]()
    
    var body: some View {
        NavigationStack(path: $path) {
            List {
                ForEach(addedActivities) { addedActivity in
                    NavigationLink(value: addedActivity) {
                        Text(addedActivity.name)
                    }
                }
            }
            .navigationDestination(for: AddedActivity.self, destination: AddActivityView.init)
            .toolbar {
                Button("Add Activity", systemImage: "plus", action: addActivity)
            }
        }
    }
    
    func addActivity() {
        let addedActivity = AddedActivity()
        modelContext.insert(addedActivity)
        path = [addedActivity]
    }
}

#Preview {
    TestAddActivityView()
}
