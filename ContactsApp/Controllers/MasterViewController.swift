//
//  MasterViewController.swift
//  ContactsApp
//
//  Created by One on 07/07/2017.
//  Copyright © 2017 Onedeveloper. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var detailViewController: DetailViewController? = nil
    var managedObjectContext: NSManagedObjectContext? = nil
    
    var contactsFromServer = [ContactFromServer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // If App launches at first time - fill CoreData model with data from .plist file
        if UserDefaults.isFirstLaunch() {
            fillCoreDataWithContentsOfPlistFile()
        }
        
        setupNavigationBar()
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)

    }
    
    // MARK: - Setup View
    
    func setupNavigationBar() {
        
        self.title = "Contacts"
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
    }
    
    // MARK: - Fill CoraData
    
    func fillCoreDataWithContentsOfPlistFile() {
        
        let context = self.fetchedResultsController.managedObjectContext
        
        for contact in ContactsSource.contacts {
            
            let newCDContact = CDContact(context: context)
            
            newCDContact.firstName = contact.firstName
            newCDContact.lastName = contact.lastName
            newCDContact.phone = contact.phone
            newCDContact.street = contact.street
            newCDContact.city = contact.city
            newCDContact.zip = contact.zip
            newCDContact.image = contact.image
        }
        
        // Save the context.
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            Alert.showWarning(fromController: self, withTitle: "Error", andText: "Please, try again later")
        }
    }
    
    // MARK: - Networking fetch (if needed)
    
    func fetchContactsFromServer() {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        // fetch data from network and fill the table view
        HttpClient.shared.accounts {[weak weakSelf = self] (items) in
            if let items = items {
                
                for item in items {
                    weakSelf?.contactsFromServer.append(item)
                }
                weakSelf?.tableView.reloadData()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            } else {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                Alert.showWarning(fromController: self, withTitle: "Error", andText: "Bad response. Please, try again later")
            }
        }
    }
    
    // MARK: - Actions
    
    func insertNewObject(_ sender: Any) {
        
        performSegue(withIdentifier: Constants.StoryboardSeugeIDs.ShowDetail.rawValue, sender: nil)
        
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.StoryboardSeugeIDs.ShowDetail.rawValue {
            
            if let indexPath = tableView.indexPathForSelectedRow {
                
                let object = fetchedResultsController.object(at: indexPath)
                
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                
                controller.contact = object
                controller.isUpdating = true
                
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
            else {

                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    // MARK: - TableView DataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.StoryboardIds.contactCell.rawValue, for: indexPath) as? ContactCell else { fatalError() }
        
        let contact = fetchedResultsController.object(at: indexPath)
        
        configureCell(cell, withContact: contact)
        
        return cell
    }
    
    func configureCell(_ cell: ContactCell, withContact contact: CDContact) {
        
        if let image = contact.image {
            cell.photo.image = UIImage(named: image)
        }
        
        cell.nameLabel.text = "\(contact.firstName!) \(contact.lastName!)"
        cell.phoneLabel.text = contact.phone
    }
    
    // MARK: - TableView Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 90.0
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let context = fetchedResultsController.managedObjectContext
            context.delete(fetchedResultsController.object(at: indexPath))
            
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
                Alert.showWarning(fromController: self, withTitle: "Error", andText: "Please, try again later")
            }
        }
    }
    
    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController<CDContact> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<CDContact> = CDContact.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "firstName", ascending: true, selector:  #selector(NSString.localizedStandardCompare))
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            Alert.showWarning(fromController: self, withTitle: "Error", andText: "Please, try again later")
        }
        
        return _fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController<CDContact>? = nil
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            return
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .update:
            print("update")
            configureCell((tableView.cellForRow(at: indexPath!) as? ContactCell)! , withContact: anObject as! CDContact)
        case .move:
            configureCell((tableView.cellForRow(at: indexPath!) as? ContactCell)!, withContact: anObject as! CDContact)
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
}

