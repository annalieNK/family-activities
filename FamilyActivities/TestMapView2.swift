//
//  TestMapView2.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 2/28/24.
//

import MapKit
import SwiftUI


extension CLLocationCoordinate2D {
    static let sfzoo = CLLocationCoordinate2D(latitude: 37.83570768670836, longitude: -122.47743128380526)
    static let stinsonbeach = CLLocationCoordinate2D(latitude: 37.751260515915675, longitude: -122.43858504295504)
}

struct MyFavoriteLocation: Identifiable, Equatable {
    var id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
    static func == (lhs: MyFavoriteLocation, rhs: MyFavoriteLocation) -> Bool {
        return lhs.id == rhs.id
    }
}

struct LocationPreviewLookAroundView: View {
    @State private var lookAroundScene: MKLookAroundScene?
    var selectedResult: MyFavoriteLocation
    
    var body: some View {
        LookAroundPreview(initialScene: lookAroundScene)
            .overlay(alignment: .bottomTrailing) {
                HStack {
                    Text("\(selectedResult.name)")
                }
                .font(.caption)
                .foregroundStyle(.white)
                .padding(18)
            }
            .onAppear {
                getLookAroundScene()
            }
            .onChange(of: selectedResult) {
                getLookAroundScene()
            }
    }
    
    func getLookAroundScene() {
        lookAroundScene = nil
        Task {
            let request = MKLookAroundSceneRequest(coordinate: selectedResult.coordinate)
            lookAroundScene = try? await request.scene
        }
    }
}

struct TestMapView2: View {
    @State private var selection: UUID?
    
    let myFavoriteLocations = [
        MyFavoriteLocation(name: "SF Zoo", coordinate: .sfzoo),
        MyFavoriteLocation(name: "Stinson Beach", coordinate: .stinsonbeach)
    ]
    
    var body: some View {
        Map(selection: $selection) {
            ForEach(myFavoriteLocations) { location in
                Marker(location.name, coordinate: location.coordinate)
                    .tint(.orange)
            }
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Spacer()
                VStack(spacing: 0) {
                    if let selection {
                        if let item = myFavoriteLocations.first(where: { $0.id == selection }) {
                            LocationPreviewLookAroundView(selectedResult: item)
                                .frame(height: 128)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding([.top, .horizontal])
                        }
                    }
                }
                Spacer()
            }
            .background(.thinMaterial)
        }
        .onChange(of: selection) {
            guard let selection else { return }
            guard let item = myFavoriteLocations.first(where: { $0.id == selection }) else { return }
            print(item.coordinate)
        }
    }
}

#Preview {
    TestMapView2()
}
