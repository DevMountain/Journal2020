//
//  EntryResultsTableViewController.swift
//  Journal
//
//  Created by Caleb Hicks on 11/3/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class EntryResultsTableViewController: UITableViewController {

    var filteredEntries: [Entry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredEntries.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("resultCell", forIndexPath: indexPath)
        
        let entry = filteredEntries[indexPath.row]

        cell.textLabel?.text = entry.title

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        self.presentingViewController?.performSegueWithIdentifier("toShowEntry", sender: cell)
    }


}
