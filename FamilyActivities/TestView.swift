//
//  TestView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 2/21/24.
//

import SwiftUI

struct TestView: View {
    @State private var isExpanded = false
    
    var body: some View {
        ZStack {
            MapView()
            
            VStack {
                Spacer()
                
                if !isExpanded {
                    SecondaryView()
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                isExpanded.toggle()
                            }
                        }
                        .gesture(
                            DragGesture()
                                .onEnded { value in
                                    // Check if swipe is moving upwards
                                    if value.translation.height < -50 {
                                        withAnimation(.easeInOut) {
                                            isExpanded.toggle()
                                        }
                                    }
                                }
                        )
                }
            }
            //.edgesIgnoringSafeArea(.all)
            
            if isExpanded {
                ExpandedView(isExpanded: $isExpanded)
            }
        }
    }
}

struct SecondaryView: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(Color.white)
            .frame(height: 100)
            .overlay(
                Text("Secondary View")
                    .foregroundColor(.black)
            )
            .padding()
    }
}

struct ExpandedView: View {
    @Binding var isExpanded: Bool
    
    var body: some View {
            VStack {
                Spacer()
                
                RoundedRectangle(cornerRadius: 0)
                    .fill(Color.white)
                    .overlay(
                        Text("Expanded View")
                            .foregroundColor(.black)
                    )
                    .padding()
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.height > 100 {
                                    withAnimation(.easeInOut) {
                                        isExpanded.toggle()
                                    }
                                }
                            }
                    )
                
                Spacer()
            }
        //.ignoresSafeArea(.all, edges: .bottom)
    }
}

struct MapView: View {
    var body: some View {
        Color.blue // Replace this with your map view implementation
    }
}

#Preview {
    TestView()
}
