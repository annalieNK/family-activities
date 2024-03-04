//
//  FeedView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/10/24.
//

import SwiftData
import SwiftUI

struct RecommendationView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Recommendation.name) private var recommendations: [Recommendation]
            
    var body: some View {
        NavigationStack {
            List(recommendations) { recommendation in
                NavigationLink(value: recommendation) {
                    Text(recommendation.name)
                }
            }
            .navigationTitle("Recommendations")
            .navigationDestination(for: Recommendation.self) { recommendation in
                RecommendationDetailView(recommendation: recommendation)
            }
            .task {
                await fetchRecommendations()
            }
        }
    }
    
    func fetchRecommendations() async {
        // Don't re-fetch data if we already have it.
        guard recommendations.isEmpty else { return }
        
        do {
            let url = URL(string: "https://raw.githubusercontent.com/annalieNK/family-activities/map-views/FamilyActivities/Files/recommendations.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let downloadedRecommendations = try decoder.decode([Recommendation].self, from: data)
            // load data all at once and save
            let insertContext = ModelContext(modelContext.container)
            
            for recommendation in downloadedRecommendations {
                insertContext.insert(recommendation) //modelContext
            }
            
            try insertContext.save() //the local data gets written to disk
        } catch {
            print("Download failed")
        }
    }
}

#Preview {
    RecommendationView()
}
