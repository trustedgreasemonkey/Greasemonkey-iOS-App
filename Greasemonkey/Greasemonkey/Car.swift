//
//  Car.swift
//  Greasemonkey
//
//  Created by david on 11/7/15.
//  Copyright © 2015 Greasemonkey. All rights reserved.
//

import Foundation

class Car
{
    var make: String
    var model: String
    var year: String
    
    init(make: String, model: String, year: String)
    {
        self.make = make
        self.model = model
        self.year = year
    }
    
//    static func carsWithJSON(json: NSArray) -> [Car]
//    {
//        var cars = [Car]()
//        
//        for result in json
//        {
//            let make = result["value"] as? String
//            let model = result["models"] as? NSArray
//            
//        }
//        
//    }
}