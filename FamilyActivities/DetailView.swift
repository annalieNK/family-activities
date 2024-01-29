//
//  DetailView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/18/24.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    
    let activity: Activity
    
    @State private var link = ""
    @State private var path = [Personal]()
    
    var body: some View {
        List {
            Section("About") {
                Text(activity.name)
                    .padding(.vertical)
            }
            
            Section("Type") {
                Text(activity.type)
            }
            
            // Add an embeded link (e.g. to the Park Services)
            Section("Activity Links") {
                ForEach(activity.links, id: \.self) { link in
                    Text(link)
                }
            }
            
        }
        .listStyle(.grouped)
        .navigationTitle(activity.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Save to personal items", action: saveToPersonal)
        }
    }
    
    // create a function to save this item to the Personal SwiftData model
    func saveToPersonal() {
        let savedActivity = Personal(name: activity.name, type: activity.type, link: link) //Personal()
        modelContext.insert(savedActivity)
        path = [savedActivity]
        // add save function
        try? modelContext.save()
        
    }
}

#Preview {
    DetailView(activity: .example)
}
