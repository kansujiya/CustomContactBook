//
//  DetailViewController.swift
//  Task1
//
//  Created by Suresh Kansujiya on 28/09/16.
//  Copyright © 2016 Suresh Kansujiya. All rights reserved.
//

import UIKit

let kFieldTableViewCell = "FieldTableViewCell"

class DetailViewController: UIViewController
{

    /*Create IBOutlet here*/
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var editOrSaveBtn : UIBarButtonItem!
    
    
    var isFromEdit : Bool = false
    var detailModel : DetailModel?
    var contactInfo : ContactInfo?
    var isSelected : Bool = false
    var viewDetailHeader : DetailTableHeaderView?
    
    var imagePicker : UIImagePickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView?.tableFooterView = UIView()
        
        /*check it's from Detail or Add new Contact*/
        
        if  isFromEdit == true
        {
            editOrSaveBtn.title = "Edit"
            tableView.userInteractionEnabled = false
        }
        else
        {
            editOrSaveBtn.title = "Save"
            isSelected = true
            detailModel = DetailModel()
        }
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
        
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableHeaderView = getTableHeader()
        tableView.separatorColor = UIColor.clearColor()
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTableHeader() -> UIView
    {
        
        viewDetailHeader  = loadHeaderNib()
        viewDetailHeader?.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 140)
        
        if isFromEdit == true {
            if let data = contactInfo?.photo
            {
                let img = UIImage(data:data,scale:1.0)
                viewDetailHeader?.setImaage(img!)
            }
        }
        
        viewDetailHeader!.delegate = self
        return viewDetailHeader!
    }
    
    @IBAction func btnSaveClicked(sender : AnyObject?)
    {
        
        if  isFromEdit == true
        {
            if  isSelected == true
            {
                editOrSaveBtn.title = "Edit"
                tableView.userInteractionEnabled = false
                isSelected = false
                
                self.view.endEditing(true)

                if (contactInfo?.fName)! == "" || (contactInfo?.lName)! == "" || (contactInfo?.mobileNumber)! == "" || (contactInfo?.emailAddress) == ""
                {
                    showAlertWithTitle("Alert", message: "Please fill all mandatory Fields.", okButtonTitle: "OK")
                    editOrSaveBtn.title = "Save"
                    isSelected = true
                    tableView.userInteractionEnabled = true

                    return
                }
                
                if (contactInfo?.fName)! == ""
                {
                    showAlertWithTitle("Alert", message: "Please enter first Name.", okButtonTitle: "OK")
                    editOrSaveBtn.title = "Save"
                    isSelected = true
                    tableView.userInteractionEnabled = true

                    return
                }
                
                if (contactInfo?.lName)! == ""
                {
                    showAlertWithTitle("Alert", message: "Please enter last Name.", okButtonTitle: "OK")
                    editOrSaveBtn.title = "Save"
                    isSelected = true
                    tableView.userInteractionEnabled = true

                    return
                }
                if validatePhoneNumber((contactInfo?.mobileNumber)!) == false
                {
                    showAlertWithTitle("Alert", message: "Please enter valid Phone Number.", okButtonTitle: "OK")
                    editOrSaveBtn.title = "Save"
                    isSelected = true
                    tableView.userInteractionEnabled = true

                    return
                }
                if (isValidEmail((contactInfo?.emailAddress)!) == false)
                {
                    showAlertWithTitle("Alert", message: "Please enter valid email id.", okButtonTitle: "OK")
                    editOrSaveBtn.title = "Save"
                    isSelected = true
                    tableView.userInteractionEnabled = true

                    return
                }
                CoreDataEngine.sharedCoreDataEngine.saveContext()
            }
            else
            {
                editOrSaveBtn.title = "Save"
                tableView.userInteractionEnabled = true
                isSelected = true
                
                let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0))
                let textField : UITextField = (cell as! FieldTableViewCell).txtField
                textField.becomeFirstResponder()

            }
            
        }
        else
        {
            self.view.endEditing(true)
            
            if (detailModel?.fName)! == "" || (detailModel?.lName)! == "" || (detailModel?.mobileNumber)! == "" || (detailModel?.emailAddress) == ""
            {
                showAlertWithTitle("Alert", message: "Please fill all mandatory Fields.", okButtonTitle: "OK")
                return
            }
            
            if (detailModel?.fName)! == ""
            {
                showAlertWithTitle("Alert", message: "Please enter first Name.", okButtonTitle: "OK")
                return
            }
            
            if (detailModel?.lName)! == ""
            {
                showAlertWithTitle("Alert", message: "Please enter last Name.", okButtonTitle: "OK")
                return
            }
            if validatePhoneNumber((detailModel?.mobileNumber)!) == false
            {
                showAlertWithTitle("Alert", message: "Please enter valid Phone Number.", okButtonTitle: "OK")
                return
            }
            if (isValidEmail((detailModel?.emailAddress)!) == false)
            {
                showAlertWithTitle("Alert", message: "Please enter valid email id.", okButtonTitle: "OK")
                return
            }
            ContactDataManager.insertOrUpdateTaskData(detailModel!)
            
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func isValidEmail(testStr:String) -> Bool
    {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        if let emailTest : NSPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx) {
            return emailTest.evaluateWithObject(testStr)
        }
        return false
    }
    
    func validatePhoneNumber(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluateWithObject(value)
        return result
    }
    
    func showAlertWithTitle(title: String, message: String, okButtonTitle: String) {
        // Initialize Alert Controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        // Configure Alert Controller
        alertController.addAction(UIAlertAction(title: okButtonTitle, style: .Default, handler: nil))
        
        // Present Alert Controller
        presentViewController(alertController, animated: true, completion: nil)
    }

    
    func loadHeaderNib() -> DetailTableHeaderView
    {
        return NSBundle.mainBundle().loadNibNamed("DetailTableHeaderView", owner: nil, options: nil)[0] as! DetailTableHeaderView
    }
}
