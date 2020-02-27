//
//  EntryDetailViewController.swift
//  Journel in 10 min
//
//  Created by Trevor Walker on 2/27/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var entryTitleTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    
    // MARK: - Properties
    //Our landing pad
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Add more explentation to this. I.E. How we can decern the users intention via the value of the ?
        //If we have an entry then we are going to update our UIElements to the data on it
       updateViews()
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        //Making sure that we have text
        guard let title = entryTitleTextField.text, !title.isEmpty, let details = detailTextView.text else {return}
        //If we have an entry we are going to update it
        if let entry = entry {
            EntryController.shared.updateEntry(entry: entry, title: title, details: details)
            //if we don't have an entry we are going to create one
        } else {
            EntryController.shared.createEntry(title: title, details: details)
        }
        //Removes the top view off of our Navigation Stack
        self.navigationController?.popViewController(animated: true)
    }
    //MARK: helper 
    func updateViews() {
        guard let entry = entry else {return}
        entryTitleTextField.text = entry.title
        detailTextView.text = entry.details
        self.title = "\(entry.timeStamp)"
    }
}
