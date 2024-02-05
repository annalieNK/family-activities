//
//  RecommendationDetailView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/30/24.
//

import SwiftUI

import SwiftData
import SwiftUI

struct RecommendationDetailView: View {
    @Environment(\.modelContext) var modelContext
    @Query var activities: [Activity]
    
    let recommendation: Recommendation
    
    var body: some View {
        List(recommendation.activityNames, id: \.self) { activity in
            if let item = activities.first(where: { $0.id == activity }) {
                NavigationLink(destination: ActivityDetailView(activity: item)) {
                    Text(item.name)
                }
            }
        }
        .listStyle(.grouped)
        .navigationTitle(recommendation.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    RecommendationDetailView(recommendation: .example)
}
