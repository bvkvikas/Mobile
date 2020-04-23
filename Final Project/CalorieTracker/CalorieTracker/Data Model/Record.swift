//
//  Record.swift
//  CalorieTracker
//
//  Created by Krishna Vikas on 4/21/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import Foundation

protocol RecordIdentifiable {
    var recordID: Date? { get set }
}

struct Record: Codable, RecordIdentifiable {
    var recordID: Date?
    var breakfast : [Items]?
    var lunch : [Items]?
    var dinner : [Items]?
    var totalCaloriesForTheDate: Int?
    
    init(recordID: Date,breakfast : [Items], lunch: [Items], dinner: [Items], totalCaloriesForTheDate: Int){
        self.recordID = recordID
        self.breakfast = breakfast
        self.lunch = lunch
        self.dinner = dinner
        self.totalCaloriesForTheDate = totalCaloriesForTheDate
    }
    
}
