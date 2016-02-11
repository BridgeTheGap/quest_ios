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
        ViewControllerManager.sharedManager.switchToViewController(ViewControllerType.Login)
    }
    
    deinit {
        print("Logout VC deinit..")
    }
}
