//
//  TabView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/10/24.
//

import SwiftUI

struct TabPageView: View {
    @ObservedObject var viewModel: ViewController
    
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
            FeedView(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "ellipsis")
                }
        }
    }
}

#Preview {
    TabPageView(viewModel: ViewController("https://www.nps.gov/alca/index.htm"))
}
