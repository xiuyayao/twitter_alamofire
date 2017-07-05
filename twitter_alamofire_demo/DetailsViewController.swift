//
//  DetailsViewController.swift
//  twitter_alamofire_demo
//
//  Created by Xiuya Yao on 7/3/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var favesLabel: UILabel!
    
    
    var tweet: Tweet! 

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
