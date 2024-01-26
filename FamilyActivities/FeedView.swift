//
//  FeedView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/10/24.
//

import LinkPresentation
import SwiftUI

struct StringLink: Identifiable {
    var id=UUID()
    var string:String
}

struct FeedView: View {
    @State var redrawPreview = false
    let links: [StringLink] = [StringLink(string: "https://www.youtube.com")]
    
    var body: some View {
        List(links) { l in
            LinkRow(previewURL: URL(string: l.string)!, redraw: self.$redrawPreview)
        }
        .frame(width: 350, height: 375, alignment: .leading)
        //.frame(maxWidth: .infinity, maxHeight: 100)
    }
}

#Preview {
    FeedView()
}
