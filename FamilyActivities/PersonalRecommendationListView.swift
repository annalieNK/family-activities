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
    
    @State private var path = [PersonalRecommendation]()
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
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
                .navigationDestination(for: PersonalRecommendation.self) { personal in PersonalRecommendationDetailView(personalRecommendation: personal)}
                
                Button("Add Itinerary", systemImage: "plus", action: addItem)
            }
        }
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = personalRecommendations[index]
            modelContext.delete(item)
        }
    }
    
    func addItem() {
        let item = PersonalRecommendation(activityNames: [])
        modelContext.insert(item)
        path = [item]
    }
}

#Preview {
    PersonalRecommendationListView()
}
