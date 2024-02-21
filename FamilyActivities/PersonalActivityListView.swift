//
//  PersonalListingView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/19/24.
//

import SwiftData
import SwiftUI

struct PersonalActivityListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \PersonalActivity.date) private var personalActivities: [PersonalActivity]
    
    @State private var path = [PersonalActivity]()

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                List {
                    ForEach(personalActivities) { personal in
                        NavigationLink(value: personal) {
                            VStack(alignment: .leading) {
                                Text(personal.name)
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .navigationDestination(for: PersonalActivity.self, destination: PersonalActivityDetailView.init)
                
                Button("Add Item", systemImage: "plus", action: addItem)
            }
        }
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = personalActivities[index]
            modelContext.delete(item)
        }
    }
    
    func addItem() {
        let item = PersonalActivity()
        modelContext.insert(item)
        path = [item]
    }
}

#Preview {
    PersonalActivityListView()
}
