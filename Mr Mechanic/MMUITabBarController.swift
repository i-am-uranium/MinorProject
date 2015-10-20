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

        let view = UIView(frame:
            CGRect(x: 0.0, y: 0.0, width: UIScreen.mainScreen().bounds.size.width, height: 20.0)
        )
        view.backgroundColor = UIColor(netHex: 0x3F51B5)
        self.view.addSubview(view)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
