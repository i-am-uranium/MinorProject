//
//  MMOfflineTableViewController.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 13/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import UIKit

class MMOfflineTableViewController: UITableViewController,UISearchBarDelegate {
    var offlineArray = [OfflineApi]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Offline Mode"
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "MMimage")!)
        jsonParsing()
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offlineArray.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! MMOfflineTableViewCell
        
        cell.name.text =  self.offlineArray[indexPath.row].name
        cell.address.text = self.offlineArray[indexPath.row].address
        cell.rating.text = String(self.offlineArray[indexPath.row].rating!)
        cell.phone.text = String(self.offlineArray[indexPath.row].phone!)
        return cell
    }
    
    
    
    // parsing offline json
    func jsonParsing(){
        // swifty json work
        
        if let path = NSBundle.mainBundle().pathForResource("res", ofType: "json") {
            do {
                let data = try NSData(contentsOfURL: NSURL(fileURLWithPath: path), options: NSDataReadingOptions.DataReadingMappedIfSafe)
                let jsonObj = JSON(data: data)
                if jsonObj != JSON.nullJSON {
                    print("jsonData:\(jsonObj)")
                    
                    let results = jsonObj["results"].array
                    if results != nil{
                        
                        print("array is printing")
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
                            let offlineObject = OfflineApi(name: name, phone: phone, latt: lat, long: long, rating: rating, address: address, local: local, city: city, country: country)
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
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //CODE TO BE RUN ON CELL TOUCH
        let alertController = UIAlertController(title: "Call " + offlineArray[(indexPath.row)].name! , message: "Are you sure you would like to call "  + offlineArray[(indexPath.row)].name!  + " ?", preferredStyle: UIAlertControllerStyle.Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default){
            UIAlertAction in
            //this how we can make call from the app
            let phoneNumber = "tel://"  + String(self.offlineArray[(indexPath.row)].phone)
        
            print(phoneNumber)
            let url : NSURL = NSURL(string: "tel://" + phoneNumber)!
            UIApplication.sharedApplication().openURL(url)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel){
            UIAlertAction in
        }
        alertController.addAction(okAction)
        alertController.addAction(cancel)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    // search bar implemtation
    @IBAction func searchTapped(sender: AnyObject) {
        let search = UISearchController(searchResultsController: nil)
        search.hidesNavigationBarDuringPresentation = false
        search.searchBar.delegate = self
        presentViewController(search, animated: true, completion: nil)
        
    }
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
        let string = searchBar.text
        print(string)
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
