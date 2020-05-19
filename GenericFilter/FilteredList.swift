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

    init(filterKey: String, filterValue: String, sortDescriptors: [NSSortDescriptor], @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(entity: T.entity(), sortDescriptors: sortDescriptors, predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
        self.content = content
    }
}
