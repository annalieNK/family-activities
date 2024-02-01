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
                    List(recommendation.friends, id: \.self) { friend in //id: \.self
                        NavigationLink {
                            //ActivityDetailView(activity: activity)
                            Text(friend.someText)
                        } label: {
                            Text(friend.name)
                        }
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
