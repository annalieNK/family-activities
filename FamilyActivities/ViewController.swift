//
//  ViewController.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/25/24.
//

//import Foundation
//import LinkPresentation
//import SwiftUI
//import UniformTypeIdentifiers
//
//class ViewController: UIViewController {
//    let urlString = "https://www.nps.gov/alca/index.htm"
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        fetchPreview()
//    }
//
//    func fetchPreview() {
//        guard let url = URL(string: urlString) else {
//            return
//        }
//        let linkPreview = LPLinkView()
//        let provider = LPMetadataProvider()
//        provider.startFetchingMetadata(for: url) { [weak self] metaData, error in
//            guard let metaData = metaData, error == nil else {
//                return
//            }
//
//            print(metaData.title ?? "No Title")
//
//            DispatchQueue.main.async {
//                linkPreview.metadata = metaData
//                self?.view.addSubview(linkPreview)
//                linkPreview.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
//                linkPreview.center = self?.view.center ?? .zero
//            }
//        }
//    }
//}

//final class ViewController: ObservableObject {
//    
//    @Published var image: UIImage?
//    @Published var title: String?
//    @Published var url: String?
//    
//    let previewURL: URL?
//    
//    init(_ url: String) {
//        self.previewURL = URL(string: url)
//        
//        fetchMetadata()
//    }
//    
//    private func fetchMetadata() {
//        guard let previewURL else { return }
//        let provider = LPMetadataProvider()
//        
//        Task {
//            let metadata = try await provider.startFetchingMetadata(for: previewURL)
//            
//            image = try await convertToImage(metadata.imageProvider)
//            title = metadata.title
//            
//            url = metadata.url?.host()
//        }
//    }
//    
//    private func convertToImage(_ imageProvider: NSItemProvider?) async throws -> UIImage? {
//        var image: UIImage?
//        
//        if let imageProvider {
//            let type = String(describing: UTType.image)
//            
//            if imageProvider.hasItemConformingToTypeIdentifier(type) {
//                let item = try await imageProvider.loadItem(forTypeIdentifier: type)
//                
//                if item is UIImage {
//                    image = item as? UIImage
//                }
//                
//                if item is URL {
//                    guard let url = item as? URL,
//                          let data = try? Data(contentsOf: url) else { return nil }
//                    
//                    image = UIImage(data: data)
//                }
//                
//                if item is Data {
//                    guard let data = item as? Data else { return nil }
//                    
//                    image = UIImage(data: data)
//                }
//            }
//        }
//        
//        return image
//    }
//}
