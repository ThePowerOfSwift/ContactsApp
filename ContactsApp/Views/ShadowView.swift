//
//  ShadowView.swift
//  ContactsApp
//
//  Created by One on 08/07/2017.
//  Copyright © 2017 Onedeveloper. All rights reserved.
//

import UIKit

// Every View that inherits from ShadowView class will drop the shadow

class ShadowView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 4.0
        backgroundColor = UIColor.white
        
        self.dropShadow()
    }
}
