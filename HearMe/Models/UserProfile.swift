//
//  UserProfile.swift
//  HearMe
//
//  Created by Zachary Nowak on 6/16/20.
//  Copyright © 2020 howdyprogrammer. All rights reserved.
//

import Foundation

class UserProfile {
    var uid:String
    var username:String
    
    init(uid:String, username:String) {
        self.uid = uid
        self.username = username
    }
}
