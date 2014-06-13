//
//  DetailViewController.swift
//  RSSSwift
//
//  Created by Muukii on 6/13/14.
//  Copyright (c) 2014 Muukii. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var webView : UIWebView

    var entry :Entry!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        var request : NSURLRequest = NSURLRequest(URL:NSURL(string: entry.url))
        self.webView.loadRequest(request)
    }

}
