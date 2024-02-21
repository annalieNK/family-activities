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
    
    var body: some View {
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
//        .navigationDestination(for: Personal.self) { personal in
//            PersonalDetailView(personal: personal)}
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = personalActivities[index]
            modelContext.delete(item)
        }
    }
}

#Preview {
    PersonalActivityListView()
}
