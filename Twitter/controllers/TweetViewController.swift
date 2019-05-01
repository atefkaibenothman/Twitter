//
//  TweetViewController.swift
//  Twitter
//
//  Created by Atef Kai Benothman on 4/30/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetButton: UIBarButtonItem!
    @IBOutlet weak var tweetTextBox: UITextView!
    @IBOutlet weak var charCountLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tweetTextBox.delegate = self
        
        tweetTextBox.becomeFirstResponder()
        
    }
    
    func checkRemainingChar() {
        
        let charsinTextView = tweetTextBox.text.count
        
        let charsRemaining = 280 - charsinTextView
        
        charCountLabel.text = "\(String(charsRemaining)) / 280"
        
        if (charsRemaining <= 10) {
            
            charCountLabel.textColor = UIColor.red
            
        } else {
            
            charCountLabel.textColor = UIColor.white
            
        }
        
        if (charsRemaining < 0) {
            
            tweetButton.tintColor = UIColor(red: (229/255.0), green: (33/255.0), blue: (74/255.0), alpha: 1.0)
            
            tweetButton.isEnabled = false
            
        } else {
            
            tweetButton.isEnabled = true
            
        }
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        checkRemainingChar()
        
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
