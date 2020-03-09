//
//  Schedules.swift
//  Assignment6
//
//  Created by Krishna Vikas on 3/8/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class Schedules {
    var arrivalTime: String!;
    var departureTime: String!;
    var scheduleID: Int! = 0;
    var lineID: Int!;
    var stops: [Stop]!
    init() {
        self.scheduleID = Int.random(in: 0 ..< 1000);
    }
}
