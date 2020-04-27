//
//  Recipe.swift
//  CalorieTracker
//
//  Created by Krishna Vikas on 4/16/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import Foundation


protocol Identifiable {
    var itemID: String? { get set }
}

struct Items: Codable, Identifiable {
    var itemID : String? = nil
    var itemName : String!
    var carbs: Double!
    var protein: Double!
    var fats: Double!
    var fiber: Double!
    var totalCalories: Int!
    
    init(itemName : String, carbs: Double, protein: Double, fats: Double, fiber: Double,totalCalories: Int){
        self.itemName = itemName
        self.carbs = carbs
        self.protein = protein
        self.fats = fats
        self.fiber = fiber
        self.totalCalories = totalCalories
    }
    
}
