//
//  FileLinkView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/29/24.
//

import SwiftUI

struct FileLinkView: View {
    
    @ObservedObject var viewModel: ViewController
    
    var body: some View {
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

//struct FileLinkView_Previews: PreviewProvider {
//    static var previews: some View {
//        FileLinkView(
//            viewModel: ViewController("https://www.youtube.com")
//        )
//    }
//}

#Preview {
    FileLinkView(
        viewModel: ViewController("https://www.youtube.com") //"https://www.nps.gov/alca/index.htm"
    )
}
