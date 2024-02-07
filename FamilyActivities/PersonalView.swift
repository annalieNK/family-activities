//
//  PersonalView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/10/24.
//

import SwiftData
import SwiftUI

struct PersonalView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var path = [Personal]()
    @State private var sortOrder = SortDescriptor(\Personal.name)
    
    @State private var showingCalendar = false //@AppStorage("showingGrid")
    
    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if showingCalendar {
                    PersonalCalendarView()
                } else {
                    PersonalListView()
                }
            }
                .toolbar {
                    Button {
                        showingCalendar.toggle()
                    } label: {
                        if showingCalendar {
                            Label("Show Personal View", systemImage: "person.fill")
                        } else {
                            Label("Show Calendar View", systemImage: "calendar")
                        }
                    }
                }
                .navigationTitle("Personal View")
                .navigationDestination(for: Personal.self, destination: EditPersonalView.init)
                .toolbar {
                    Button("Add Item", systemImage: "plus", action: addItem)
                }
        }
    }
    
    func addItem() {
        let item = Personal()
        modelContext.insert(item)
        path = [item]
    }
}

#Preview {
    PersonalView()
}
