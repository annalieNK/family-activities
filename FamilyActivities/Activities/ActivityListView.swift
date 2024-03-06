//
//  ActivityListView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 2/26/24.
//

import MapKit
import SwiftData
import SwiftUI

struct ActivityListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Activity.name) private var activities: [Activity]
    
    @Binding var searchText: String
    @Binding var selectedType: String
    
    @State private var filterType = FilterTag.default
        
    enum FilterTag {
        case `default`, beach, familyActivity
    }
    
    var body: some View {
        VStack {
            Text("\(filteredActivities.count) activities") //filteredActivities //filterLocations
            
            NavigationStack {
                List(filteredActivities) { activity in //activities //filterLocations
                    NavigationLink(value: activity) {
                        Text(activity.name)
                    }
                }
                .navigationTitle("Activities")
                .navigationDestination(for: Activity.self) { activity in
                    ActivityDetailView(activity: activity)
                }
                .task {
                    await fetchActivities()
                }
                .searchable(text: $searchText, prompt: "Search")
            }
        }
        .background(.white)
    }
    
    var searchActivity: [Activity] {
        if searchText.isEmpty {
            return activities
        } else {
            return activities.filter { $0.name.localizedCaseInsensitiveContains(searchText) || $0.type.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
//    var filteredActivities: [Activity] {
//        switch filterType {
//        case .default:
//            return searchActivity
//        case .beach:
//            return searchActivity.filter { $0.type == "beach"}
//        case .familyActivity:
//            return searchActivity.filter { $0.type == "family activities"}
//        }
//    }
    
    var filteredActivities: [Activity] {
        if selectedType.isEmpty {
            return searchActivity
        } else {
            return searchActivity.filter { $0.type == selectedType }
        }
    }
    
    // Adjust the map region to reflect the list items
//    var filteredLocations: [Activity] {
//        let mapRect = MKMapView(frame: .zero).visibleMapRect
//        let visibleMapRect = MKMapRect(origin: mapRect.origin, size: mapRect.size)
//        
//        return activities.filter { activity in
//            visibleMapRect.contains(MKMapPoint(activity.coordinate))
//        }
//    }

    func fetchActivities() async {
        // Don't re-fetch data if we already have it.
        guard activities.isEmpty else { return }
        
        do {
            let url = URL(string: "https://raw.githubusercontent.com/annalieNK/family-activities/map-views/FamilyActivities/Files/activities.json")!
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

//#Preview {
//    ActivityListView()
//}
