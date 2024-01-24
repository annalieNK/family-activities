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
    @Query(sort: \PersonalItem.name) private var personalItems: [PersonalItem]
    
    var body: some View {
        List {
            ForEach(personalItems) { item in
                NavigationLink(value: item) {
                    VStack(alignment: .leading) {
                        Text(item.name)
                    }
                }
            }
            .onDelete(perform: deleteItems)
        }
    }
    
    func deleteItems(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = personalItems[index]
            modelContext.delete(item)
        }
    }
}

#Preview {
    PersonalListingView()
}
