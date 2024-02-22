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
            ActivityView()
                .tabItem {
                    Image(systemName: "map")
                }
            PersonalView()
                .tabItem {
                    Image(systemName: "heart")
                }
            RecommendationView()
                .tabItem {
                    Image(systemName: "ellipsis")
                }
            TestView3()
                .tabItem {
                    Image(systemName: "questionmark.square")
                }
        }
    }
}

#Preview {
    TabPageView()
}
