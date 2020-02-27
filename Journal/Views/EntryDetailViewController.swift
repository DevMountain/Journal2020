//
//  EntryDetailViewController.swift
//  Journal in 10 min
//
//  Created by Trevor Walker on 2/27/20.
//  Copyright © 2020 Trevor Walker. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextView: UITextView!
    
    // MARK: - Properties
    //Our landing pad
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up our delegates
        titleTextField.delegate = self
        detailTextView.delegate = self
        updateViews()
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        //Making sure that we have text
        guard let title = titleTextField.text, !title.isEmpty, let details = detailTextView.text else {return}
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
    
    @IBAction func clearTapped(_ sender: Any) {
        //Clears out all of our text
        titleTextField.text = ""
        detailTextView.text = ""
    }
    //MARK: helper
    /**
     - Description: If we have an Entry then the user wants to update or view that Entry. In order to allow them to do that we are going to display the data from our passed entry. If we don't have an entry then the user is creating a new entry so we have no need to load any data
     */
    func updateViews() {
        guard let entry = entry else {return}
        titleTextField.text = entry.title
        detailTextView.text = entry.details
    }
    
    // MARK: - Delegate Functions
    ///Going to get called when we press return while typing in a textField
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    ///Going to get called when we press return while typing in a textView
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //check to see if the character is a new line, or a return. If it is, then we resign first responder
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
