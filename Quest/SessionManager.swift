//
//  SessionManager.swift
//  Quest
//
//  Created by Joshua Park on 2/3/16.
//  Copyright © 2016 KnowRe. All rights reserved.
//

import UIKit

enum TaskType: String {
    case Login = "https://usb2c-qa.knowre.com/api/landing/loginEmail"
}

class SessionManager: NSObject, NSURLSessionDataDelegate {
    static let sharedManager = SessionManager()
    var session: NSURLSession?
    var data: NSData? {
        // Observe property change
        willSet {
            print("Received data from request and updating property")
        }
        didSet {
            do {
                let dic = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as! NSDictionary
                if dic["success"]! as! Bool == true {
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        ViewControllerManager.sharedManager.switchToViewController(ViewControllerType.Logout)
                    })
                }
            } catch {
                print("Data is not JSON type.")
            }
        }
    }
    
    // MARK: Public
    func loginWithUsername(username: String,  password: String, remember: Bool) {
        beginSession()
        let request = NSMutableURLRequest(URL: NSURL(string: TaskType.Login.rawValue)!)
        
        let jsonString = "{  \"email\": \"\(username)\", \"password\" : \"\(password)\", \"rememberMe\" : \(String(remember)) }"
        let parameters = ["input":jsonString]
        
        do {
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            request.HTTPMethod = "POST"
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(parameters, options: .PrettyPrinted)
            
            let dataTask = session!.dataTaskWithRequest(request)
            dataTask.resume()
        } catch {
            print("Abort session due to input data error")
        }
    }
    
    // MARK: Private
    private func beginSession() {
        session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration(), delegate: self, delegateQueue: NSOperationQueue.mainQueue())
    }
    
    private func endSession() {
        session = nil
    }
    
    // MARK: URLSessionDataDelegate
    @objc internal func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?) {
        if let e = error {
            print(e.localizedDescription)
        }
    }
    
    @objc internal func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData) {
        self.data = data
        endSession()
    }
}
