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
    
    @State private var offset: CGFloat = UIScreen.main.bounds.height * 0.7 //0.85
    @State private var dragOffset: CGFloat = 0
    @State private var selectedItemIndex: Int? = nil
    
    var body: some View {
        ZStack {
            // Secondary View
            VStack {
                Text("\(activities.count)")
                
                //                if let selectedItemIndex = selectedItemIndex {
                //                    Text("Item: \(activities[selectedItemIndex])")
                //                }
                NavigationStack {
                    List(activities) { activity in
                        NavigationLink(value: activity) {
                            Text(activity.name)
                        }
                    }
                    .navigationDestination(for: Activity.self) { activity in
                        ActivityDetailView(activity: activity)
                    }
                    .task {
                        await fetchActivities()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .offset(y: offset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        self.dragOffset = value.translation.height
                    }
                    .onEnded { value in
                        if self.dragOffset < -300 {
                            withAnimation {
                                self.offset = 0
                            }
                        } else {
                            withAnimation {
                                self.offset = UIScreen.main.bounds.height * 0.7
                            }
                        }
                    }
            )
            .animation(.spring())
            
            // Primary View
            VStack {
                NavigationStack {
                    List(activities) { activity in
                        Text(activity.name)
                    }
                    .navigationTitle("Activities")
                    .task {
                        await fetchActivities()
                    }
                }
            }
            .zIndex(-1) // Ensure the primary view is below the secondary view
        }
    }
    
    func fetchActivities() async {
        // Don't re-fetch data if we already have it.
        guard activities.isEmpty else { return }
        
        do {
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
