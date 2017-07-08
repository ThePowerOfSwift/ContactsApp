//
//  RoundedImage.swift
//  ContactsApp
//
//  Created by One on 08/07/2017.
//  Copyright © 2017 Onedeveloper. All rights reserved.
//

import UIKit

// Every UIImageView that inherits from RoundedImage class will be rounded

class RoundedImage: UIImageView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = frame.width / 2
        layer.masksToBounds = true;
    }
}
