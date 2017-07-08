//
//  PlistLoader.swift
//  ContactsApp
//
//  Created by One on 08/07/2017.
//  Copyright © 2017 Onedeveloper. All rights reserved.
//

import Foundation
import UIKit
import CoreData

enum PlistError: Error {
    case invalidResource
    case parsingFailure
}

// Getting data from contactsDB.plist and converting to dictionaries

class PlistLoader {
    
    static func array(fromFile name: String, ofType type: String) throws -> [[String: String]] {
        // getting a path
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {
            throw PlistError.invalidResource
        }
        // initializing with array
        guard let array = NSArray(contentsOfFile: path) as? [[String: String]] else {
            throw PlistError.parsingFailure
        }
        
        return array
    }
}

// Returns filled array

class ContactsSource {
    static var contacts: [Contact] {
        let data = try! PlistLoader.array(fromFile: "ContactsDB", ofType: "plist")
        
        return data.flatMap { Contact(dictionary: $0) }
    }
}
