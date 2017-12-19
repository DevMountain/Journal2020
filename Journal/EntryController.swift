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
		if entries.count == 0 {
			// Create dummy data
			saveToPersistentStorage(entries: dummyEntries(count: 50_000))
		}
	}
	
	func add(entry: Entry) {
		var entries = self.entries
		entries.append(entry)
		saveToPersistentStorage(entries: entries)
	}
	
	func remove(entry: Entry) {
		
		var entries = self.entries
		if let entryIndex = entries.index(of: entry) {
			entries.remove(at: entryIndex)
		}
		
		saveToPersistentStorage(entries: entries)
	}
	
	func update(entry: Entry, with title: String, text: String) {
		
		remove(entry: entry)
		entry.title = title
		entry.text = text
		add(entry: entry)
	}
	
	// MARK: - Persistence
	
	private func fileURL() -> URL {
		let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		let fileName = "journal.json"
		let documentsDirectoryURL = urls[0].appendingPathComponent(fileName)
		return documentsDirectoryURL
	}
	
	private func saveToPersistentStorage(entries: [Entry]) {
		
		let encoder = JSONEncoder()
		do {
			let data = try encoder.encode(entries)
			try data.write(to: fileURL())
		} catch let error {
			print("There was an error saving to persistent storage: \(error)")
		}
	}
	
	// MARK: Properties
	
	var entries: [Entry] {
		do {
			let data = try Data(contentsOf: fileURL())
			return try JSONDecoder().decode([Entry].self, from: data)
		} catch let error {
			NSLog("There was an error saving to persistent storage: \(error)")
			return []
		}
	}
}
