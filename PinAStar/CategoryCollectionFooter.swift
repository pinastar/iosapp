//
//  CategoryCollectionFooter.swift
//  PinAStar
//
//  Created by Glynvile Satago on 3/19/15.
//  Copyright (c) 2015 PinAStar Apps Corp. All rights reserved.
//

import UIKit

protocol CategoryCollectionFooterDelegate{
    func selectedFollow(sender : UIButton)
}

class CategoryCollectionFooter: UICollectionReusableView {
    
    var delegate : CategoryCollectionFooterDelegate?
    
    @IBOutlet weak var btnFollow: UIButton!
    @IBAction func clickedFollow(sender: UIButton) {
        delegate?.selectedFollow(sender)
    }
}
