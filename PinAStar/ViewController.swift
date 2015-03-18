//
//  ViewController.swift
//  PinAStar
//
//  Created by Glynvile Satago on 3/16/15.
//  Copyright (c) 2015 PinAStar Apps Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FBLoginViewDelegate {

    @IBOutlet weak var btnLogin: FBLoginView!
    @IBOutlet weak var btnTwitter: UIButton!
    
    var accountStore : ACAccountStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnLogin.delegate = self
        self.btnLogin.readPermissions = ["public_profile", "email", "user_friends"]
        
        self.accountStore = ACAccountStore()
        let twitterAcc  = self.accountStore.accountWithIdentifier(ACAccountTypeIdentifierTwitter)
        

       // self.accountStore.requestAccessToAccountsWithType(twitterAcc, options: nil){ (flag,error) -> Void in
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func loginViewShowingLoggedInUser(loginView: FBLoginView!) {
        
    }
    func loginViewShowingLoggedOutUser(loginView: FBLoginView!) {
        
    }
    func loginViewFetchedUserInfo(loginView: FBLoginView!, user: FBGraphUser!) {
        
    }
    func loginView(loginView: FBLoginView!, handleError error: NSError!) {
        
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

