//
//  EntryListViewController.swift
//  Journal
//
//  Created by James Pacheco on 10/15/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class EntryListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.sharedController.entries.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("entryCell", forIndexPath: indexPath)
        let entry = EntryController.sharedController.entries[indexPath.row]
        cell.textLabel?.text = entry.title
        
        let timeStamp = entry.timeStamp
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy hh:mm:ss"
        let dateString = dateFormatter.stringFromDate(timeStamp)
        cell.detailTextLabel?.text = dateString
        
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            EntryController.sharedController.entries.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toShowDetail" {
            if let detailViewController = segue.destinationViewController as? EntryDetailViewController {
                _ = detailViewController.view
                let indexPath = tableView.indexPathForSelectedRow
                let entry = EntryController.sharedController.entries[indexPath!.row]
                detailViewController.updateWithEntry(entry)
            }
        }
    }
    

}
