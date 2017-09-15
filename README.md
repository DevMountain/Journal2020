# Journal

### Level 1

Students will build a simple journal app to practice MVC separation, protocols, master-detail interfaces, table views, and persistence. 

Journal is an excellent app to practice basic Cocoa Touch princples and design patterns. Students are encouraged to repeat building Journal regularly until the principles and patterns are internalized and the student can build Journal without a guide.

Students who complete this project independently are able to:

### Part One - Model Objects and Controllers

* Understand basic model-view-controller design and implementation
* Create a custom model object with a memberwise initializer
* Understand, create, and use a shared instance
* Create a model object controller with create, read, update, and delete functions
* Implement the Equatable protocol

### Part Two - User Interface

* Implement a master-detail interface
* Implement the `UITableViewDataSource` protocol
* Understand and implement the `UITextFieldDelegate` protocol to dismiss the keyboard
* Create relationship segues in Storyboards
* Understand, use, and implement the 'updateViews' pattern
* Implement 'prepare(for segue: UIStoryboardSegue, sender: Any?)' to configure destination view controllers

### Part Three - Controller Implementation

* Add data persistence using UserDefaults
* Create a custom model object with a failable initializer
* Use the array map function to translate objects

## Part One - Model Objects and Controllers

### Entry

Create an Entry model class that will hold title, text, and timestamp properties for each entry.

1. Add a new `Entry.swift` file and define a new `Entry` class
2. Add properties for timestamp, title, and body text
3. Add a memberwise initializer that takes parameters for each property
* Consider setting a default parameter value for timestamp.

### EntryController

Create a model object controller called `EntryController` that will manage adding, reading, updating, and removing entries. We will follow the shared instance design pattern because we want one consistent source of truth for our entry objects that are held on the controller.

1. Add a new `EntryController.swift` file and define a new `EntryController` class inside.
2. Add an entries array property, and set its value to an empty array
3. Create a `addEntryWith(title: ...)` function that takes in a `title`, and `text`, creates a new instance of `Entry`, and adds it to the entries array
4. Create a `remove(entry: Entry)` function that removes the entry from the entries array
* There is no 'removeObject' function on arrays. You will need to find the index of the object and then remove the object at that index.
* You will face a compiler error because we have not given the Entry class a way to find equal objects. You will resolve the error by implementing the Equatable protocol in the next step.

5. Create an `update(entry: ...)` function that should take in an existing entry as a parameter, as well as the title and text strings to update the entry with
6. Create a `shared` property as a shared instance
* Review the syntax for creating shared instance properties

### Equatable Protocol

Implement the Equatable protocol for the Entry class. The Equatable protocol allows you to check for equality between two variables of a specific class. You may use the ObjectIdentifier() function on class types, but you may decide to manually check the values of the title, text, and timestamp properties.

1. Add the Equatable protocol function to the top or bottom of your `Entry.swift` file
2. Return the result of a comparison between the `lhs` and `rhs` parameters using ObjectIdentifier() or checking the property values on each parameter

### Black Diamonds

* Implement the NSCoding protocol on the Entry class
* Create a Unit test that verifies NSCoding functionality by converting an instance to and from NSData

### Tests

Uncomment any relevant tests for this part. Verify that required classes are members of the test targets.

* Verifies Entry memberwise initializer
* Verifies existence of 'shared' shared instance
* Verifies adding entries from EntryController
* Verifies removing entries from EntryController

## Part Two - User Interface

### Master List View

Build a view that lists all journal entries. You will use a UITableViewController and implement the UITableViewDataSource functions.

The UITableViewController subclass template comes with a lot of boilerplate and commented code. For readability, please remove all unnecessary boilerplate from your code. 

You will want this view to reload the table view each time it appears in order to display newly created entries.

1. Add a UITableViewController as your root view controller in Main.storyboard and embed it into a UINavigationController
2. Create an EntryListTableViewController file as a subclass of UITableViewController and set the class of your root view controller scene
3. Implement the UITableViewDataSource functions using the EntryController entries array
* Pay attention to your `reuseIdentifier` in the Storyboard scene and your `dequeueReusableCell(withIdentifier:for:)` function call
4. Set up your cells to display the title of the entry
5. Implement the UITableViewDataSource `tableView(_:commit:forRowAt:)` function to enable swipe to delete functionality
6. Add a UIBarButtonItem to the UINavigationBar with the plus symbol
* Select 'Add' in the System Item menu from the Identity Inspector to set the button as a plus symbol, these are system bar button items, and include localization and other benefits

### Detail View

Build a view that provides editing and view functionality for a single entry. You will use a UITextField to capture the title, a UITextView to capture the body, a UIBarButtonItem to save the new or updated entry, and a UIButton to clear the title and body text areas.

Your Detail View should follow the 'updateViews' pattern for updating the view elements with the details of a model object. To follow this pattern, the developer adds an 'updateViews' function that checks for a model object. The function updates the view with details from the model object.

