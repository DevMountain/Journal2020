//
//  Entry.swift
//  Journal
//
//  Created by Caleb Hicks on 10/1/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation

class Entry: Equatable {
    
    var timestamp: NSDate
    var title: String
    var text: String
    
    init(timestamp: NSDate = NSDate(), title: String, text: String) {
        
        self.timestamp = timestamp
        self.title = title
        self.text = text
    }

}

func == (lhs: Entry, rhs: Entry) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}