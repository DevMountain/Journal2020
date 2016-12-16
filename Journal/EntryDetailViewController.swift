//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Caleb Hicks on 10/3/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		updateViews()
	}
	
	// MARK: Actions
	
	@IBAction func saveButtonTapped(_ sender: AnyObject) {
		
		if let entry = self.entry {
			entry.title = self.titleTextField.text!
			entry.text = self.bodyTextView.text
			entry.timestamp = Date()
		} else {
			let newEntry = Entry(title: self.titleTextField.text!, text: self.bodyTextView.text)
			EntryController.shared.addEntry(newEntry)
			entry = newEntry
		}
		
		let _ = self.navigationController?.popViewController(animated: true)
	}
	
	@IBAction func clearButtonTapped(_ sender: AnyObject) {
		
		titleTextField.text = ""
		bodyTextView.text = ""
	}
	
	// MARK: Private
	
	private func updateViews() {
		guard let entry = entry else { return }
		titleTextField.text = entry.title
		bodyTextView.text = entry.text
	}
	
	// MARK: UITextFieldDelegate
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		
		textField.resignFirstResponder()
		
		return true
	}
	
	// MARK: Properties
	
	var entry: Entry? {
		didSet {
			updateViews()
		}
	}
	
	@IBOutlet weak var titleTextField: UITextField!
	@IBOutlet weak var bodyTextView: UITextView!
}
