//
//  Popup.swift
//  Sample
//
//  Created by Glynvile Satago on 3/14/15.
//  Copyright (c) 2015 Glynvile Satago. All rights reserved.
//

import UIKit

class Popup: UIView {

    private var thisInstantObject : UIView!
    private var tintLayer : CALayer = CALayer()
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    required override init() {
        super.init()
        
        thisInstantObject = UINib(nibName: "Popup", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as UIView
        
       // var appdel : AppDelegate = UIApplication.sharedApplication()
        
       // tintLayer.frame = appdel.window?.fra
        
      //  println("self.window bounds -> \(appdel.window?.frame)")
        tintLayer.backgroundColor = UIColor.blackColor().CGColor
        
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        println("init coder - popup")
    }
    required override init(frame: CGRect) {
        super.init(frame: frame)
        println("init frame - popup")
    }
    func show(){
        self.window?.layer.addSublayer(tintLayer)
        self.window?.addSubview(thisInstantObject)
    }
    func hide(){
        
    }
}
