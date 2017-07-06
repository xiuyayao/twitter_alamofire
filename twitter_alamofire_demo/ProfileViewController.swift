//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Xiuya Yao on 7/6/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class ProfileViewController: UIViewController {
    
    // NEED TO ADD AUTOLAYOUT TO THIS
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var followingsCount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("it got to the profile view did load")

        nameLabel.text = User.current?.name
        screenNameLabel.text = User.current?.screenName
        
        followersCount.text = String(describing: User.current?.followersCount)
        followingsCount.text = String(describing: User.current?.followingsCount)
        
        // make profileImage circular
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        profileImage.layer.masksToBounds = true
        
        let profileImageUrl = URL(string: (User.current?.profileImageUrlString)!)
        profileImage.af_setImage(withURL: profileImageUrl!)
        
        APIManager.shared.userDetails(screen_name: User.current!.screenName, id: User.current!.id) { (user: User?, error: Error?) in
            let url = URL(string: user?.backgroundImageUrlString ?? "") // nil coalesence
            self.backgroundImage.af_setImage(withURL: url!)
        }
        
        // make an api call to the /users/show endpoint 
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
