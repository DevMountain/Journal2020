//
//  EntryController.swift
//  Journal
//
//  Created by Caleb Hicks on 10/1/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation

class EntryController {
    
    private static let EntriesKey = "entries"
    
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
	
	// MARK: Private
    
    private func loadFromPersistentStorage() {
        
		let entryDictionariesFromDefaults = UserDefaults.standard.object(forKey: EntryController.EntriesKey) as? [[String : Any]]

        if let entryDictionaries = entryDictionariesFromDefaults {
        
            entries = entryDictionaries.flatMap { Entry(dictionary: $0) }
        }
    }
    
    private func saveToPersistentStorage() {
        
        let entryDictionaries = entries.map { $0.dictionaryRepresentation() }
        
        UserDefaults.standard.set(entryDictionaries, forKey: EntryController.EntriesKey)
    }
	
	// MARK: Properties
	
	private(set) var entries = [Entry]()
}
