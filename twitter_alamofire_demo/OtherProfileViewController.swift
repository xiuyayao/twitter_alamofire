//
//  OtherProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Xiuya Yao on 7/6/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class OtherProfileViewController: UIViewController {
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var followingsCount: UILabel!


    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = user.name
        screenNameLabel.text = user.screenName
        
        followersCount.text = String(describing: user.followersCount)
        followingsCount.text = String(describing: user.followingsCount)
        
        // make profileImage circular
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.layer.masksToBounds = true
        
        // make an api call to the /users/show endpoint
        APIManager.shared.userDetails(screen_name: user.screenName, id: user.id) { (user: User?, error: Error?) in
            
            let url = URL(string: user?.backgroundImageUrlString ?? "") // nil coalesence
            self.backgroundImage.af_setImage(withURL: url!)
            
            let profileImageUrl = URL(string: user?.profileImageUrlString ?? "")
            self.profileImage.af_setImage(withURL: profileImageUrl!)
        }
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
