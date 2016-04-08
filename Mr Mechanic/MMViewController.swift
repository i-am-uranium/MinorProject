//
//  MMViewController.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 08/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//
import Foundation
import UIKit
import MapKit

class MMViewController: UIViewController,CLLocationManagerDelegate {
    
    // Mark: - Types
    let EXPONENTIAL_POWER:Double = 0.2
    var userRating:Float?
    var idString:String?
    var locationMgr:CLLocationManager!
    var longitude:Double?
    var lattitude:Double?
    var annotationTitle:String?
    var annotaionSubtitles:String?
    var place:MMOnlineModel?
    var dataReceived = [MMOnlineModel]()
    var subTitle:String?
    let tintColor:UIColor = UIColor(netHex: 0xfa3562)
    var animation = AlertAndAnimation()
    
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
        //        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "MMimage")!)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        animation.animateLeft(myLocation)
        animation.animateRight(feedback)
        animation.animateLeft(direction)
        animation.animateRight(callButton)
        
    }
    
    // Mark: - Map Implementation
    func mapImplementation(){
        locationMgr = CLLocationManager()
        locationMgr?.delegate = self
        locationMgr?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.title = place?.name!
        if place != nil{
            
            
            let location = CLLocationCoordinate2DMake((place?.latt!)!, (place?.long!)!)
            print(location)
            let span = MKCoordinateSpanMake(0.01, 0.01)
            let region = MKCoordinateRegionMake(location, span)
            self.mapOutlet.setRegion(region, animated: true)
            let annatotion = MKPointAnnotation()
            annatotion.coordinate = location
            annatotion.title = place?.name!
            annatotion.subtitle = place?.address!
            self.mapOutlet.addAnnotation(annatotion)
        }
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
                let subAdmin = placemark.administrativeArea
                let postalCode = placemark.postalCode
                
                if subLocality == nil || locality == nil || subAdmin == nil || postalCode == nil{
                    self.subTitle = " "
                }else{
                    let sub1 = subLocality! + ","
                    let sub2 = locality! + ","
                    let sub3 = subAdmin! + ","
                    let sub4 = postalCode!
                    self.subTitle = sub1 + sub2 + sub3 +  sub4
                }
                
            }
        }
        
        
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)
        pointAnnotation.title = "You're here"
        pointAnnotation.subtitle = self.subTitle
        let pinAnnotaion = MKPinAnnotationView(annotation: pointAnnotation, reuseIdentifier: nil)
        pinAnnotaion.tintColor = THEME_COLOR
        pinAnnotaion.backgroundColor = THEME_COLOR
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
    
    // Mark: Updating The Rating
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
            let reviewRating = Float(rating.text!)
            self.updatingRatings(reviewRating!)
            
        }))
        
        self.presentViewController(ratingAlertVIew, animated: true, completion: nil)
    }
    
    func updatingRatings(reviewRating:Float){
        
        let priviousRating = self.place!.rating
        print(priviousRating)
        if reviewRating < 10 {
            userRating = (reviewRating + priviousRating!) / 2
            self.updatingRatingToParse(userRating!)
            
        }
        else if reviewRating < 100 {
            self.userRating = (reviewRating + priviousRating!) / 20
            self.updatingRatingToParse(userRating!)
        }else{
            self.updatingRatingToParse(5.0)
            
        }
        
    }
    
    
    func updatingRatingToParse(rating:Float){
        
        let roundedRating = round(rating)
        let query = PFQuery(className:"res")
        query.getObjectInBackgroundWithId(self.idString!) {
            (object: PFObject?, error: NSError?) -> Void in
            if error != nil {
                print(error)
            } else if let ratObject = object {
                ratObject["rating"] = roundedRating
                ratObject.saveInBackground()
            }
        }
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
