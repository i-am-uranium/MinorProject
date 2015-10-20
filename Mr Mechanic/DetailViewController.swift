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
    
    // Constants for Storyboard/ViewControllers.
    static let storyboardName = "Main"
    static let viewControllerIdentifier = "DetailViewController"
    
    // Constants for state restoration.
    static let restoreProduct = "restoreProductKey"
    
    // MARK: Properties
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var countryLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var callButton: UIButton!
   
    
    
    var product: Mechanic!
    
    
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
    
    
    // Mrak:- UIAppereance
    
    func uiAppearence(){
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "MMimage")!)
        
        title = product.name
        nameLabel.text = title
        addressLabel.text = product.address
        locationLabel.text = product.local
        cityLabel.text = product.city
        countryLabel.text = product.country
        ratingLabel.text = String(product.rating)
        
        self.callButton.layer.borderWidth = 1.0
        self.callButton.layer.borderColor = UIColor(netHex: 0x008000).CGColor
        self.callButton.layer.cornerRadius = 3.0
    }
    
    
    
    
    // Mark: - Call button action
    
    
    @IBAction func callButtonsFunction(sender: AnyObject) {
        let name = product.name
        let phone = product.phone
        let alertController = UIAlertController(title: "Call " + name, message: "Are you sure you would like to call "  + name + " ?", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){
            UIAlertAction in
            //this how we can make call from the app
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
        
        // Encode the product.
        coder.encodeObject(product, forKey: DetailViewController.restoreProduct)
    }
    
    override func decodeRestorableStateWithCoder(coder: NSCoder) {
        super.decodeRestorableStateWithCoder(coder)
        
        // Restore the product.
        if let decodedProduct = coder.decodeObjectForKey(DetailViewController.restoreProduct) as? Mechanic {
            product = decodedProduct
        }
        else {
            fatalError("A mechanicProduct did not exist. In your app, handle this gracefully.")
        }
    }
}
