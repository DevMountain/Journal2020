//
//  EntryListTableViewController.swift
//  Journel in 10 min
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

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Will set our number of rows equal to the number of entries we have
        return EntryController.shared.entries.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        //setting the text label of our cell
//        let title
        cell.textLabel?.text = EntryController.shared.entries[indexPath.row].title
        // Configure the cell...

        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //called to delete our cell on swipe
            EntryController.shared.deleteEntry(entry: EntryController.shared.entries[indexPath.row])
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        // flesh out the docs
        //Identifier
        if segue.identifier == "showEntry" {
            //Index
            guard let index = tableView.indexPathForSelectedRow,
                //Destination
                let destination = segue.destination as? EntryDetailViewController else {return}
            //Object to Send
            let entry = EntryController.shared.entries[index.row]
            //Object to Receive
            destination.entry = entry
        }
    }
}
