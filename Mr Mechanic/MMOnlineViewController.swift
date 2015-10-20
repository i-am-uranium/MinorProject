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
    
    @IBOutlet var actInd: UIActivityIndicatorView!
    let MAXDIS:Double = 20
    var lt:Double?
    var ln:Double?
    var locationMgr:CLLocationManager!
    var distanceInKm = [Double]()
    var dataPassing = [MMOnlineModel]()
    var dataStoring = [MMOnlineModel]()
    var model:MMOnlineModel?
    @IBOutlet var tableview: UITableView!
    var timelineData:NSMutableArray = NSMutableArray()
    var distance = [Double]()
    
    
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
    override func viewDidLayoutSubviews() {
        //
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
                        
                    }
                }
                
                let array:NSArray = self.timelineData.reverseObjectEnumerator().allObjects
                self.timelineData = NSMutableArray(array:array)
                self.tableview.reloadData()
                
            } else {
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
        return timelineData.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MMOnlineTableViewCell
        
        
        if self.dataStoring.count != 0 {
            
            
            // Mark: - distance
            
                let fromLocation = CLLocation(latitude: self.lt!, longitude: self.ln!)
                let toLat = self.dataStoring[indexPath.row].latt
                let toLon = self.dataStoring[indexPath.row].long
                let toLocation = CLLocation(latitude: toLat! , longitude: toLon!)
                print(fromLocation)
                print(toLocation)
                let distance = fromLocation.distanceFromLocation(toLocation)
                let approxDistance = distance / 1000.0
                self.distance.append(approxDistance)
                print(self.distance)
                print(approxDistance)
            
            
            if self.distance[indexPath.row] < 12427 {
            
                let test = self.dataStoring[indexPath.row].name
                cell.name.text = test!
                //cell.address.text = self.dataStoring[indexPath.row].address!
                cell.phoneNumber.text = String(self.dataStoring[indexPath.row].phone!)
                cell.rating.text = String(self.dataStoring[indexPath.row].rating!)
                cell.address.text = "distance From You is: " + String(format: "%.3f", approxDistance)
                cell.phone.text = "Phone:"
                cell.star.image = UIImage(named: "star-40")
                actInd.stopAnimating()
                return cell
                
            }
            else {
                actInd.stopAnimating()
                print("no near by  mechanic shop")
            }
            
           
        }else{
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
            
        }
        return cell
    }
    
    
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    

    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }



    // MARK: - Navigation
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "map"{
            let place = segue.destinationViewController as! MMViewController
            place.place = self.model
            
        }
    }
    
    
}
