//
//  ContactCell.swift
//  ContactsApp
//
//  Created by One on 08/07/2017.
//  Copyright © 2017 Onedeveloper. All rights reserved.
//

import UIKit

class ContactCell: UITableViewCell {

    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
