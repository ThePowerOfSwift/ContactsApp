//
//  Alert.swift
//  ContactsApp
//
//  Created by One on 07/07/2017.
//  Copyright © 2017 Onedeveloper. All rights reserved.
//

import Foundation
import UIKit

class Alert {
    
    // Standard warning alert
    
    class func showWarning(fromController controller: UIViewController, withTitle title: String, andText text: String) {
        
        let alertController = UIAlertController (title: title, message: text, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        controller.present(alertController, animated: true, completion: nil)
    }
}
