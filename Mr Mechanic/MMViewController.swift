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
    
    // Mark: - Types
    var locationMgr:CLLocationManager!
    var longitude:Double?
    var lattitude:Double?
    var annotationTitle:String?
    var annotaionSubtitles:String?
    var place:MMOnlineModel?
    var dataReceived = [MMOnlineModel]()
    var subTitle:String?
    let tintColor:UIColor = UIColor(netHex: 0xfa3562)
    
    // Mrak: - Properties
    @IBOutlet var mapOutlet: MKMapView!
    @IBOutlet var feedback: UIButton!
    @IBOutlet var myLocation: UIButton!
    @IBOutlet var callButton: UIButton!
    @IBOutlet var direction: UIButton!
    
    // Mark: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mapImplementation()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "MMimage")!)
    
    }
   
    // Mark: - Map Implementation
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
        let geoCoder = CLGeocoder()
        let coordinate = newLocation.coordinate
        
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location){(placemarks, error) -> Void in
            
            if let validPlacemark = placemarks?.first{
                let placemark = validPlacemark
                let subLocality = placemark.subLocality
                let locality = placemark.locality
                let subAdmin = placemark.subAdministrativeArea
                let postalCode = placemark.postalCode
                
                let sub1 = subLocality! + ","
                let sub2 = locality! + ","
                let sub3 = subAdmin! + ","
                let sub4 = postalCode!
                self.subTitle = sub1 + sub2 + sub3 +  sub4
                
            }
       }
        
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
        pointAnnotation.title = "Your Location is:"
        pointAnnotation.subtitle = self.subTitle
        let pinAnnotaion = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: nil)
        pinAnnotaion.tintColor = self.tintColor
        self.mapOutlet.centerCoordinate = pointAnnotation.coordinate
        self.mapOutlet.addAnnotation(pinAnnotaion.annotation!)
    }
    

    // Mark: - Call button function
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
    
    // Mark: - Direction button function
    @IBAction func directionButtonsFunction(sender: AnyObject) {
        let la = place?.latt!
        let lo = place?.long!
        let str = "http://maps.apple.com/maps?daddr=" + String(la!) + "," + String(lo!)
        UIApplication.sharedApplication().openURL(NSURL(string: str)!)
    }
    
    // Mark: Getting The Rating
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
