//
//  Urls.swift
//  Twitter
//
//  Created by Atef Kai Benothman on 4/29/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import Foundation

enum Url: String {
    
    case TwitterAPI = "https://api.twitter.com/1.1/statuses/home_timeline.json"
    case TwitterPostAPI = "https://api.twitter.com/1.1/statuses/update.json"
    case TwitterFavButton = "https://api.twitter.com/1.1/favorites/create.json"
    case TwitterDestroyButton = "https://api.twitter.com/1.1/favorites/destroy.json"
    case TwitterRetweetButton = "https://api.twitter.com/1.1/statuses/retweets/:id.json"
    case TwitterUnRetweetButton = "https://api.twitter.com/1.1/statuses/unretweet/:id.json"
    
}
