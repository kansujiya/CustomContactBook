//
//  DetailTableHeaderView.swift
//  Task1
//
//  Created by Suresh Kansujiya on 28/09/16.
//  Copyright © 2016 Suresh Kansujiya. All rights reserved.
//

@objc

protocol choosePhotoProtocol {
    
    optional func openActionSheetForPhoto()
}

import UIKit

class DetailTableHeaderView: UIView {

    @IBOutlet weak var imgViewPhoto : UIImageView!
    
    var delegate : choosePhotoProtocol?
    
    override func awakeFromNib()
    {
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action: #selector(DetailTableHeaderView.imageTapped))
        imgViewPhoto.userInteractionEnabled = true
        imgViewPhoto.addGestureRecognizer(tapGestureRecognizer)
        
        imgViewPhoto.layer.cornerRadius = imgViewPhoto.frame.size.height/2
        imgViewPhoto.clipsToBounds = true
    }
    
    func setImaage(img : UIImage)  {
        imgViewPhoto.image = img
    }
    
    func imageTapped()
    {
        if let delegate = self.delegate
        {
                if let result = delegate.openActionSheetForPhoto?()
                {
                    return result
                }
        }
    }
    
}


