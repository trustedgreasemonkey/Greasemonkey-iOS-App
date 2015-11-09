//
//  Validator.swift
//  In-Due-Time
//
//  Created by david on 11/4/15.
//  Copyright © 2015 The Iron Yard. All rights reserved.
//

import Foundation

class Validator
{
    func isValidEmail(email: String) -> Bool
    {
        print("validate emilId: \(email)")
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let result = emailTest.evaluateWithObject(email)
        
        return result
    }
}