//
//  TestMapView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 2/26/24.
//

import MapKit
import SwiftData
import SwiftUI

struct TestMapView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Activity.name) private var activities: [Activity]
    
    @State private var offset: CGFloat = UIScreen.main.bounds.height * 0.8
    @State private var dragOffset: CGFloat = 0
    
    @State private var selectedItem: Activity? = nil
    
    //    @State private var position = MapCameraPosition.region(
    //        MKCoordinateRegion(
    //            center: CLLocationCoordinate2D(latitude: 37.77, longitude: -122.42),
    //            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
    //        )
    //    )
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Map { //Map(position: $position)
                    ForEach(activities) { activity in
                        Annotation(activity.name, coordinate: activity.coordinate) {
                            Image(systemName: "mappin.circle.fill") //Text(activity.name)
                                .onTapGesture {
                                    self.selectedItem = activity
                                }
                                //.zIndex(1)
                        }
                        .annotationTitles(.hidden)
                    }
                }
                //.zIndex(-1)
                
                // Activity Item View
                if let selectedItem = selectedItem {
                    ActivityItemView(activity: selectedItem)
                        .frame(height: 200)
                } else {
                    // Activity List View
                        ActivityListView()
                        .offset(y: offset)
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    self.dragOffset = value.translation.height
                                }
                                .onEnded { value in
                                    if self.dragOffset < -300 {
                                        withAnimation {
                                            self.offset = 0
                                        }
                                    } else {
                                        withAnimation {
                                            self.offset = UIScreen.main.bounds.height * 0.8
                                        }
                                    }
                                }
                        )
                }
            }
            .gesture(
                TapGesture()
                    .onEnded { value in
                        self.selectedItem = nil
                    }
            )
        }
    }
}

#Preview {
    TestMapView()
}

