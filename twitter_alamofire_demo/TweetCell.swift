//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favesLabel: UILabel!
    
    @IBAction func replyAction(_ sender: UIButton) {
    }
    
    @IBAction func retweetAction(_ sender: UIButton) {
    }
    
    @IBAction func likeAction(_ sender: UIButton) {
    }
    
    @IBAction func messageAction(_ sender: UIButton) {
    }
    
    
    
    /*
    var id: Int64 // For favoriting, retweeting & replying
    var text: String // Text content of tweet
    var favoriteCount: Int? // Update favorite count label
    var favorited: Bool? // Configure favorite button
    var retweetCount: Int // Update favorite count label
    var retweeted: Bool // Configure retweet button
    var user: User // Contains name, screenname, etc. of tweet author
    var createdAtString: String // Display date
     
     id = dictionary["id"] as! Int64
     text = dictionary["text"] as! String
     favoriteCount = dictionary["favorite_count"] as? Int
     favorited = dictionary["favorited"] as? Bool
     retweetCount = dictionary["retweet_count"] as! Int
     retweeted = dictionary["retweeted"] as! Bool
     
     let user = dictionary["user"] as! [String: Any]
     self.user = User(dictionary: user)
     
     let createdAtOriginalString = dictionary["created_at"] as! String
     let formatter = DateFormatter()
     // Configure the input format to parse the date string
     formatter.dateFormat = "E MMM d HH:mm:ss Z y"
     // Convert String to Date
     let date = formatter.date(from: createdAtOriginalString)!
     // Configure output format
     formatter.dateStyle = .short
     formatter.timeStyle = .none
     // Convert Date to String
     createdAtString = formatter.string(from: date)
    */
    
    // MAKE MORE LABELS AND IMAGE VIEW OUTLETS
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            nameLabel.text = tweet.user.name
            screennameLabel.text = tweet.user.screenName
            timeLabel.text = tweet.createdAtString
            
            if tweet.retweetCount == 0 {
                retweetLabel.text = ""
            } else {
                retweetLabel.text = String(tweet.retweetCount)
            }
            
            if tweet.retweetCount == 0 {
                favesLabel.text = ""
            } else {
                favesLabel.text = String(tweet.favoriteCount!)
            }
            
            // profileImage: UIImageView!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
