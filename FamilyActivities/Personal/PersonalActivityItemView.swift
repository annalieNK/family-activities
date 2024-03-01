//
//  PersonalActivityItemView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 2/28/24.
//

import SwiftData
import SwiftUI

struct PersonalActivityItemView: View {
    @Environment(\.modelContext) var modelContext
    
    let personalActivity: PersonalActivity
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                NavigationLink(destination: PersonalActivityDetailView(personalActivity: personalActivity)) {
                    HStack {
//                        Image(personalActivity.id)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 200, height: 200)
                        
//                        VStack(alignment: .leading) {
//                            Text(personalActivity.name)
//                            
//                            Text(personalActivity.type)
//                        }
                    }
                }
            }
        }
        .background(.white)
    }
}

#Preview {
    PersonalActivityItemView(personalActivity: .example)
}
