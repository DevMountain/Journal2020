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
	
	var entries: [Entry] {
		let entryDictionaries = UserDefaults.standard.object(forKey: EntryController.EntriesKey) as? [[String : Any]]
		
		return entryDictionaries?.flatMap { Entry(dictionary: $0) } ?? []
	}
	
	func add(entry: Entry) {
		
		var scratch = self.entries
		scratch.append(entry)		
		saveToPersistentStorage(newEntries: scratch)
	}
	
	func remove(entry: Entry) {
		
		var scratch = self.entries
		if let index = scratch.index(of: entry) {
			scratch.remove(at: index)
		}
		saveToPersistentStorage(newEntries: scratch)
	}
	
	func saveToPersistentStorage(newEntries: [Entry]) {
		
		let entryDictionaries = newEntries.map { $0.dictionaryRepresentation() }
		
		UserDefaults.standard.set(entryDictionaries, forKey: EntryController.EntriesKey)
	}
	
}
