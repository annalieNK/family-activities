//
//  AddJournalView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/6/24.
//

import MapKit
import SwiftData
import SwiftUI

//extension CLLocationCoordinate2D {
//    static let sfZoo = CLLocationCoordinate2D(latitude: 37.73, longitude: -122.50)
//    static let stinsonBeach = CLLocationCoordinate2D(latitude: 37.90, longitude: -122.64)
//}

struct AddJournalView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Activity.name) private var activities: [Activity]
    
    //@Bindable var journal: Journal
    
    @State private var journal: Journal?
    @State private var newJournalsPath = [Journal]()
    
    @State private var selectedActivity: Activity?
    @State private var searchText = ""
    
    @State private var name: String = ""
    
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
        let locations = journal?.locations ?? []
        
        VStack {
            Form {
                TextField("Name", text: $name)
                
                Section("Items Visited") {
                    ForEach(locations) { location in
                        Text(location.name)
                    }
                }
            }
            
            Map {
                ForEach(locations) { location in
                    Marker("", coordinate: location.coordinate)
                }
            }
            
            Map {
                ForEach(searchActivity) { activity in
                    Annotation(activity.name, coordinate: activity.coordinate) {
                        VStack {
                            ZStack {
                                Image(systemName: "circle.fill")
                                    .font(selectedActivity == activity ? .largeTitle : .title)
                                    .opacity(selectedActivity == activity ? 1 : 0.5)
                                
                                Image(systemName: activity.symbol)
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                        .onTapGesture {
                            selectedActivity = activity
                            if let unwrappedJournal = journal {
                                let newLocation = Location(name: activity.name, latitude: activity.coordinate.latitude, longitude: activity.coordinate.longitude)
                                unwrappedJournal.locations.append(newLocation)
                            }
                        }
                    }
                    .annotationTitles(.hidden)
                }
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            
            Button("Save") {
                guard let selectedActivity = self.selectedActivity else { return }
                print("Tapped Save Button")
                let newItem = Journal(name: name)
                modelContext.insert(newItem)
                newJournalsPath = [newItem]
            }
        }
    }

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
