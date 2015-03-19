//
//  ViewController.swift
//  PinAStar
//
//  Created by Glynvile Satago on 3/16/15.
//  Copyright (c) 2015 PinAStar Apps Corp. All rights reserved.
//

import UIKit
import TwitterKit


class ViewController: UIViewController, FBLoginViewDelegate {

    @IBOutlet weak var btnFacebook: FBLoginView!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var viewTwitter: UIView!
    
    @IBAction func clickedRegister(sender: UIButton) {
    }
    var accountStore : ACAccountStore!
    //74627-Dev
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.btnFacebook.delegate = self
        self.btnFacebook.readPermissions = ["public_profile", "email", "user_friends"]
        
      /*  let btnTwitterLogin = TWTRLogInButton(logInCompletion: { (session: TWTRSession!, error : NSError!) -> Void in
            
        })
        btnTwitterLogin.frame.size = self.btnFacebook.frame.size
        btnTwitterLogin.center = self.view.center
        self.view.addSubview(btnTwitterLogin)
        
     */
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //facebook delegate methods
    func loginViewShowingLoggedInUser(loginView: FBLoginView!) {
        println("login view showing logged in user")
        
        var tblMain = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("main") as TableViewController
        var nav = UINavigationController(rootViewController: tblMain)
        self.presentViewController(nav, animated: true, completion: nil)
        
    }
    func loginViewShowingLoggedOutUser(loginView: FBLoginView!) {
        println("login view showing logged out")
        
    }
    func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!) {
        println("login view fetched user info : \(user)")
    }
    func loginView(loginView: FBLoginView!, handleError error: NSError!) {
        println("login handle error : \(error.debugDescription)")
    }
    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser){
        println("user : \(user)")
        println("user-id : \(user.objectID)")
        println("user-name : \(user.name)")
        var userEmail = user.objectForKey("email") as String
        println("user-email : \(userEmail)")
    }
    func loginView(loginView : FBLoginView! , handleError : NSError ){
        println("Error : \(handleError.localizedDescription)")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