1. Add an `EntryDetailViewController` file as a subclass of UIViewController and an optional `entry` property to the class 
2. Add a UIViewController scene to Main.storyboard and set the class to `EntryDetailViewController`
3. Add a UITextField for the entry's title text to the top of the scene, add an outlet to the class file called `titleTextField`, and set the delegate relationship
* To set the delegate relationship control drag from the UITextField to the current view controller in the scene dock 
4. Implement the delegate function `textFieldShouldReturn` to resign first responder to dismiss the keyboard
* Before you implement the delegate function be sure to adopt the UITextFieldDelegate protocol 
5. Add a UITextView for the entry's body text beneath the title text field and add an outlet to the class file `bodyTextView`.
6. Add a UIButton beneath the body text view and add an IBAction to the class file that clears the text in the titleTextField and bodyTextView.
7. Add a UIBarButtonItem to the UINavigationBar as a Save System Item and add an IBAction to the class file
* You may need to add a segue to see a UINavigationBar on the detail view, and a UINavigationItem to add the UIBarButtonItem to the UINavigationBar, this will be covered in the next section
8. In the IBAction check if the optional `entry` property holds an entry, if so, call the `update(entry: ...)` function in the `EntryController` to  update the properties of the entry. If not, call the `add(entry: Entry)` function on the `EntryController`. After adding a new entry, or updating the existing entry, dismiss the current view.
9. Add an `updateViews()` function that checks if the optional `entry` property holds an entry. If it doesn't, implement the function to update all view elements that reflect details about the model object (in this case, the titleTextField and bodyTextView)
10. Make your `entry` property a computed property and call `updateViews()` whenever that property gets set
11. Update the `viewDidLoad()` function to call `updateViews()`

### Segue

You will add two separate segues from the List View to the Detail View. The segue from the plus button will tell the EntryDetailViewController that it should create a new entry. The segue from a selected cell will tell the EntryDetailViewController that it should display a previously created entry, and save any changes to the same.

1. Add a 'show' segue from the Add button to the EntryDetailViewController scene and give the segue an identifier
* Consider that this segue will be used to add an entry when naming the identifier
2. Add a 'show' segue from the table view cell to the EntryDetailViewController scene and give the segue an identifier
* Consider that this segue will be used to edit an entry when naming the identifier
3. Add a `prepare(for segue: UIStoryboardSegue, sender: Any?)` function to the EntryListTableViewController
4. Implement the `prepare(for segue: UIStoryboardSegue, sender: Any?)` function. If the identifier is 'toShowEntry' we will pass the selected entry to the DetailViewController, which will call our `updateViews()` function 
* You will need to capture the selected entry by using the indexPath of the selected cell
* Remember that the `updateViews()` function will update the destination view controller with the entry details
* Since we aren't passing an entry if the identifier is 'toAddEntry' we don't need to account for this in our `prepare(for segue: UIStoryboardSegue, sender: Any?)`

### Black Diamonds

* Implement UITableViewCellEditingStyles to enable swipe to delete entries on the List View
* Update Unit and UITests to verify delete functionality

### Tests

Uncomment any relevant tests for this part. Verify that required classes are members of the test targets.

* Verifies User Interface for adding and editing an entry

## Part Three - Controller Implementation

You will use UserDefaults to add basic data persistence to the Journal app. 

### Add Factory Functions to Entry

Because Entry class objects are not plist compatible, and UserDefaults will only store classes that are, we have two options:

1. Implement NSCoding to allow native saving and loading from plist objects like UserDefaults
2. Add factory functions to make a dictionary representation of the object and initialize new objects with a dictionary

There are pros and cons to both approaches. We've opted to go with the latter because it is closer to working with network services and APIs which we will do later on in the course.

1. Write a `dictionaryRepresentation` computed property that returns a dictionary with keys and values matching the properties of the object.
* Avoid using 'magic strings' in your code. Create private string keys for the class for each property that will be stored to and pulled from a dictionary (ex. `private static let timeStampKey = "timestamp"`)

2. Write a failable initializer that takes a dictionary as a parameter and sets the timestamp, title, and text properties using the values from the dictionary.
* Use `guard let` to check the optional values in the dictionary and return nil if any of the properties are missing

### Add UserDefaults functionality to the EntryController

Our `EntryController` object is the source of truth for entries. We are now adding a layer of persistent storage, so we need to update our `EntryController` to load entries from UserDefaults on initialization and save the entries to UserDefaults when they are updated.

1. Write a method called `saveToPersistentStorage()` that will save the current entries array to UserDefaults
* Map the entries array to an array of plist compatible dictionary copies
* Avoid 'magic strings' when saving to UserDefaults

2. Write a method called `loadFromPersistentStorage()` that will load saved dictionary entries from UserDefaults and set `entries` to the results
* Use the Entry `init(dictionary: [String: Any])` in a flatMap function to turn the dictionaries into Entry class objects

3. Call the `loadFromPersistentStorage()` function when the `EntryController` is initialized

4. Call the `saveToPersistentStorage()` any time that the list of entries is modified

### Black Diamonds

* Add support for multiple journals by adding a Journal object that holds entries, a Journal list view that displays Journals, and making the Entry list view display just the entries from the selected journal
* Add support for tags on journals, add functionality to select a tag to display a list of entries with that tag
* Implement the NSCoding protocol on the Entry class
* Create a unit test that verifies NSCoding functionality by converting an instance to and from the `Data` class
* Refactor persistence to work natively with Entry objects

### Tests

Uncomment any relevant tests for this part. Verify that required classes are members of the test targets.

* Verifies persistence cycle

## Contributions

Please refer to CONTRIBUTING.md.

## Copyright

© DevMountain LLC, 2015. Unauthorized use and/or duplication of this material without express and written permission from DevMountain, LLC is strictly prohibited. Excerpts and links may be used, provided that full and clear credit is given to DevMountain with appropriate and specific direction to the original content.

