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
    @Query(sort: \NewItinerary.name) private var newItineraries: [NewItinerary]
    
    @State private var isAddItinerary = false
    
    @State private var path = [NewItinerary]()
    
    var body: some View {
        VStack {
            List {
                ForEach(recommendations.filter { $0.isSaved }) { recommendation in
                    NavigationLink(destination: RecommendationDetailView(recommendation: recommendation)) {
                        Text(recommendation.name)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            
            List {
                ForEach(newItineraries) { newItinerary in
                    NavigationLink(destination: AddItineraryView(newItinerary: newItinerary)) { //Text("Show itinerary") //NewItineraryDetailView(newItinerary: newItinerary)
                        Text(newItinerary.name)
                    }
                }
                .onDelete(perform: deleteNewItineraries)
            }
        }
        .navigationBarTitle("Itineraries", displayMode: .inline)
        .toolbar {
            Button {
                addItem()//isAddItinerary = true
            } label: {
                Image(systemName: "plus")
            }
        }
//        .sheet(isPresented: $isAddItinerary) {
//            AddItineraryView()
//        }
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = recommendations[index]
            modelContext.delete(item)
        }
    }
    
    func deleteNewItineraries(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = newItineraries[index]
            modelContext.delete(item)
        }
    }
    
    func addItem() {
        let item = NewItinerary(name: "New Itinerary")
        modelContext.insert(item)
        path = [item]
    }
}

#Preview {
    PersonalRecommendationListView()
}
