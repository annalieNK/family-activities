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
    @State private var selectedItemIndex: Int? = nil
    
    @State private var isDetailActive = false
    @State private var selectedItem: Activity? = nil
    @State private var isListVisible: Bool = false
    @State private var isTapGestureEnabled: Bool = true
    
    //    @State private var position = MapCameraPosition.region(
    //        MKCoordinateRegion(
    //            center: CLLocationCoordinate2D(latitude: 37.77, longitude: -122.42),
    //            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
    //        )
    //    )
    
    var body: some View {
        ZStack {
            Map { //Map(position: $position)
                ForEach(activities) { activity in
                    Annotation(activity.name, coordinate: activity.coordinate) {
                        Image(systemName: "mappin.circle.fill") //Text(activity.name)
                            .onTapGesture {
                                self.selectedItemIndex = activities.firstIndex(of: activity)
                                self.selectedItem = activity
                                self.isDetailActive = true
                                self.isListVisible = true
                                self.isTapGestureEnabled = false
                            }
                    }
                    .annotationTitles(.hidden)
                }
            }
            .zIndex(-1)
            
            // Activity Item View
            //            if let selectedItemIndex = selectedItemIndex {
            //                Text(activities[selectedItemIndex].name)
            //            if isListVisible {
            //                ActivityItemView(activities: [selectedItem!])
            if let selectedItem = selectedItem {
                //                List {
                //                    Text(selectedItem.name)
                //                }
                NavigationStack {
                    List {
                        NavigationLink(value: selectedItem) {
                            Text(selectedItem.name)
                        }
                    }
                    .navigationDestination(for: Activity.self) { selectedItem in
                        ActivityDetailView(activity: selectedItem)
                    }
                }
                
                // Activity List View
                ActivityListView()
                    .frame(maxWidth: .infinity)
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
                    if self.isTapGestureEnabled {
                        self.selectedItemIndex = nil
                        self.selectedItem = nil
                    }
                    self.isTapGestureEnabled = true // Enable tap gesture again
                }
        )
    }
}

#Preview {
    TestMapView()
}

