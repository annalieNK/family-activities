//
//  RecommendationView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/10/24.
//

import SwiftData
import SwiftUI

struct ActivityView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Activity.name) private var activities: [Activity]
    
    var body: some View {
        NavigationStack {
            List(activities) { activity in
                NavigationLink(value: activity) {
                    Text(activity.name)
                }
            }
            .navigationTitle("Recommendations")
            .navigationDestination(for: Activity.self) { activity in
                DetailView(activity: activity)
            }
            .task {
                await fetchUsers()
            }
        }
    }
    
    func fetchUsers() async {
        // Don't re-fetch data if we already have it.
        guard activities.isEmpty else { return }
        
        do {
            // https://raw.githubusercontent.com/annalieNK/family-activities/SwiftData/FamilyActivities/activities.json
            // https://www.hackingwithswift.com/samples/friendface.json
            let url = URL(string: "https://raw.githubusercontent.com/annalieNK/family-activities/adding_rich_links_v2/FamilyActivities/activities.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let downloadedActivities = try decoder.decode([Activity].self, from: data)
            // load data all at once and save
            let insertContext = ModelContext(modelContext.container)
            
            for activity in downloadedActivities {
                insertContext.insert(activity) //modelContext
            }
            
            try insertContext.save() //the local data gets written to disk
        } catch {
            print("Download failed")
        }
    }
}

#Preview {
    ActivityView()
}
