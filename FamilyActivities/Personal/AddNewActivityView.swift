//
//  AddNewActivityView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/19/24.
//

import MapKit
import SwiftData
import SwiftUI

struct AddNewActivityView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \NewActivity.name) private var newActivities: [NewActivity]
    
    @Bindable var newActivity: NewActivity

    @State private var path = [NewActivity]()
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    var body: some View {
        MapReader { proxy in
            Map(initialPosition: startPosition) {
                ForEach(newActivities) { location in
                    Marker(location.name, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                }
            }
            
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    let newLocation = NewActivity(latitude: coordinate.latitude, longitude: coordinate.longitude) //id: "new",
                    modelContext.insert(newLocation)
                    path = [newLocation]
                    print("Tapped at \(coordinate)")
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: NewActivity.self, configurations: config)
        return AddNewActivityView(newActivity: .example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
