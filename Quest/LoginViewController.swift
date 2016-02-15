//
//  LoginViewController.swift
//  Quest
//
//  Created by Joshua Park on 2/2/16.
//  Copyright © 2016 KnowRe. All rights reserved.
//

import UIKit
import Google

class LoginViewController: UIViewController {
    weak var usernameField: UITextField!
    weak var passwordField: UITextField!
    weak var loginButton: UIButton!
    
    override func loadView() {
        let view = LoginView(inputField: true, buttonTitle: "Submit")
        
        self.view = view
        
        usernameField = view.usernameField
        passwordField = view.passwordField
        loginButton = view.submitButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.addTarget(self, action: "loginButtonAction:", forControlEvents: .TouchUpInside)
        
        // FIXME: Remove in real code
        usernameField.text = "quest1"
        passwordField.text = "quest1"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Target action
    func loginButtonAction(sender: AnyObject) {
        // Google analytics only for release
        #if RELEASE
            print("LOGIN: Release mode")
            let loginEvent = GAIDictionaryBuilder.createEventWithCategory("user_action", action: "tap_login", label: nil, value: nil).build() as [NSObject: AnyObject]
            GAI.sharedInstance().defaultTracker.send(loginEvent)
        #endif
        
        // Check for valid user input
        if usernameField.text!.isEmpty || passwordField.text!.isEmpty {
            let alert = UIAlertController(title: "Cannot Login", message: "Please type in your username and password", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Retry", style: .Cancel, handler: { (action) -> Void in
                self.usernameField.becomeFirstResponder()
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        // Session manager: begin session
        SessionManager.sharedManager.beginSession()
        
        // Completion: If data task is successful with a response, switch to logout view controller
        SessionManager.sharedManager.completion = { data in
            do {
                let dic = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSDictionary
                if dic["success"]! as! Bool == true {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        ViewControllerManager.sharedManager.switchToViewController(ViewControllerType.Logout)
                    })
                }
            } catch {
                print("Data is not a dictionary type")
            }
            
            SessionManager.sharedManager.endSession()
        }
        let tuples = SessionManager.sharedManager.dataTask(.Login, username: usernameField.text!, password: passwordField.text!, remember: true)
        
        if let task = tuples.dataTask {
            task.resume()
        } else {
            print(tuples.errorMessage!)
        }
    }
    
    deinit {
        print("Login VC deinit..")
    }
}
