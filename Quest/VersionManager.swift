//
//  VersionManager.swift
//  Quest
//
//  Created by Joshua Park on 2/1/16.
//  Copyright © 2016 KnowRe. All rights reserved.
//

import UIKit

let checkVerURL = NSURL(string: "http://usb2c-qa.knowre.com/api/common/checkVerIOS")!

class VersionManager: NSObject {
    static let sharedManager = VersionManager()
    let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    dynamic var request: NSURLRequest?
    dynamic var version: String?
    
    func latestVersion() {
        let dataTask = session.dataTaskWithURL(checkVerURL) { (data, response, error) -> Void in
            if let e = error {
                print(e.localizedDescription)
            } else {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)) as! NSDictionary
                    self.updateIfNeeded(json)
                } catch {
                    print("Error: Data is not of JSON Type")
                }
            }
        }
        dataTask.resume()
    }
    
    func updateIfNeeded(json: NSDictionary) {
        let appInfo = json["data"]!["appInfo"]! as! [String: String]!
        let version = appInfo["ver"]!
        
        self.version = version
        
        let currentVersion = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleShortVersionString") as! String
        if currentVersion < version {
            // Perform update
            let updateURL = NSURL(string: appInfo["url"]!)!
            request = NSURLRequest(URL: updateURL)
        }
    }
}
