# Journal

### Level 1

Students will build a simple journal app to practice MVC separation, protocols, master-detail interfaces, table views, and persistence.

Journal is an excellent app to practice basic Cocoa Touch principles and design patterns. Students are encouraged to repeat the building journal regularly until they master the principles and patterns and build journals without a guide.

Students who complete this project independently can:

### Part One - Model Objects and Controllers

* Understand basic model-view-controller design and implementation
* Create a custom model object with a memberwise initializer
* Understand, create, and use a shared instance
* Create a model object controller with create, read, update, and delete functions
* Implement the Equatable protocol
* Implement a master-detail interface
* Implement the `UITableViewDataSource` protocol
* Understand and implement the `UITextFieldDelegate` protocol to dismiss the keyboard
* Create relationship segues in Storyboards
* Understand, use, and implement the 'updateViews' pattern
* Implement 'prepare(for segue: UIStoryboardSegue, sender: Any?)' to configure destination view controllers

### Part Two - Controller Implementation

* Add data persistence using the Codable protocol and write data to a local file path (URL).
* Upon launch, decode the data returned from the local file path (URL) back into our custom model objects.

## Part One - Model Objects and Controllers

### Entry

Create an Entry model class that will hold title, text, and timestamp properties for each entry.

1. Add a new `Entry.swift` file and define a new `Entry` class
2. Add properties for timestamp, title, and body text
3. Add a memberwise initializer that takes parameters for each property
* Consider setting a default parameter value for the timestamp.

### EntryController

Create a model object controller called `EntryController` that will manage adding, reading, updating, and removing entries. For entry objects in the controller, there should be a consistent source of truth for the entry objects to follow the shared instance design pattern.

1. Add a new `EntryController.swift` file and define a new `EntryController` class within then class.
2. Add an entries array property, and set its value to an empty array
3. Create a `addEntryWith(title: ...)` function that takes in a `title`, and `text`. It should create a new instance of `Entry` and add it to the entries array
4. Create a `remove(entry: Entry)` function that removes the entry from the entries array
* There is no 'removeObject' function on arrays. Find the index of the object and then remove the object at that index.
* You will face a compiler error because we have not given the Entry class a way to find equal objects. To resolve the error, implement the Equatable protocol in the next step.

5. Create an `update(entry: ...)` function that should take in an existing entry as a parameter and the title and text strings to update the entry.
6. Create a `shared` property as a shared instance
* Review the syntax for creating shared instance properties

### Equatable Protocol

Implement the Equatable protocol for the Entry class. The Equatable protocol helps to check for equality between two variables of a specific class. To ensure that the two objects we are comparing when using this protocol are the same, manually check the values of all the variables - the title, text, and timestamp properties. 

1. Add the Equatable protocol function in an extension to the bottom of the `Entry.swift` file
2. Return the result of the comparison between the 'lhs' and 'rhs' parameters by checking the property values on each parameter.

### Master List View

Build a view that lists all journal entries. Use a UITableViewController and implement the UITableViewDataSource functions.

The UITableViewController subclass template comes with a lot of boilerplate and commented code. For readability, please remove all unnecessary boilerplate from the code.

This view will reload the table view each time it appears in order to display newly created entries.

1. Add a UITableViewController as the root view controller in Main.storyboard and embed it into a UINavigationController
2. Create an `EntryListTableViewController` file as a subclass of UITableViewController. Set the class of the root view controller scene
3. Implement the UITableViewDataSource functions using the EntryController `entries` array
* Pay attention to the `reuseIdentifier` in the Storyboard scene and the `dequeueReusableCell(withIdentifier:for:)` function call
4. Set up the cells to display the title of the entry
5. Implement the UITableViewDataSource `tableView(_:commit:forRowAt:)` function to enable swipe to delete functionality
6. Add a UIBarButtonItem to the UINavigationBar.
* Select 'Add' in the System Item menu from the Identity Inspector to set the button as a plus symbol. These are system bar button items, including localization and other benefits

### Detail View

Build a view that provides editing and view functionality for a single entry. Use a UITextField to capture the title, a UITextView to capture the body, a UIBarButtonItem to save the new or updated entry, and a UIButton to clear the title and body text areas.

The Detail View should follow the 'updateViews' pattern for updating the view elements with the details of a model object. To follow this pattern, add an 'updateViews' function that checks for a model object. The function updates the view with details from the model object.

1. Add an `EntryDetailViewController` file as a subclass of UIViewController and an optional `entry` property to the class
2. Add a UIViewController scene to Main.storyboard and set the class to `EntryDetailViewController`
3. Add a UITextField for the entry's title text to the top of the scene, add an outlet to the class file called `titleTextField`. Set the delegate relationship by adopting the UITextFieldDelegate protocol in the `EntryDetailViewController` class.
4. Implement the delegate function `textFieldShouldReturn` and call the resignFirstResponder() method on the titleTextField to dismiss the keyboard.
5. Add a UITextView for the entry's body text beneath the title text field and add an outlet to the class file `bodyTextView`.
6. Add a UIButton beneath the body text view and add an IBAction to the class file that clears the text in the titleTextField and bodyTextView.
7. Add a UIBarButtonItem to the UINavigationBar as a `Save` System Item and add an IBAction to the class file called `saveButtonTapped`
(*You will need to add a segue from `EntryListTableViewController` to see a UINavigationBar on the detail view; and a UINavigationItem to add the UIBarButtonItem to the UINavigationBar, in the next section, this will be covered*)
8. In the `saveButtonTapped` IBAction, check if the optional `entry` property holds an entry. If so, call the `update(entry: ...)` function in the `EntryController` to update the properties of the entry. If not, call the `add(entry: Entry)` function on the `EntryController`. After adding a new entry, or updating the existing entry, dismiss the current view.
9. Add an `updateViews()` function that checks if the optional `entry` property holds an entry. If it does, implement the function to update all view elements that reflect details about the model object `entry` (in this case, the titleTextField and bodyTextView)
10. Update the `viewDidLoad()` function to call `updateViews()`

