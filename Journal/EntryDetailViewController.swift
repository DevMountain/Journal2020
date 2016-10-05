//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Caleb Hicks on 10/3/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let entry = entry {
            updateWithEntry(entry)
        }
    }

    @IBAction func saveButtonTapped(_ sender: AnyObject) {
        
        if let entry = self.entry {
            entry.title = self.titleTextField.text!
            entry.text = self.bodyTextView.text
            entry.timestamp = Date()
        } else {
            let newEntry = Entry(title: self.titleTextField.text!, text: self.bodyTextView.text)
            EntryController.sharedController.addEntry(newEntry)
            self.entry = newEntry
        }
        
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearButtonTapped(_ sender: AnyObject) {
        
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    func updateWithEntry(_ entry: Entry) {
        self.entry = entry
        
        self.titleTextField.text = entry.title
        self.bodyTextView.text = entry.text
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }

}
