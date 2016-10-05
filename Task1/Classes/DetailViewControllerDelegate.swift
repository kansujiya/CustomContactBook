//
//  DetailViewControllerDelegate.swift
//  Task1
//
//  Created by Suresh Kansujiya on 28/09/16.
//  Copyright © 2016 Suresh Kansujiya. All rights reserved.
//

import UIKit

extension DetailViewController : UITableViewDelegate, UITableViewDataSource
{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier(kFieldTableViewCell) as? FieldTableViewCell
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier:kFieldTableViewCell) as? FieldTableViewCell
        }
        
        cell?.txtField.delegate = self
        
        if isFromEdit == true {
            switch indexPath.row {
            case 0:
                
                if  let fName = contactInfo?.fName
                {
                    cell?.setValueInCell("First Name*", Placeholder: "First Name", text : fName, Tag: indexPath.row)
                }
                else{
                
                    cell?.setValueInCell("First Name*", Placeholder: "First Name", text : "", Tag: indexPath.row)
                    
                }
                
            case 1:
                if let lName = contactInfo?.lName
                {
                    cell?.setValueInCell("Last Name*", Placeholder: "Last Name", text : lName,Tag: indexPath.row)
                }
                else
                {
                    cell?.setValueInCell("Last Name*", Placeholder: "Last Name", text : "",Tag: indexPath.row)
                }
                
            case 2:
                if let mobileNumber  = contactInfo?.mobileNumber
                {
                    cell?.setValueInCell("Mobile Number*", Placeholder: "Mobile Number",text : mobileNumber, Tag: indexPath.row)
                }
                else{
                     cell?.setValueInCell("Mobile Number*", Placeholder: "Mobile Number",text : "", Tag: indexPath.row)
                }
                
            case 3:
                if let emailAdd = contactInfo?.emailAddress
                {
                    cell?.setValueInCell("Email Address*", Placeholder: "Email Address", text : emailAdd,Tag: indexPath.row)
                }
                else
                {
                    cell?.setValueInCell("Email Address*", Placeholder: "Email Address", text : "",Tag: indexPath.row)
                }
                
            case 4:
                    if let date = contactInfo?.dataOfBirth
                    {
                        let dateFormatter = NSDateFormatter()
                        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
                        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle

                        let strDate = dateFormatter.stringFromDate(date)
                        cell?.setValueInCell("Birth Date", Placeholder: "Birth Date", text : strDate, Tag: indexPath.row)
                    }
                    else
                    {
                        cell?.setValueInCell("Birth Date", Placeholder: "Birth Date", text : "", Tag: indexPath.row)
                    }
                
                
            case 5:
                if let address = contactInfo?.address
                {
                    cell?.setValueInCell("Address", Placeholder: "Address",text : address, Tag: indexPath.row)
                }
                else
                {
                    cell?.setValueInCell("Address", Placeholder: "Address",text : "", Tag: indexPath.row)
                }
                
            default:
                break
            }
        }
        else
        {
            switch indexPath.row {
            case 0:
                    cell?.setValueInCell("First Name*", Placeholder: "First Name", text : "", Tag: indexPath.row)
            case 1:
                    cell?.setValueInCell("Last Name*", Placeholder: "Last Name", text : detailModel!.lName,Tag: indexPath.row)
            case 2:
                
                    cell?.setValueInCell("Mobile Number*", Placeholder: "000-000-0000",text : (detailModel?.mobileNumber)!, Tag: indexPath.row)
            case 3:
                    cell?.setValueInCell("Email Address*", Placeholder: "Email Address", text : (detailModel?.emailAddress)!,Tag: indexPath.row)
            case 4:
                    cell?.setValueInCell("Birth Date", Placeholder: "Birth Date", text : "", Tag: indexPath.row)
            case 5:
                    cell?.setValueInCell("Address", Placeholder: "Address",text : (detailModel?.address)!, Tag: indexPath.row)
            default:
                break
            }
        }
        cell?.selectionStyle = .None
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }

}

extension DetailViewController : UITextFieldDelegate
{
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool // return NO to disallow editing.
    {
        return true
    }
    func textFieldDidBeginEditing(textField: UITextField) // became first responder
    {
        if textField.tag == 4
        {
            let datePickerView:UIDatePicker = UIDatePicker()
            
            datePickerView.datePickerMode = UIDatePickerMode.Date
            
            textField.inputView = datePickerView
            
            datePickerView.addTarget(self, action: #selector(DetailViewController.datePickerValueChanged), forControlEvents: UIControlEvents.ValueChanged)
        }
    }
    func textFieldShouldEndEditing(textField: UITextField) -> Bool // return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
    {
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField) // may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
    {
        if isFromEdit == true
        {
            switch textField.tag {
            case 0:
                contactInfo!.fName = textField.text!
            case 1:
                contactInfo!.lName = textField.text!
            case 2:
                contactInfo!.mobileNumber = textField.text!
            case 3:
                contactInfo!.emailAddress = textField.text!
            case 4: break
                //detailModel!.dataOfBirth = NSDate()
            case 5:
                contactInfo!.address = textField.text!
            default:
                break
            }
        }
        else
        {
            switch textField.tag {
            case 0:
                detailModel!.fName = textField.text!
            case 1:
                detailModel!.lName = textField.text!
            case 2:
                detailModel!.mobileNumber = textField.text!
            case 3:
                detailModel!.emailAddress = textField.text!
            case 4: break
            //detailModel!.dataOfBirth = NSDate()
            case 5:
                detailModel!.address = textField.text!
            default:
                break
            }

        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool // return NO to not change text
    {
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        return true
    }

    func datePickerValueChanged(sender:UIDatePicker)
    {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        dateFormatter.timeStyle = NSDateFormatterStyle.NoStyle
        
        let cell = tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 4, inSection: 0))
        let textField : UITextField = (cell as! FieldTableViewCell).txtField
        textField.text = dateFormatter.stringFromDate(sender.date)
        
        if isFromEdit == true
        {
            contactInfo?.dataOfBirth = sender.date
        }
        else
        {
            detailModel?.dataOfBirth = sender.date
        }
    }
}

extension DetailViewController : choosePhotoProtocol
{
    func openActionSheetForPhoto()
    {
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "", message: " Choose an option!", preferredStyle: .ActionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        //Create and add first option action
        let takePictureAction: UIAlertAction = UIAlertAction(title: "Take Picture", style: .Default) { action -> Void in
            //Code for launching the camera goes here
            self.openGalleryCamera(1)
        }
        actionSheetController.addAction(takePictureAction)
        //Create and add a second option action
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Choose From Camera Roll",style: .Default) { action -> Void in
            //Code for picking from camera roll goes here
            self.openGalleryCamera(2)
        }
        actionSheetController.addAction(choosePictureAction)
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    func openGalleryCamera(index : Int)
    {
        imagePicker = UIImagePickerController()
        imagePicker!.allowsEditing = false
        if index == 1
        {
            imagePicker!.sourceType = .PhotoLibrary
        }
        else
        {
            imagePicker!.sourceType = .Camera
        }
        
        imagePicker!.delegate = self
        presentViewController(imagePicker!, animated: true, completion: nil)
    }

}



extension DetailViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            let data : NSData =  UIImagePNGRepresentation(pickedImage)!
            if isFromEdit == true {
                 contactInfo!.photo = data
            }
            else
            {
                detailModel?.photo = data
            }
            viewDetailHeader?.setImaage(pickedImage)
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
