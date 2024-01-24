//
//  PersonalView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/10/24.
//

import SwiftData
import SwiftUI

struct PersonalView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var path = [PersonalItem]()
    @State private var sortOrder = SortDescriptor(\PersonalItem.name)
    
    var body: some View {
        NavigationStack(path: $path) {
            PersonalListingView()
                .navigationTitle("Personal View")
                .navigationDestination(for: PersonalItem.self, destination: EditPersonalView.init)
                .toolbar {
                    Button("Add Item", systemImage: "plus", action: addItem)
                }
        }
    }
    
    //    func addItem() {
    //        let noe = Personal(name: "Noe", type: "neighborhood")
    //        modelContext.insert(noe)
    //    }
    
    // add item
    func addItem() {
        let item = PersonalItem(name: "")
        modelContext.insert(item)
        path = [item]
    }
}

#Preview {
    PersonalView()
}
