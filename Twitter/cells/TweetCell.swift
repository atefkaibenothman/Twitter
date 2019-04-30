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

}
