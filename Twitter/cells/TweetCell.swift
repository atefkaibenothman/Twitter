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
    
    
    func setFavorite(isFavorated:Bool) {
        favorited = isFavorated
        if (favorited) {
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else {
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
            
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
            }, failure: { (error) in
                print("Favorite did not succeed: \(error)")
            })

            
            if (!(favCount.text?.contains("k"))!) {
                
                favCount.textColor = UIColor(red: (229/255.0), green: (33/255.0), blue: (74/255.0), alpha: 1.0)
                favCount.text = String((Int(favCount.text!)! + 1))
                
            } else {
                
                favCount.textColor = UIColor(red: (229/255.0), green: (33/255.0), blue: (74/255.0), alpha: 1.0)
                
            }
            
            
            
        } else {
            TwitterAPICaller.client?.destroyTweet(tweetID: tweetID, success: {
                self.setFavorite(isFavorated: false)
            }, failure: { (error) in
                print("Unfavorite did not succeed: \(error)")
            })
            
            if (!(favCount.text?.contains("k"))!) {
                
                if ((Int(favCount.text!)! - 1) >= 0) {
                    favCount.text = String((Int(favCount.text!)! - 1))
                } else {
                    favCount.text = "0"
                }
                
                
            }
            
            favCount.textColor = UIColor(red: (170/255.0), green: (184/255.0), blue: (195/255.0), alpha: 1.0)
            
        }
        
        
    }
    
    @IBAction func onRetweetButton(_ sender: Any) {
        
    }
    
    
}
