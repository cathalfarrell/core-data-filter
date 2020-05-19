//
//  ContentView.swift
//  GenericFilter
//
//  Created by Cathal Farrell on 15/05/2020.
//  Copyright © 2020 Cathal Farrell. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "S"

    let sortDescriptors: [NSSortDescriptor] = [NSSortDescriptor(key: "lastName", ascending: true), NSSortDescriptor(key: "firstName", ascending: false) ]

    var body: some View {
            VStack {

                //Generic Filter - pass in the key and attribute on which to filter
                FilteredList(filterPredicate: .beginsWith, filterKey: "lastName", filterValue: lastNameFilter, sortDescriptors: sortDescriptors) { (singer: Singer) in
                    Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
                }

                Button("Add Examples") {
                    let jonathan = Singer(context: self.moc)
                    jonathan.firstName = "Jonathan"
                    jonathan.lastName = "Swift"

                    let taylor = Singer(context: self.moc)
                    taylor.firstName = "Taylor"
                    taylor.lastName = "Swift"

                    let ed = Singer(context: self.moc)
                    ed.firstName = "Ed"
                    ed.lastName = "Sheeran"

                    let adele = Singer(context: self.moc)
                    adele.firstName = "Adele"
                    adele.lastName = "Adkins"

                    try? self.moc.save()
                }

                Button("Show A") {
                    self.lastNameFilter = "A"
                }

                Button("Show S") {
                    self.lastNameFilter = "S"
                }
            }
    }
}
