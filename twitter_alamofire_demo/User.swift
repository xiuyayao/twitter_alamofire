//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import Foundation

class User {
    
    static var current: User?
    
    var name: String
    var screenName: String
    var profileImageUrlString: String
    
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as! String
        screenName = "@" + (dictionary["screen_name"] as! String)
        profileImageUrlString = dictionary["profile_image_url_https"] as! String
        

    }
}
