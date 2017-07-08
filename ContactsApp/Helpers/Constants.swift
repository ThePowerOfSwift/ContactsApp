//
//  Constants.swift
//  ContactsApp
//
//  Created by One on 07/07/2017.
//  Copyright © 2017 Onedeveloper. All rights reserved.
//

import Foundation
import UIKit

class Constants: NSObject {
    
    // MARK: - Colors
    
    struct Color {
        
        static let navigationBar = UIColor(red: 35/255.0, green: 175/255.0, blue: 175/255.0, alpha: 1)
        static let shadowColor = UIColor(red: 170/255.0, green: 170/255.0, blue: 170/255.0, alpha: 1)
    }
    
    // MARK: - Images
    
    struct Image {
        
        static let user = #imageLiteral(resourceName: "defaultUser")
        
    }
    
    // MARK: - StoryBoard IDs
    
    enum StoryboardIds: String {
        
        // cells
        case contactCell

        // controllers
        case MasterViewController
        case DetailViewController
    }
    
    // MARK: - Segues
    
    enum StoryboardSeugeIDs:String {
        
        case ShowDetail = "showDetail"
    }
}
