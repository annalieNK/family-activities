//
//  ItemDetailView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 2/1/24.
//

import SwiftUI

struct ItemDetailView: View {
    var friend: Friend

    var body: some View {
//        Text("Item Detail: \(activity.name)")
//            .navigationTitle(activity.name)
        List {
            Section("About") {
                Text(friend.name)
                    .padding(.vertical)
            }
            
            Section("Type") {
                Text(friend.someText)
            }
        }
        .listStyle(.grouped)
        .navigationTitle(friend.name)
    }
}

//#Preview {
//    ItemDetailView(friend: .example)
//}
