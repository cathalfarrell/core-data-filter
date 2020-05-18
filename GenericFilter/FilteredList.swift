//
//  FilteredList.swift
//  GenericFilter
//
//  Created by Cathal Farrell on 18/05/2020.
//  Copyright © 2020 Cathal Farrell. All rights reserved.
//
import CoreData
import SwiftUI

// MARK:- Custom Filter for Singer
struct FilteredList: View {

    let predicate = "lastName BEGINSWITH %@"

    var fetchRequest: FetchRequest<Singer>
    var singers: FetchedResults<Singer> { fetchRequest.wrappedValue }

    var body: some View {
        List(singers, id: \.self) { singer in
            Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
        }
    }

    init(filter: String) {
        //Custom filter created when initialised
        fetchRequest = FetchRequest<Singer>(entity: Singer.entity(), sortDescriptors: [], predicate: NSPredicate(format: predicate, filter))
    }
}
