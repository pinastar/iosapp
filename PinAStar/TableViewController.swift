//
//  TableViewController.swift
//  Sample
//
//  Created by Glynvile Satago on 3/7/15.
//  Copyright (c) 2015 Glynvile Satago. All rights reserved.
//

import UIKit

enum ScrollDirection{
    case up, down
}
enum ScrollFunctionType{
    case ScrollFunctionLeftOnly,
    ScrollFunctionRightOnly,
    ScrollFunctionLeftAndRight
}

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TableViewCellDelegate {
    
    var arrayDataLeft : NSMutableArray?
    var arrayDataRight : NSMutableArray?
    
    var touchedTable : UITableView!
    var lastTouchedTable : UITableView!

    var lastLeftY :CGFloat = 0
    var lastRightY :CGFloat = 0
    
    let scrollConstant :CGFloat = 5
    
    var isBannerHide : Bool = false
    
    var isSplitScroll = true
    
    var isLeftTableTouched = false
    var isRightTableTouched = false

    @IBOutlet weak var tblLeft: UITableView!
    @IBOutlet weak var tblRight: UITableView!
    @IBOutlet weak var viewBanner: UIView!
    @IBOutlet weak var imgBanner: UIImageView!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        var switchbtn = UISwitch()
        switchbtn.setOn(isSplitScroll, animated: false)
        switchbtn.addTarget(self, action: Selector("switched:"), forControlEvents: UIControlEvents.ValueChanged)
        var btn = UIBarButtonItem(customView: switchbtn)
        self.navigationItem.rightBarButtonItem = btn
        
        var titleView : UIImageView = UIImageView(image: UIImage(named: "star.png"))
        titleView.contentMode = UIViewContentMode.ScaleAspectFit
        titleView.frame = CGRectMake(0, 0, 40, 40)
        self.navigationItem.titleView = titleView
        
        self.title = "Home"
        
        self.tblLeft.registerNib(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        self.tblRight.registerNib(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        self.tblRight.showsVerticalScrollIndicator = false
        self.tblLeft.showsVerticalScrollIndicator = false

        self.automaticallyAdjustsScrollViewInsets = false

        let dataLeft :NSArray = self.getArrayData("Data")
        let dataRight :NSArray = self.getArrayData("Data2")
        
        arrayDataLeft = NSMutableArray()
        arrayDataRight = NSMutableArray()
        
        self.getData(dataLeft, dataArray: arrayDataLeft!)
        self.getData(dataRight, dataArray: arrayDataRight!)
        
       // tblLeft.bounces = false
       // tblRight.bounces = false
        
        //tblLeft.exclusiveTouch = true
        
        println("tbl content offset \(tblLeft.contentOffset.y) || \(tblRight.contentOffset.y)")
        
        /*
        UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(recognizePan:)];
        panGestureRecognizer.maximumNumberOfTouches = 1;
        [scrollView addGestureRecognizer:panGestureRecognizer];
        [panGestureRecognizer release];
        */

        //banner swipe
        var swipeUp : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipeBanner:"))
        swipeUp.direction = UISwipeGestureRecognizerDirection.Up;
        self.viewBanner.addGestureRecognizer(swipeUp)
        
        var swipeDown : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("unSwipeBanner:"))
        self.viewBanner.addGestureRecognizer(swipeDown)

    }
    @objc func switched(sender : UISwitch){
        isSplitScroll = !isSplitScroll
        
        if(isSplitScroll)
        {
          //  self.view.multipleTouchEnabled = false
        }
       // self.tblRight.setContentOffset(self.tblLeft.contentOffset, animated: true)
        //sender.setOn(isSplitScroll, animated: true)
    }

    @objc func swipeBanner(sender : AnyObject){
        if !isBannerHide {
            self.moveBannerWithHeight(self.viewBanner.frame.height)
            isBannerHide = !isBannerHide
        }
    }
    @objc func unSwipeBanner(sender : AnyObject){
        if isBannerHide {
            self.moveBannerWithHeight(-self.viewBanner.frame.height)
            isBannerHide = !isBannerHide
        }
    }
    func moveBannerWithHeight(heightx : CGFloat!){
        UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 8, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            var height = heightx * 0.70
            
            self.viewBanner.frame.origin.y -= height
            
            self.tblLeft.frame.origin.y -= height
            self.tblLeft.frame.size.height += height
            
            self.tblRight.frame.origin.y -= height
            self.tblRight.frame.size.height += height
        }, completion: nil)
        
    }
    
    func tableViewCellCloseSelected(sender: AnyObject!) {
        var cell : TableViewCell = sender as AnyObject as TableViewCell
        let tblView = cell.superview?.superview as UITableView
        
        let indx  = self.getArraySourceWithTable(tblView)?.indexOfObject(cell.data!) as Int!
        
        self.getArraySourceWithTable(tblView)?.removeObject(cell.data!)
        tblView.deleteRowsAtIndexPaths([NSIndexPath(forRow: indx, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Automatic)
        
    }
    func getData(dataContent :NSArray, dataArray :NSMutableArray) {
        for datum in dataContent
        {
            var d : Data = Data()
            
            let size :NSDictionary = datum["image_size"] as NSDictionary
            d.imageSize = CGSizeMake(size["width"] as CGFloat, size["height"] as CGFloat)
            d.image_filename = datum["image_filename"] as String
            d.excerpt = datum["excerpt"] as String
            
            d.numOfPins = datum["no_pins"] as Int
            d.numOfHearts = datum["no_likes"] as Int
            
            dataArray.addObject(d)
        }
        
    }
    func panGR(){
       // println("panning")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let vw: AnyObject? = touches.anyObject()
        
        println("view touched : \(vw)")
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        //println("height of \(indexPath.row)")
        var datum : Data = self.getArraySourceWithTable(tableView)?.objectAtIndex(indexPath.row) as Data
        
        return (datum.heightOfImage() > cellMaxImageSize ? cellMaxImageSize : datum.heightOfImage()) + cellHeightMinimum
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.getArraySourceWithTable(tableView)!.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as TableViewCell
        cell.data = self.getArraySourceWithTable(tableView)?.objectAtIndex(indexPath.row) as? Data
        cell.setDataUI()
        cell.delegate = self
        
       // cell.textLabel??.text = array
       // cell.lbl.text = array[indexPath.row]
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
       // var pageVC : PageViewController = PageViewController()
       // pageVC.data = self.getArraySourceWithTable(tableView)?.objectAtIndex(indexPath.row) as? Data
        
      //  self.presentViewController(pageVC, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func getArraySourceWithTable(tableView : UITableView) -> NSMutableArray?
    {
        if(tableView == self.tblLeft)
        {
            return self.arrayDataLeft!
        }
        else
        {
            return self.arrayDataRight!
        }
    }
    
    //get array of data from the plist, returns an NSArray
    func getArrayData(filename :String) -> NSArray!
    {
        //println("file name \(filename)")
        var dict :NSDictionary!
        var arr :NSArray!
        if let path = NSBundle.mainBundle().pathForResource(filename, ofType: "plist")
        {
            dict = NSDictionary(contentsOfFile: path)
            arr = dict["array_data"] as NSArray
        }
        return arr
    }
    
    func scrollDirection(scrollView : UIScrollView) -> ScrollDirection{
        var direction :ScrollDirection?
        
        if scrollView == self.tblLeft{
            if lastLeftY > scrollView.contentOffset.y{
                direction = ScrollDirection.down
            }
            else{
                direction = ScrollDirection.up
            }
        }
        else if scrollView == self.tblRight{
            if lastRightY > scrollView.contentOffset.y{
                direction = ScrollDirection.down
            }
            else{
                direction = ScrollDirection.up
            }
        }
        return direction!
    }
    func tryScrollView( scrollView : UIScrollView, lastValueY : CGFloat) -> (ScrollDirection, CGFloat ){
        var direction : ScrollDirection?
        var valueY = lastValueY
        
        if lastValueY > scrollView.contentOffset.y
        {
            direction = ScrollDirection.down
           // println("going down")
        }
        else
        {
            direction = ScrollDirection.up
          //  println("going up")
        }
        println("last view y : \(lastValueY)")
        valueY = scrollView.contentOffset.y
        return (direction! , valueY)
    }
    
    //delegate methods for UIScrollview
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        touchedTable = scrollView as UITableView
        
        if scrollView == tblLeft {
            isLeftTableTouched = true
            tblRight.userInteractionEnabled = false
            println("left began draging")
        }
        else {
            isRightTableTouched = true
            tblLeft.userInteractionEnabled = false
            println("right began draging")
        }
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let tbl : String = scrollView == self.tblLeft ? "Left" : "Right"
        
        if(isSplitScroll == true)
        {
            if scrollView == self.tblLeft && isLeftTableTouched
            {
                self.tblRight.contentOffset.y = scrollView.contentOffset.y
            }
            else if scrollView == self.tblRight && isRightTableTouched
            {
                self.tblLeft.contentOffset.y = scrollView.contentOffset.y
            }
        }
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        // self.endScrollView(scrollView)
        if scrollView == tblLeft {
            isLeftTableTouched = false
            tblRight.userInteractionEnabled = true
        }
        else {
            isRightTableTouched = false
            tblLeft.userInteractionEnabled = true
        }
    }
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //  self.endScrollView(scrollView)
        if scrollView == tblLeft {
            isLeftTableTouched = false
            tblRight.userInteractionEnabled = true
        }
        else {
            isRightTableTouched = false
            tblLeft.userInteractionEnabled = true
        }
    }

}
