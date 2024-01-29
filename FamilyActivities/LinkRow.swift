//
//  LinkRow.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/25/24.
//

import Foundation
import LinkPresentation
import SwiftUI

struct LinkRow: UIViewRepresentable {
    var previewURL: URL
    //@Binding var redraw: Bool
    
    func makeUIView(context: Context) -> LPLinkView {
        
        let view = LPLinkView(url: previewURL)
        //let view = LPLinkView()
        
        let provider = LPMetadataProvider()
        
        provider.startFetchingMetadata(for: previewURL) { (metadata, error) in
            guard let metadata = metadata, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                view.metadata = metadata
                //self.view.addSubview(view)
                view.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
                //view.sizeToFit()
                //view.center = self?.view.center ?? .zero
                //self.redraw.toggle()
            }
        }
        return view
    }

    func updateUIView(_ uiView: LPLinkView, context: Context) {
        // New instance for each update.
    }
}
