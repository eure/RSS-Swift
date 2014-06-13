//
//  ViewController.swift
//  RSSSwift
//
//  Created by Muukii on 6/13/14.
//  Copyright (c) 2014 Muukii. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate {
                            
    @IBOutlet var tableView : UITableView

    var entries : NSMutableArray!
    var rssUrl : NSURL!
    {
    didSet{
        let request : NSURLRequest = NSURLRequest(URL:self.rssUrl)
        func completionBlock(data: NSData!, response: NSURLResponse!, error: NSError!) -> Void {
            var parser : NSXMLParser = NSXMLParser(data: data)
            parser.delegate = self;
            parser.parse()
        }
        var task : NSURLSessionDataTask = NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler:completionBlock)
        task.resume()
    }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        entries = NSMutableArray()

        let url : NSURL = NSURL(string: "http://qiita.com/tags/Swift/feed.atom")
        self.rssUrl = url
               // Do any additional setup after loading the view, typically from a nib.
    }

    // TableView DataSource
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1;
    }
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return self.entries.count;
    }

    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        var cell : TableViewCell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as TableViewCell
        let entry : Entry! = entries.objectAtIndex(indexPath.row) as Entry
        cell.textLabel.text = entry.title
        return cell
    }

    func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!)
    {
        var controller : DetailViewController = self.storyboard.instantiateViewControllerWithIdentifier("DetailViewController")
         as DetailViewController
        var entry : Entry! = entries.objectAtIndex(indexPath.row) as Entry
        controller.entry = entry
        self.navigationController.pushViewController(controller, animated: true)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    // NSXMLParserDelegate

    var entryFlag : Bool = false
    var titleFlag : Bool = false
    var urlFlag : Bool = false
    var currentEntry : Entry!

    let entryKey = "entry"
    let titleKey = "title"
    let urlKey   = "url"

    func parserDidStartDocument(parser: NSXMLParser!)
    {
        println("Parse Start")
    }
    
    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: NSDictionary!)
    {
        if elementName == entryKey {
            entryFlag = true
            currentEntry = Entry()
        } else if elementName == titleKey {
            titleFlag = true
        } else if elementName == urlKey {
            urlFlag = true
        }
    }

    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
    {
        if elementName == entryKey {
            entryFlag = false
            entries.addObject(currentEntry)
        } else if elementName == titleKey {
            titleFlag = false
        } else if elementName == urlKey {
            urlFlag = false
        }
    }

    func parser(parser: NSXMLParser!, foundCharacters string: String!)
    {
        if entryFlag {
            if titleFlag {
                var tmpString : String? = currentEntry.title;
                currentEntry.title = tmpString? ? tmpString! + string : string
            } else if urlFlag {
                currentEntry.url = string
            }
        }
    }

    func parserDidEndDocument(parser: NSXMLParser!)
    {
        println("Parse End　\(self.entries)")
        self.tableView.reloadData()
    }
}

