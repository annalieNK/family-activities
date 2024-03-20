//
//  AddActivityView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/4/24.
//

import MapKit
import SwiftData
import SwiftUI

struct LocationCoordinate: Identifiable, Equatable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
    
    static func == (lhs: LocationCoordinate, rhs: LocationCoordinate) -> Bool {
        return lhs.coordinate.latitude == rhs.coordinate.latitude && lhs.coordinate.longitude == rhs.coordinate.longitude
    }
}

struct AddActivityView: View {
    @Environment(\.modelContext) var modelContext
    @State private var newActivity: NewActivity?
    @State private var newActivitiesPath = [NewActivity]()
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    )
    
    var lastMarkerCoordinate: LocationCoordinate? {
            return markedCoordinates.last
        }
    
    @State private var name: String = ""
    @State private var type: String = ""
    @State private var selectedCoordinate: CLLocationCoordinate2D?
    @State private var markedCoordinates: [LocationCoordinate] = []
    
    var body: some View {
        VStack {
            Form {
                TextField("Name", text: $name)//$newActivity.name)
                TextField("Type", text: $type)//$newActivity.type
            }
            
            MapReader { proxy in
                Map(initialPosition: startPosition) {
                    if let lastCoordinate = lastMarkerCoordinate { //ForEach(markedCoordinates) { location in
                        Marker("", coordinate: lastCoordinate.coordinate) //Marker("", coordinate: location.coordinate)
                    }
                }
                    .onTapGesture { position in
                        guard let selectedCoordinate = proxy.convert(position, from: .local) else { return }
                        self.selectedCoordinate = selectedCoordinate
                        self.markedCoordinates.append(LocationCoordinate(coordinate: selectedCoordinate))
                    }
            }
            
            Button("Save") {
                guard let selectedCoordinate = self.selectedCoordinate else { return }
                print("Tapped Save Button")
                let newItem = NewActivity(name: name, type: type, latitude: selectedCoordinate.latitude, longitude: selectedCoordinate.longitude)
                modelContext.insert(newItem)
                newActivitiesPath = [newItem] //self.newActivity = newItem
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: NewActivity.self, configurations: config)
        return AddActivityView() //newActivity: .example
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
