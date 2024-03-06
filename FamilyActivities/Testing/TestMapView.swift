////
////  TestMapView.swift
////  FamilyActivities
////
////  Created by Annalie Kruseman on 2/26/24.
////
//
//import MapKit
//import SwiftData
//import SwiftUI
//
//struct TestMapView: View {
//    @Environment(\.modelContext) var modelContext
//    @Query(sort: \Activity.name) private var activities: [Activity]
//    
//    @State private var offset: CGFloat = UIScreen.main.bounds.height * 0.8
//    @State private var dragOffset: CGFloat = 0
//    
//    @State private var selectedItem: Activity? = nil
//    
//    @State private var position = MapCameraPosition.region(
//        MKCoordinateRegion(
//            center: CLLocationCoordinate2D(latitude: 37.77, longitude: -122.42),
//            span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
//        )
//    )
//    
//   // @State private var position = MapCameraPosition.automatic
//  
//    
//    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
//    
//    @State private var visibleRegion: MKCoordinateRegion?
//    
//    var body: some View {
//        NavigationView {
//            ZStack(alignment: .bottom) {
//                Map(position: $position) { //Map(position: $position) //initialPosition: .region(region)
//                    ForEach(activities) { activity in
//                        Annotation(activity.name, coordinate: activity.coordinate) {
//                            Image(systemName: "mappin.circle.fill")
//                                .onTapGesture {
//                                    self.selectedItem = activity
//                                }
//                        }
//                    }
//                }
//                //                .onMapCameraChange { context in
//                //                    visibleRegion = context.region
//                //                }
//                .zIndex(-1)
//                //.safeAreaInset(edge: .bottom) {
//                
//                if let selectedItem = selectedItem {
//                    ActivityItemView(activity: selectedItem)
//                        .frame(height: 200)
//                } else {
//                    ActivityListView()
//                    .background(.white)
//                    .offset(y: offset)
//                    .gesture(
//                        DragGesture()
//                            .onChanged { value in
//                                self.dragOffset = value.translation.height
//                            }
//                            .onEnded { value in
//                                if self.dragOffset < -300 {
//                                    withAnimation {
//                                        self.offset = 0
//                                    }
//                                } else {
//                                    withAnimation {
//                                        self.offset = UIScreen.main.bounds.height * 0.8
//                                    }
//                                }
//                            }
//                    )
//                }
//            }
//            .gesture(
//                TapGesture()
//                    .onEnded { value in
//                        self.selectedItem = nil
//                    }
//            )
//        }
//    }
//}
//
//#Preview {
//    TestMapView()
//}
//
