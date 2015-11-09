//
//  User.swift
//  Greasemonkey
//
//  Created by david on 11/7/15.
//  Copyright © 2015 Greasemonkey. All rights reserved.
//

import Foundation

class User
{
    let name: String
    let number: Int
    let car: Car?
    
    init(name: String, number: Int, car: Car?)
    {
        self.name = name
        self.number = number
        self.car = car
    }
}