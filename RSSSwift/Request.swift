//
//  Request.swift
//  RSSSwift
//
//  Created by Muukii on 6/13/14.
//  Copyright (c) 2014 Muukii. All rights reserved.
//

import UIKit

class Request: NSObject {
    var session : NSURLSession?
    init()
    {
        super.init()
        let sessionConfiguration : NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        self.session = NSURLSession(configuration: sessionConfiguration)
    }

    class func foo() {

    }
    func foo(){
        var task : NSURLSessionDataTask = self.session.dataTaskWithHTTPGetRequest(nil, completionHandler: ((NSData!, NSURLResponse!, NSError!) -> Void)?{

        })
    }
}
