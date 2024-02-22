//
//  TestView3.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 2/22/24.
//

import SwiftUI

struct TestView3: View {
    @State private var offset: CGFloat = UIScreen.main.bounds.height * 0.7
    @State private var dragOffset: CGFloat = 0
    @State private var items = Array(1...10) // Sample list items
    
    var body: some View {
        ZStack {
            // Secondary View
            VStack {
                Spacer()
                Text("Secondary View")
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
                                self.offset = UIScreen.main.bounds.height * 0.7
                            }
                        }
                    }
            )
            .animation(.spring())
            
            // Primary View
            Color.blue.edgesIgnoringSafeArea(.all)
                .zIndex(-1) // Ensure the primary view is below the secondary view
        }
    }
}

#Preview {
    TestView3()
}
