//
//  MMAboutUsViewController.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 16/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import UIKit
import Social

class MMAboutUsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    

    @IBOutlet var suggestion: UIButton!
    let socialLabNadImg = [("SocialIcon1","Facebook","http://www.facebook.com"),
        ("SocialIcon2","Twitter","http://www.twitter.com"),
        ("SocialIcon3","Google","http://www.google.com"),
        ("SocialIcon4","In","http://www.google.com")]

    override func viewDidLoad() {
        super.viewDidLoad()
        vdd()

    }
    
    
    // Mark: - viewDidLoad
    func vdd(){
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backButton
        tableView.delegate = self
        tableView.dataSource = self
        let backImage = UIImage(named: "simpleImage")
        self.title = "About Us"
        self.tableView.backgroundColor = UIColor.clearColor()
        self.view.backgroundColor = UIColor(patternImage: backImage!)
        self.suggestion.layer.borderWidth = 1.0
        self.suggestion.layer.borderColor = UIColor(netHex: 0xfa3562).CGColor
        self.suggestion.layer.cornerRadius = 3.0
    }
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return socialLabNadImg.count
    }
    
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MMAboutUsTableViewCell
        
        if(indexPath.item % 2 == 0){
            cell.backgroundColor = UIColor.clearColor()
        }else{
            cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
        }
        let (image,label,_) = socialLabNadImg[indexPath.row]
        cell.socailLabel.text = label
        cell.socialImage.image = UIImage(named: image)
        cell.socialImage.layer.cornerRadius = cell.socialImage.frame.size.width / 2
        cell.socialImage.clipsToBounds = true
        cell.socialImage.layer.borderWidth = 2.0
        cell.socialImage.layer.borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.2).CGColor
        
        
        return cell
    }

    
    
    
    
  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "social"){
            let vc = segue.destinationViewController as! MMSocialViewController
            if let indexPath : NSIndexPath = self.tableView.indexPathForSelectedRow!{
                let (_,_,socailUrl) = self.socialLabNadImg[indexPath.row]
                vc.social = socailUrl
                
            }
            
        }
    }

    
    
    
    // Mark: - Social Link Integration
    
    
    // Facebook integration
    @IBAction func facebook(sender: AnyObject) {
        //check if the facebok service is availble
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook)
        {
            //if the facebook service is available then find the VIEW
            let facebookSheet : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            // add constraints o the view
            facebookSheet.setInitialText("Chekc This Awesome App Download From App Store" )
            // represrent the view
            self.presentViewController(facebookSheet, animated: true, completion: nil)
            
        }else{
            let alert = UIAlertController(title: "Acounts", message: "Please log in to your acount in your settings ", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
        
    }
    
    // twitter integration
    @IBAction func twitter(sender: AnyObject) {
        
        //check if the twitter service is availble
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeTwitter)
        {
            //if the facebook service is available then find the VIEW
            let twitterSheet : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            // add constraints o the view
            twitterSheet.setInitialText("Chekc This Awesome App Download From App Store")
                        // represrent the view
            self.presentViewController(twitterSheet, animated: true, completion: nil)
            
        }else{
            // create an alert
            let alert = UIAlertController(title: "Acounts", message: "Please log in to your acount in your settings ", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
    
    }
}