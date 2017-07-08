[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://www.apple.com/ios/ios-10/)
[![Swift Version](https://img.shields.io/badge/swift-3.0-yellow.svg?style=flat)](https://swift.org)
[![License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](http://mit-license.org)

# Contacts App

### iOS Software Test

The application was written as a response to the test task for the vacancy "iOS developer".  
  
The basic idea is to use the device's local memory (using CoreData) to perform "CRUD" operations, build the UI foundations, 
the overall architecture and culture of the code.  
  
The application is similar to the standard "Contacts" application. Implemented the ability to add, delete and edit a contact.  
  
For the contacts model I’ve created a .plist file to fetch data from there (and place in CoreData) only once, when the app starts at first time.
There is also prepared model for networking fetch (using Alamofire). So switching between won't be hard.  
  
Time spent on the task - 6 hours.  
  
Link to the video demonstration of an app: https://www.dropbox.com/s/g8l1txmhhgrqikq/ContactsDemo.mov?dl=0

<p align="center">
  <img src="https://user-images.githubusercontent.com/23423988/27987812-d0f17644-641c-11e7-9cb3-d5429415774a.png" alt="Image") />
  <img src="https://user-images.githubusercontent.com/23423988/27987815-d5387e50-641c-11e7-837d-d965fd9abc6a.png" alt="Image") />
</p>

## Used  

- Swift 3.0
- `CoreData`
- MVC pattern
- auto Layout
- `UIAlertController`
- `Alamofire`, `ObjectMapper` (if needed)
- `NSUserDefaults`
- Reading information from .plist file
- Custom `UITableView`
  
## To do

- [ ] Provide checking for textfields information

## License

ContactsApp is available under the MIT license. See the LICENSE file for more info.
