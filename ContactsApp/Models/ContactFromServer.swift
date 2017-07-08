//
//  Contact.swift
//  ContactsApp
//
//  Created by One on 07/07/2017.
//  Copyright © 2017 Onedeveloper. All rights reserved.
//

import Foundation
import ObjectMapper

class ContactFromServer: NSObject, Mappable {
    
    var contactID: String? = nil
    var firstName: String? = nil
    var lastName:String? = nil
    var phoneNumber:String? = nil
    var streetAddress1:String? = nil
    var streetAddress2:String? = nil
    var city:String? = nil
    var state:String? = nil
    var zipCode:String? = nil
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        contactID               <- map["contactID"]
        firstName               <- map["firstName"]
        lastName                <- map["lastName"]
        phoneNumber             <- map["phoneNumber"]
        streetAddress1          <- map["streetAddress1"]
        streetAddress2          <- map["streetAddress2"]
        city                    <- map["city"]
        state                   <- map["state"]
        zipCode                 <- map["zipCode"]
        
    }
}

