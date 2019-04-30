//
//  TweetCell.swift
//  Twitter
//
//  Created by Atef Kai Benothman on 4/29/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var tweetName: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var tweetScreenName: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favCount: UILabel!
    
    var favorited: Bool = false
    var tweetID: Int = -1
    var retweeted: Bool = false
    
    
    func setFavorite(isFavorated: Bool) {
        favorited = isFavorated
        if (favorited) {
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
            
        }
    }
    
    func setRetweet(isRetweeted: Bool) {

        retweeted = isRetweeted
        
        if (retweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2
        profilePicture.clipsToBounds = true
        
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    
    @IBAction func onFavButton(_ sender: Any) {
        
        let tobeFavorited = !favorited
        
        if (tobeFavorited) {
            TwitterAPICaller.client?.favoriteTweet(tweetID: tweetID, success: {
                
                self.setFavorite(isFavorated: true)
                
                if (!(self.favCount.text?.contains("k"))!) {
                    
                    self.favCount.textColor = UIColor(red: (229/255.0), green: (33/255.0), blue: (74/255.0), alpha: 1.0)
                    self.favCount.text = String((Int(self.favCount.text!)! + 1))
                    
                } else {
                    
                    self.favCount.textColor = UIColor(red: (229/255.0), green: (33/255.0), blue: (74/255.0), alpha: 1.0)
                    
                }
                
            }, failure: { (error) in
                print("Favorite did not succeed: \(error)")
            })
            
            
        } else {
            TwitterAPICaller.client?.destroyTweet(tweetID: tweetID, success: {
                
                self.setFavorite(isFavorated: false)
                
                if (!(self.favCount.text?.contains("k"))!) {
                    
                    if ((Int(self.favCount.text!)! - 1) >= 0) {
                        self.favCount.text = String((Int(self.favCount.text!)! - 1))
                    } else {
                        self.favCount.text = "0"
                    }
                    
                }
                
                self.favCount.textColor = UIColor(red: (170/255.0), green: (184/255.0), blue: (195/255.0), alpha: 1.0)
                
            }, failure: { (error) in
                print("Unfavorite did not succeed: \(error)")
            })
        
        }
        
        
    }
    
    
    
    @IBAction func onRetweetButton(_ sender: Any) {
        
        let tobeRetweeted = !retweeted
        
        if (tobeRetweeted) {
            
            TwitterAPICaller.client?.retweet(tweetID: tweetID, success: {
                
                self.setRetweet(isRetweeted: true)
                self.retweetCount.textColor = UIColor(red: (0/255.0), green: (207/255.0), blue: (130/255.0), alpha: 1.0)
                self.retweetCount.text = String(Int(self.retweetCount.text!)! + 1)
                
            }, failure: { (error) in
                print("Retweet did not succeed: \(error)")
            })
            
            
            
        } else {
            
            TwitterAPICaller.client?.unretweet(tweetID: tweetID, success: {
                
                self.setRetweet(isRetweeted: false)
                self.retweetCount.textColor = UIColor(red: (170/255.0), green: (184/255.0), blue: (195/255.0), alpha: 1.0)
                self.retweetCount.text = String(Int(self.retweetCount.text!)! - 1)
                
            }, failure: { (error) in
                print("Unretweet did not succeed: \(error)")
            })
            
            
            
        }
        
        
    }
    
    
}
