//
//  RecommendationDetailView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/30/24.
//

import MapKit
import SwiftData
import SwiftUI

struct RecommendationDetailView: View {
    @Environment(\.modelContext) var modelContext
    @Query var activities: [Activity]
    
    let recommendation: Recommendation
    
    @State private var path = [PersonalRecommendation]()
    
    var body: some View {
        //Form {
//        ScrollView {
            NavigationView {
                VStack {
                    Text(recommendation.name)
                    Spacer()
                    Text(recommendation.text)
                    
                    List(recommendation.activityNames, id: \.self) { activityID in
                        if let activity = activities.first(where: { $0.id == activityID }) {
                            NavigationLink(destination: ActivityDetailView(activity: activity)) {
                                Text(activity.name)
                            }
                        }
                    }
                    
                    Map {
                        ForEach(recommendation.activityNames, id: \.self) { activityID in
                            if let activity = activities.first(where: { $0.id == activityID}) {
                                Annotation(activity.name, coordinate: activity.coordinate) {
                                    Image(systemName: "mappin.circle.fill")
                                }
                            }
                        }
                    }
                    .frame(width: 350, height: 200)
                }
            }
//        }
        .listStyle(.grouped)
        .toolbar {
            Button("Save to personal items", action: saveToPersonalRecommendation)
        }
    }
    
    func saveToPersonalRecommendation() {
        let savedRecommendation = PersonalRecommendation(name: recommendation.name, activityNames: recommendation.activityNames)
        modelContext.insert(savedRecommendation)
        path = [savedRecommendation]
        try? modelContext.save()
        
    }
}

#Preview {
    RecommendationDetailView(recommendation: .example)
}
