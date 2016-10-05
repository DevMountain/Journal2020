//
//  Entry.swift
//  Journal
//
//  Created by Caleb Hicks on 10/1/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation

class Entry: Equatable {
    
    private let timestampKey = "timestamp"
    private let titleKey = "title"
    private let textKey = "text"
    
    var timestamp: Date
    var title: String
    var text: String
    
    init(timestamp: Date = Date(), title: String, text: String) {
		
        self.timestamp = timestamp
        self.title = title
        self.text = text
    }
    
    init?(dictionary: Dictionary<String, AnyObject>) {
        guard let timestamp = dictionary[timestampKey] as? Date,
            let title = dictionary[titleKey] as? String,
            let text = dictionary[textKey] as? String else {
                
                self.timestamp = Date()
                self.title = ""
                self.text = ""

                return nil
        }
        
        self.timestamp = timestamp
        self.title = title
        self.text = text
    }
    
    func dictionaryCopy() -> Dictionary<String, AnyObject> {
        
        let dictionary = [
            timestampKey : self.timestamp,
            titleKey : self.title,
            textKey : self.text
        ] as [String : Any]
        
        return dictionary as Dictionary<String, AnyObject>
    }
    
}

func ==(lhs: Entry, rhs: Entry) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}
