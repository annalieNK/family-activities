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
    @Query(sort: \PersonalActivity.date) private var personalActivities: [PersonalActivity]
    
    var groupedItems: [String: [PersonalActivity]] { //[(String, [Personal])] {
        Dictionary(grouping: personalActivities) { item in
            //item.shortDate
            formatDate(item.date, format: "MM yyyy") //MM sorts by month number, whereas MMMM sorts alphabettically
        }
        //.sorted(by: { $1.key > $0.key })
    }
    
    var body: some View {
        List {
            ForEach(groupedItems.sorted(by: { $1.key > $0.key }), id: \.key) { month, items in
            //ForEach(groupedItems, id: \.0) { month, items in]
                if month != "12 4000" {
                    Section(header: Text(convertDateFormat(month)!)) { //sectionHeader(for: month)
                        ForEach(items, id: \.id) { item in
                            Text("\(item.name)")
                        }
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
    
    private func convertDateFormat(_ date: String) -> String? {
        // Create a date formatter for the original format "MM yyyy"
        let originalFormatter = DateFormatter()
        originalFormatter.dateFormat = "MM yyyy"
        
        // Create a date formatter for the desired format "MMMM yyyy"
        let newFormatter = DateFormatter()
        newFormatter.dateFormat = "MMMM yyyy"
        
        // Parse the original date string
        if let date = originalFormatter.date(from: date) {
            // Convert the date to the desired format
            return newFormatter.string(from: date)
        } else {
            // Return nil if the parsing fails
            return nil
        }
    }
        
    // change section header for Date.distantFuture AND change date format
    private func sectionHeader(for month: String) -> Text {
        if month == "12 4000" {
            return Text("Not planned activities")
        } else {
            return Text(convertDateFormat(month)!)//Text(month)
        }
    }
}

#Preview {
    PersonalCalendarView()
}