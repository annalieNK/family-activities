//
//  FeedView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/10/24.
//

import LinkPresentation
import SwiftUI

struct FeedView: View {
    //let urlString = "https://www.nps.gov/alca/index.htm"
    
    @ObservedObject var viewModel: ViewController
    
    var body: some View {
        // add a text and references to the Activity Items
        //        Text("Feed View") //urlString
        //            .navigationTitle("Feed")
        HStack(spacing: 15) {
            if let image = viewModel.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: 107, maxHeight: 107)
                    .clipped()
                    .cornerRadius(16)
            }
            
            VStack(alignment: .leading, spacing: 1, content: {
                if let title = viewModel.title {
                    Text(title)
                        .font(.body)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.leading)
                }
                
                if let url = viewModel.url {
                    Text(url)
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                }
            })
            .padding(.top, 16)
            .padding(.bottom, 9)
            .padding(.trailing, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: 100)
    }
}

//#Preview {
//    FeedView()
//}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(
            viewModel: ViewController("https://www.nps.gov/alca/index.htm")
        )
    }
}
