//
//  Entry.swift
//  Journal in 10 min
//
//  Created by Trevor Walker on 2/27/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import Foundation

class Entry: Codable {
    // MARK: - Properties
    var title: String
    var details: String
    var timeStamp: Date
    
    // MARK: - Initilizer
    // By passing in timestamp it gives us the option to set our own if we want in the future. If we don't pass one in then it just has a default value of the current Date
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
