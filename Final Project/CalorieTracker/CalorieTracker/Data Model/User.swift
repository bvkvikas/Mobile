//
//  User.swift
//  CalorieTracker
//
//  Created by Krishna Vikas on 4/17/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import Foundation


protocol UserIdentifiable {
    var userID: String? { get set }
}

struct User: Codable, UserIdentifiable {
    var userID : String? = nil
    var firstName : String!
    var lastName : String!
    var emailID: String!
    var age: Double!
    var gender: String!
    var heightFeet: Int!
    var heightInches: Double!
    var totalCaloriesToConsume: Int!
    var weight: Double!
    
    init(firstName : String,lastName: String, emailID: String, age: Double, gender: String, heightFeet: Int, heightInches: Double, totalCaloriesToConsume: Int, weight: Double){
        self.firstName = firstName
        self.lastName = lastName
        self.emailID = emailID
        self.age = age
        self.gender = gender
        self.heightFeet = heightFeet
        self.heightInches = heightInches
        self.totalCaloriesToConsume = totalCaloriesToConsume
        self.weight = weight
    }
    
}
