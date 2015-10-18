//
//  AppDelegate.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 07/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        Parse.setApplicationId("HEJmj368db3vjcSG4u2kGkgDkPZvohy7XNQXLOnX",
            clientKey: "fKyQg8bEXrdoOdsv58FV45QzAgqTagWBFtcA3rIU")
        
        
        
        
        
        //let navColor:UIColor = UIColor(netHex: 0x3F51B5)
       // let navColor = UIColor(patternImage: UIImage(named: "MMBar")!)
        
        let tintColor:UIColor = UIColor(netHex: 0x000000)
        let titleColor:UIColor = UIColor(netHex: 0x212121)
        let barTintColor:UIColor = UIColor(netHex: 0xfa3562)
        //UINavigationBar.appearance().backgroundColor = navColor
        UINavigationBar.appearance().tintColor = tintColor
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: titleColor]
//      UIBarButtonItem.appearance().tintColor = tintColor
//      UITabBar.appearance().backgroundColor = navColor  
//      let color = UIColor(red: 194/255, green: 0/255, blue: 4/255, alpha: 1.0)
            UITabBar.appearance().tintColor = barTintColor
        UILabel.appearance().textColor = tintColor
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

