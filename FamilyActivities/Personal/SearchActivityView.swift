//
//  SearchActivityView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/21/24.
//

import SwiftData
import SwiftUI

struct SearchActivityView: View {
    @Query(sort: \Activity.name) private var activities: [Activity]
    
    @State private var selectedActivity: Activity?
    @State private var newItinerary: NewItinerary?
    
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search for activity", text: $searchText)
                            .onChange(of: searchText) { newSearch in
                                activities.filter { $0.name.localizedCaseInsensitiveContains(newSearch) }
                            }
                    }
                    List(searchActivity) { activity in
                        Button {
                            if let newItinerary = newItinerary, !newItinerary.locations.isEmpty {
                                selectedActivity = activity
                                print(selectedActivity!.name)
                                let newLocation = Location(name: activity.name, latitude: activity.coordinate.latitude, longitude: activity.coordinate.longitude) 
                                newItinerary.locations.append(newLocation)
                            }
                        } label: {
                            Text(activity.name)
                        }
                    }
                }
            }
        }
    }
    
    var searchActivity: [Activity] {
        if searchText.isEmpty {
            return [] //activities
        } else {
            return activities.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

#Preview {
    SearchActivityView()
}
