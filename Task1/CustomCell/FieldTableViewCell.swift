//
//  FieldTableViewCell.swift
//  Task1
//
//  Created by Suresh Kansujiya on 28/09/16.
//  Copyright © 2016 Suresh Kansujiya. All rights reserved.
//

import UIKit

class FieldTableViewCell: UITableViewCell {

    
    /*Create IBoutlet here*/
    @IBOutlet weak var lblName : UILabel!
    @IBOutlet weak var txtField : UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setValueInCell(name : String , Placeholder strPlace : String, text strTxt : String,Tag tag : Int)
    {
        lblName.text = name
        txtField.placeholder = strPlace
        txtField.tag = tag
        txtField.text = strTxt
        
        if tag == 2
        {
            txtField.keyboardType = .NumbersAndPunctuation
        }
        else
        {
            txtField.keyboardType = .Default
        }
    }

}
