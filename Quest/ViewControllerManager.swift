//
//  ViewControllerManager.swift
//  Quest
//
//  Created by Joshua Park on 2/2/16.
//  Copyright © 2016 KnowRe. All rights reserved.
//

import UIKit

enum ViewControllerType {
    case Login
    case Logout
}

class ViewControllerManager: NSObject {
    static let sharedManager = ViewControllerManager()
    
    func switchToViewController(type: ViewControllerType) {
        let keyWindow = UIApplication.sharedApplication().keyWindow!

        switch type {
        case .Login:
            keyWindow.rootViewController = LoginViewController()
        case .Logout:
            keyWindow.rootViewController = LogoutViewController()
        }
    }
}
