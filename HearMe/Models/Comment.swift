//
//  Comment.swift
//  HearMe
//
//  Created by Zachary Nowak on 6/29/20.
//  Copyright © 2020 howdyprogrammer. All rights reserved.
//

import Foundation

class Comment {
    var userName: String
    var comment: String
    var timestamp : Double
    
    init (userName: String, comment: String, timestamp: Double) {
        self.userName = userName
        self.comment = comment
        self.timestamp = timestamp
    }
    
}
