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
            Form {
                Section("About") {
                    Text(recommendation.text)
                        .padding(.vertical)
                }
                
//                Section("Activities") {
//                    List(recommendation.activitiesList, id: \.self) { activity in //id: \.self
//                        NavigationLink {
//                            RecommendationActivityDetailView(activity: activity)
//                            //ActivityDetailView(activity: activity)
//                            //Text(friend.type)
//                        } label: {
//                            Text(activity.name)
//                        }
//                    }
//                }
            }
            .listStyle(.grouped)
            .navigationTitle(recommendation.name)
            .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    RecommendationDetailView(recommendation: .example)
}
