//
//  JournalView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/6/24.
//

import SwiftData
import SwiftUI

struct JournalView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \NewItinerary.name) private var newItineraries: [NewItinerary]
    
    @State private var path = [NewItinerary]()
    @State private var isAddUsedItinerary = false
    @State private var isNewJournalItem = false
    
    @State private var newItinerary: NewItinerary? //@Bindable var newItinerary: NewItinerary
    
    var body: some View {
        VStack {
            Menu {
                Button {
                    //isNewJournalItem = true
                    addItem()
                } label: {
                    Text("New")
                }
                Button {
                    isAddUsedItinerary = true
                } label: {
                    Text("Use Itinerary")
                }
            } label: {
                Label("Add New Item", systemImage: "book.closed")
            }
            
            List {
                ForEach(newItineraries) { itinerary in
                    NavigationLink(destination: AddItineraryView(newItinerary: itinerary)) {
                        Text(itinerary.name)
                    }
                }
                .onDelete(perform: deleteItems)
            }
        }
        .navigationBarTitle("JournalView")//, displayMode: .inline)
        .sheet(isPresented: $isAddUsedItinerary) {
            NavigationView {
                List {
                    ForEach(newItineraries) { itinerary in
                        NavigationLink(destination: AddItineraryView(newItinerary: itinerary)) {
                            Text(itinerary.name)
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isNewJournalItem) {
            Text("Create a new Journal Item here")
        }
    }
    
    func addItem() {
        let item = NewItinerary(name: "New Itinerary")
        modelContext.insert(item)
        path = [item]
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = newItineraries[index]
            modelContext.delete(item)
        }
    }
}

#Preview {
    JournalView()
}
