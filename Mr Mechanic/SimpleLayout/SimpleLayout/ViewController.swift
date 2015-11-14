//
//  ViewController.swift
//  SimpleLayout
//
//  Created by Ravi Ranjan on 23/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var simple: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
            animationsRight()
     
       
        
    }

    override func viewDidAppear(animated: Bool) {
        
        
    }
    
    func animations(){
        let rotate = CABasicAnimation(keyPath:"transform.rotation")
        rotate.byValue = -(M_PI*2)
        rotate.duration = 5.0
        rotate.timingFunction = CAMediaTimingFunction (name:kCAMediaTimingFunctionEaseInEaseOut)
        self.simple.layer.addAnimation(rotate, forKey: "myRotationAnimation")
        //
    }
    
    func animationsRight(){
        let rotate = CABasicAnimation(keyPath:"transform.rotation")
        rotate.byValue = (M_PI*2)
        rotate.duration = 5.0
        rotate.timingFunction = CAMediaTimingFunction (name:kCAMediaTimingFunctionEaseInEaseOut)
        self.simple.layer.addAnimation(rotate, forKey: "myRotationAnimation")
        
    }
    
    
    
    

}

