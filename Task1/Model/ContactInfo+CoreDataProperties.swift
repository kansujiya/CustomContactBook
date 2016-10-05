//
//  ContactInfo+CoreDataProperties.swift
//  Task1
//
//  Created by Suresh Kansujiya on 28/09/16.
//  Copyright © 2016 Suresh Kansujiya. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ContactInfo {

    @NSManaged var address: String?
    @NSManaged var dataOfBirth: NSDate?
    @NSManaged var emailAddress: String?
    @NSManaged var fName: String?
    @NSManaged var lName: String?
    @NSManaged var mobileNumber: String?
    @NSManaged var photo: NSData?

}
