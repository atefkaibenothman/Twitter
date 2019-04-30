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
            
        } else {
            TwitterAPICaller.client?.destroyTweet(tweetID: tweetID, success: {
                self.setFavorite(isFavorated: false)
            }, failure: { (error) in
                print("Unfavorite did not succed: \(error)")
            })
            
        }
        
        
    }
    
    @IBAction func onRetweetButton(_ sender: Any) {
        
    }
    
    
}
