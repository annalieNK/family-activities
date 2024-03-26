//
//  NewActivityListView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/19/24.
//

import MapKit
import SwiftData
import SwiftUI

struct NewActivityListView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \NewActivity.name) private var newActivities: [NewActivity]
        
    @State private var isAddActivity = false
    @AppStorage("showingMap") private var showingList = true
    
    var body: some View {
        Group {
            if showingList {
                Map {
                    ForEach(newActivities) { newActivity in
                        Marker(newActivity.name, coordinate: newActivity.coordinate)
                    }
                }
            } else {
                List {
                    ForEach(newActivities) { newActivity in
                        NavigationLink(destination: NewActivityDetailView(newActivity: newActivity)) {
                            Text("\(newActivity.name)")
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .automatic) {
                Button {
                    showingList.toggle()
                } label: {
                    if showingList {
                        Label("Show list", systemImage: "list.dash")
                    } else {
                        Label("Show map", systemImage: "map")
                    }
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isAddActivity = true
                } label: {
                    Label("Add Activity", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $isAddActivity) {
            AddActivityView() //newActivity: NewActivity.example
        }
        .navigationBarTitle("Random Locations", displayMode: .inline)
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = newActivities[index]
            modelContext.delete(item)
        }
    }
}

#Preview {
    NewActivityListView()
}
