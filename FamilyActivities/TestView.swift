//
//  TestView.swift
//  FamilyActivities
//
//  Created by Annalie Kruseman on 1/31/24.
//

import SwiftUI

// Define the Item class
class Item: Identifiable {
    var id = UUID()
    var name: String

    init(name: String) {
        self.name = name
    }
}

// Define the Group class that contains a list of items
class Group: Identifiable {
    var id = UUID()
    var name: String
    var items: [Item]

    init(name: String, items: [Item]) {
        self.name = name
        self.items = items
    }
}

struct TestView: View {
    let groups = [
        Group(name: "Group 1", items: [Item(name: "Item A"), Item(name: "Item B")]),
        Group(name: "Group 2", items: [Item(name: "Item C"), Item(name: "Item D")])
        // Add more groups as needed
    ]

    var body: some View {
        NavigationView {
            List(groups) { group in
                NavigationLink(destination: GroupDetailView1(group: group)) {
                    Text(group.name)
                }
            }
            .navigationTitle("Groups")
        }
    }
}

struct GroupDetailView1: View {
    var group: Group

    var body: some View {
        List(group.items) { item in
            NavigationLink(destination: ItemDetailView(item: item)) {
                Text(item.name)
            }
        }
        .navigationTitle(group.name)
    }
}

struct ItemDetailView: View {
    var item: Item

    var body: some View {
        Text("Item Detail: \(item.name)")
            .navigationTitle(item.name)
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
