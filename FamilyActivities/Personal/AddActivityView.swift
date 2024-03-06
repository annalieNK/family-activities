//
//  AddActivityView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/4/24.
//

import MapKit
import SwiftData
import SwiftUI

struct AddActivityView: View {
    @Bindable var addedActivity: AddedActivity // make it editable
    
//    @Environment(\.modelContext) var modelContext
//    @Query(sort: \AddedActivity.name) private var addedActivities: [AddedActivity]
    
//    @State private var path = [AddedActivity]()
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    var body: some View {
        VStack {
            Form {
                TextField("Name", text: $addedActivity.name)
                TextField("Name", text: $addedActivity.type)
                
            }
            
//            MapReader { proxy in
//                Map(initialPosition: startPosition) {
//                    ForEach(addedActivities) { location in
//                        Marker(location.name, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
//                    }
//                }
//
//                .onTapGesture { position in
//                    if let coordinate = proxy.convert(position, from: .local) {
//                        let newLocation = AddedActivity(id: "new", latitude: coordinate.latitude, longitude: coordinate.longitude)
//                        modelContext.insert(newLocation)
//                        path = [newLocation]
//                        print("Tapped at \(coordinate)")
//                    }
//                }
//            }
        }
        
        .navigationTitle("Add Activity")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    // make temporarily in memory storage for our data
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: AddedActivity.self, configurations: config)
        return AddActivityView(addedActivity: .example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
