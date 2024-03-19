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
    @Bindable var newActivity: NewActivity // make it editable
    
    @Environment(\.modelContext) var modelContext
    
    @State private var path = [NewActivity]()
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    var body: some View {
        VStack {
            Form {
                TextField("Name", text: $newActivity.name)
                TextField("Name", text: $newActivity.type)
                
            }
            
            MapReader { proxy in
                Map(initialPosition: startPosition)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            let newLocation = NewActivity(id: "new", latitude: coordinate.latitude, longitude: coordinate.longitude)
                            modelContext.insert(newLocation)
                            path = [newLocation]
                            print("Tapped at \(coordinate)")
                        }
                    }
            }
        }
    }
}

#Preview {
    // make temporarily in memory storage for our data
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: NewActivity.self, configurations: config)
        return AddActivityView(newActivity: .example)
            .modelContainer(container)
    } catch {
        fatalError("Failed to create model container.")
    }
}
