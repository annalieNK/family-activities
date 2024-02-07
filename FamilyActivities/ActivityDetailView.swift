//
//  DetailView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/18/24.
//

import SwiftData
import SwiftUI

struct ActivityDetailView: View {
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
            
            // Add an embeded links (e.g. to the Park Services)
            Section("Activity Links") {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(activity.links, id: \.self) { link in
                            LinkRow(previewURL: URL(string: link)!)
                            //FileLinkView(viewModel: ViewController(link))
                                .frame(width: 350, height: 375, alignment: .leading)
                        }
                    }
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
        let savedActivity = Personal(name: activity.name, type: activity.type, link: link) //Personal() //id: activity.id,
        modelContext.insert(savedActivity)
        path = [savedActivity]
        // add save function
        try? modelContext.save()
        
    }
}

#Preview {
    ActivityDetailView(activity: .example)
}
