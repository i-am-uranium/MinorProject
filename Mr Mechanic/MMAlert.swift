//
//  MMAlert.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 26/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import Foundation

class AlertAndAnimation{
    
    
    // MARK: - UIAlertView presentation
    
    func alertView(title title:String,message:String,alertTitle:String,view:UIViewController){
        if title.isEmpty{
            return
        }else{
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: alertTitle, style: UIAlertActionStyle.Default, handler: nil))
            view.presentViewController(alert, animated: true, completion: nil)}
    }
    
    func alertView(title title:String,message:String,alertTitle:String,view:UITableViewController){
        
        if title.isEmpty{
            return
        }else{
            let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: alertTitle, style: UIAlertActionStyle.Default, handler: nil))
            view.presentViewController(alert, animated: true, completion: nil)}
    }
    
    
    // MARK: - Button aniamtions
    
    func animateLeft(button:UIButton){
        let rotate = CABasicAnimation(keyPath:"transform.rotation")
        rotate.byValue = -(M_PI*2)
        rotate.duration = 3.0
        rotate.timingFunction = CAMediaTimingFunction (name:kCAMediaTimingFunctionEaseInEaseOut)
        button.layer.addAnimation(rotate, forKey: "myRotationAnimation")
        
    }
    func animateRight(button:UIButton){
        let rotate = CABasicAnimation(keyPath:"transform.rotation")
        rotate.byValue = (M_PI*2)
        rotate.duration = 3.0
        rotate.timingFunction = CAMediaTimingFunction (name:kCAMediaTimingFunctionEaseInEaseOut)
        button.layer.addAnimation(rotate, forKey: "myRotationAnimation")
    }
    
    // MARK: - TextField animation
    func textFieldAnimation(text:UILabel){
    text.alpha = 1.0
    }
}