//
//  EntryController.swift
//  Journal
//
//  Created by Caleb Hicks on 10/1/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation

class EntryController {
    
    fileprivate let entriesKey = "entries"
    
    static let sharedController = EntryController()
    
    var entries: [Entry]
    
    init() {
        
        self.entries = []
        
        self.loadFromPersistentStorage()
    }
    
    func addEntry(_ entry: Entry) {
        
        entries.append(entry)
        
        self.saveToPersistentStorage()
    }
    
    func removeEntry(_ entry: Entry) {
        
        if let entryIndex = entries.index(of: entry) {
            entries.remove(at: entryIndex)
        }
        
        self.saveToPersistentStorage()
    }
    
    func loadFromPersistentStorage() {
        
        let entryDictionariesFromDefaults = UserDefaults.standard.object(forKey: entriesKey) as? [Dictionary<String, AnyObject>]

        if let entryDictionaries = entryDictionariesFromDefaults {
        
            self.entries = entryDictionaries.map({Entry(dictionary: $0)!})
        }
    }
    
    func saveToPersistentStorage() {
        
        let entryDictionaries = self.entries.map({$0.dictionaryCopy()})
        
        UserDefaults.standard.set(entryDictionaries, forKey: entriesKey)
    }
    
}
