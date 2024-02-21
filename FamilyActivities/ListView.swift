//
//  TestView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 2/21/24.
//

import SwiftUI

struct ListView: View {
    @State private var showActivities = true
    
    var body: some View {
        VStack {
            HStack {
                Button("Activities") {
                    self.showActivities = true
                }
                Button("Recommendations") {
                    self.showActivities = false
                }
            }
            
            if showActivities {
                PersonalActivityListView()
            } else {
                PersonalRecommendationListView()
            }
        }
    }
}

#Preview {
    ListView()
}
