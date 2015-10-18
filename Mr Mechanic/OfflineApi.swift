//
//  OfflineApi.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 13/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import Foundation


class OfflineApi{

    var name:String?
    var phone:Int?
    var latt:Double?
    var long:Double?
    var rating:Float?
    var address:String?
    var local:String?
    var city:String?
    var country:String?

    init(name:String,phone:Int,latt:Double,long:Double,rating:Float,address:String,local:String,city:String,country:String){
        
        
        self.name = name
        self.phone = phone
        self.latt = latt
        self.long = long
        self.rating = rating
        self.address = address
        self.local = local
        self.city = city
        self.country = country
    }
    

}
