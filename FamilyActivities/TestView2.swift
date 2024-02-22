//
//  TestView2.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 2/22/24.
//

import SwiftUI

struct TestView2: View {
    @GestureState private var dragState: CGFloat = 0
    @State private var expanded = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Primary View
            Color.blue
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Secondary View
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(.white)
                .frame(height: expanded ? .infinity : 200)
                .padding()
                .offset(y: max(0, dragState))
                .gesture(
                    DragGesture()
                        .updating($dragState) { value, state, _ in
                            state = value.translation.height
                        }
                        .onEnded { value in
                            withAnimation {
                                if value.translation.height > 100 {
                                    expanded = false
                                } else {
                                    expanded = true
                                }
                            }
                        }
                )
        }
    }
}

#Preview {
    TestView2()
}
