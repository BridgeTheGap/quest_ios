//
//  ViewController.swift
//  Quest
//
//  Created by Joshua Park on 1/27/16.
//  Copyright © 2016 KnowRe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    weak var checkButton: UIButton!
    weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Observe Version Manager
        VersionManager.sharedManager.addObserver(self, forKeyPath: "version", options: .New, context: nil)
        
        // Add text view
        let textView = UITextView()
        self.textView = textView
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.editable = false
        
        self.view.addSubview(textView)
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[textView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["textView": textView]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[textView]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["textView": textView]))

        // Add check button
        let checkButton = UIButton()
        self.checkButton = checkButton
        
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        
        checkButton.addTarget(self, action: "checkButtonAction:", forControlEvents: .TouchUpInside)
        checkButton.setTitle("Check Version", forState: .Normal)
        checkButton.setTitleColor(UIColor.blackColor(), forState: .Normal)
        
        self.view.addSubview(checkButton)
        self.view.addConstraint(NSLayoutConstraint(item: checkButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0.0))
        self.view.addConstraint(NSLayoutConstraint(item: checkButton, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 0.0))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: KVO
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if let key = keyPath {
            if key == "version" {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.textView.text = change!["new"] as! String
                    ViewControllerManager.sharedManager.switchToViewController(ViewControllerType.Login)
                })
            }
        }
    }
    
    func checkButtonAction(sender: AnyObject) {
        VersionManager.sharedManager.latestVersion()
    }
}

