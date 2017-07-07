//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Xiuya Yao on 7/5/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage
import RSKPlaceholderTextView

protocol ComposeViewControllerDelegate: class {
    func did(post: Tweet)
}

class ComposeViewController: UIViewController {
    
    weak var delegate: ComposeViewControllerDelegate?
    
    @IBOutlet weak var newTweet: RSKPlaceholderTextView!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    
    @IBAction func didTapPost(_ sender: UIButton) {
        APIManager.shared.composeTweet(with: newTweet.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            }
        }
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func didTapCancel(_ sender: UIButton) {
        view.endEditing(true)
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLabel.text = User.current?.name
        screenNameLabel.text = User.current?.screenName
        
        // make profileImage circular
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.layer.masksToBounds = true
        
        // make an api call to the /users/show endpoint
        APIManager.shared.userDetails(screen_name: User.current!.screenName, id: User.current!.id) { (user: User?, error: Error?) in
            
            let profileImageUrl = URL(string: user?.profileImageUrlString ?? "")
            self.profileImage.af_setImage(withURL: profileImageUrl!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
