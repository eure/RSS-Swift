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
                parser.delegate = self
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
    }

    // TableView DataSource
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int
    {
        return 1
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return self.entries.count
    }

    func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!
    {
        var cell : TableViewCell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as TableViewCell
        let entry : Entry! = entries.objectAtIndex(indexPath.row) as Entry
        cell.textLabel.text = entry.title
        cell.textLabel.font = UIFont.systemFontOfSize(12)
        cell.textLabel.numberOfLines = 0
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

    var parseKey : String!
    var tmpEntry : Entry!

    let entryKey = "entry"
    let titleKey = "title"
    let urlKey   = "url"

    func parserDidStartDocument(parser: NSXMLParser!)
    {
        println("parse start")
        entries = NSMutableArray()
    }

    func parser(parser: NSXMLParser!, didStartElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!, attributes attributeDict: NSDictionary!)
    {
        parseKey = nil
        if elementName == entryKey {
            tmpEntry = Entry()
            entries.addObject(tmpEntry)
        } else {
            parseKey = elementName
        }
    }

    func parser(parser: NSXMLParser!, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
    {
        parseKey = nil
    }

    func parser(parser: NSXMLParser!, foundCharacters string: String!)
    {
        if parseKey? == titleKey {
            if tmpEntry {
                var tmpString : String? = tmpEntry?.title
                tmpEntry.title = tmpString? ? tmpString! + string : string
            }
        } else if parseKey? == urlKey {
            tmpEntry.url = string
        }
    }

    func parserDidEndDocument(parser: NSXMLParser!)
    {
        self.tableView.reloadData()
    }
}

