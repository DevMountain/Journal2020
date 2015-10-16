//
//  EntryController.swift
//  Journal
//
//  Created by James Pacheco on 10/15/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation

class EntryController {
    
    static let sharedController: EntryController = EntryController()
    
    var entries: [Entry] = []
    
    func addEntry(entry: Entry) -> (){
        entries.append(entry)
    }
    
    func removeEntry(entry: Entry) -> (){
        let index = self.entries.indexOf(entry)
        if let entryIndex = index {
            entries.removeAtIndex(entryIndex)
        }
    }
}

