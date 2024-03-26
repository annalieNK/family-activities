//
//  JournalDetailView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/25/24.
//

import MapKit
import SwiftData
import SwiftUI

struct JournalDetailView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    let journal: Journal
    
    var body: some View {
        ScrollView {
            VStack {
                Text(journal.name)
                
                Map {
                    ForEach(journal.locations) { location in
                        Annotation(location.name, coordinate: location.coordinate) {
                            Image(systemName: "mappin.circle.fill")
                        }
                    }
                }
                .frame(width: 350, height: 200)
            }
        }
    }
}

#Preview {
    JournalDetailView(journal: .example)
}
