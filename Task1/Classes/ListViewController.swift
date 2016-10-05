//
//  ViewController.swift
//  Task1
//
//  Created by Suresh Kansujiya on 27/09/16.
//  Copyright © 2016 Suresh Kansujiya. All rights reserved.
//

import UIKit
import Contacts
import MessageUI

let kListTableCell = "ListTableCell"
class ListViewController: UIViewController {

    /*Create IBOutlet here*/
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    /*Create Veraible's here*/
    var arrContact : NSMutableArray?
    var tempContactInfo : ContactInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView?.tableFooterView = UIView()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
            self.fetchTaskResult()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: FetchData
    
    func fetchTaskResult() {
        
        activityIndicator?.stopAnimating()
        arrContact = ContactDataManager.getContactDatasource()
        
        if let arr = arrContact
        {
            if arr.count > 0
            {
                tableView.reloadData()
            }
        }
        else
        {
            showAlertWithTitle("Alert", message: "No Contact list found", okButtonTitle: "OK")
        }
    }
    
    func showAlertWithTitle(title: String, message: String, okButtonTitle: String) {
        // Initialize Alert Controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        // Configure Alert Controller
        alertController.addAction(UIAlertAction(title: okButtonTitle, style: .Default, handler: nil))
        
        // Present Alert Controller
        presentViewController(alertController, animated: true, completion: nil)
    }

}

