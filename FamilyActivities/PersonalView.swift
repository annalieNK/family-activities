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
    @State private var sortOrder = SortDescriptor(\PersonalActivity.name)
    //    @State private var sortOrder = SortDescriptor(\PersonalRecommendation.name)
    
    
    var body: some View {
        ListView()
        //PersonalRecommendationListView()
        //PersonalActivityListView()
            .navigationTitle("Personal View")
    }
}

#Preview {
    PersonalView()
}
