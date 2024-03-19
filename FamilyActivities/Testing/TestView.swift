//
//  TestView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 2/21/24.
//

import SwiftUI

struct TestView: View {
    var body: some View {
            NavigationView {
                VStack {
                    Text("First View")
                        .font(.title)
                        .padding()
                    
                    // Include NamesListView here
                    NamesListView()
                }
                .navigationBarTitle("Navigation Demo")
            }
        }
    }

    struct NamesListView: View {
        let names = ["John", "Jane", "Bob", "Alice"]
        
        var body: some View {
            List(names, id: \.self) { name in
                NavigationLink(destination: DetailView(name: name)) {
                    Text(name)
                }
            }
            .navigationBarTitle("Names List")
        }
    }

    struct DetailView: View {
        let name: String
        
        var body: some View {
            Text("Detail for \(name)")
                .font(.title)
                .padding()
        }
    }

#Preview {
    TestView()
}
