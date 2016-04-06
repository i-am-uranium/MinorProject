//
//  MMUITabBarController.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 16/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import UIKit

class MMUITabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layer.borderWidth = 1.0
        self.view.layer.borderColor = UIColor(netHex: 0x3F51B5).CGColor
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
