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
    var url : String!

    init() {
        super.init()

    }

    func toString() {
        println(self.title)
        println(self.url)
    }
}
