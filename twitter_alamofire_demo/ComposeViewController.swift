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
        
        let profileImageUrl = URL(string: (User.current?.profileImageUrlString)!)
        profileImage.af_setImage(withURL: profileImageUrl!)
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
