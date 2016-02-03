//
//  LoginView.swift
//  Quest
//
//  Created by Joshua Park on 2/3/16.
//  Copyright © 2016 KnowRe. All rights reserved.
//

import UIKit

class LoginView: UIView {
    let usernameField = UITextField()
    let passwordField = UITextField()
    let submitButton = UIButton()
    
    convenience init(inputField: Bool, buttonTitle: String) {
        self.init(frame: CGRectZero)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.configure(inputField: inputField, buttonTitle: buttonTitle)
    }

    func configure(inputField inputField: Bool, buttonTitle: String) {
        self.backgroundColor = UIColor.whiteColor()
        
        if inputField {
            usernameField.translatesAutoresizingMaskIntoConstraints = false
            usernameField.autocapitalizationType = .None
            usernameField.autocorrectionType = .No
            usernameField.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
            usernameField.placeholder = "account"
            usernameField.returnKeyType = .Next
            
            self.addSubview(usernameField)
            
            // passwordField
            passwordField.translatesAutoresizingMaskIntoConstraints = false
            passwordField.autocapitalizationType = .None
            passwordField.autocorrectionType = .No
            passwordField.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
            passwordField.placeholder = "password"
            passwordField.returnKeyType = .Done
            passwordField.secureTextEntry = true
            
            self.addSubview(passwordField)
            
            // Set constraints
            self.addConstraint(NSLayoutConstraint(item: usernameField, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 0.65, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: usernameField, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 44.0))
            self.addConstraint(NSLayoutConstraint(item: usernameField, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: passwordField, attribute: .Top, relatedBy: .Equal, toItem: usernameField, attribute: .Bottom, multiplier: 1, constant: 8))
            
            self.addConstraint(NSLayoutConstraint(item: passwordField, attribute: .Width, relatedBy: .Equal, toItem: usernameField, attribute: .Width, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: passwordField, attribute: .Height, relatedBy: .Equal, toItem: usernameField, attribute: .Height, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: passwordField, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: passwordField, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 8))
        }
        
        // submitButton
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.backgroundColor = UIColor(white: 0.95, alpha: 1)
        submitButton.setTitle(buttonTitle, forState: .Normal)
        submitButton.setTitleColor(UIColor.lightGrayColor(), forState: .Normal)
        
        self.addSubview(submitButton)
        
        // Set constraints
        self.addConstraint(NSLayoutConstraint(item: submitButton, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 120.0))
        self.addConstraint(NSLayoutConstraint(item: submitButton, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 44.0))
        self.addConstraint(NSLayoutConstraint(item: submitButton, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: submitButton, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 44.0))
    }
    
    deinit {
        print("Login View deinit..")
    }
}
