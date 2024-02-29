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
    
    @State private var path = [PersonalActivity]()
    
    var body: some View {
        //GeometryReader { geometry in
            ScrollView {
                VStack { //List
                    Image(activity.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 350)
                    
                    Section("About") {
                        Text(activity.name)
                            .padding(.vertical)
                    }
                    
                    Section("Type") {
                        Text(activity.type)
                    }
                    
                    Section("Coordinates") {
                        Text("\(activity.latitude), \(activity.longitude)")
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
//            }
        }
        .listStyle(.grouped)
        .navigationTitle(activity.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Save to personal items", action: saveToPersonalActivity)
        }
    }
    
    // create a function to save this item to the Personal SwiftData model
    func saveToPersonalActivity() {
        let savedActivity = PersonalActivity(name: activity.name, type: activity.type, link: link, latitude: activity.latitude, longitude: activity.longitude) //, latitude: activity.latitude, longitude: activity.longitude
        modelContext.insert(savedActivity)
        path = [savedActivity]
        try? modelContext.save()
        
    }
}

#Preview {
    ActivityDetailView(activity: .example)
}
