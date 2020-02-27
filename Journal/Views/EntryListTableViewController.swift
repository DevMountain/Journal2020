//
//  EntryListTableViewController.swift
//  Journal in 10 min
//
//  Created by Trevor Walker on 2/27/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    ///Will update our table view everytime the view appears
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Helper Functions
    
    
    /// Formats our date into MM-dd-yyyy format
    /// - Parameter date: The date that we want to format
    func formatDate(date: Date) -> String {
        let format = DateFormatter()
        format.dateFormat = "MM-dd-yyyy"
        return format.string(from: date)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Will set our number of rows equal to the number of entries we have
        return EntryController.shared.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        //Grabbing our entry based on the index of the cell
        let entry = EntryController.shared.entries[indexPath.row]
        //setting our cells title equal to the entries title
        cell.textLabel?.text = entry.title
        //setting our cells detail label equal the result of format date. We are passing in our entries time stamp because we want to format it to be more readable
        cell.detailTextLabel?.text = formatDate(date: entry.timeStamp)
        
        // Configure the cell...

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // called to delete our cell on swipe
            /// Grabs the `Entry` that we want to delete
            let entry = EntryController.shared.entries[indexPath.row]
            /// Calls the delete function on our `EntryController`
            EntryController.shared.deleteEntry(entry: entry)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        //Identifier
            // We are checking to see if the identifier of our segue matches "showEntry". If it does then we will run the code inside, if not then we will just pass over it.
        if segue.identifier == "showEntry" {
            /// Making sure that we have a selected row that we can use to grab an `Entry`
            guard let index = tableView.indexPathForSelectedRow,
                //Destination
                    ///Making sure that our segues destination is an `EntryDetailViewController`, this also allows us to get access to the properties on `EntryDetailViewController`
                let destination = segue.destination as? EntryDetailViewController else {return}
            //Object to Send
                //Grabs the entry that we want to send based off of the index that we unwrapped earlier
            let entry = EntryController.shared.entries[index.row]
            //Object to Receive
                /// sends our entry to the entry on our `EntryDetailViewController`
            destination.entry = entry
        }
    }
}
