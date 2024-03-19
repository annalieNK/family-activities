//
//  NewActivityListView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/19/24.
//

import SwiftData
import SwiftUI

struct NewActivityListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \NewActivity.name) private var newActivities: [NewActivity]
    
    @State private var path = [NewActivity]()
    
    var body: some View {
        List {
            ForEach(newActivities) { newActivity in
                NavigationLink(destination: AddActivityView(newActivity: newActivity)) {
                    Text(newActivity.name)
                }
            }
            .onDelete(perform: deleteItems)
        }
        
        Button("Add Item", systemImage: "plus", action: addItem)
//        NavigationStack(path: $path) {
//            NewActivityListingView(sort: sortOrder)
//                .navigationDestination(for: NewActivity.self, destination: EditNewActivityView.init)
//                .toolbar {
//                    Button("Add New Activity", systemImage: "plus", action: addNewActivity)
//                }
//        }
        //Text("Tst")
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = newActivities[index]
            modelContext.delete(item)
        }
    }
    
    func addItem() {
        let item = NewActivity()
        modelContext.insert(item)
        path = [item]
    }
}

#Preview {
    NewActivityListView()
}
