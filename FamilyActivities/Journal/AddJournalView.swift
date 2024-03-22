//
//  AddJournalView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/6/24.
//

import MapKit
import SwiftData
import SwiftUI

extension CLLocationCoordinate2D {
    static let sfZoo = CLLocationCoordinate2D(latitude: 37.73, longitude: -122.50)
    static let stinsonBeach = CLLocationCoordinate2D(latitude: 37.90, longitude: -122.64)
}

struct AddJournalView: View {
    @Query(sort: \Activity.name) private var activities: [Activity]
    
    @Bindable var journal: Journal
    
    //    @State private var newItem = ""
    //    @State private var latitude: Double
    //    @State private var longitude: Double
    @State private var selectedActivity: Activity?
    @State private var searchText = ""
    
    @State private var isAddLocation = false
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    )
    
    var searchActivity: [Activity] {
        if searchText.isEmpty {
            return []
        } else {
            return activities.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        VStack {
            Form {
                TextField("Name", text: $journal.name)
                
                Section("Items Visited") {
                    ForEach(journal.locations) { location in
                        Text(location.name)
                    }
                }
                
                //                HStack {
                //                    TextField("Add a new item in ", text: $newItem)
                //                    Button("Add", action: addItem)
                //                }
            }
            
            Button {
                isAddLocation = true
            } label: {
                Label("Add Activity", systemImage: "plus")
            }
            
            Map {
                ForEach(journal.locations) { location in
                    Marker("", coordinate: location.coordinate)
                }
            }
            
            Map {
                ForEach(searchActivity) { activity in
                    Annotation(activity.name, coordinate: activity.coordinate) { //Marker
                        VStack {
                            ZStack {
                                Image(systemName: "circle.fill")
                                    .font(selectedActivity == activity ? .largeTitle : .title)
                                    .opacity(selectedActivity == activity ? 1 : 0.5)
                                //.style(for: activity)
                                
                                Image(systemName: activity.symbol)
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                selectedActivity = activity
                                let newLocation = Location(name: activity.name, latitude: activity.coordinate.latitude, longitude: activity.coordinate.longitude) //name: activity.name,
                                journal.locations.append(newLocation)
                            }
                        }
                    }
                    .annotationTitles(.hidden)
                }
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
        }
        .sheet(isPresented: $isAddLocation) {
        }
        //.navigationBarTitle("", displayMode: .automatic)
        //.navigationBarHidden(true)
    }
    
    //        func addItem() {
    //            guard newItem.isEmpty == false else { return }
    //
    //            withAnimation {
    //                let location = Location(name: newItem)
    //                journal.locations.append(location)
    //                newItem = ""
    //            }
    //        }
}

//#Preview {
//    // make temporarily in memory storage for our data
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: Journal.self, configurations: config)
////        let example = Personal(name: "Example name", type: "Example type", link: "Example link")
//        return AddJournalView(journal: .example)
//            .modelContainer(container)
//    } catch {
//        fatalError("Failed to create model container.")
//    }
//}
