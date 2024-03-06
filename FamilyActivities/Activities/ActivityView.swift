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
    @State private var showFilterOptions = false
    @State private var filterType = FilterTag.default
    @State private var searchText = ""
    @State private var showList = false
    
    @State private var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.77, longitude: -122.42),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    )
    
    enum FilterTag {
        case `default`, beach, familyActivity
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Button {
                    showFilterOptions = true
                } label: {
                    Text("Type")
                }
                .buttonStyle(BorderedButtonStyle())
                
                ZStack(alignment: .bottom) {
                    Map { //Map(position: $position)
                        ForEach(filteredActivities) { activity in //activities
                            Annotation(activity.name, coordinate: activity.coordinate) {
                                //Image(systemName: "mappin.circle.fill")
                                VStack {
                                    ZStack {
                                        Image(systemName: "circle.fill")
                                            .font(selectedItem == activity ? .largeTitle : .title)
                                            .opacity(selectedItem == activity ? 1 : 0.5)
                                        //.style(for: activity)
                                        
                                        Image(systemName: activity.symbol)
                                            .font(.caption)
                                            .foregroundColor(.white)
                                    }
                                }
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        self.selectedItem = activity
                                    }
                                }
                            }
                            .annotationTitles(.hidden)
                        }
                    }
                    .zIndex(-1)
                    //.safeAreaInset(edge: .bottom) {
                    //.searchable(text: $searchText, prompt: "Search for a resort") // Here, or at the bottom? Both locations work.
                    .gesture(
                        TapGesture()
                            .onEnded { value in
                                self.selectedItem = nil
                                //filterType = FilterTag.default
                            }
                    )
                    
                    // Activity Item View
                    if let selectedItem = selectedItem {
                        ActivityItemView(activity: selectedItem)
                            .frame(height: 200)
                    }
                }
                
                Button {
                    showList = true
                } label: {
                    Text("\(filteredActivities.count) activities")
                }
                .sheet(isPresented: $showList) {
                    ActivityListView()
                        .presentationDetents([.large]) //[.medium, .large] .fraction(0.95)
                        .presentationDragIndicator(.visible)
                }                
                    //                else {
                    //                    // Activity List View
                    //                    ActivityListView()
                    //                        .offset(y: offset)
                    //                        .gesture(
                    //                            DragGesture()
                    //                                .onChanged { value in
                    //                                    self.dragOffset = value.translation.height
                    //                                }
                    //                                .onEnded { value in
                    //                                    if self.dragOffset < -300 {
                    //                                        withAnimation {
                    //                                            self.offset = 0
                    //                                        }
                    //                                    } else {
                    //                                        withAnimation {
                    //                                            self.offset = UIScreen.main.bounds.height * 0.8
                    //                                        }
                    //                                    }
                    //                                }
                    //                        )
                    //                }
            }
//            .gesture(
//                TapGesture()
//                    .onEnded { value in
//                        self.selectedItem = nil
//                        //filterType = FilterTag.default
//                    }
//            )
            .searchable(text: $searchText, prompt: "Search by activity name")
            .confirmationDialog("Filter activities", isPresented: $showFilterOptions) {
                Button("All") { filterType = .default }
                Button("Beach") { filterType = .beach }
                Button("Family Activity") { filterType = .familyActivity }
            }
        }
    }
    
    var searchActivity: [Activity] {
        if searchText.isEmpty {
            return activities
        } else {
            return activities.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var filteredActivities: [Activity] {
        switch filterType {
        case .default:
            return searchActivity
        case .beach:
            return searchActivity.filter { $0.type == "beach"}
        case .familyActivity:
            return searchActivity.filter { $0.type == "family activities"}
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
