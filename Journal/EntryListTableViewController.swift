//
//  ListTableViewController.swift
//  Journal
//
//  Created by Caleb Hicks on 10/3/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController, UISearchResultsUpdating {

    var searchController: UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearchController()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    func setUpSearchController() {
        
        let resultsController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ResultsController")
        
        searchController = UISearchController(searchResultsController: resultsController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        definesPresentationContext = true
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let searchTerm = searchController.searchBar.text!.lowercaseString
        
        let resultsController = searchController.searchResultsController as? EntryResultsTableViewController
        
        if let resultsController = resultsController {
            resultsController.filteredEntries = EntryController.sharedController.entries.filter({$0.title.lowercaseString.containsString(searchTerm)})
            resultsController.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.sharedController.entries.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("entryCell", forIndexPath: indexPath)

        let entry = EntryController.sharedController.entries[indexPath.row]
        
        cell.textLabel?.text = entry.title

        return cell
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let entry = EntryController.sharedController.entries[indexPath.row]
            
            EntryController.sharedController.removeEntry(entry)
            
            // Delete the row from the table view
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toShowEntry" {
            let sender = sender as! UITableViewCell
            
            var selectedEntry: Entry
            
            // if we get an indexPath from the search results controller, use filteredEntries
            // else, use EntryController
            
            if let indexPath = (searchController.searchResultsController as? EntryResultsTableViewController)?.tableView.indexPathForCell(sender) {
                
                let filteredEntries = (searchController.searchResultsController as! EntryResultsTableViewController).filteredEntries
                
                selectedEntry = filteredEntries[indexPath.row]
            } else {
                
                let indexPath = tableView.indexPathForCell(sender)!
                selectedEntry = EntryController.sharedController.entries[indexPath.row]
            }
            
            if let destinationViewController = segue.destinationViewController as? EntryDetailViewController {
                _ = destinationViewController.view
                destinationViewController.updateWithEntry(selectedEntry)
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
