//
//  DetailViewController.swift
//  ContactsApp
//
//  Created by One on 07/07/2017.
//  Copyright © 2017 Onedeveloper. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UITableViewController {
    
    // to pass data from previous VC
    var contact: CDContact?
    
    // distinguish between updating and adding contact
    var isUpdating = false
    
    @IBOutlet weak var contactPhoto: UIImageView!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var zipCodeField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    // MARK: - Setup View
    
    func configureView() {
        
        firstNameField.becomeFirstResponder()
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap(_:)))
        tableView.addGestureRecognizer(recognizer)
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveChanges(_:)))
        navigationItem.rightBarButtonItem = saveButton
        
        if let contact = contact {
            
            if let image = contact.image {
                contactPhoto.image = UIImage(named: image)
            }
        
            firstNameField.text = contact.firstName
            lastNameField.text = contact.lastName
            phoneNumberField.text = contact.phone
            addressField.text = contact.street
            cityField.text = contact.city
            zipCodeField.text = contact.zip
        }
        else {
            contactPhoto.image = Constants.Image.user
        }
    }
    
    // MARK: - Actions
    
    func saveChanges(_ sender: Any) {

        if  let firstname = firstNameField.text,
            let lastname = lastNameField.text,
            let phone = phoneNumberField.text,
            let street = addressField.text,
            let city = cityField.text,
            let zip = zipCodeField.text {
            
            // Update contact
            if isUpdating {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                contact?.firstName = firstname
                contact?.lastName = lastname
                contact?.phone = phone
                contact?.street = street
                contact?.city = city
                contact?.zip = zip
                appDelegate.saveContext()
            }
                
            // Add contact to CoreData stack
            else {
                
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                
                let newContact = CDContact(context: context)
                
                newContact.firstName = firstname
                newContact.lastName = lastname
                newContact.phone = phone
                newContact.street = street
                newContact.city = city
                newContact.zip = zip
                newContact.image = "defaultUser"
                
                // saving data
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
            }
            
            self.navigationController?.navigationController?.popToRootViewController(animated: true)
        
        }
    }
    
    func hideKeyboardOnTap(_ sender: Any) {
        self.view.endEditing(true)
    }
    
    // just for testing puropse. Quickly fill all textfields
    @IBAction func testButtonAction(_ sender: Any) {
        
        firstNameField.text = "John"
        lastNameField.text = "Doe"
        phoneNumberField.text = "555-15-10"
        addressField.text = "White light district"
        cityField.text = "New York"
        zipCodeField.text = "485610"
    }
}

extension DetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}

