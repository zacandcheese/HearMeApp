//
//  Post.swift
//  HearMe
//
//  Created by Zachary Nowak on 6/16/20.
//  Copyright © 2020 howdyprogrammer. All rights reserved.
//

import Foundation

class Post {
    var id: String
    var author:UserProfile
    var title: String
    var description: String
    var date: String
    var lat: Double
    var long: Double
    
    init(id: String, author: UserProfile, title: String, description: String, lat: Double, long: Double, date: String){
        self.id = id
        self.author = author
        self.title = title
        self.description = description
        self.date = date
        self.lat = lat
        self.long = long
    }
}
