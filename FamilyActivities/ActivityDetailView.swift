//
//  DetailView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/18/24.
//

import SwiftData
import SwiftUI

struct ActivityDetailView: View {
    @Environment(\.modelContext) var modelContext
    
    let activity: Activity
        
    var body: some View {
        List {
            Section("About") {
                Text(activity.name)
                    .padding(.vertical)
            }
            
            Section("Type") {
                Text(activity.descript)
            }
        }
        .listStyle(.grouped)
        .navigationTitle(activity.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ActivityDetailView(activity: .example)
//    @Query var activities: [Activity]
//    ActivityDetailView(activity: activities[0])
}
