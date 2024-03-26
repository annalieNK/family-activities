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
        
    //    @State private var path = [PersonalRecommendation]()
    //@State private var sortOrder = SortDescriptor(\PersonalActivity.name)
    //    @State private var sortOrder = SortDescriptor(\PersonalRecommendation.name)
        
    var body: some View {
        NavigationView { //NavigationStack
            VStack {
//                List {
                
                    NavigationLink(destination: PersonalActivityListView()) {
                        HStack {
                            Image(systemName: "bookmark")
                            Spacer()
                            Text("Saved and New Activities")
                        }
                        .padding()
                    }
                    NavigationLink(destination: PersonalRecommendationListView()) {
                        HStack {
                            Image(systemName: "bookmark")
                            Spacer()
                            Text("Saved and New Itineraries")
                        }
                        .padding()
                    }
                    NavigationLink(destination: NewActivityListView()) {
                        HStack {
                            Image(systemName: "mappin.and.ellipse")
                            Spacer()
                            Text("Random Locations")
                        }
                        .padding()
                    }
//                }
                Spacer()
                
                NavigationLink(destination: JournalView()) {
                    HStack {
                        Image(systemName: "book.closed")
                        Spacer()
                        Text("Create a Journal")
                    }
                    .padding()
                }
                
                Spacer()
            }
            .navigationBarTitle("PersonalView", displayMode: .inline)
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    PersonalView()
}
