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
    
//    @State private var activityNames = [String]()
//    @State private var path = [PersonalActivity]()
    @State private var path = [PersonalRecommendation]()
//    @State private var sortOrder = SortDescriptor(\PersonalActivity.name)
    @State private var sortOrder = SortDescriptor(\PersonalRecommendation.name)
    
    @State private var showingCalendar = false //@AppStorage("showingGrid")
    
    var body: some View {
        NavigationStack(path: $path) {
            Group {
                if showingCalendar {
                    PersonalCalendarView()
                } else {
                    //PersonalActivityListView()
                    PersonalRecommendationListView()
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
//                .toolbar {
//                    Button("Add Item", systemImage: "plus", action: addItem)
//                }
        }
    }
    
//    func addItem() {
//        let item = PersonalActivity()
//        //let item = PersonalRecommendation()
//        modelContext.insert(item)
//        path = [item]
//    }
}

#Preview {
    PersonalView()
}
