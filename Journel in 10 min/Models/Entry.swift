//
//  Entry.swift
//  Journel in 10 min
//
//  Created by Trevor Walker on 2/27/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import Foundation

class Entry {
    // MARK: - Properties
    var title: String
    var details: String
    //We can just set our time stamp to our current date using Date()
    var timeStamp: Date
    
    // MARK: - Initilizer
    init(title: String, details: String, timeStamp: Date = Date()) {
        self.title = title
        self.details = details
        self.timeStamp = timeStamp
    }
}

extension Entry: Equatable {
    static func == (lhs: Entry, rhs: Entry) -> Bool {
        return lhs.title == rhs.title &&
            lhs.details == rhs.details &&
            lhs.timeStamp == rhs.timeStamp
    }
}
