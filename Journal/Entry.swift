//
//  Entry.swift
//  Journal
//
//  Created by Caleb Hicks on 10/25/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import Foundation
import CoreData

class Entry: NSManagedObject {

    convenience init(title: String, text: String, timestamp: NSDate = NSDate(), context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        let entity = NSEntityDescription.entityForName("Entry", inManagedObjectContext: context)!
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.title = title
        self.text = text
        self.timestamp = timestamp
    }

}
