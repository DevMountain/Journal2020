# Journal

### Level 1

Students will build a simple Journal app to practice MVC separation, protocols, master-detail interfaces, table views, and persistence. 

Journal is an excellent app to practice basic Cocoa Touch princples and design patterns. Students are encouraged to repeat building Journal regularly until the principles and patterns are internalized and the student can build Journal without a guide.

Students who complete this project independently are able to:

### Part One - Model Objects and Controllers

* understand basic model-view-controller design and implementation
* create a custom model object with a memberwise initializer
* understand, create, and use a shared instance
* create a model object controller with create, read, update, delete functions
* implement the Equatable protocol

### Part Two - User Interface

* implement a master-detail interface
* implement the UITableViewDataSource protocol
* understand and implement the UITextFieldDelegate protocol to dismiss the keyboard
* create relationship segues in Storyboards
* understand, use, and implement the 'updateWith' pattern
* implement 'prepareForSegue' to configure destination view controllers

### Part Three - Controller Implementation

* add data persistence using NSUserDefaults
* understand, use, and implement the builder functions pattern
* create a custom model object with a failable initializer
* use the array map function to translate objects

## Part One - Model Objects and Controllers

### Entry

Create an Entry model class that will hold a title, text, and timestamp for each entry.

1. Add a new ```Entry.swift``` file and define a new ```Entry``` class
2. Add properties for timestamp, title, and body text
3. Add a memberwise initializer that takes parameters for each property
    * note: Consider setting a default parameter value for timestamp.

### EntryController

Create a model object controller called EntryController that will manage adding, reading, updating, and removing entries. We will follow the shared instance design pattern because we want one consistent source of truth for our entry objects that are held on the controller.

1. Add a new ```EntryController.swift``` file and define a new ```EntryController``` class inside.
2. Add an entries Array property, set it to empty in the initializer
3. Create a ```addEntry(entry: Entry)``` function that adds the entry parameter to the entries array
4. Create a ```removeEntry(entry: Entry)``` function that removes the entry from the entries array
    * note: There is no 'removeObject' function on arrays. You will need to find the index of the object and then remove the object at that index.
    * note: You will face a compiler error because we have not given the Entry class a way to find equal objects. You will resolve the error by implementing the Equatable protocol in the next step.
5. Create a sharedController property as a shared instance. 
    * note: Review the syntax for creating shared instance properties

### Equatable Protocol

Implement the Equatable protocol for the Entry class. The Equatable protocol allows you to check for equality between two variables of an specific class. You may use the ObjectIdentifier() function on class types, but you may decide to manually check the values of the title, text, and timestamp variables.

1. Add the Equatable protocol function to the top or bottom of your ```Entry.swift``` file
2. Return the result of a comparison between the ```lhs``` and ```rhs``` parameters using ObjectIdentifier() or checking the property values on each parameter

### Black Diamonds

* Implement the NSCoding protocol on the Entry class
* Create a Unit test that verifies NSCoding functionality by converting an instance to and from NSData

### Tests

Uncomment any relevant tests for this part. Verify that required classes are members of the test targets.

* Verifies Entry memberwise initializer
* Verifies existence of sharedController shared instance
* Verifies adding entries from EntryController
* Verifies removing entries from EntryController

## Part Two - User Interface

### Master List View

Build a view that lists all journal entries. You will use a UITableViewController and implement the UITableViewDataSource functions.

The UITableViewController subclass template comes with a lot of boilerplate and commented code. For readability, please remove all unused boilerplate from your code. 

You will want this view to reload the table view each time it appears in order to display newly created entries.

1. Add a UITableViewController as your root view controller in Main.storyboard and embed it into a UINavigationController
2. Create an EntryListTableViewController file as a subclass of UITableViewController and set the class of your root view controller scene
3. Implement the UITableViewDataSource functions using the EntryController entries array
    * note: Pay attention to your ```reuseIdentifier``` in the Storyboard scene and your dequeue function call
4. Set up your cells to display the title of the entry
5. Implement the UITableViewDataSource ```commitEditingStyle``` functions to enable swipe to delete functionality
6. Add a UIBarButtonItem to the UINavigationBar with the plus symbol
    * note: Select 'Add' in the System Item menu from the Identity Inspector to set the button as a plus symbol, these are system bar button items, and include localization and other benefits

### Detail View

Build a view that provides editing and view functionality for a single entry. You will use a UITextField to capture the title, a UITextView to capture the body, a UIButton to save, and a UIButton to clear the title and body text areas.

Your Detail View should follow the 'updateWith' pattern for updating the view elements with the details of a model object. To follow this pattern, the developer adds an 'updateWith' function that takes a model object. The function updates the view with details from the model object.

1. Add an 'updateWith' functions that takes a model object as a parameter (in this case, an Entry)
2. Implement the 'updateWith' functions to update all view elements that reflect details about the model object (in this case, the titleTextField and bodyTextView)

This view needs to serve as a reading and editing view. You will add a UITextField to display the title (titleTextField) and a UITextView to display the body text (bodyTextView), a 'Clear' button that resets both fields, and a 'Save' button that saves the new or changed entry.

#### View Setup

