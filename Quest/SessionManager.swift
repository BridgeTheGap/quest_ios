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

class SessionManager: NSObject {
    static let sharedManager = SessionManager()
    var session: NSURLSession?
    var completion: ((NSData) -> Void)?
    
    func beginSession() {
        session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    }
    
    func beginSessionWithConfiguration(configuration: NSURLSessionConfiguration, delegate: NSURLSessionDelegate?, delegateQueue: NSOperationQueue?) {
        session = NSURLSession(configuration: configuration, delegate: delegate, delegateQueue: delegateQueue)
    }
    
    func dataTask(task: TaskType, username: String, password: String, remember: Bool) -> (dataTask: NSURLSessionDataTask?, errorMessage: String?) {
        if session == nil {
            return (nil, "Begin session by calling -beginSessionWithConfiguration(_, delegate)")
        }
        
        switch task {
        case .Login:
            let request = NSMutableURLRequest(URL: NSURL(string: task.rawValue)!)
            
            let jsonString = "{  \"email\": \"\(username)\", \"password\" : \"\(password)\", \"rememberMe\" : \(String(remember)) }"
            let parameters = ["input":jsonString]
            
            do {
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                
                request.HTTPMethod = "POST"
                request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(parameters, options: .PrettyPrinted)
                
                return (session!.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
                    if let e = error {
                        print(e.localizedDescription)
                    } else {
                        self.completion!(data!)
                    }
                }), nil)
            } catch {
                return (nil, "Abort session due to input data error")
            }
        }
    }
    
    func endSession() {
        session = nil
    }
}
