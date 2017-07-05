//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favesLabel: UILabel!

    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    
    @IBAction func replyAction(_ sender: UIButton) {
        
    }
    
    @IBAction func retweetAction(_ sender: UIButton) {
        
        if retweetButton.isSelected { // UNRETWEET A TWEET
            
            retweetButton.isSelected = false
            
            // Update the local tweet model
            tweet.retweeted = false
            tweet.retweetCount -= 1
            
            // TODO: Update cell UI
            if tweet.retweetCount <= 0 {
                tweet.retweetCount = 0
                retweetLabel.text = "0"
            } else {
                retweetLabel.text = String(tweet.retweetCount)
            }
            
            // TODO: Send a POST request to the POST favorites/create endpoint
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
            
        } else { // LIKE A TWEET
            
            retweetButton.isSelected = true
            
            // Update the local tweet model
            tweet.retweeted = true
            tweet.retweetCount += 1
            
            // TODO: Update cell UI
            if tweet.retweetCount <= 0 {
                tweet.retweetCount = 0
                retweetLabel.text = "0"
            } else {
                retweetLabel.text = String(tweet.retweetCount)
            }
            
            // TODO: Send a POST request to the POST favorites/create endpoint
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
        }
    }
    
    @IBAction func likeAction(_ sender: UIButton) {
        
        if likeButton.isSelected { // UNLIKE A TWEET
            
            likeButton.isSelected = false
            
            // Update the local tweet model
            tweet.favorited = false
            tweet.favoriteCount! -= 1
            
            // TODO: Update cell UI
            if tweet.favoriteCount! <= 0 {
                tweet.favoriteCount = 0
                favesLabel.text = "0"
            } else {
                favesLabel.text = String(tweet.favoriteCount!)
            }
            
            // TODO: Send a POST request to the POST favorites/create endpoint
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }

        } else { // LIKE A TWEET
            
            likeButton.isSelected = true
            
            // Update the local tweet model
            tweet.favorited = true
            tweet.favoriteCount! += 1
            
            // TODO: Update cell UI
            if tweet.favoriteCount! <= 0 {
                tweet.favoriteCount = 0
                favesLabel.text = "0"
            } else {
                favesLabel.text = String(tweet.favoriteCount!)
            }
            
            // TODO: Send a POST request to the POST favorites/create endpoint
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
    }
    
    @IBAction func messageAction(_ sender: UIButton) {
    }
    
    
    var tweet: Tweet! {
        didSet {
            
            if tweet.retweeted {
                retweetButton.isSelected = true
            } else {
                retweetButton.isSelected = false
            }
            
            if tweet.favorited! {
                likeButton.isSelected = true
            } else {
                likeButton.isSelected = false
            }
            
            tweetTextLabel.text = tweet.text
            nameLabel.text = tweet.user.name
            screenNameLabel.text = tweet.user.screenName
            timeLabel.text = tweet.createdAtString
            
            if tweet.retweetCount == 0 {
                retweetLabel.text = "0"
            } else {
                retweetLabel.text = String(tweet.retweetCount)
            }
            
            if tweet.favoriteCount == 0 {
                favesLabel.text = "0"
            } else {
                favesLabel.text = String(tweet.favoriteCount!)
            }
            
            let profileImageUrl = URL(string: tweet.user.profileImageUrlString)
            profileImage.af_setImage(withURL:  profileImageUrl!)
        }
    }
    
    func refreshData() {
        
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
