//
//  Utilities.swift
//  CalorieTracker
//
//  Created by Krishna Vikas on 4/15/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleTextField(_ textfield:UITextField) {
        
        // Create the bottom line
        let bottomLine = CALayer()
        
        bottomLine.frame = CGRect(x: 0, y: textfield.frame.height - 2, width: textfield.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 237/255, green: 15/255, blue: 0/255, alpha: 1.0).cgColor
        
        // Remove border on text field
        textfield.borderStyle = .none
        
        // Add the line to the text field
        textfield.layer.addSublayer(bottomLine)
        
    }
    
    static func styleFilledButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor(red: 237/255, green: 15/255, blue: 0/255, alpha: 1.0)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
        button.titleLabel?.textColor = UIColor.white
    }
    
    static func styleLogoutButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor(red: 237/255, green: 15/255, blue: 0/255, alpha: 1.0)
        button.layer.cornerRadius = 10
        button.tintColor = UIColor.white
        button.titleLabel?.textColor = UIColor.white
    }
    
    static func styleDateButton(_ button:UIButton) {
        
        // Filled rounded corner style
        button.backgroundColor = UIColor(red: 237/255, green: 15/255, blue: 0/255, alpha: 1.0)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
        button.titleLabel?.textColor = UIColor.white
    }
    
    static func styleHollowButton(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
        button.titleLabel?.textColor = UIColor.black
    }
    
    static func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
