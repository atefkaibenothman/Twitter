//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by Atef Kai Benothman on 4/29/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var tweetArray = [NSDictionary]()
    var numberOfTweet: Int!
    
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTweet()
        
        myRefreshControl.addTarget(self, action: #selector(loadTweet), for: .valueChanged)
        
        tableView.refreshControl = myRefreshControl
        
        tableView.estimatedRowHeight = 180
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadTweet()
    }
    
    
    @objc func loadTweet() {
        
        
        numberOfTweet = 10
        
        let myParams = ["count": numberOfTweet]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: Url.TwitterAPI.rawValue, parameters: myParams as [String : Any], success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            self.myRefreshControl.endRefreshing()
            
        }, failure: { (Error) in
            print("Could not retrieve tweets!")
        })
        
        
    }
    
    
    func loadMoreTweet() {
    
        numberOfTweet = numberOfTweet + 15
        
        let myParams = ["count": numberOfTweet]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: Url.TwitterAPI.rawValue, parameters: myParams as [String : Any], success: { (tweets: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            
            for tweet in tweets {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            
        }, failure: { (Error) in
            print("Could not retrieve tweets!")
        })
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row + 1 == tweetArray.count {
            loadMoreTweet()
        }
        
    }
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        UserDefaults.standard.set(false, forKey: "userLoggedIn")
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        let imageURL = URL(string: (user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageURL!)
        
        if let imageData = data {
            cell.profilePicture.image = UIImage(data: imageData)
        }
        
        
        cell.tweetScreenName.text = "@" + (user["screen_name"] as? String)!
        cell.tweetName.text = user["name"] as? String
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as? String
        
        cell.setFavorite(isFavorated: tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.setRetweet(isRetweeted: tweetArray[indexPath.row]["retweeted"] as! Bool)
        
//        if (tweetArray[indexPath.row]["favorited"] as! Bool == true) {
//
//            cell.favCount.textColor = UIColor(red: (229/255.0), green: (33/255.0), blue: (74/255.0), alpha: 1.0)
//
//        }
//
//        if (tweetArray[indexPath.row]["retweeted"] as! Bool == true) {
//
//            cell.retweetCount.textColor = UIColor(red: (0/255.0), green: (207/255.0), blue: (130/255.0), alpha: 1.0)
//
//        }
        
        cell.tweetID = tweetArray[indexPath.row]["id"] as! Int
        
        cell.retweetCount.text = "\(tweetArray[indexPath.row]["retweet_count"] ?? "")"
        
        cell.favCount.text = "\(tweetArray[indexPath.row]["favorite_count"] ?? "")"
        
        var favCount = Double(cell.favCount.text!)!
        
        if (favCount >= 5000.0) {
            
            favCount = round((favCount / 1000.0) * 10) / 10
            cell.favCount.text = String(favCount) + "k"
            
        }
        
        
        return cell
        
    }
    
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }

}
