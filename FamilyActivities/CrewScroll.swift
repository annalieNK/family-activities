//
//  CrewScroll.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 2/1/24.
//

import SwiftUI

struct CrewScroll: View {
    let crew: [RecommendationDetailView.CrewMember]
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(crew, id: \.role) { crewMember in
                    NavigationLink {
                        Text("Astronaut details")
                        //AstronautView(astronaut: crewMember.astronaut)
                    } label: {
                        VStack {
                            Text(crewMember.activity.name)
                            Text(crewMember.role)
                        }
                    }
                }
            }
        }
    }
}

struct CrewScroll_Previews: PreviewProvider {
    static var previews: some View {
        CrewScroll(crew: [])
    }
}

//#Preview {
//    CrewScroll()
//}
