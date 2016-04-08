//
//  MMSpareParts.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 07/04/16.
//  Copyright © 2016 Ravi Ranjan. All rights reserved.
//

import Foundation
class MMSpareParts:NSObject,NSCoding{
    // Mark:-Types
    
    enum CoderKeys:String{
        case nameKey
        case modelkeys
        case imagekeys
    }
    var name:String
    var models:String
    var image:String
    
    // MARK:-Initializers
    init(name:String,models:String,image:String){
        self.name = name
        self.models = models
        self.image = image
    }
    
    
    
    // MARK:-NSCoding
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey(CoderKeys.nameKey.rawValue) as! String
        models = aDecoder.decodeObjectForKey(CoderKeys.modelkeys.rawValue) as! String
        image = aDecoder.decodeObjectForKey(CoderKeys.imagekeys.rawValue) as! String
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: CoderKeys.nameKey.rawValue)
        
        
    }
}

