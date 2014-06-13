//
//  ViewController.swift
//  RSSSwift
//
//  Created by Muukii on 6/13/14.
//  Copyright (c) 2014 Muukii. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
                            
    @IBOutlet var tableView : UITableView
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url : NSURL = NSURL(string: "http://api.dribbble.com/shots/everyone")
        let request : NSURLRequest = NSURLRequest(URL: url)

        func completionBlock(data: NSData!, response: NSURLResponse!, error: NSError!) -> Void {

        }

        var task : NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler:completionBlock)

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // TableView DataSource
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1;
    }
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return 100;
    }

    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        var cell : TableViewCell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as TableViewCell
        return cell
    }

}

