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
    
    struct CrewMember {
        let role: String
        let activity: Activity
    }
    
    let recommendation: Recommendation
    let crew: [CrewMember]
    
    var body: some View {
        VStack {
            Section("About") {
                Text(recommendation.descript)
                    .padding(.vertical)
            }
            
            //                List(recommendation.activitiesList, id: \.self) { activity in //id: \.self
            //                    NavigationLink(value: activity) {
            //                        RecommendationActivityDetailView(recommendationActivity: activity)
            //                        //ActivityDetailView(activity: activity)
            //                        //Text(activity.type)
            //                    } label: {
            //                    Text(activity.name)
            //                }
            //                List(recommendation.activitiesList, id: \.self) { activity in
            //                    NavigationLink(value: activity) {
            //                        Text(activity.name)
            //                    }
            //                }
            //                .navigationDestination(for: RecommendationActivity.self) { activity in
            //                    RecommendationActivityDetailView(recommendationActivity: activity)
            
            CrewScroll(crew: crew)
            
        }
        .listStyle(.grouped)
        .navigationTitle(recommendation.descript)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    init(recommendation: Recommendation, activities: [String: Activity]) {
            self.recommendation = recommendation
            
            self.crew = recommendation.crew.map { member in
                if let activity = activities[member.name] {
                    return CrewMember(role: member.role, activity: activity)
                } else {
                    fatalError("Missing \(member.name)")
                }
            }
        }
}

#Preview {
    @Query var recommendations: [Recommendation]
    @Query var activities: [String: Activity]
    RecommendationDetailView(recommendation: recommendations[0], activities: activities)
}
