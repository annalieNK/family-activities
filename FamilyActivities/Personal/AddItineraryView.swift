//
//  AddItineraryView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/21/24.
//

import MapKit
import SwiftData
import SwiftUI

struct AddItineraryView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var newItinerariesPath = [NewItinerary]()
    @Bindable var newItinerary: NewItinerary //@State private var newItinerary: NewItinerary?
    
    @State private var isAddLocation = false
    
    @State private var name: String = ""
    
    @State private var selectedActivity: Activity? = nil
    
    @Query(sort: \Activity.name) private var activities: [Activity]
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            Section {
                TextField("Name", text: $newItinerary.name)
            }
            
            //if let newItinerary = newItinerary, !newItinerary.locations.isEmpty {
            ZStack(alignment: .bottom) {
                MapReader { proxy in
                    Map {
                        ForEach(newItinerary.locations) { location in
                            //Marker("", coordinate: location.coordinate)
                            Annotation(location.name, coordinate: location.coordinate) {
                                Button(action: {
                                    let selectedActivity = activities.first(where: { $0.name == location.name})
                                    self.selectedActivity = selectedActivity
                                }) {
                                    Image(systemName: "mappin.circle.fill")
                                        .contextMenu {
                                            Button("Delete") {
                                                deleteLocations(withName: location.name)
                                            }
                                        }
                                }
                            }
                        }
                    }
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
                            selectedActivity = nil
                            print("\(String(describing: selectedActivity?.coordinate))")
                        }
                    }
                    
                    if let selectedActivity = selectedActivity {
                        ActivityItemView(activity: selectedActivity)
                            .frame(height: 200)
                    }
                }
            }
            
            Button {
                isAddLocation = true
            } label: {
                Text("Add Location") //Label("Add Location", systemImage: "plus")
            }
        }
        .sheet(isPresented: $isAddLocation) {
            //SearchActivityView()
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
                                //if let newItinerary = newItinerary, !newItinerary.locations.isEmpty {
                                selectedActivity = activity
                                print(selectedActivity!.name)
                                let newLocation = Location(name: activity.name, latitude: activity.coordinate.latitude, longitude: activity.coordinate.longitude)
                                newItinerary.locations.append(newLocation)
                                //}
                            } label: {
                                Text(activity.name)
                            }
                        }
                    }
                }
            }
            .presentationDetents([.medium]) //, .medium //[.height(400), .fraction(0.8)]
        }
    }
    
    var searchActivity: [Activity] {
        if searchText.isEmpty {
            return [] //activities
        } else {
            return activities.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    //newItinerary.locations.removeAll(where: {$0.name == location.name })
    func deleteLocations(withName name: String) {
        newItinerary.locations.removeAll { $0.name == name }
    }
    
}

#Preview {
    AddItineraryView(newItinerary: .example)
}