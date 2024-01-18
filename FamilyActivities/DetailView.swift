//
//  DetailView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/18/24.
//

import SwiftUI

struct DetailView: View {
    let activity: Activity

    var body: some View {
        List {
            Section("About") {
                Text(activity.name)
                    .padding(.vertical)
            }

            Section("Contact details") {
                Text("email: \(activity.email)")
            }
        }
        .listStyle(.grouped)
        .navigationTitle(activity.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailView(activity: .example)
}
