//
//  Entry.swift
//  RSSSwift
//
//  Created by Muukii on 6/13/14.
//  Copyright (c) 2014 Muukii. All rights reserved.
//

import UIKit

class Entry: NSObject {
    var id : String!
    var title : String!
    var link : String!
    var url : String!
    var foo : String!
    init() {
        super.init()
        foo = "muukii"
    }

    func toString() {
        println(self.title)
        println(self.link)
        println(self.foo)
    }
}
