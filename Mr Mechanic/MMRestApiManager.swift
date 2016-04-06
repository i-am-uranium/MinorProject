//
//  RestApiManager.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 18/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import Foundation


class RestApiManager {
    
    // Mark: - Types
    
    var name = [String]()
    var phone = [Int]()
    var latt = [Double]()
    var long = [Double]()
    var rating = [Float]()
    var address = [String]()
    var local = [String]()
    var city = [String]()
    var country = [String]()
    
    // Mark: Fetch Json Data
    
    func fetchData(){
        let url = "https://itunes.apple.com/search?term=jack+johnson&limit=10"
        
        do {
            let data = try NSData(contentsOfURL: NSURL(string: url)!, options: NSDataReadingOptions.DataReadingMappedIfSafe)
            let jsonObj = JSON(data: data)
            if jsonObj != JSON.nullJSON {
                //print("jsonData:\(jsonObj)")
                
                let results = jsonObj["results"].array
                print(results)
                if results != nil{
                    for values in results!{
                        
                        self.name.append(values["collectionPrice"].stringValue)
                        self.phone.append(values["artistId"].intValue)
                        self.latt.append(values["artistId"].doubleValue)
                        self.long.append(values["artistId"].doubleValue)
                        self.rating.append(values["artistId"].floatValue)
                        self.address.append(values["kind"].stringValue)
                        self.local.append(values["kind"].stringValue)
                        self.city.append(values["kind"].stringValue)
                        self.country.append(values["kind"].stringValue)
                        
                    }
                }
                
            } else {
                print("could not get json from file, make sure that file contains valid json.")
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    // Mark: - Retrun count
    
    func arrayCount()->Int{
        if name.count == 0{
            return 0
        }
        return name.count
    }
    
    
    // Mark: - function that retruns array
    
    func returnFetchedData(indexPath:NSIndexPath)->(String,Int,Double,Double,Float,String,String,String,String){
        let name = self.name[indexPath.row]
        let phone = self.phone[indexPath.row]
        let lat = self.latt[indexPath.row]
        let long = self.long[indexPath.row]
        let rating = self.rating[indexPath.row]
        let address = self.address[indexPath.row]
        let local = self.local[indexPath.row]
        let city = self.city[indexPath.row]
        let country = self.country[indexPath.row]
        return (name,phone,lat,long,rating,address,local,city,country)
        
    }
    
}


