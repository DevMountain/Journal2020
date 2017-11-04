//
//  EntryController.swift
//  Journal
//
//  Created by Caleb Hicks on 10/1/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation

class EntryController {
    
    static let shared = EntryController()
    
    init() {
        loadFromPersistentStorage()
    }
    
    func addEntryWith(title: String, text: String) {
        
        let entry = Entry(title: title, text: text)
        
        entries.append(entry)
        
        saveToPersistentStorage()
    }
    
    func remove(entry: Entry) {
		
        if let entryIndex = entries.index(of: entry) {
            entries.remove(at: entryIndex)
        }
        
        saveToPersistentStorage()
    }
    
    func update(entry: Entry, with title: String, text: String) {
        
        entry.title = title
        entry.text = text
        saveToPersistentStorage()
    }
	
	// MARK: - Persistence
    
    private func fileURL() -> URL {
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileName = "journal.json"
        let documentsDirectoryURL = urls[0].appendingPathComponent(fileName)
        return documentsDirectoryURL
    }
    
    private func loadFromPersistentStorage() {
        
		let decoder = JSONDecoder()
        do {
            let data = try Data(contentsOf: fileURL())
            let entries = try decoder.decode([Entry].self, from: data)
            self.entries = entries
        } catch let error {
            print("There was an error saving to persistent storage: \(error)")
        }
    }
    
    private func saveToPersistentStorage() {
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(entries)
            try data.write(to: fileURL())
        } catch let error {
            print("There was an error saving to persistent storage: \(error)")
        }
    }
	
	// MARK: Properties
	
	private(set) var entries = [Entry]()
}
