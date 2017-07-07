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
    
    var id: NSNumber
    var name: String
    var screenName: String
    var followingsCount: Int
    var followersCount: Int
    var profileImageUrlString: String
    var backgroundImageUrlString: String?
    
    // For user persistance
    var dictionary: [String: Any]
    
    init(dictionary: [String: Any]) {
        
        // print(dictionary)
        
        id = dictionary["id"] as! NSNumber
        name = dictionary["name"] as! String
        screenName = "@" + (dictionary["screen_name"] as! String)
        followingsCount = dictionary["friends_count"] as! Int
        followersCount = dictionary["followers_count"] as! Int
        profileImageUrlString = dictionary["profile_image_url_https"] as! String
        
        if profileImageUrlString.contains(".jpg") {
            profileImageUrlString = String((profileImageUrlString.characters.dropLast(11))) + ".jpg"
        } else {
            profileImageUrlString = String((profileImageUrlString.characters.dropLast(12))) + ".jpeg"
        }
        
        
        
        if dictionary["profile_banner_url"] != nil {
            backgroundImageUrlString = dictionary["profile_banner_url"] as? String
        }
        self.dictionary = dictionary
    }
    
    private static var _current: User?
    
    static var current: User? {
        get {
            if _current == nil {
                let defaults = UserDefaults.standard
                if let userData = defaults.data(forKey: "currentUserData") {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! [String: Any]
                    _current = User(dictionary: dictionary)
                }
            }
            return _current
        }
        set (user) {
            _current = user
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
        }
    }
    
    // From the video
    /*
    class var currentUser: User? {
        get { // chunk of code that's run when someone tries to access this property
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? Data
                if let userData = userData {
                    let dictionary = try! JSONSerialization.data(withJSONObject: userData, options: []) as! Dictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            let defaults = UserDefaults.standard
            if let user = user {
                // try! block acknowledges that whatever comes after it can fail
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.setObject(user, forKey: "currentUserData")
            } else {
                defaults.setObject(nil, forKey: "currentUserData")
            }
            defaults.synchronize()
        }
    }
    */
}
