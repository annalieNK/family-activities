//
//  TestMapView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 2/26/24.
//

import MapKit
import SwiftData
import SwiftUI

struct TestMapView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Activity.name) private var activities: [Activity]
    
    var body: some View {
        ZStack {
            Text("Map View")
        }
    }
}

#Preview {
    TestMapView()
}

