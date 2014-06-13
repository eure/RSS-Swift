//
//  Request.swift
//  RSSSwift
//
//  Created by Muukii on 6/13/14.
//  Copyright (c) 2014 Muukii. All rights reserved.
//

import UIKit

class Request: NSObject {
    var session : NSURLSession!
    init()
    {
        super.init()
        let sessionConfiguration : NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        self.session = NSURLSession(configuration: sessionConfiguration)
    }

    class func foo() {

    }
    func foo(){
        let url : NSURL = NSURL(string: "")
        let request : NSURLRequest = NSURLRequest(URL: url)

        func completionBlock(data: NSData!, response: NSURLResponse!, error: NSError!) -> Void {

        }

        var task : NSURLSessionDataTask = self.session.dataTaskWithRequest(request, completionHandler:completionBlock)
    }
}
