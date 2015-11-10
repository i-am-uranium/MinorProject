//
//  Interface.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 21/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import Foundation
class Interface {

    var name:String?
    var phone:Int?
    var latt:Double?
    var long:Double?
    var address:String?
    
    
    
    func Interface (name:String,phone:Int,latt:Double,long:Double,address:String){
        self.name = name
        self.phone = phone
        self.latt = latt
        self.long = long
        self.address = address
        
    }
    
    func Interface () -> (String,Int,Double,Double,String){
        
        return (name!,phone!,latt!,long!,address!)
    }
}