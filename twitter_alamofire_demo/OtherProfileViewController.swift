//
//  OtherProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Xiuya Yao on 7/6/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

class OtherProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
// , UIScrollViewDelegate
{
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var followingsCount: UILabel!

    var user: User!
    
    var tweets: [Tweet] = []
    
    var refreshControl: UIRefreshControl!
    
    // Create a flag
    var isMoreDataLoading = false
    // var loadingMoreView: InfiniteScrollActivityView?
    
    @IBOutlet weak var tableView: UITableView!
    
    /*
    func tweetCell(_ tweetCell: OtherTimelineCell, didTap user: User) {
        // Perform segue to profile view controller
        performSegue(withIdentifier: "viewOtherProfileSegue", sender: user)
    }
    */
    
    func refresh() {
        
        APIManager.shared.getUserTimeLine(with: user) {(tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                
                // for debugging
                print("Number of posts in feed: \(tweets.count)")
                
                // Stop the loading indicator
                // self.loadingMoreView?.stopAnimating()
                // Update flag
                self.isMoreDataLoading = false
                // Reload the tableView now that there is new data
                self.tableView.reloadData()
                
            } else if let error = error {
                print("Error getting home timeline: " + error.localizedDescription)
            }
        }
        self.refreshControl.endRefreshing()
    }
    
    
    func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        refresh()
        self.tableView.reloadData()
    }
    
    /*
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (!isMoreDataLoading) {
            // Calculate the position of one screen length before the bottom of the results
            let scrollViewContentHeight = tableView.contentSize.height
            let scrollOffsetThreshold = scrollViewContentHeight - tableView.bounds.size.height
            
            // When the user has scrolled past the threshold, start requesting
            if(scrollView.contentOffset.y > scrollOffsetThreshold && tableView.isDragging) {
                isMoreDataLoading = true
                
                // Update position of loadingMoreView, and start loading indicator
                let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
                loadingMoreView?.frame = frame
                loadingMoreView!.startAnimating()
                
                // FIX THIS!!!!! HOW TO LOAD MORE TWEETS FROM TIMELINE
                // Code to load more results
                APIManager.shared.getMoreUserTweets(with: Int(tweets.last!.id), completion: { (tweets: [Tweet]?, error: Error?) in
                    if let tweets = tweets {
                        print("successful loading more tweets")
                        
                        // Update flag
                        self.isMoreDataLoading = false
                        // Stop the loading indicator
                        self.loadingMoreView?.stopAnimating()
                        
                        if tweets.count == 1 {
                            
                        } else {
                            for tweet in tweets {
                                self.tweets.append(tweet)
                            }
                            // Reload the tableView now that there is new data
                            self.tableView.reloadData()
                        }
                        
                        // for debugging
                        print("Number of posts in feed: \(tweets.count)")
                        
                    } else if let error = error {
                        print("Error getting home timeline: " + error.localizedDescription)
                    }
                })
            }
        }
    }
    */

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
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets.zero
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        //        tableView.setNeedsLayout()
        //        tableView.layoutIfNeeded()
        
        refreshControl = UIRefreshControl()
        
        // If it had an event, who is it going to notify?
        refreshControl.addTarget(self, action: #selector(OtherProfileViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        /*
        // Set up Infinite Scroll loading indicator
        let frame = CGRect(x: 0, y: tableView.contentSize.height, width: tableView.bounds.size.width, height: InfiniteScrollActivityView.defaultHeight)
        loadingMoreView = InfiniteScrollActivityView(frame: frame)
        loadingMoreView!.isHidden = true
        tableView.addSubview(loadingMoreView!)
        
        var insets = tableView.contentInset
        insets.bottom += InfiniteScrollActivityView.defaultHeight
        tableView.contentInset = insets
        */
        
        refresh()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OtherTimelineCell", for: indexPath) as! OtherTimelineCell
        
        // set the tweet property of the cell to the current tweet
        cell.tweet = tweets[indexPath.row]
        // cell.delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // pass object through segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "composeSegue" {
            
            let destination = segue.destination as! ComposeViewController
            destination.delegate = self
            
        } else if segue.identifier == "detailSegue" {
            let cell = sender as! UserTimelineCell
            
            if let indexPath = tableView.indexPath(for: cell) {
                
                let tweet = tweets[indexPath.row]
                let detailsViewController = segue.destination as! DetailsViewController
                detailsViewController.tweet = tweet
            }
        } else if segue.identifier == "viewProfileSegue" {
            
            let user = sender as! User
            
            let otherProfileViewController = segue.destination as! OtherProfileViewController
            otherProfileViewController.user = user
        }
    }
    */
    
    
    class InfiniteScrollActivityView: UIView {
        var activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
        static let defaultHeight:CGFloat = 60.0
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupActivityIndicator()
        }
        
        override init(frame aRect: CGRect) {
            super.init(frame: aRect)
            setupActivityIndicator()
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            activityIndicatorView.center = CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
        }
        
        func setupActivityIndicator() {
            activityIndicatorView.activityIndicatorViewStyle = .gray
            activityIndicatorView.hidesWhenStopped = true
            self.addSubview(activityIndicatorView)
        }
        
        func stopAnimating() {
            self.activityIndicatorView.stopAnimating()
            self.isHidden = true
        }
        
        func startAnimating() {
            self.isHidden = false
            self.activityIndicatorView.startAnimating()
        }
    }
}
