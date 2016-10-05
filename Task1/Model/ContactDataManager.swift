//
//  ContactDataManager.swift
//  Task1
//
//  Created by Suresh Kansujiya on 28/09/16.
//  Copyright © 2016 Suresh Kansujiya. All rights reserved.
//

import UIKit
import CoreData

let kContactInfo = "ContactInfo"

class ContactDataManager: NSObject {

    // Insert code here to add functionality to your managed object subclass
    /**  this function initialize the new entity to insert in the managecontex*/
    
    class func initializContactInfo()-> ContactInfo {
        let task = NSEntityDescription.insertNewObjectForEntityForName(kContactInfo, inManagedObjectContext: CoreDataEngine.sharedCoreDataEngine.managedObjectContext) as! ContactInfo
        return task
    }
    
    class func getContactDatasource()->NSMutableArray? {
        let fetchRequest = NSFetchRequest(entityName: kContactInfo)
        //fetchRequest.predicate = NSPredicate(format: "state == \(state)")
        
        do {
            let resultArr = try CoreDataEngine.sharedCoreDataEngine.managedObjectContext.executeFetchRequest(fetchRequest)
            if resultArr.count > 0 {
                let arrResult = resultArr as NSArray
                return  arrResult.mutableCopy() as? NSMutableArray
            }
            else {
                return nil
            }
        }
        catch let error as NSError {
            Swift.debugPrint(error)
        }
        return nil
        
    }
    
    class func  insertOrUpdateTaskData(detailModel : DetailModel)
    {
        // insert a new task object
        let contactInfo = initializContactInfo()
        contactInfo.fName = detailModel.fName
        contactInfo.lName = detailModel.lName
        contactInfo.mobileNumber = detailModel.mobileNumber
        contactInfo.emailAddress = detailModel.emailAddress
        contactInfo.photo  = detailModel.photo
        contactInfo.address = detailModel.address
        contactInfo.dataOfBirth = detailModel.dataOfBirth
        CoreDataEngine.sharedCoreDataEngine.saveContext()
        
    }
}
