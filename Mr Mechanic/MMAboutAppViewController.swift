//
//  MMAboutAppViewController.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 26/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import UIKit
import Social

class MMAboutAppViewController: UIViewController {
    
    var alert = AlertAndAnimation()
    @IBOutlet weak var facebook: UIButton!
    @IBOutlet weak var twitter: UIButton!
    @IBOutlet weak var suggestionButton: UIButton!
    @IBOutlet weak var aboutAppTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewEdit()
        
    }
    
    func viewEdit(){
        self.title = "Help"
        self.aboutAppTextView.layer.cornerRadius = 5.0
        //        self.aboutAppTextView.layer.borderColor = UIColor.grayColor().CGColor
        //        self.aboutAppTextView.layer.borderWidth = 0.25
        self.aboutAppTextView.backgroundColor = UIColor.clearColor()
        self.suggestionButton.layer.cornerRadius = 3.0
        self.suggestionButton.layer.borderWidth = 1.0
        self.suggestionButton.layer.borderColor = UIColor(netHex: 0x3F51B5).CGColor
    }
    
    override func viewDidAppear(animated: Bool) {
        alert.animateRight(facebook)
        alert.animateLeft(twitter)
    }
    
    //Mark: - Social Link Integration
    
    @IBAction func facebook(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook)
        {
            let facebookSheet : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText("Chekc This Awesome App Download From App Store" )
            self.presentViewController(facebookSheet, animated: true, completion: nil)
        }else{
            alert.alertView(title: "Accounts", message: "Please log in to your acount in your settings ", alertTitle: "Ok", view: self)
        }
    }
    
    @IBAction func twitter(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter)
        {
            let twitterSheet : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            twitterSheet.setInitialText("Chekc This Awesome App Download From App Store")
            self.presentViewController(twitterSheet, animated: true, completion: nil)
        }else{
            alert.alertView(title: "Accounts", message: "Please log in to your acount in your settings ", alertTitle: "Ok", view: self)
        }
    }
    
}
