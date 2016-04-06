//
//  JONavigationViewController.swift
//  J-ONE
//
//  Created by Ravi Ranjan on 2/12/16.
//  Copyright © 2016 CodeWithRabbit. All rights reserved.
//

import UIKit

class MMNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        navigationController?.navigationBar.translucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor(),NSFontAttributeName:UIFont(name: "Snell Roundhand", size: 22)!]
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
}
