//
//  FilteredList.swift
//  GenericFilter
//
//  Created by Cathal Farrell on 18/05/2020.
//  Copyright © 2020 Cathal Farrell. All rights reserved.
//
import CoreData
import SwiftUI

/*
 Challenge 1 - Make it accept an array of NSSortDescriptor objects to get used in its fetch request.
 */

/*
 Challenge 2 - Make it accept a string parameter that controls which predicate is applied. You can use Swift’s string interpolation to place this in the predicate.
 */

// MARK:- Generic Filter for anything
struct FilteredList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var singers: FetchedResults<T> { fetchRequest.wrappedValue }

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(singers, id: \.self) { singer in
            self.content(singer)
        }
    }

    init(filterPredicate: String, filterKey: String, filterValue: String, sortDescriptors: [NSSortDescriptor], @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: filterPredicate, filterKey, filterValue))
        self.content = content
    }
}
