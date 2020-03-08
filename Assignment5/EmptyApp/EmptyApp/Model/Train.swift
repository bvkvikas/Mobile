//
//  Train.swift
//  EmptyApp
//
//  Created by Krishna Vikas on 2/24/20.
//  Copyright © 2020 rab. All rights reserved.
//

import UIKit

class Train {
    var lineID: Int! = 0;
    var trainLineName : String!
    var schedule: [Schedules]
    
    init(){
        self.lineID = Int.random(in: 0 ..< 1000);
        self.schedule = [Schedules()]
        }
}
