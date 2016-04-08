//
//  MMSocialViewController.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 18/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import UIKit

class MMSocialViewController: UIViewController {
    @IBOutlet weak var socialWebView: UIWebView!
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    var social:String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vdl()
        
    }
    
    // Mark: - viewDidLoad
    
    func vdl(){
        let backImage = UIImage(named: "MMimage")
        self.view.backgroundColor = UIColor(patternImage: backImage!)
        self.title = "Social"
        let url = NSURL(string: social!)
        let request = NSURLRequest(URL: url!)
        socialWebView.backgroundColor = UIColor.clearColor()
        socialWebView.loadRequest(request)
        
    }
    
    func configureWebView() {
        socialWebView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.4)
        socialWebView.scalesPageToFit = true
        socialWebView.dataDetectorTypes = .All
    }
    
    
    func webViewDidStartLoad(_:UIWebView){
        actInd.startAnimating()
    }
    
    func webViewDidFinishLoad(_:UIWebView){
        actInd.stopAnimating()
        
        
    }
    
    
}
