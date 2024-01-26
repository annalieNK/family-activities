//
//  TabView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/10/24.
//

import SwiftUI

struct TabPageView: View {    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                }
            RecommendationListView()
                .tabItem {
                    Image(systemName: "map")
                }
            PersonalView()
                .tabItem {
                    Image(systemName: "heart")
                }
            FeedView()
                .tabItem {
                    Image(systemName: "ellipsis")
                }
        }
    }
}

#Preview {
    TabPageView()
}
