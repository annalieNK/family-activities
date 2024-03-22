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
    @Query(sort: \NewActivity.name) private var newActivities: [NewActivity]
    
    @State private var offset: CGFloat = UIScreen.main.bounds.height * 0.8
    @State private var dragOffset: CGFloat = 0
    @State private var selectedItem: Activity? = nil
    @State private var showFilterOptions = false
    @State private var filterType = FilterTag.default
    @State private var searchText = ""
    @State private var showList = false
    
    @State private var selected: String = ""
    
    @State private var selectedType = ""
        
    //@State private var filteredItems: [Activity] = []
    
//    @State private var position = MapCameraPosition.region(
//        MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 37.77, longitude: -122.42),
//            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//        )
//    )
    
    @State private var position = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    
    enum FilterTag {
        case `default`, beach, familyActivity
    }
    
    var body: some View {
        NavigationView {
            VStack {
//                Button {
//                    showFilterOptions = true
//                    //showFilterOptions.toggle()
//                } label: {
//                    Text("Type")
//                }
//                .buttonStyle(BorderedButtonStyle())
                
                Picker("Filter by Type", selection: $selectedType) { // $filterType
                    Text("All").tag("").foregroundColor(.black)
                    ForEach(Set(activities.map { $0.type }).sorted(), id: \.self) { type in
                        Text(type)//.tag(type).foregroundColor(.black)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                
                GeometryReader { geometry in
                    ZStack(alignment: .bottom) {
                        MapReader { proxy in
                            Map { //Map(position: $position)
                                ForEach(filteredActivities) { activity in //activities
                                    Annotation(activity.name, coordinate: activity.coordinate) {
                                        Button(action: {
                                            selectedItem = activity
                                            print(selectedItem == nil)
                                            print(selectedItem!.name)
                                            print(selectedItem!.coordinate)
                                        }) {
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
                                        }
                                    }
                                    .annotationTitles(.hidden)
                                }
                                
//                                // add a filter to show these new activities
//                                ForEach(newActivities) { newActivity in
//                                    Marker(newActivity.name, coordinate: newActivity.coordinate)
//                                }
                            }
                            .zIndex(-1)
                            .searchable(text: $searchText, prompt: "Search for a resort") // Here, or at the bottom? Both locations work.
                            .onTapGesture { value in
                                let coordinate = proxy.convert(value, from: .local)
                                print("\(coordinate!)")
                                
                                let tappedOnActivity = activities.contains { activity in
                                    // Check if tap location falls within a certain range of any data point
                                    let distance = CLLocation(latitude: coordinate!.latitude, longitude: coordinate!.longitude).distance(from: CLLocation(latitude: activity.coordinate.latitude, longitude: activity.coordinate.longitude))
                                    return distance < 500 // Adjust this threshold as needed
                                }
                                print(tappedOnActivity)
                                
                                if !tappedOnActivity {
                                    selectedItem = nil
                                    print("\(String(describing: selectedItem?.coordinate))")
                                }
                            }
                            
                            // Activity Item View
                            if let selectedItem = selectedItem {
                                ActivityItemView(activity: selectedItem)
                                    .frame(height: 100)
                            } else {
                                Button {
                                    withAnimation {
                                        showList = true
                                    }
                                } label: {
                                    Text("\(filteredActivities.count) activities") //filteredLocations
                                }
                            }
                        }
                    }
                    
                    if showList {
                        ActivityListView(searchText: $searchText, selectedType: $selectedType, showlist: $showList)
                            .frame(height: geometry.size.height * 1)
                            .transition(.move(edge: .bottom))
                    }
                }
//                .sheet(isPresented: $showList) { // popover //fullScreenCover
//                    ActivityListView(searchText: $searchText, selectedType: $selectedType)
//                        .presentationDetents([.fraction(0.85)]) //[.medium, .large] [.large]
//                        .presentationDragIndicator(.visible)
//                }
            }
            //.searchable(text: $searchText, prompt: "Search by activity name")
//            .sheet(isPresented: $showFilterOptions) {
//                NavigationView {
//                    Picker("Filter by Type", selection: $selectedType) { // $filterType
//                        //Text("All").tag("").foregroundColor(.black)
//                        ForEach(Set(activities.map { $0.type }).sorted(), id: \.self) { type in
//                            Text(type)//.tag(type).foregroundColor(.black)
//                        }
//                    }
//                    .pickerStyle(.inline) // SegmentedPickerStyle()
//                    .toolbar {
//                        ToolbarItem(placement: .bottomBar) {
//                            HStack {
//                                Button("Clear") {
//                                    selectedType = ""
//                                    showFilterOptions = false
//                                }
//                                Spacer()
//                                Button("Show \(filteredItems.count) activities") {
//                                    showFilterOptions = false
//                                }
//                            }
//                            .padding()
//                        }
//                    }
//                }
//                .presentationDetents([.medium])
//            }
        }
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
    
    var filteredLocations: [Activity] {
        let mapRect = MKMapView(frame: .zero).visibleMapRect
        let visibleMapRect = MKMapRect(origin: mapRect.origin, size: mapRect.size)
        
        return activities.filter { activity in
            visibleMapRect.contains(MKMapPoint(activity.coordinate))
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
