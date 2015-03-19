//
//  MainViewController.swift
//  PinAStar
//
//  Created by Glynvile Satago on 3/19/15.
//  Copyright (c) 2015 PinAStar Apps Corp. All rights reserved.
//

import UIKit

class MainViewController: UIViewController , FBLoginViewDelegate {

    override init(){
        super.init(nibName: "MainViewController", bundle: nil)
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnFBLogin.delegate = self;
        self.btnFBLogin.readPermissions = ["public_profile", "email", "user_friends"];

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBOutlet weak var btnFBLogin: FBLoginView!
    @IBOutlet weak var btnRegisterEmail: UIButton!

    @IBAction func clickedRegisterEmail(sender: UIButton) {
    }
    
    func loginViewShowingLoggedOutUser(loginView: FBLoginView!) {
        println("main showing logged out user")
    }
    func loginViewShowingLoggedInUser(loginView: FBLoginView!) {
        println("main showing logged in user")
        let loggedVC = LoggedViewController()
        self.presentViewController(loggedVC, animated: true, completion: nil)
    }
}
