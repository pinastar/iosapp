//
//  Data.swift
//  Sample
//
//  Created by Glynvile Satago on 3/9/15.
//  Copyright (c) 2015 Glynvile Satago. All rights reserved.
//

import UIKit

class Data: NSObject {
    
    var image_filename : String = ""
    var imageSize :CGSize = CGSize(width: 100.0, height: 100.0)
    
    var excerpt : String = ""
    var numOfPins :Int = 0
    var numOfHearts :Int = 0
    
    func heightOfExcerpt() -> CGFloat{
        return CGFloat()
    }
    func heightOfImage() -> CGFloat{
        
        let img = UIImage(named: self.image_filename)
        let h = img?.size.height
        return h!
    }
    
}
