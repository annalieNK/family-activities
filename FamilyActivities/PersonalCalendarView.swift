//
//  PersonalCalendarView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 2/6/24.
//

import SwiftData
import SwiftUI

struct PersonalCalendarView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Personal.name) private var personals: [Personal]
    
    var groupedItems: [String: [Personal]] {
        Dictionary(grouping: personals) { item in
            formatDate(item.date, format: "MMMM yyyy")
        }
    }
    
    var body: some View {
        List {
            ForEach(groupedItems.sorted(by: { $0.key > $1.key }), id: \.key) { month, items in
                Section(header: Text(month)) {
                    ForEach(items, id: \.id) { item in
                        Text("\(item.name)")
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
    
    private func formatDate(_ date: Date, format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}

#Preview {
    PersonalCalendarView()
}
