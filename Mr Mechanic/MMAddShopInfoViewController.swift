//
//  MMAddShopInfoViewController.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 07/04/16.
//  Copyright © 2016 Ravi Ranjan. All rights reserved.
//

import UIKit

class MMAddShopInfoViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func dismissSelf(){
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func cancelButtonPressed(){
        dismissSelf()
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
