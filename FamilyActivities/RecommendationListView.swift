//
//  RecommendationView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/10/24.
//

import SwiftUI

struct RecommendationListView: View {
    let activities: [Activity] = Bundle.main.decode("activities.json")
    
    var body: some View {
        NavigationView {
            List(activities) { activity in
                NavigationLink {
                    Text("Show a detail view here")
                } label: {
                    HStack {
                        Image(activity.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                        
                        VStack(alignment: .leading) {
                            Text(activity.title)
                                .font(.headline)
                            Text(activity.type)
                        }
                    }
                }
            }
            .navigationTitle("Recommendations")
        }
    }
    
    
}

#Preview {
    RecommendationListView()
}
