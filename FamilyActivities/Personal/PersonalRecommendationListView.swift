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
    @Query(sort: \Recommendation.name) private var recommendations: [Recommendation]
        
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(recommendations.filter { $0.isSaved }) { recommendation in
                        NavigationLink(value: recommendation) {
                            VStack(alignment: .leading) {
                                Text(recommendation.name)
                            }
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .navigationDestination(for: Recommendation.self) { recommendation in RecommendationDetailView(recommendation: recommendation)}
                
                //Button("Add Itinerary", systemImage: "plus", action: addItem)
            }
        }
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = recommendations[index]
            modelContext.delete(item)
        }
    }
    
//    func addItem() {
//        let item = PersonalRecommendation(activityNames: [])
//        modelContext.insert(item)
//        path = [item]
//    }
}

#Preview {
    PersonalRecommendationListView()
}
