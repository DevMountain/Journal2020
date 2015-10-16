//
//  Entry.swift
//  Journal
//
//  Created by James Pacheco on 10/15/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation

class Entry: Equatable {
    
    var timeStamp: NSDate
    var title: String
    var body: String
    
    init(timeStamp: NSDate, title: String, body: String){
        self.timeStamp = timeStamp
        self.title = title
        self.body = body
    }
}

func == (lhs: Entry, rhs: Entry) -> Bool {
    return ((lhs.title == rhs.title) && (lhs.timeStamp == rhs.timeStamp) && (lhs.body == rhs.body))
}