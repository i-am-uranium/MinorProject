//
//  MMViewController.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 08/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import UIKit
import MapKit

class MMViewController: UIViewController,CLLocationManagerDelegate {
    var longitude:Double?
    var lattitude:Double?
    var annotationTitle:String?
    var annotaionSubtitles:String?
    var place:MMOnlineModel?
    
    
    @IBOutlet var rectangle: UIImageView!
    @IBOutlet var mapOutlet: MKMapView!
    var locationMgr:CLLocationManager!
    @IBOutlet var feedback: UIButton!
    @IBOutlet var myLocation: UIButton!
    @IBOutlet var callButton: UIButton!
    @IBOutlet var direction: UIButton!
    var nameField = [String]?()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapImplementation()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "MMimage")!)
        
       
        
    }

    func mapImplementation(){

            locationMgr = CLLocationManager()
            locationMgr?.delegate = self
            locationMgr?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.title = place?.name!
            let location = CLLocationCoordinate2DMake((place?.latt!)!, (place?.long!)!)
            let span = MKCoordinateSpanMake(0.01, 0.01)
            let region = MKCoordinateRegionMake(location, span)
            self.mapOutlet.setRegion(region, animated: true)
            let annatotion = MKPointAnnotation()
            annatotion.coordinate = location
            annatotion.title = place?.name!
            annatotion.subtitle = place?.address!
            self.mapOutlet.addAnnotation(annatotion)
            
    
    }
    
    @IBAction func myLocationAction(sender: AnyObject) {
        locationMgr.requestWhenInUseAuthorization()
        locationMgr.startUpdatingLocation()
        locationMgr.delegate = self
    }
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        let coordinate = newLocation.coordinate
        let pointAnnotation = MKPointAnnotation()
        
        
        let fromLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let toLocation = CLLocation(latitude: (place?.latt!)! , longitude: (place?.long!)!)
        
        let distance = fromLocation.distanceFromLocation(toLocation)
        let approxDistance = distance / 1000.0
        print(approxDistance)
        
        
        
        
        
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
        let pinAnnotaion = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: nil)
        self.mapOutlet.centerCoordinate = pointAnnotation.coordinate
        self.mapOutlet.addAnnotation(pinAnnotaion.annotation!)
    }
    
    
    
    
    // call button function
    
    @IBAction func callButtonsFunction(sender: AnyObject) {
        let alertController = UIAlertController(title: "Call " + (place?.name!)!, message: "Are you sure you would like to call "  + (place?.name!)! + " ?", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){
            UIAlertAction in
            //this how we can make call from the app
            let url : NSURL = NSURL(string: "tel://" + String(self.place?.phone))!
            UIApplication.sharedApplication().openURL(url)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel){
            UIAlertAction in
        }
        alertController.addAction(okAction)
        alertController.addAction(cancel)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    // direction button function
    @IBAction func directionButtonsFunction(sender: AnyObject) {
        let la = place?.latt!
        let lo = place?.long!
        let str = "http://maps.apple.com/maps?daddr=" + String(la!) + "," + String(lo!)
        UIApplication.sharedApplication().openURL(NSURL(string: str)!)
    }
    
    
    // to get the rating from the user
   @IBAction func rating(){
        let ratingAlertVIew = UIAlertController(title: "Rate it!", message: "You can give the rating based on your experience", preferredStyle: UIAlertControllerStyle.Alert)
        ratingAlertVIew.addTextFieldWithConfigurationHandler({
            textField in
            textField.placeholder = "Your Rating"
            textField.keyboardType = UIKeyboardType.DecimalPad
            
        })
        ratingAlertVIew.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        ratingAlertVIew.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: {
        alertAction in
            let rate:NSArray = NSArray(array: ratingAlertVIew.textFields!)
            let rating = rate.objectAtIndex(0) as! UITextField
            let str = rating.text
            print(str!)
            
        }))
    
        self.presentViewController(ratingAlertVIew, animated: true, completion: nil)
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
