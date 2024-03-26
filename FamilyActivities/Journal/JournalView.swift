//
//  JournalView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 3/6/24.
//

import SwiftData
import SwiftUI

struct JournalView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    @Query(sort: \NewItinerary.name) private var newItineraries: [NewItinerary]
    @Query(sort: \Journal.name) private var journalItems: [Journal] //sort by date
    
    @State private var newItinerariesPath = [NewItinerary]()
    @State private var journalPath = [Journal]()
    @State private var isAddUsedItinerary = false
    @State private var isNewJournalItem = false
    @State private var isPresentingSheet2 = false
    
    @State private var newItinerary: NewItinerary? //@Bindable var newItinerary: NewItinerary
    
    @State private var name: String = ""
    
    var body: some View {
        VStack {
            Menu {
                Button {
                    addItem()
                    //isNewJournalItem = true
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
                ForEach(journalItems) { journal in
                    if journal.name == "New Journal Item" {
                        NavigationLink(destination: AddJournalView(journal: journal)) {
                            Text(journal.name)
                        }
                    } else {
                        NavigationLink(destination: JournalDetailView(journal: journal)) {
                            Text(journal.name)
                        }
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
//                        NavigationLink(destination: AddItineraryView(newItinerary: itinerary)) {
                        Button {
                            print("Show a sheet view to add new Journal item")
                            isPresentingSheet2 = true
//                            let newJournalItem = Journal(name: itinerary.name)
//                            let newJournalLocations = Location(latitude: , longitude:     )
//                            newItinerary.locations.append(newLocation)
//                            modelContext.insert(newJournalItem)
//                            journalPath = [newJournalItem]
                        } label: {
                            Text(itinerary.name)
                        }
                    }
                }
            }
            .sheet(isPresented: $isPresentingSheet2) {
                AddJournalView(journal: .example) //Text("isSheet2")
            }
        }
//        .sheet(isPresented: $isNewJournalItem) {
//            AddJournalView(journal: .example)//Text("Create a new Journal Item here")
//        }
    }
    
    func addItem() {
        let item = Journal(name: "New Journal Item")
        modelContext.insert(item)
        journalPath = [item]
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = journalItems[index]
            modelContext.delete(item)
        }
    }
}

#Preview {
    JournalView()
}
