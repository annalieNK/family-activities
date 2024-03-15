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
//        NavigationView {//NavigationStack(path: $path) {
//            VStack {
                List {
                    ForEach(journalItems) { journal in
//                        NavigationLink(value: journal) {
//                            VStack(alignment: .leading) {
//                                Text(journal.name)
//                            }
//                        }
                        NavigationLink(destination: AddJournalView(journal: journal)) {
                            Text(journal.name)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
//                .navigationDestination(for: Journal.self) { item in
//                    AddJournalView(journal: item)
//                }
                Button("Add Item", systemImage: "plus", action: addItem)
//            }
            .navigationBarTitle("JournalView")//, displayMode: .inline)
            //.navigationBarHidden(true)
//        }
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = journalItems[index]
            modelContext.delete(item)
        }
    }
    
    func addItem() {
        let item = Journal()
        modelContext.insert(item)
        path = [item]
    }
}

#Preview {
    JournalView()
}
