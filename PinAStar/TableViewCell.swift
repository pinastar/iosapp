//
//  TableViewCell.swift
//  Sample
//
//  Created by Glynvile Satago on 3/7/15.
//  Copyright (c) 2015 Glynvile Satago. All rights reserved.
//

import UIKit

let cellHeightMinimum : CGFloat = 186
let cellMaxImageSize : CGFloat = 400
let star : String = "★"

protocol TableViewCellDelegate{
    func tableViewCellCloseSelected(sender :AnyObject!)
}
class TableViewCell: UITableViewCell {
    
    var data :Data?
    var delegate :TableViewCellDelegate?
    
    func setDataUI()
    {
        self.txtExcerpt.text = data?.excerpt
        if let num_p :Int = data?.numOfPins
        {
            self.btnPin.setTitle("◉ \(num_p)", forState: UIControlState.Normal)
        }
        if let num_h :Int = data?.numOfHearts
        {
             self.btnHeart.setTitle("\(star) \(num_h)", forState: UIControlState.Normal)
        }
        
       // println("size w : \(data?.imageSize.width) h : \(data?.imageSize.height)")
        
        self.img.frame.size = data!.imageSize
        self.img.image = UIImage(named: data!.image_filename)
        self.img.layer.cornerRadius = 10
        self.img.layer.masksToBounds = true
        
        self.img.contentMode = UIViewContentMode.ScaleAspectFill

        //self.txtExcerpt.frame.size = self.txtExcerpt.contentSize
        self.txtExcerpt.textContainer.lineBreakMode = NSLineBreakMode.ByTruncatingTail
        
        self.img.userInteractionEnabled = false
        self.txtExcerpt.userInteractionEnabled = false
    }
    
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var txtExcerpt: UITextView!
    
    @IBOutlet weak var btnPin: UIButton!
    @IBOutlet weak var btnHeart: UIButton!
    @IBOutlet weak var btnRemove: UIButton!
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        println("cell coder")
        
        var longpressGR = UILongPressGestureRecognizer(target: self, action: "longPressed:")
        longpressGR.minimumPressDuration = 1.0
        self.addGestureRecognizer(longpressGR)
    }
    @objc func longPressed(sender : UILongPressGestureRecognizer){
       
        let coords = sender.locationInView(self.window)
        
        if sender.state  == UIGestureRecognizerState.Ended{
             println("long pressed ended")

        }
        else if sender.state == UIGestureRecognizerState.Began{
             println("long pressed begin")
            
            var pop : Popup = Popup()
            pop.show()
        }
        
    }
    @IBAction func clickedPin(sender: UIButton) {
        self.data?.numOfPins += 1
        if let num_p :Int = data?.numOfPins
        {
            self.btnPin.setTitle("◉ \(num_p)", forState: UIControlState.Normal)
        }
    }
    @IBAction func clickedHeart(sender: UIButton) {
        self.data?.numOfHearts += 1
        if let num_h :Int = data?.numOfHearts
        {
            self.btnHeart.setTitle("\(star) \(num_h)", forState: UIControlState.Normal)
        }
    }
    @IBAction func clickedRemove(sender: UIButton) {
        
        delegate!.tableViewCellCloseSelected(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
