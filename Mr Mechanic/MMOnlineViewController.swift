//
//  MMOnlineViewController.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 17/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import UIKit
import MapKit

class MMOnlineViewController: UIViewController,UITableViewDelegate,CLLocationManagerDelegate {
    
    // Mark: - Types
    let MAX_DIS:Double = 20
    let NULL = 0
    let DIV:Double = 1000.0
    let MUL = 1000
    var lt:Double?
    var ln:Double?
    var locationMgr:CLLocationManager!
    var dataStoring = [MMOnlineModel]()
    var model:MMOnlineModel?
    var passingModel:MMOnlineModel?
    var timelineData:NSMutableArray = NSMutableArray()
    
    
    // Mark: - Properties
    
    @IBOutlet var actInd: UIActivityIndicatorView!
    @IBOutlet var tableview: UITableView!


    
    // Mark: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backButton = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backButton
        myLocationAction()
        actInd.startAnimating()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "MMimage")!)
        self.title = "Mr Mechanic"
        
    }
    
    override func viewDidAppear(animated: Bool) {
        loadData()
    }
    
  
    @IBAction func loadData(){
        timelineData.removeAllObjects()
        let findtimelineData:PFQuery = PFQuery(className:"res")
        findtimelineData.findObjectsInBackgroundWithBlock {
            (objects: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                if let objects = objects  {
                    for object in objects {
                        self.timelineData.addObject(object)
                        let fromLocation = CLLocation(latitude: self.lt!, longitude: self.ln!)
                        let toLat = object.objectForKey("lat") as? Double
                        let toLon = object.objectForKey("lon") as? Double
                        let toLocation = CLLocation(latitude: toLat! , longitude: toLon!)
                        let distance = fromLocation.distanceFromLocation(toLocation)
                        let approxDistance = distance / 1000.0
                        
                        if approxDistance < self.MAX_DIS {
                            // Mark: - Storing Data
                            let title = object.objectForKey("name") as? String
                            let subTitle = object.objectForKey("add") as? String
                            let latt = object.objectForKey("lat") as? Double
                            let long = object.objectForKey("lon") as? Double
                            let phone = object.objectForKey("ph") as? Int
                            let rating = object.objectForKey("rating") as? Float
                            let local = object.objectForKey("local") as? String
                            let city = object.objectForKey("city") as? String
                            let country = object.objectForKey("contry") as? String
                            self.model = MMOnlineModel(name: title!, phone: phone!, latt: latt!, long: long!, rating: rating!, address: subTitle!, local: local!, city: city!, country: country!)
                            self.dataStoring.append(self.model!)
                            
                        }else{
                        
                            self.actInd.stopAnimating()
                        }
                        
                    }
                }
                
                let array:NSArray = self.timelineData.reverseObjectEnumerator().allObjects
                self.timelineData = NSMutableArray(array:array)
                self.tableview.reloadData()
                
            } else {
                
                let alert  = UIAlertController(title: "Oops!", message: "data not available switch to Offline Mode OR hit retry", preferredStyle: UIAlertControllerStyle.Alert)
                let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel){
                    UIAlertAction in
                }
                alert.addAction(cancel)
                alert.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.Default){
                    UIAlertAction in
                    self.loadData()
                    
                    })
                self.presentViewController(alert, animated: true, completion: nil)
                print("Error: \(error!) \(error!.userInfo)")
            }
        }
        
    }
    
    
    
    // Mark: - My location
    
    func myLocationAction() {
        locationMgr = CLLocationManager()
        locationMgr?.delegate = self
        locationMgr?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationMgr.requestWhenInUseAuthorization()
        locationMgr.startUpdatingLocation()
        locationMgr.delegate = self
    }
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        let coordinate = newLocation.coordinate
        self.lt = coordinate.latitude
        self.ln = coordinate.longitude
        
    }
    
    
    
    // MARK: - Table view data source
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStoring.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MMOnlineTableViewCell
        
        // Mark: - Local Types
        let fromLocation = CLLocation(latitude: self.lt!, longitude: self.ln!)
        let toLat = self.dataStoring[indexPath.row].latt
        let toLon = self.dataStoring[indexPath.row].long
        let toLocation = CLLocation(latitude: toLat! , longitude: toLon!)
        let distance = fromLocation.distanceFromLocation(toLocation)
        let approxDistance = distance / DIV
        let name = dataStoring[indexPath.row].name
        let phone = dataStoring[(indexPath.row)].phone
        let rating = dataStoring[indexPath.row].rating
        
        // Mark: - Properties modification
        cell.name.text = name!
        cell.phoneNumber.text = String(phone!)
        cell.rating.text = String(rating!)
        cell.address.text = "distance From You is: " + String(format: "%.3f", approxDistance) + " Km"
        cell.phone.text = "Phone:"
        cell.star.image = UIImage(named: "star-40")
        actInd.stopAnimating()
        return cell
    }
    
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "map"{
            let place = segue.destinationViewController as! MMViewController
            let indexPath = self.tableview.indexPathForSelectedRow
            if dataStoring.count != 0{
                let name = dataStoring[indexPath!.row].name
                let phone = dataStoring[(indexPath?.row)!].phone
                let lat = dataStoring[indexPath!.row].latt
                let lon = dataStoring[(indexPath?.row)!].long
                let rating = dataStoring[indexPath!.row].rating
                let address = dataStoring[(indexPath?.row)!].address
                let local = dataStoring[indexPath!.row].local
                let city = dataStoring[indexPath!.row].city
                let country = dataStoring[(indexPath?.row)!].country
                let model = MMOnlineModel(name: name!, phone: phone!, latt: lat!, long: lon!, rating: rating!, address: address!, local: local!, city: city!, country: country!)
                place.place = model
            }else{
                print("Something went wrong")
            }
            
        }
        
    }
}



