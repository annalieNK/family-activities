//
//  TestView3.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 2/22/24.
//

import SwiftUI

struct TestView3: View {
    @State private var offset: CGFloat = UIScreen.main.bounds.height * 0.7 //0.85
    @State private var dragOffset: CGFloat = 0
    @State private var items = Array(1...10) // Sample list items
    @State private var selectedItemIndex: Int? = nil
    
    var body: some View {
        ZStack {
            // Secondary View
            VStack {
                Text("\(items.count) items")
                    .foregroundColor(.white)
                    .font(.title)
                
                if let selectedItemIndex = selectedItemIndex {
                    Text("Item: \(items[selectedItemIndex])")
                        .foregroundColor(.white)
                }
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
                                self.offset = UIScreen.main.bounds.height * 0.7
                            }
                        }
                    }
            )
            .animation(.spring())
            
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
        }
    }
}

#Preview {
    TestView3()
}
