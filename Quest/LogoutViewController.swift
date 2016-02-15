//
//  LogoutViewController.swift
//  Quest
//
//  Created by Joshua Park on 2/2/16.
//  Copyright © 2016 KnowRe. All rights reserved.
//

import UIKit
import Google

class LogoutViewController: UIViewController {
    weak var logoutButton: UIButton!

    override func loadView() {
        let view = LoginView(inputField: false, buttonTitle: "Logout")
        
        self.view = view
        logoutButton = view.submitButton
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoutButton.addTarget(self, action: "logoutButtonAction:", forControlEvents: .TouchUpInside)
    }
    
    // MARK: Target action
    func logoutButtonAction(sender: UIButton) {
        // Google Analytics only for release
        #if RELEASE
            print("LOGOUT: Release mode")
            let logoutEvent = GAIDictionaryBuilder.createEventWithCategory("user_action", action: "logout", label: nil, value: nil).build() as [NSObject: AnyObject]
            GAI.sharedInstance().defaultTracker.send(logoutEvent)
        #endif
        
        ViewControllerManager.sharedManager.switchToViewController(ViewControllerType.Login)
    }
    
    deinit {
        print("Logout VC deinit..")
    }
}
