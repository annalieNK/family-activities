//
//  ActivityItemView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 2/26/24.
//

import SwiftData
import SwiftUI

struct ActivityItemView: View {
    @Environment(\.modelContext) var modelContext
    
    let activities: [Activity]
    //@Query(sort: \Activity.name) private var activities: [Activity]
    
    var body: some View {
        //Text(activity.name)
        
        VStack {
            NavigationStack {
                List(activities) { activity in
                    NavigationLink(value: activity) {
                        Text(activity.name)
                    }
                }
                .navigationDestination(for: Activity.self) { activity in
                    ActivityDetailView(activity: activity)
                }
            }
        }
    }
}

//#Preview {
//    ActivityItemView()
//}
