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
    
    init() {
        loadFromPersistentStorage()
    }
    
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
        saveToPersistentStorage()
    }
    
    /// Used to Delete our `Entry`
    /// - Parameter entry: The `Entry` that we want to delete
    func deleteEntry(entry: Entry) {
        guard let index = entries.firstIndex(of: entry) else {return}
        entries.remove(at: index)
        saveToPersistentStorage()
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
        saveToPersistentStorage()
    }
    
    /**
    Used to create a file path for a location to save our data
    - Returns: A URL used to specify file location
    */
    private func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileName = "journal.json"
        let documentsDirectoryURL = urls[0].appendingPathComponent(fileName)
        return documentsDirectoryURL
    }
    
    /**
    Saves the current entries array as data to a file on disk
    */
    private func saveToPersistentStorage() {
        let jsonEncoder = JSONEncoder()
        do {
            let data = try jsonEncoder.encode(entries)
            try data.write(to: fileURL())
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /**
    Loads saved data from disk, decodes the data into an array of Entry and assigns that array to the source of truth (entries) on the Entry Controller
    */
    private func loadFromPersistentStorage() {
        let jsonDecoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let entries = try jsonDecoder.decode([Entry].self, from: data)
            self.entries = entries
        } catch {
            print(error.localizedDescription)
        }
    }
}
