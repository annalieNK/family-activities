//
//  NewItineraryDetailView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/21/24.
//

import MapKit
import SwiftData
import SwiftUI

struct NewItineraryDetailView: View {
    @Environment(\.modelContext) var modelContext
    let newItinerary: NewItinerary
    
    var body: some View {
        VStack {
            Text(newItinerary.name)
            
            Section("Activities") {
                ForEach(newItinerary.locations) { location in
                    Text(location.name)
                }
            }
            
//            Map {
//                ForEach(newItinerary.locations) { location in
//                    Marker("", coordinate: location.coordinate)
//                }
//            }
        }
    }
}

#Preview {
    NewItineraryDetailView(newItinerary: .example)
}