1. Add an ```EntryDetailViewController``` file as a subclass of UIViewController
2. Add a UIViewController scene to Main.storyboard and set the class to ```EntryDetailViewController```
3. Add a UITextField for the entry's title text to the top of the scene, add an outlet to the class file, and set the delegate relationship
4. Implement the delegate functions ```textFieldShouldReturn``` to resign first responder to dismiss the keyboard
5. Add a UITextView for the entry's body text beneath the title text field, add an outlet to the class file
6. Add a UIButton beneath the body text view, add an action to the class file that clears the text in the titleTextField and bodyTextView
7. Add a UIBarButtonItem to the UINavigationBar as a Save System Item, add an action to the class file
8. Add an optional Entry property ```var entry: Entry?```
9. In the action check if the entry property holds an entry, if so, update the properties of the entry. If not, call the save function on the ```EntryController```. After saving the entry, dismiss the current view.
    * note: You may need to add a segue to see a UINavigationBar on the detail view, and a UINavigationItem to add the UIBarButtonItem to the UINavigationBar, this will be covered in the next step

### Segue

You will add two separate segues from the List View to the Detail View. The segue from the plus button will tell the EntryDetailViewController that it should create a new entry. The segue from a selected cell will tell the EntryDetailViewController that it should display a previously created entry, and save any changes to the same.

1. Add a 'show' segue from the Add button to the EntryDetailViewController scene and give the segue an identifier
    * note: Consider that this segue will be used to add an entry when naming the identifier
2. Add a 'show' segue from the table view cell to the EntryDetailViewController scene and give the segue an identifier
    * note: Consider that this segue will be used to edit an entry when naming the identifier
3. Add a ```prepareForSegue``` function to the EntryListTableViewController
4. Implement the ```prepareForSegue``` function. Check the identifier of the segue parameter, if the identifier is 'toAddEntry' then we will present the destination view controller without passing an entry
5. Continue implementing the ```prepareForSegue``` function. If the identifier is 'toViewEntry' we will pass the selected entry to the DetailViewController by calling our ```updateWithEntry(entry: Entry)``` function
    * note: You will need to capture the selected entry by using the indexPath of the selected cell
    * note: Remember that the ```updateWithEntry(entry: Entry)``` function will update the destination view controller with the entry details

### Black Diamonds

* Implement UITableViewCellEditingStyles to enable swipe to delete entries on the List View
* Update Unit and UITests to verify delete functionality

### Tests

Uncomment any relevant tests for this part. Verify that required classes are members of the test targets.

* Verifies User Interface for adding and editing an entry

## Part Three - Controller Implementation

You will use NSUserDefaults to add basic data persistence to the Journal app. 

### Add Factory Functions to Entry

Because Entry class objects are not plist compatible, and NSUserDefaults will only store classes that are, we have two options:

1. Implement NSCoding to allow native saving and loading from plist objects like NSUserDefaults
2. Add factory functions to make Dictionary representations of the object and initialize new objects with a Dictionary

There are pros and cons to both approaches. We've opted to go with the latter because it is closer to working with network services and APIs later on in the class.

1. Write a dictionaryCopy function that returns a Dictionary with keys and values matching the properties of the object.
    * note: Avoid using 'Magic Strings' in your code. Create private string keys for the class for each property that will be stored to and pulled from a Dictionary (ex. ```private let timeStampKey = "timestamp"```)

2. Write a failable initializer that takes a Dictionary as a parameter and sets the timestamp, title, and text properties using the values from the dictionary.
    * note: Use ```guard let``` to check the optional values in the Dictionary, return nil if any of the properties are missing
    * note: There is a known bug in Swift that requires stored properties to be set even when returning nil from a faillable initializer

### Add NSUserDefaults Functionality to the EntryController

Our EntryController object is the source of truth for entries. We are now adding a layer of persistent storage, so we need to update our EntryController to load entries from NSUserDefaults on initialization, and save the entries to NSUserDefaults when they are updated.

1. Write a method called ```saveToPersistentStorage()``` that will save the current entries array to NSUserDefaults
    * note: Map the entries array to an array of plist compatible dictionary copies
    * note: Avoid 'Magic Strings' when saving to NSUserDefaults

2. Write a method called ```loadFromPersistentStorage()``` that will load saved dictionary entries from NSUserDefaults and set self.entries to the results
    * note: Use the Entry ```init(dictionary: Dictionary)``` in a Map function to turn the dictionaries into Entry class objects

3. Call the ```loadFromPersistentStorage()``` function when the EntryController is initialized

4. Call the ```saveToPersistentStorage()``` any time that the list of entries is modified

### Black Diamonds

* Implement the NSCoding protocol on the Entry class
* Create a Unit test that verifies NSCoding functionality by converting an instance to and from NSData
* Refactor persistence to work natively with Entry objects

### Tests

Uncomment any relevant tests for this part. Verify that required classes are members of the test targets.

* Verifies persistence cycle

## Contributions

Please refer to CONTRIBUTING.md.

## Copyright

© DevMountain LLC, 2015. Unauthorized use and/or duplication of this material without express and written permission from DevMountain, LLC is strictly prohibited. Excerpts and links may be used, provided that full and clear credit is given to DevMountain with appropriate and specific direction to the original content.