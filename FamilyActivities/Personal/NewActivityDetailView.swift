//
//  NewActivityDetailView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/20/24.
//

import MapKit
import SwiftData
import SwiftUI

struct NewActivityDetailView: View {
    @Environment(\.modelContext) var modelContext
    let newActivity: NewActivity
    
    var body: some View {
        VStack {
            Text(newActivity.name)
            Text(newActivity.type)
            
            Map {
                Marker("", coordinate: newActivity.coordinate)
            }
        }
    }
}

#Preview {
    NewActivityDetailView(newActivity: .example)
}
