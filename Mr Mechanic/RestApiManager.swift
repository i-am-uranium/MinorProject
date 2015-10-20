//
//  RestApiManager.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 18/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import Foundation


class RestApiManager {
    
    var name = [String]()
    var rating = [String]()
    var address = [String]()
    var latt = [Double]()
    var long = [Double]()
    var userReviews = [String]()
    
    let urlString = "http://www.niecdelhi.ac.in/api/events.php"
    
    func fetchItems (success:() -> ()){
        let url = NSURL(string: urlString)
        
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithURL(url!) {(data, response, error) in
            do {
                
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableContainers) as! NSArray
                
                self.name = json.valueForKeyPath("garage_name") as! [String]
                
                self.rating = json.valueForKey("rating") as! [String]
                
                self.address = json.valueForKey("address") as! [String]
                
                print(self.name + self.rating  + self.address)
                success()
                
            }catch{
                print(error)
                print( "Something went wrong!")
            }
        }
        task.resume()
    }
    
    func numberOfSections() -> Int {
        return 1
        
    }
    func numberOfItems(section:Int) ->Int{
        return name.count
    }
    
    func nameOfGarage(indexPath:NSIndexPath) ->String{
        return name[indexPath.row]
    }
    
    func rating(indexPath:NSIndexPath) ->String
    {
        return rating[indexPath.row]
    }
    func address(indexPath:NSIndexPath) ->String
    {
        return address[indexPath.row]
    }
    func lattitude(indexPath:NSIndexPath)->Double
    {
        return latt[indexPath.row]
    }
    func longitude(indexPath:NSIndexPath)->Double
    {
        return latt[indexPath.row]
    }
    func userReviews(indexPath:NSIndexPath) ->String
    {
        return userReviews[indexPath.row]
    }
    
    
}
