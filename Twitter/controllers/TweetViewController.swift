//
//  TweetViewController.swift
//  Twitter
//
//  Created by Atef Kai Benothman on 4/30/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController {

    @IBOutlet weak var tweetButton: UIBarButtonItem!
    @IBOutlet weak var tweetTextBox: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tweetTextBox.becomeFirstResponder()
        
    }
    

    @IBAction func onCancelButton(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func onTweetButton(_ sender: Any) {
    
        if (!tweetTextBox.text.isEmpty) {
    TwitterAPICaller.client?.postTweet(tweetString: tweetTextBox.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("Error posting tweet \(error)")
                self.dismiss(animated: true, completion: nil)
            })
            
        } else {
            
            self.dismiss(animated: true, completion: nil)
            
        }
        
    }
    
}
