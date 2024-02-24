//
//  TestView3.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 2/22/24.
//

import SwiftUI

struct TestView3: View {
    @State private var offset: CGFloat = UIScreen.main.bounds.height * 0.85 //0.7
    @State private var dragOffset: CGFloat = 0
    @State private var items = Array(1...10) // Sample list items
    @State private var selectedItemIndex: Int? = nil
    
    var body: some View {
        ZStack {
            // Primary View
            VStack {
                List(items, id: \.self) { item in
                    Button(action: {
                        self.selectedItemIndex = items.firstIndex(of: item)
                    }) {
                        Text("Item \(item)")
                    }
                }
                .listStyle(PlainListStyle())
                
            }
            .zIndex(-1) // Ensure the primary view is below the secondary view
            
            // Separate Small View
            if let selectedItemIndex = selectedItemIndex {
                VStack {
                    Text("Selected Item: \(items[selectedItemIndex])")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                .offset(y: offset == 0 ? 0 : 300) // Adjust as needed
                
                // Secondary View
                VStack {
                    Text("\(items.count) items")
                        .foregroundColor(.white)
//                        .font(.title)
                    
                    List(items, id: \.self) { item in
                        Text("Item \(item)")
                    }
                    .listStyle(PlainListStyle())
                }
                .frame(maxWidth: .infinity)
                .background(Color.green)
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
                                    self.offset = UIScreen.main.bounds.height * 0.85 //0.7
                                }
                            }
                        }
                )
                .animation(.spring())
            } else {
                // Secondary View
                VStack {
                    Text("\(items.count) items")
                        .foregroundColor(.white)
                        .font(.title)
                    
                    List(items, id: \.self) { item in
                        Text("Item \(item)")
                    }
                    .listStyle(PlainListStyle())
                }
                .frame(maxWidth: .infinity)
                .background(Color.green)
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
                                    self.offset = UIScreen.main.bounds.height * 0.85 //0.7
                                }
                            }
                        }
                )
                .animation(.spring())
            }
        }
    }
}

#Preview {
    TestView3()
}
