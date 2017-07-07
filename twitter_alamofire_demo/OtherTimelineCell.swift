//
//  OtherTimelineCell.swift
//  twitter_alamofire_demo
//
//  Created by Xiuya Yao on 7/7/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//


import UIKit
import AlamofireImage
import ActiveLabel

/*
protocol OtherTimelineCellDelegate: class {
    // Add required methods the delegate needs to implement
    func tweetCell(_ tweetCell: OtherTimelineCell, didTap user: User)
}
*/

class OtherTimelineCell: UITableViewCell {
    
    // weak var delegate: OtherTimelineCellDelegate?
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: ActiveLabel!
    
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
            
            // Update cell UI
            if tweet.retweetCount <= 0 {
                tweet.retweetCount = 0
                retweetLabel.text = "0"
            } else {
                retweetLabel.text = String(tweet.retweetCount)
            }
            
            // Send a POST request to the POST favorites/create endpoint
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                }
            }
            
        } else { // LIKE A TWEET
            
            retweetButton.isSelected = true
            
            // Update the local tweet model
            tweet.retweeted = true
            tweet.retweetCount += 1
            
            // Update cell UI
            if tweet.retweetCount <= 0 {
                tweet.retweetCount = 0
                retweetLabel.text = "0"
            } else {
                retweetLabel.text = String(tweet.retweetCount)
            }
            
            // Send a POST request to the POST favorites/create endpoint
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
            
            // Update cell UI
            if tweet.favoriteCount! <= 0 {
                tweet.favoriteCount = 0
                favesLabel.text = "0"
            } else {
                favesLabel.text = String(tweet.favoriteCount!)
            }
            
            // Send a POST request to the POST favorites/create endpoint
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
            
            // Update cell UI
            if tweet.favoriteCount! <= 0 {
                tweet.favoriteCount = 0
                favesLabel.text = "0"
            } else {
                favesLabel.text = String(tweet.favoriteCount!)
            }
            
            // Send a POST request to the POST favorites/create endpoint
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
            
            // tweetTextLabel.text = tweet.text
            
            tweetTextLabel.customize { label in
                label.text = tweet.text
                // label.text = "This is a post with #multiple #hashtags and a @userhandle."
                label.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1)
                label.hashtagColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
                label.mentionColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
                label.URLColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
                // label.handleMentionTap { self.alert("Mention", message: $0) }
                // label.handleHashtagTap { self.alert("Hashtag", message: $0) }
                // label.handleURLTap { self.alert("URL", message: $0.absoluteString) }
                
                // FIX THIS LINE OF CODE?? RUNS FINE BUT WARNINGS
                label.handleURLTap { url in UIApplication.shared.open(url) }
            }
            
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
            
            // make profileImage circular
            profileImage.layer.cornerRadius = profileImage.frame.width / 2
            profileImage.layer.masksToBounds = true
            
            let profileImageUrl = URL(string: tweet.user.profileImageUrlString)
            profileImage.af_setImage(withURL:  profileImageUrl!)
        }
    }
    
    func refreshData() {
        
    }
    
    /*
    func didTapUserProfile(_ sender: UITapGestureRecognizer) {
        // Call method on delegate
        delegate?.tweetCell(self, didTap: tweet.user)
    }
    */
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        /*
        let profileTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapUserProfile(_:)))
        profileImage.addGestureRecognizer(profileTapGestureRecognizer)
        profileImage.isUserInteractionEnabled = true
        */
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
