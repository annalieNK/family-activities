//
//  PersonalListingView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/19/24.
//

import SwiftData
import SwiftUI

struct PersonalListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Personal.name) private var personals: [Personal]
    
    var body: some View {
        List {
            ForEach(personals) { personal in
                NavigationLink(value: personal) {
                    VStack(alignment: .leading) {
                        Text(personal.name)
                    }
                }
            }
        }
    }
}

#Preview {
    PersonalListingView()
}
