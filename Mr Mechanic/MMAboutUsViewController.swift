//
//  MMAboutUsViewController.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 16/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import UIKit

class MMAboutUsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet var tableView: UITableView!
    

    @IBOutlet var suggestion: UIButton!
    let socialImages = ["SocialIcon1","SocialIcon2","SocialIcon3","SocialIcon4"]
    let socialLabNadImg = [("SocialIcon1","Facebook"),("SocialIcon2","Google Plus"),("SocialIcon3","Twitter"),("SocialIcon1","in")]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let backImage = UIImage(named: "MMimage")
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
        
        return socialImages.count
    }
    
  
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MMAboutUsTableViewCell
        
        if(indexPath.item % 2 == 0){
            cell.backgroundColor = UIColor.clearColor()
        }else{
            cell.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.2)
        }
        let (image,label) = socialLabNadImg[indexPath.row]
        cell.socailLabel.text = label
        cell.socialImage.image = UIImage(named: image)
        cell.socialImage.layer.cornerRadius = cell.socialImage.frame.size.width / 2
        cell.socialImage.clipsToBounds = true
        cell.socialImage.layer.borderWidth = 2.0
        cell.socialImage.layer.borderColor = UIColor.whiteColor().colorWithAlphaComponent(0.2).CGColor
        
        
        return cell
    }

    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