### Segue

Add two separate segues from the List View to the Detail View. The segue from the plus button will tell the EntryDetailViewController that it should create a new entry. The segue from a selected cell will tell the EntryDetailViewController that it should display a previously created entry, and save all changes.

1. Add a 'show' segue from the Add button to the EntryDetailViewController scene. This segue will not need an identifier since we will not be passing information using this segue. 
2. Add a 'show' segue from the table view cell to the EntryDetailViewController scene and give the segue an identifier
(*When naming the identifier, consider that this segue will be used to edit an entry*)
3. Add a `prepare(for segue: UIStoryboardSegue, sender: Any?)` function to the EntryListTableViewController
4. Implement the `prepare(for segue: UIStoryboardSegue, sender: Any?)` function. If the identifier is 'showEntry' we will pass the selected entry to the DetailViewController, which will call our `updateViews()` function
* You will need to capture the selected entry by using the indexPath of the selected cell
* Remember that the `updateViews()` function will update the destination view controller with the entry details

### Black Diamonds

* Implement UITableViewCellEditingStyles to enable swipe to delete entries on the List View
Please See: https://developer.apple.com/documentation/uikit/uitableviewdelegate/1614869-tableview?language=objc


## Part Two - Controller Implementation

Use the Codable protocol to add necessary data persistence to the Journal app. Once the model objects are encoded, save this data to a local file on disk. To access this file, use the URL pointing it. This is a file URL, not a Web URL. It is similar to those seen in Finder  ex: path (User/Desktop/Projects/MyProject/myData.json)

### Add Data Persistence functionality to the EntryController

Our `EntryController` object is the source of truth for entries. We are now adding a layer of persistent storage. We need to update the `EntryController` to load entries from persistent storage upon initialization and save the entries to persistent storage when they are created/updated.

##### Creating the URL
1. Copy and paste this method into the project. Note that this method returns a URL, which is the URL for the file location where we will be saving our data.
```
private func fileURL() -> URL {
let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
let fileName = "journal.json"
let documentsDirectoryURL = urls[0].appendingPathComponent(fileName)
return documentsDirectoryURL
}
```

##### Saving data to the URL
1. Write a method called `saveToPersistentStorage()` that will save the current entries array to a file on disk. Implement this function to:
1. Create an instance of `JSONEncoder`
2. Call `encode(value: Encodable) throws` on your instance of the JSONEncoder, passing in the array of entries as the Encodable argument. Assign the return of this function to a constant named `data`. _**NOTE - The objects in the array need to be `Codable` objects.** Go back to the Entry class and adopt the Codable protocol._  Please see Encoding & Decoding Custom Types:  https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types or reference the guided lecture from this morning.
3. Notice that this function throws; that means that this function will throw an error if it does not work the way it should when called. Functions that throw need to be marked with `try` in front of the function call. Put this call inside a **do catch block** and `catch` any error that throws. 
_ If you need to learn about doing catch blocks, review the documentation._
4. Call `data.write(to: URL)` This function asks for a URL. We can pass in the `fileURL()` as an argument, which will write the data at the URL. *Hint - This is also a throwing function.*
2. Call `saveToPersistentStorage()` any time that the list of entries is modified (CRUD functions)

#### Quick lesson on local urls 
The screenshot below shows how local URLs work. URLs are not just web-based. On the computer, there are local file URLs. Open the finder and right-click to "get info". When done, it will show the location of the folder on the local machine. For example, iCloud Drive / Desktop / Dev Mountain Bank / etc. 
Local files are separated by components which are forward-slashes. Extensions are . (dots). Images are a good example of extensions such as .jpg or .png
<img width="1676" alt="screen shot 2018-10-01 at 11 03 26 am" src="https://user-images.githubusercontent.com/23179585/46303711-d7f20300-c569-11e8-979a-d5b777e371ea.png">

##### Loading data from the URL
1. Write a method called `loadFromPersistentStorage()` that will load the current data from the file on disk where we saved our entries(data). Implement this function to:
1. Create an instance of `JSONDecoder`
2. Create a constant called `data` to hold the data that you will get back by calling `Data(contentsOf:)`. Now pass in the `fileURL()` as an argument. _(This is a throwing function)_
3. Call `decode(from:)` on your instance of the JSONDecoder. Assign the return of this function to a constant named `entries`. This function takes in two arguments: a type `[Entry].self`, and your instance of data. It will decode the data into an array of Entry.
4. Now set self.entries to this array of entries.

2. Call the `loadFromPersistentStorage()` function when the `EntryController` is initialized

Run the app; it should now function properly—test for bugs.

### Black Diamonds

* Add support for multiple journals by adding a Journal object that holds entries, a Journal list view that displays Journals, and making the Entry list view display just the entries from the selected journal
* Add support for tags on journals, add functionality to select a tag to display a list of entries with that tag


## Contributions

Please refer to CONTRIBUTING.md.

## Copyright

© DevMountain LLC, 2015. Unauthorized use and/or duplication of this material without express and written permission from DevMountain, LLC is strictly prohibited. Excerpts and links may be used, provided that full and clear credit is given to DevMountain with appropriate and specific direction to the original content.


