//
//  DetailViewController.swift
//  Serch
//
//  Created by Ravi Ranjan on 19/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

/*
Abstract:
The detail view controller navigated to from our main and results table.
*/

import UIKit

class DetailViewController: UIViewController {
    // MARK: Types
    var product: Mechanic!
    // Constants for Storyboard/ViewControllers.
    static let storyboardName = "Main"
    static let viewControllerIdentifier = "DetailViewController"
    
    // Constants for state restoration.
    static let restoreProduct = "restoreProductKey"
    
    // MARK: Properties
    @IBOutlet weak var dView: UIView!{
        didSet{
            dView.layer.cornerRadius = 3.0
            dView.layer.shadowColor = UIColor.grayColor().CGColor
            dView.layer.shadowOffset = CGSize.zero
            dView.layer.shadowRadius = 4.0
            dView.layer.shadowOpacity = 0.5
        }
    }
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var callButton: UIButton!
    
    
    
    // MARK: Initialization
    
    class func detailViewControllerForProduct(product: Mechanic) -> DetailViewController {
        let storyboard = UIStoryboard(name: DetailViewController.storyboardName, bundle: nil)
        
        let viewController = storyboard.instantiateViewControllerWithIdentifier(DetailViewController.viewControllerIdentifier) as! DetailViewController
        
        viewController.product = product
        
        return viewController
    }
    
    // MARK: View Life Cycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        uiAppearence()
        
    }
    
    
    // MARK:- UIAppereance
    
    func uiAppearence(){
        self.view.backgroundColor = BACKGROUND_COLOR
        title = product.name.uppercaseString
        nameLabel.text = title
        addressTextView.text = product.address
        locationLabel.text = product.local
        cityLabel.text = product.city
        countryLabel.text = product.country
        self.callButton.setTitleColor(UIColor(netHex: 0x800080), forState:UIControlState.Selected)
        self.callButton.layer.borderWidth = 1.0
        self.callButton.layer.borderColor = UIColor(netHex: 0x008000).CGColor
        self.callButton.layer.cornerRadius = 3.0
        
        let RATING = product.rating
        
        if  RATING < 2.0{
            star1.hidden = true
            star2.hidden = true
            star3.hidden = true
            star4.hidden = true
        }else if RATING < 3.0{
            star2.hidden = true
            star3.hidden = true
            star4.hidden = true
            
        }else if RATING < 4.0{
            star3.hidden = true
            star4.hidden = true
            
        }else if RATING < 5.0{
            star4.hidden = true
        }else{
            
        }
    }
    
    
    
    
    // MARK: - Call button action
    
    @IBAction func callButtonsFunction(sender: AnyObject) {
        let name = product.name
        let phone = product.phone
        let alertController = UIAlertController(title: "Call " + name, message: "Are you sure you would like to call "  + name + " ?", preferredStyle: UIAlertControllerStyle.Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){
            UIAlertAction in
            let url : NSURL = NSURL(string: "tel://" + String(phone))!
            UIApplication.sharedApplication().openURL(url)
        }
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel){
            UIAlertAction in
        }
        alertController.addAction(okAction)
        alertController.addAction(cancel)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    // MARK: UIStateRestoration
    
    override func encodeRestorableStateWithCoder(coder: NSCoder) {
        super.encodeRestorableStateWithCoder(coder)
        
        // Encode the mechanicdata.
        coder.encodeObject(product, forKey: DetailViewController.restoreProduct)
    }
    
    override func decodeRestorableStateWithCoder(coder: NSCoder) {
        super.decodeRestorableStateWithCoder(coder)
        
        // Restore the mechanicdata.
        if let decodedProduct = coder.decodeObjectForKey(DetailViewController.restoreProduct) as? Mechanic {
            product = decodedProduct
        }
        else {
            fatalError("A mechanicdata did not exist. In your app, handle this gracefully.")
        }
    }
}
