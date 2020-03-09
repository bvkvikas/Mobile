//
//  Train.swift
//  Assignment6
//
//  Created by Krishna Vikas on 3/8/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//


import UIKit

class Train {
    var lineID: Int! = 0;
    var trainLineName : String!
    var source : String!
    var destination : String!
    var schedule: [Schedules]
    
    init(){
        self.lineID = Int.random(in: 0 ..< 1000);
        self.schedule = [Schedules()]
        }
}
