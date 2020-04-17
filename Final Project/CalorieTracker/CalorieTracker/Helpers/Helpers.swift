//
//  Helpers.swift
//  CalorieTracker
//
//  Created by Krishna Vikas on 4/16/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import Foundation

enum TypeEnum
{
    case time
    case date
    case other
    case email
}

extension String {
    
    func isValidTime() -> Bool {
        let dateRegex = "^([0-1][0-9]|[2][0-3]):([0-5][0-9])$"
        let dateTest = NSPredicate(format: "SELF MATCHES %@",dateRegex)
        return dateTest.evaluate(with: self)
    }
    func isEmptyOrWhitespace() -> Bool {
        if(self.isEmpty) {
            return true
        }
        return (self.trimmingCharacters(in: NSCharacterSet.whitespaces) == "")
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func toDouble() -> Double {
        return NumberFormatter().number(from: self)!.doubleValue
    }

}

