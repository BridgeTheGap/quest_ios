//
//  LoginViewController.swift
//  Quest
//
//  Created by Joshua Park on 2/2/16.
//  Copyright © 2016 KnowRe. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    weak var usernameField: UITextField!
    weak var passwordField: UITextField!
    weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        // usernameField
        let usernameField = UITextField()
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        usernameField.autocapitalizationType = .None
        usernameField.autocorrectionType = .No
        usernameField.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        usernameField.placeholder = "account"
        usernameField.returnKeyType = .Next
        
        self.view.addSubview(usernameField)
        self.usernameField = usernameField
        
        // passwordField
        let passwordField = UITextField()
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.autocapitalizationType = .None
        passwordField.autocorrectionType = .No
        passwordField.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        passwordField.placeholder = "password"
        passwordField.returnKeyType = .Done
        passwordField.secureTextEntry = true
        
        self.view.addSubview(passwordField)
        self.passwordField = passwordField
        
        // loginButton
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.addTarget(self, action: "loginButtonAction:", forControlEvents: .TouchUpInside)
        loginButton.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        loginButton.setTitle("submit", forState: .Normal)
        loginButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        
        self.view.addSubview(loginButton)
        self.loginButton = loginButton
        
        // Add and set constraints
        self.view.addConstraint(NSLayoutConstraint(item: usernameField, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 120.0))
        self.view.addConstraint(NSLayoutConstraint(item: usernameField, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 44.0))
        self.view.addConstraint(NSLayoutConstraint(item: usernameField, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: passwordField, attribute: .Top, relatedBy: .Equal, toItem: usernameField, attribute: .Bottom, multiplier: 1, constant: 8))
        
        self.view.addConstraint(NSLayoutConstraint(item: passwordField, attribute: .Width, relatedBy: .Equal, toItem: usernameField, attribute: .Width, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: passwordField, attribute: .Height, relatedBy: .Equal, toItem: usernameField, attribute: .Height, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: passwordField, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: passwordField, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: loginButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 120.0))
        self.view.addConstraint(NSLayoutConstraint(item: loginButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 44.0))
        self.view.addConstraint(NSLayoutConstraint(item: loginButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: loginButton, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 45))

        // FIXME: Remove in real code
        usernameField.text = "quest1"
        passwordField.text = "quest1"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        usernameField.text = ""
        passwordField.text = ""
    }
    
    // MARK: Target action
    func loginButtonAction(sender: AnyObject) {
        // FIXME: Uncomment later
        // Check for valid user input
        if usernameField.text!.isEmpty || passwordField.text!.isEmpty {
            let alert = UIAlertController(title: "Cannot Login", message: "Please type in your username and password", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Retry", style: .Cancel, handler: { (action) -> Void in
                self.usernameField.becomeFirstResponder()
            }))
            
            self.presentViewController(alert, animated: true, completion: nil)
            return
        }
        
        let dataTask = self.dataTaskWithUsername(usernameField.text!, password: passwordField.text!, remember: true)
        if let task = dataTask {
            task.resume()
        }
    }
    
    // MARK: NSURLSession
    func dataTaskWithUsername(username: String, password: String, remember: Bool) -> NSURLSessionDataTask? {
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        let request = NSMutableURLRequest(URL: NSURL(string: "https://usb2c-qa.knowre.com/api/landing/loginEmail")!)
        
        let jsonString = "{  \"email\": \"\(username)\", \"password\" : \"\(password)\", \"rememberMe\" : \(String(remember)) }"
        let parameters = ["input":jsonString]
        
        do {
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.HTTPMethod = "POST"
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(parameters, options: .PrettyPrinted)
            
            return session.dataTaskWithRequest(request) { (data, response, error) -> Void in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.parseData(data!)
                    })
                }
            }
        } catch {
            print("Abort session due to input data error")
            return nil
        }
    }
    
    func parseData(data: NSData) {
        do {
            let dic = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSDictionary
            if dic["success"]! as! Bool == true {
                ViewControllerManager.sharedManager.switchToViewController(ViewControllerType.Logout)
            }
        } catch {
            print("Data is not a dictionary type")
        }
    }
    
    deinit {
        print("Login VC deinit..")
    }
}
