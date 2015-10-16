//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by James Pacheco on 10/15/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextField: UITextView!
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func  updateWithEntry(entry: Entry) {
        self.entry = entry
        titleTextField.text = entry.title
        bodyTextField.text = entry.body
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func saveEntry(sender: AnyObject) {
        if let entry = self.entry {
            entry.title = self.titleTextField.text!
            entry.body = self.bodyTextField.text
            entry.timeStamp = NSDate()
        } else {
            let time = NSDate()
            let newEntry = Entry(timeStamp: time, title: self.titleTextField.text!, body: self.bodyTextField.text)
            EntryController.sharedController.addEntry(newEntry)
            self.entry = newEntry
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func clearEntry(sender: AnyObject) {
        titleTextField.text = ""
        bodyTextField.text = ""
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
