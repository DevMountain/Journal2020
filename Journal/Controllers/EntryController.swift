//
//  EntryController.swift
//  Journal in 10 min
//
//  Created by Trevor Walker on 2/27/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import Foundation

class EntryController {
    
    // MARK: - Properties
    //Shared instance
    static let shared = EntryController()
    //Source of truth
    var entries: [Entry] = []
    
    // MARK: - CRUD
    
    /**
    This function creates an `Entry`
    - Parameters:
    - title: Sets the `Title` of our new `Entry`
    - details: Sets the `Details` of our new `Entry`
    */
    func createEntry(title: String, details: String) {
        let entry = Entry(title: title, details: details)
        entries.append(entry)
    }
    
    
    /// Used to Delete our `Entry`
    /// - Parameter entry: The `Entry` that we want to delete
    func deleteEntry(entry: Entry) {
        guard let index = entries.firstIndex(of: entry) else {return}
        entries.remove(at: index)
    }
    /**
    Used to update an `Entry` and the timestamp on it
    - Parameters:
    - entry: The `Entry` that we want to update
    - title: The title that we want to update our `Entry` title too
    - details: The details that we want to update our `Entry` details too
    */
    func updateEntry(entry: Entry, title: String, details: String) {
        entry.title = title
        entry.details = details
    }
}
