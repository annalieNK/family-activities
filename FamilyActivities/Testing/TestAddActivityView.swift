//
//  TestAddActivityView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/4/24.
//

import MapKit
import SwiftData
import SwiftUI

struct TestAddActivityView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \AddedActivity.name) private var addedActivities: [AddedActivity]
    
    @State private var path = [AddedActivity]()
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    var body: some View {
        //        NavigationStack(path: $path) {
        //            List {
        //                ForEach(addedActivities) { addedActivity in
        //                    NavigationLink(value: addedActivity) {
        //                        Text(addedActivity.name)
        //                    }
        //                }
        //            }
        //            .navigationDestination(for: AddedActivity.self, destination: AddActivityView.init)
        //            .toolbar {
        //                Button("Add Activity", systemImage: "plus", action: addActivity)
        //            }
        //        }
        MapReader { proxy in
            Map(initialPosition: startPosition) {
                ForEach(addedActivities) { location in
                    Marker(location.name, coordinate: CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude))
                }
            }

            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    let newLocation = AddedActivity(id: "new", latitude: coordinate.latitude, longitude: coordinate.longitude)
                    modelContext.insert(newLocation)
                    path = [newLocation]
                    print("Tapped at \(coordinate)")
                }
            }
        }
    }
    
    func addActivity() {
        //        let addedActivity = AddedActivity()
        //        modelContext.insert(addedActivity)
        //        path = [addedActivity]
    }
}

#Preview {
    TestAddActivityView()
}
