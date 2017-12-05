//
//  Entry.swift
//  Journal
//
//  Created by Caleb Hicks on 10/1/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation

class Entry: Equatable, Codable {
	
	init(timestamp: Date = Date(), title: String, text: String) {
		
		self.timestamp = timestamp
		self.title = title
		self.text = text
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
