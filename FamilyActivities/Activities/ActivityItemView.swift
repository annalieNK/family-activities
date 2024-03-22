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
//        ScrollView(.horizontal) {
//            HStack {
                NavigationLink(destination: ActivityDetailView(activity: activity)) {
                    HStack {
                        Image(activity.id)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                        
                        VStack(alignment: .leading) {
                            Text(activity.name)
                            
                            Text(activity.type)
                        }
                    }
                }
//            }
//        }
        .navigationBarTitle("", displayMode: .inline) //"Map View"
        .navigationBarHidden(true)
        .background(.white)
    }
}

#Preview {
    ActivityItemView(activity: .example)
}
