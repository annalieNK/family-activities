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
                
                Section("Activities") {
                    ForEach(recommendation.activities, id: \.self) { item in
                        Text(item)
                    }
                }
                
                Section("Friends") {
                    List(recommendation.friends) { friend in
                        NavigationLink {
                            Text(friend.someText)
                        } label: {
                            Text(friend.name)
                        }
                    }
//                    .navigationDestination(for: Recommendation.self) { friend in
//                        Text(friend.name)
//                    }
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
