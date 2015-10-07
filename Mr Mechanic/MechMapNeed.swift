//
//  MechMapNeed.swift
//  Mr Mechanic
//
//  Created by Ravi Ranjan on 07/10/15.
//  Copyright © 2015 Ravi Ranjan. All rights reserved.
//

import Foundation
class MechMapNeed {

    var name:String?
    var latt:Double?
    var long:Double?
    init(name:String,latt:Double,long:Double){
    
        self.name = name
        self.latt = latt
        self.long = long
    }
}