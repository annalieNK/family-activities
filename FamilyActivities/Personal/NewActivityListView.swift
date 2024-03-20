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
    
    @State private var isAddActivity = false
    
    var body: some View {
        List {
            ForEach(newActivities) { newActivity in
                NavigationLink(destination: NewActivityDetailView(newActivity: newActivity)) { //AddActivityView(newActivity: newActivity)
                    Text("\(newActivity.name)")
                }
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isAddActivity = true
                } label: {
                    Label("Add Activity", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $isAddActivity) {
            AddActivityView() //newActivity: NewActivity.example
        }
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = newActivities[index]
            modelContext.delete(item)
        }
    }
}

#Preview {
    NewActivityListView()
}
