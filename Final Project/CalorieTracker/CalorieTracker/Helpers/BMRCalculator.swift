//
//  BMRCalculator.swift
//  CalorieTracker
//
//  Created by Krishna Vikas on 4/17/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import Foundation

class BMRCalculator {
    
     private init(){}
    
    static let shared = BMRCalculator()
    
    // Function to get a BMR daily calories intake, based on:
    // Weight, Height, Age, and Gender
    static func getBMR(weight:Double, height:Double, age:Int, gender: String)->Int{
        //Declare local variables
        var BMR = 0.0
        var weightCalculation = 0.0
        var heightCalculation = 0.0
        var ageCalculaition = 0.0
        
        //If Gender is Male, use the following formula: BMR=66.47+ (13.75 x W) + (5.0 x H) - (6.75 x A)
        if gender == "Male" {
            weightCalculation = 13.75 * toKilograms(weight: weight)
            heightCalculation = 5.0 * toCentimeters(height: height)
            ageCalculaition = 6.75 * Double(age)
            
            BMR = 66.47 + weightCalculation  + heightCalculation - ageCalculaition
            
            return Int(BMR)
        }
        //Else Gender is Female, use the following formula: BMR=665.09 + (9.56 x W) + (1.84 x H) - (4.67 x A)
        else{
            weightCalculation = 9.56 * toKilograms(weight: weight)
            heightCalculation = 1.84 * toCentimeters(height: height)
            ageCalculaition = 4.67 * Double(age)
            
            BMR =  665.09 + weightCalculation + heightCalculation - ageCalculaition
            
            return Int(BMR)
        }
    }
    
    //Formula to calculate remaining calories
    static func getRemaining(goal: Int, current: Int)->Int{
        var remaining = goal - current
        if remaining < 0 {
            remaining = 0
        }
        return remaining
    }
    
    // Function to convert from pounds to killograms
    private static func toKilograms(weight:Double)->Double{
        return weight/2.2
    }
    
    // Function to convert from inches into centemiters
    private static func toCentimeters(height:Double)->Double{
        return height*2.54
    }
    
     static func getTotalHeightInInches(heightInFeet:Int, heightInInches:Int)-> Double {
        return Double((heightInFeet * 12) + (heightInInches))
    }
    
}
