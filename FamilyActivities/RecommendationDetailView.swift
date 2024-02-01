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
//                    List(recommendation.activities, id: \.self) { item in
//                        Text(item)
//                    }
//                }
                
                Section("Activities") {
                    List(recommendation.activities, id: \.self) { item in
                        NavigationLink {
                            Text(item)
                        } label: {
                            Text(item)
                        }
                    }
                }
                
                Section("Items") {
                    List(recommendation.items, id: \.self) { item in
                        NavigationLink {
                            Text(item.name)
                        } label: {
                            Text(item.name)
                        }
                    }
                }
                
//                Section("Items") {
//                    ForEach(recommendation.items) { item in
//                        NavigationLink(destination: ActivityDetailView(acticity: item)) {
//                            Text(item.name)
//                        }
//                    }
//                }
                
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
