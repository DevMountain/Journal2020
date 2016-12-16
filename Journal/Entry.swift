//
//  Entry.swift
//  Journal
//
//  Created by Caleb Hicks on 10/1/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation

class Entry: Equatable {
	
	private static let TimestampKey = "timestamp"
	private static let TitleKey = "title"
	private static let TextKey = "text"
	
	init(timestamp: Date = Date(), title: String, text: String) {
		
		self.timestamp = timestamp
		self.title = title
		self.text = text
	}
	
	init?(dictionary: [String : Any]) {
		guard let timestamp = dictionary[Entry.TimestampKey] as? Date,
			let title = dictionary[Entry.TitleKey] as? String,
			let text = dictionary[Entry.TextKey] as? String else {
				
				self.timestamp = Date()
				self.title = ""
				self.text = ""
				
				return nil
		}
		
		self.timestamp = timestamp
		self.title = title
		self.text = text
	}
	
	func dictionaryRepresentation() -> [String : Any] {
		return [
			Entry.TimestampKey : timestamp,
			Entry.TitleKey : title,
			Entry.TextKey : text
		]
	}
	
	// MARK: Properties
	
	var timestamp: Date
	var title: String
	var text: String
	
}

func ==(lhs: Entry, rhs: Entry) -> Bool {
	if lhs.timestamp != rhs.timestamp { return false }
	if lhs.title != rhs.title { return false }
	if lhs.text != rhs.text { return false }
	
	return true
}
