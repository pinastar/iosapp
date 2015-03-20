//
//  Popup.swift
//  Sample
//
//  Created by Glynvile Satago on 3/14/15.
//  Copyright (c) 2015 Glynvile Satago. All rights reserved.
//

import UIKit

class Popup: UIView {

    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var btnPin: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    
   // private var thisInstantObject : Popup!
    private var tintLayer : CALayer = CALayer()
    private var appdelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    required override init() {
        super.init()
        
       // thisInstantObject = UINib(nibName: "Popup", bundle: nil).instantiateWithOwner(self, options: nil)[0] as Popup

       // tintLayer.frame = appdel.window?.fra
        
        tintLayer.frame = appdelegate.window!.frame
        tintLayer.backgroundColor = UIColor.blackColor().CGColor
        
        btnPin.layer.cornerRadius = btnPin.frame.size.height
        
    }
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "Popup", bundle: nil).instantiateWithOwner(self, options: nil)[0] as UIView

    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        println("init coder - popup")
    }
    required override init(frame: CGRect) {
        super.init(frame: frame)
        println("init frame - popup")
    }
    func showAtPoint(point : CGPoint){
        
       // println("btn at : \(thisInstantObject.subviews)")
        tintLayer.opacity = 0
        self.alpha = 0
        self.center = point
        
        self.btnPin.frame = CGRectMake(0, 0, 100, 100)
        self.btnPin.alpha = 0.5
        
        appdelegate.window?.layer.addSublayer(tintLayer)
        appdelegate.window?.addSubview(self)
        
        
      //  thisInstantObject.btnLike?.center = thisInstantObject.center
      //  thisInstantObject.btnShare?.center = thisInstantObject.center
        
        UIView.animateWithDuration(0.25, delay: 0.0, usingSpringWithDamping: 2, initialSpringVelocity: 0.75, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            
            self.tintLayer.opacity = 0.75
            self.alpha = 1
            
            self.btnPin.frame = CGRectMake(0, 0, 10, 10)

        }) { (flag) -> Void in
            
        }
    }
    func hide(){
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.tintLayer.opacity = 0
            self.alpha = 0
        }) { (flag) -> Void in
            self.tintLayer.removeFromSuperlayer()
            self.removeFromSuperview()
        }
    }
}
