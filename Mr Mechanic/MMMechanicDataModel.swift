//  Created by Ravi Ranjan on 13/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

/* 
Abstract:
The data model object describing the product displayed in both main and results tables.
*/


import Foundation


class Mechanic:NSObject,NSCoding{
    // MARK: Types
    
    enum CoderKeys: String {
        case nameKey
        case phKey
        case latKey
        case lonKey
        case ratingKey
        case addressKey
        case localKey
        case cityKey
        case countryKey
    }
    
    
    // MARK: Properties
    
    var name:String
    var phone:Int
    var latt:Double
    var long:Double
    var rating:Float
    var address:String
    var local:String
    var city:String
    var country:String
    
    
    
    // MARK: Initializers
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
    
    
    
    
    // MARK: NSCoding
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey(CoderKeys.nameKey.rawValue) as! String
        phone = aDecoder.decodeObjectForKey(CoderKeys.phKey.rawValue) as! Int
        latt = aDecoder.decodeDoubleForKey(CoderKeys.latKey.rawValue)
        long = aDecoder.decodeDoubleForKey(CoderKeys.lonKey.rawValue)
        rating = aDecoder.decodeFloatForKey(CoderKeys.ratingKey.rawValue)
        address = aDecoder.decodeObjectForKey(CoderKeys.addressKey.rawValue) as! String
        local = aDecoder.decodeObjectForKey(CoderKeys.localKey.rawValue) as! String
        city = aDecoder.decodeObjectForKey(CoderKeys.cityKey.rawValue) as! String
        country = aDecoder.decodeObjectForKey(CoderKeys.countryKey.rawValue) as! String
        
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: CoderKeys.nameKey.rawValue)
        aCoder.encodeInteger(phone, forKey: CoderKeys.phKey.rawValue)
        aCoder.encodeDouble(latt, forKey: CoderKeys.latKey.rawValue)
        aCoder.encodeDouble(long, forKey: CoderKeys.lonKey.rawValue)
        aCoder.encodeFloat(rating, forKey: CoderKeys.ratingKey.rawValue)
        aCoder.encodeObject(address, forKey: CoderKeys.nameKey.rawValue)
        aCoder.encodeObject(local, forKey: CoderKeys.nameKey.rawValue)
        aCoder.encodeObject(city, forKey: CoderKeys.nameKey.rawValue)
        aCoder.encodeObject(country, forKey: CoderKeys.nameKey.rawValue)
        
    }
    
    
    
    
    
}
