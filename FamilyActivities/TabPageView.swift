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
//            HomeView()
//                .tabItem {
//                    Image(systemName: "house")
//                }
            ActivityView()
                .tabItem {
                    Image(systemName: "list.bullet")
                }
            PersonalView()
                .tabItem {
                    Image(systemName: "heart")
                }
            RecommendationView()
                .tabItem {
                    Image(systemName: "ellipsis")
                }
//            TestMapView()
//                .tabItem {
//                    Image(systemName: "map")
//                }
//            TestMapView2()
//                .tabItem {
//                    Image(systemName: "map")
//                }
        }
    }
}

#Preview {
    TabPageView()
}
