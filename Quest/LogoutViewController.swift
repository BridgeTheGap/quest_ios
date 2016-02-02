//
//  LogoutViewController.swift
//  Quest
//
//  Created by Joshua Park on 2/2/16.
//  Copyright © 2016 KnowRe. All rights reserved.
//

import UIKit

class LogoutViewController: UIViewController {
    weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        // logoutButton
        let logoutButton = UIButton()
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.addTarget(self, action: "logoutButtonAction:", forControlEvents: .TouchUpInside)
        logoutButton.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        logoutButton.setTitle("Log out", forState: .Normal)
        logoutButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        
        self.view.addSubview(logoutButton)
        self.logoutButton = logoutButton
        
        // Add and set constraints
        self.view.addConstraint(NSLayoutConstraint.init(item: logoutButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 120.0))
        self.view.addConstraint(NSLayoutConstraint.init(item: logoutButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 44.0))
        self.view.addConstraint(NSLayoutConstraint.init(item: logoutButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0))
        self.view.addConstraint(NSLayoutConstraint.init(item: logoutButton, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 45))
    }
    
    func logoutButtonAction(sender: UIButton) {
        ViewControllerManager.sharedManager.switchToViewController(ViewControllerType.Login)
    }
    
    deinit {
        print("Logout VC deinit..")
    }
}
