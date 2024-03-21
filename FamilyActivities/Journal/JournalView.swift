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
    @Query(sort: \Journal.name) private var journalItems: [Journal]
    
    @State private var path = [Journal]()
    @State private var isAddJournal = false
    
    var body: some View {
        VStack {
            List {
                ForEach(journalItems) { journal in
                    NavigationLink(destination: Text(journal.name)) { //AddJournalView() //journal: journal
                        Text(journal.name)
                    }
                }
                .onDelete(perform: deleteItems)
            }
            
            //Button("Add Item", systemImage: "plus", action: addItem)
        }
        .navigationBarTitle("JournalView")//, displayMode: .inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    //isAddJournal = true
                    addItem()
                } label: {
                    Label("Add Journal", systemImage: "plus")
                }
            }
        }
        .sheet(isPresented: $isAddJournal) {
            AddJournalView() //journal: journal
        }
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = journalItems[index]
            modelContext.delete(item)
        }
    }
    
    func addItem() {
        let item = Journal(name: "New Activity")
        modelContext.insert(item)
        path = [item]
    }
}

#Preview {
    JournalView()
}
