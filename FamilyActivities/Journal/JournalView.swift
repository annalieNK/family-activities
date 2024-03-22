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
    
    var body: some View {
        List {
            ForEach(journalItems) { journal in
                NavigationLink(destination: AddJournalView(journal: journal)) {
                    Text(journal.name)
                }
            }
            .onDelete(perform: deleteItems)
        }
        //Button("Add Item", systemImage: "plus", action: addItem)
            .navigationBarTitle("JournalView")//, displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        addItem()
                    } label: {
                        Label("Add Activity", systemImage: "plus")
                    }
                }
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
