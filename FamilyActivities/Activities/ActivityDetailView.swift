//
//  DetailView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/18/24.
//

import MapKit
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
            VStack {
                Text(activity.name)
                Text(activity.type)
                Text("Saved to Personal: \(activity.isSaved ? "True" : "False")")
                
                Image(activity.id)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350, height: 200)
                
                Map(initialPosition: .region(MKCoordinateRegion(center: activity.coordinate, span: (MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))))) {
                    Annotation(activity.name, coordinate: activity.coordinate) {
                        Image(systemName: "mappin.circle.fill")
                    }
                }
                .frame(width: 350, height: 200)
                                                
                // Add an embeded links (e.g. to the Park Services)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack { //(spacing: 20)
                        ForEach(activity.links, id: \.self) { link in
                            LinkRow(previewURL: URL(string: link)!)
                            //FileLinkView(viewModel: ViewController(link))
                                .frame(width: 100, height: 100, alignment: .leading)
                        }
                    }
                    //.padding(.horizontal)
                }
            }
        }
        .toolbar {
            //Button("Save to personal items", action: saveToPersonalActivity)
            Button(action: {
                // Toggle the boolean value of the item
                self.activity.isSaved.toggle()
                try? modelContext.save()
            }) {
                Text("Save")
            }
        }
        
    }
    
    // create a function to save this item to the Personal SwiftData model
    func saveToPersonalActivity() {
        //let savedActivity = PersonalActivity(name: activity.name, type: activity.type, link: link, latitude: activity.latitude, longitude: activity.longitude)
        let savedActivity = PersonalActivity(link: link)
        modelContext.insert(savedActivity)
        path = [savedActivity]
        try? modelContext.save()
        
    }
}

#Preview {
    ActivityDetailView(activity: .example)
}
