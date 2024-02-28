//
//  RecommendationView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/10/24.
//

import MapKit
import SwiftData
import SwiftUI

struct ActivityView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Activity.name) private var activities: [Activity]
    
    @State private var offset: CGFloat = UIScreen.main.bounds.height * 0.8
    @State private var dragOffset: CGFloat = 0
    
    @State private var selectedItem: Activity? = nil
    
    //    @State private var position = MapCameraPosition.region(
    //        MKCoordinateRegion(
    //            center: CLLocationCoordinate2D(latitude: 37.77, longitude: -122.42),
    //            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
    //        )
    //    )
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Map { //Map(position: $position)
                    ForEach(activities) { activity in
                        Annotation(activity.name, coordinate: activity.coordinate) {
                            Image(systemName: "mappin.circle.fill")
                                .onTapGesture {
                                    self.selectedItem = activity
                                }
                        }
                        .annotationTitles(.hidden)
                    }
                }
                .zIndex(-1)
                
                // Activity Item View
                if let selectedItem = selectedItem {
                    ActivityItemView(activity: selectedItem)
                        .frame(height: 200)
                } else {
                    // Activity List View
                        ActivityListView()
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
                                            self.offset = UIScreen.main.bounds.height * 0.8
                                        }
                                    }
                                }
                        )
                }
            }
            .gesture(
                TapGesture()
                    .onEnded { value in
                        self.selectedItem = nil
                    }
            )
        }
    }
    
    func fetchActivities() async {
        // Don't re-fetch data if we already have it.
        guard activities.isEmpty else { return }
        
        do {
            let url = URL(string: "https://raw.githubusercontent.com/annalieNK/family-activities/map-views/FamilyActivities/activities.json")!
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
