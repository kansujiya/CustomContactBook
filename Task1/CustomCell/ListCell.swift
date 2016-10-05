//
//  ListCell.swift
//  Task2
//
//  Created by Suresh Kansujiya on 27/09/16.
//  Copyright © 2016 Suresh Kansujiya. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {

    /*create outlet here*/
    @IBOutlet weak var imageViewPhoto : UIImageView!
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var lblPhoneNumber : UILabel!
    @IBOutlet weak var lblEmailAddress : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageViewPhoto.layer.cornerRadius = imageViewPhoto.frame.size.height/2
        imageViewPhoto.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataInCell(contactInfo : ContactInfo) {
        lblName.text = contactInfo.fName! + " " + contactInfo.lName!
        lblPhoneNumber.text = contactInfo.mobileNumber
        lblEmailAddress.text = contactInfo.emailAddress
        
        if let data = contactInfo.photo
        {
            imageViewPhoto.image = UIImage(data:data,scale:1.0)
        }
    }
    
}
