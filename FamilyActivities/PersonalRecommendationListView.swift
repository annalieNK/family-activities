//
//  PersonalListingView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/19/24.
//

import SwiftData
import SwiftUI

struct PersonalRecommendationListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \PersonalRecommendation.date) private var personalRecommendations: [PersonalRecommendation]
    
    var body: some View {
        List {
            ForEach(personalRecommendations) { personal in
                NavigationLink(value: personal) {
                    VStack(alignment: .leading) {
                        Text(personal.name)
                    }
                }
            }
            .onDelete(perform: deleteItems)
        }
        .navigationDestination(for: PersonalRecommendation.self, destination: PersonalRecommendationDetailView.init)
//        .navigationDestination(for: Personal.self) { personal in
//            PersonalDetailView(personal: personal)}
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = personalRecommendations[index]
            modelContext.delete(item)
        }
    }
}

#Preview {
    PersonalRecommendationListView()
}
