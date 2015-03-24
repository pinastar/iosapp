//
//  LoggedViewController.swift
//  PinAStar
//
//  Created by Glynvile Satago on 3/19/15.
//  Copyright (c) 2015 PinAStar Apps Corp. All rights reserved.
//

import UIKit

class LoggedViewController: UIViewController, FBLoginViewDelegate {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init() {
        super.init(nibName: "LoggedViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnLogout.delegate = self;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!) {
        println("logged - in user info")
        self.imgView.profileID = user.objectID
        self.lblName.text = user.name
    }
    func loginViewShowingLoggedOutUser(loginView: FBLoginView!) {
        println("logged -  out user")
        let loggedOutVC = MainViewController()
        self.presentViewController(loggedOutVC, animated: true, completion: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgView: FBProfilePictureView!
    @IBOutlet weak var btnLogout: FBLoginView!
    @IBOutlet weak var btnGetStarted: UIButton!

    @IBAction func clickedGetStarted(sender: UIButton) {
        let categoryCVC = CategoryCollectionViewController()
        self.navigationController?.pushViewController(categoryCVC, animated: true)
        // self.presentViewController(categoryCVC, animated: true, completion: nil)
    }
}
