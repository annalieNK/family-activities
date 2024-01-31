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
    
    struct ActivityName {
        let activity: Activity
    }
    
    let recommendation: Recommendation
    
    let activityNames: [ActivityName]
    
    @State private var link = ""
    
    var body: some View {
        Form {
            Section("About") {
                Text(recommendation.text)
                    .padding(.vertical)
            }
                        
            Section("Activity Refrences") {
                ForEach(recommendation.activities, id: \.self) { activity in
                    Text(activity)
                }
            }
            
            //ActivitiesScroll(activityNames: activityNames)
            
        }
        .listStyle(.grouped)
        .navigationTitle(recommendation.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
//    init(recommendation: Recommendation, activities: [String: Activity]) {
//        self.recommendation = recommendation
//        
//        self.activityNames = recommendation.activityNames.map { member in
//            if let activity = activities[member.name] {
//                return ActivityName(activity: activity)
//            } else {
//                fatalError("Missing \(member.name)")
//            }
//        }
//    }
}

//#Preview {
//    RecommendationDetailView(recommendation: recommendations[0], activities: activities[0])
//}
