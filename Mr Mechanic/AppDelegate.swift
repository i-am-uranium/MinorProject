//
//  AppDelegate.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 07/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import UIKit

var reachability:Reachability?
var reachabilityStatus = " "

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var internetCheck:Reachability?
    var lt:Double?
    var ln:Double?
    var offlineArray = [Mechanic]()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        Parse.setApplicationId("HEJmj368db3vjcSG4u2kGkgDkPZvohy7XNQXLOnX",
            clientKey: "fKyQg8bEXrdoOdsv58FV45QzAgqTagWBFtcA3rIU")
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: kReachabilityChangedNotification, object: nil)
        internetCheck = Reachability.reachabilityForInternetConnection()
        internetCheck?.startNotifier()
        statusChangedWithRichability(internetCheck!)
        appearence()
        print(reachabilityStatus)
        // Mark: - Offline Implementation
        
        if let path = NSBundle.mainBundle().pathForResource("response", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.nullJSON {
                    // print("jsonData:\(jsonObj)")
                    
                    let results = jsonObj["results"].array
                    if results != nil{
                        
                        // print("array is printing")
                        for values in results!{
                            let name = values["name"].stringValue
                            let phone = values["ph"].intValue
                            let lat = values["lat"].doubleValue
                            let long = values["lon"].doubleValue
                            let rating = values["rating"].floatValue
                            let address = values["add"].stringValue
                            let local = values["local"].stringValue
                            let city = values["city"].stringValue
                            let country = values["contry"].stringValue
                            let offlineObject = Mechanic(name: name, phone: phone, latt: lat, long: long, rating: rating, address: address, local: local, city: city, country: country)
                            offlineArray.append(offlineObject)
                            
                        }
                    }
                    
                } else {
                    print("could not get json from file, make sure that file contains valid json.")
                }
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        
        let tabController = window!.rootViewController as! UITabBarController
        tabController.selectedIndex = 2
        let navController = tabController.viewControllers!.first as! UINavigationController
        let tableViewController = navController.viewControllers.first as! MainTableViewController
        tableViewController.mechanic = offlineArray
        return true
    }
    
    func reachabilityChanged(notification:NSNotification){
        reachability = notification.object as? Reachability
        statusChangedWithRichability(reachability!)
    }
    func statusChangedWithRichability(currentReachabilityStatus:Reachability){
        let networkStatus:NetworkStatus = currentReachabilityStatus.currentReachabilityStatus()
        switch networkStatus.rawValue{
        case NotReachable.rawValue:reachabilityStatus = NOACCESS
        case ReachableViaWiFi.rawValue:reachabilityStatus = WIFI
        case ReachableViaWWAN.rawValue:reachabilityStatus = WWAN
        default:return
        }
        NSNotificationCenter.defaultCenter().postNotificationName("ReachStatusChanged", object: nil)
    }
    
    
    func appearence(){
        let navigationBarAppearence = UINavigationBar.appearance()
        navigationBarAppearence.barTintColor = THEME_COLOR
        navigationBarAppearence.tintColor = UIColor.whiteColor()
        navigationBarAppearence.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]
        UITabBar.appearance().tintColor = THEME_COLOR
        //        UITabBar.appearance().barTintColor = THEME_COLOR
    }
    
    
    
    
    
    
    func applicationWillResignActive(application: UIApplication) {
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
    }
    
    func applicationWillTerminate(application: UIApplication) {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kReachabilityChangedNotification, object: nil)
        //        self.saveContext()
    }
    
    
    func application(application: UIApplication, shouldSaveApplicationState coder: NSCoder) -> Bool {
        return true
    }
    
    func application(application: UIApplication, shouldRestoreApplicationState coder: NSCoder) -> Bool {
        return true
    }
    func application(application: UIApplication, willFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        return true
    }
    
    
    
}

