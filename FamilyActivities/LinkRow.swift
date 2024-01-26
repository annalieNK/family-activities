//
//  LinkRow.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/25/24.
//

//import Foundation
//import LinkPresentation
//import SwiftUI
//
//struct LinkRow: UIViewRepresentable {
//    var previewURL: URL
//    @Binding var redraw: Bool
//    
//    func makeUIView(context: Context) -> LPLinkView {
//        let view = LPLinkView(url: previewURL)
//        
//        let provider = LPMetadataProvider()
//        provider.startFetchingMetadata(for: previewURL) { (metadata, error) in
//            if let metadata = metadata {
//                DispatchQueue.main.async {
//                    view.metadata = metadata
//                    view.sizeToFit()
//                    self.redraw.toggle()
//                }
//            }
//            else if error != nil
//            {
//                let metadata = LPLinkMetadata()
//                metadata.title = "Custom title"
//                view.metadata = metadata
//                view.sizeToFit()
//                self.redraw.toggle()
//            }
//        }
//        return view
//    }
//
//    func updateUIView(_ uiView: LPLinkView, context: Context) {
//        // New instance for each update.
//    }
//}
