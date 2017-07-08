//
//  Contact.swift
//  ContactsApp
//
//  Created by One on 08/07/2017.
//  Copyright © 2017 Onedeveloper. All rights reserved.
//

import Foundation

import UIKit

// This is a model to store infortation from .plist file

struct Contact {
    let firstName: String
    let lastName: String
    let phone: String
    let street: String
    let city: String
    let zip: String
    let image: String
}

extension Contact {
    
    struct Key {
        static let firstName = "firstName"
        static let lastName = "lastName"
        static let phone = "phoneNumber"
        static let street = "streetAddress"
        static let city = "city"
        static let zip = "zip"
        static let image = "avatarName"
    }
    
    // accessing each value of a relevant key and assigning to the stored property
    init?(dictionary: [String: String]) {
        guard let firstNameString = dictionary[Key.firstName],
            let lastNameString = dictionary[Key.lastName],
            let phoneString = dictionary[Key.phone],
            let streetString = dictionary[Key.street],
            let cityString = dictionary[Key.city],
            let imageString = dictionary[Key.image],
            let zipString = dictionary[Key.zip] else { return nil }
        
        self.firstName = firstNameString
        self.lastName = lastNameString
        self.phone = phoneString
        self.street = streetString
        self.city = cityString
        self.zip = zipString
        self.image = imageString
    }
}
