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
            List {
                NavigationLink(destination: PersonalActivityListView()) {
                    Text("Saved and New Activities")
                }
                NavigationLink(destination: PersonalRecommendationListView()) {
                    Text("Saved and New Itineraries")
                }
                NavigationLink(destination: NewActivityListView()) {
                    Text("Random Locations")
                }
                NavigationLink(destination: JournalView()) {
                    Text("Create a Journal")
                }
                
            }
            .navigationBarTitle("PersonalView", displayMode: .inline) 
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    PersonalView()
}
