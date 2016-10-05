//
//  ListViewControllerDelegate.swift
//  Task2
//
//  Created by Suresh Kansujiya on 27/09/16.
//  Copyright © 2016 Suresh Kansujiya. All rights reserved.
//

import UIKit
import MessageUI
import CoreData

extension ListViewController : UITableViewDataSource,UITableViewDelegate
{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let arr = arrContact {
           return arr.count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier(kListTableCell) as? ListCell
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier:kListTableCell) as? ListCell
        }
        cell?.setDataInCell(arrContact![indexPath.row] as! ContactInfo)
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "", message: " Choose an option!", preferredStyle: .ActionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        //Create and add first option action
        let showDetail: UIAlertAction = UIAlertAction(title: "Show Details", style: .Default) { action -> Void in
            //Code for launching the camera goes here
            self.pushDetailVC()
        }
        actionSheetController.addAction(showDetail)
        //Create and add a second option action
        let call: UIAlertAction = UIAlertAction(title: "Call",style: .Default) { action -> Void in
            //Code for picking from camera roll goes here
            self.makeCall()
        }
        actionSheetController.addAction(call)
        
        //Create and add a third option action
        let email: UIAlertAction = UIAlertAction(title: "Send an Email",style: .Default) { action -> Void in
            //Code for picking from camera roll goes here
            self.composeMail()
        }
        actionSheetController.addAction(email)
        
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
        
        tempContactInfo = (arrContact![indexPath.row] as! ContactInfo)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete
        {
            let contactInfo = arrContact!.objectAtIndex(indexPath.row) as! ContactInfo
            CoreDataEngine.sharedCoreDataEngine.managedObjectContext.deleteObject(contactInfo as NSManagedObject)
            CoreDataEngine.sharedCoreDataEngine.saveContext()
            arrContact?.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    func makeCall()
    {
        
        let strPhoneNumber = tempContactInfo!.mobileNumber
        if let url = NSURL(string: "tel://\(strPhoneNumber)")
        {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    func pushDetailVC()
    {
        let identifier = "DetailViewController"
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let detailViewController = storyBoard.instantiateViewControllerWithIdentifier(identifier) as! DetailViewController
        detailViewController.contactInfo = tempContactInfo
        detailViewController.isFromEdit = true
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    func composeMail()
    {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.presentViewController(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
    }
}

extension ListViewController : MFMailComposeViewControllerDelegate
{
    func configuredMailComposeViewController() -> MFMailComposeViewController
    {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        mailComposerVC.setToRecipients([tempContactInfo!.emailAddress!])
        mailComposerVC.setSubject("Sending you an in-app e-mail...")
        mailComposerVC.setMessageBody("Sending e-mail in-app is not so bad!", isHTML: false)
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        showAlertWithTitle("Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", okButtonTitle: "OK")
    }
    
    // MARK: MFMailComposeViewControllerDelegate
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }
}

