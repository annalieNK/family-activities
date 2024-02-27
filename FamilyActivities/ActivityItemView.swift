//
//  ActivityItemView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 2/26/24.
//

import SwiftData
import SwiftUI

struct ActivityItemView: View {
    @Environment(\.modelContext) var modelContext
    
    let activity: Activity
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                NavigationLink(destination: ActivityDetailView(activity: activity)) {
                    HStack {
                        Image(systemName: "figure.2.and.child.holdinghands")
                        
                        VStack(alignment: .leading) {
                            Text(activity.name)
                            
                            Text(activity.type)
                        }
                    }
                }
            }
        }
        .background(.white)
    }
}

#Preview {
    ActivityItemView(activity: .example)
}
