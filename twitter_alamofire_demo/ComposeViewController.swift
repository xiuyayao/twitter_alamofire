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

class ComposeViewController: UIViewController, UITextViewDelegate {
    
    let postAlertController = UIAlertController(title: "Max Characters Reached", message: "Tweet CANNOT exceed 140 characters", preferredStyle: .alert)
    
    weak var delegate: ComposeViewControllerDelegate?
    
    @IBOutlet weak var newTweet: RSKPlaceholderTextView!
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var charCountLabel: UILabel!
    
    
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
    
    func textViewDidChange(_ newTweet: UITextView) {
        let text = newTweet.text!
        let remainingCount = 140 - text.characters.count
        let count = text.characters.count
        
        if count == 139
        {
            charCountLabel.text = "1 character remaining"
        } else if count <= 140 {
            charCountLabel.text = String(remainingCount) + " characters remaining"
        } else {
            charCountLabel.text = "0 characters remaining"
            self.present(self.postAlertController, animated: true)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newTweet.delegate = self
        
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
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }

        // add the OK action to the alert controller
        postAlertController.addAction(OKAction)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
