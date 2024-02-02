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
    
    let recommendation: Recommendation
    
    var body: some View {
        //        NavigationView {
        Form {
            Section("About") {
                Text(recommendation.text)
                    .padding(.vertical)
            }
            
            Section("Activities") {
//                List(recommendation.activitiesList, id: \.self) { activity in //id: \.self
//                    NavigationLink(value: activity) {
//                        RecommendationActivityDetailView(recommendationActivity: activity)
//                        //ActivityDetailView(activity: activity)
//                        //Text(activity.type)
//                    } label: {
//                    Text(activity.name)
//                }
                List(recommendation.activitiesList, id: \.self) { activity in
                    NavigationLink(value: activity) {
                        Text(activity.name)
                    }
                }
                .navigationDestination(for: RecommendationActivity.self) { activity in
                    RecommendationActivityDetailView(recommendationActivity: activity)
            }
        }
    }
        .listStyle(.grouped)
        .navigationTitle(recommendation.name)
        .navigationBarTitleDisplayMode(.inline)
    //        }
}

}

#Preview {
    RecommendationDetailView(recommendation: .example)
}
