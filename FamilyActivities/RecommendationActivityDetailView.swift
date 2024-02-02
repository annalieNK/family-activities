//
//  DetailView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/18/24.
//

import SwiftData
import SwiftUI

struct RecommendationActivityDetailView: View {
    @Environment(\.modelContext) var modelContext
    
    let recommendationActivity: RecommendationActivity
    
    @State private var link = ""
    @State private var path = [Personal]()
    
    var body: some View {
        List {
            Section("About") {
                Text(recommendationActivity.name)
                    .padding(.vertical)
            }
            
            Section("Type") {
                Text(recommendationActivity.type)
            }
                        
            Section("Activity Links") {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(recommendationActivity.links, id: \.self) { link in
                            LinkRow(previewURL: URL(string: link)!)
                            //FileLinkView(viewModel: ViewController(link))
                                .frame(width: 350, height: 375, alignment: .leading)
                        }
                    }
                }
            }
        }
        .listStyle(.grouped)
        .navigationTitle(recommendationActivity.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    RecommendationActivityDetailView(recommendationActivity: .example)
}
