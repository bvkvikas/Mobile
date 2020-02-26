//
//  Schedules.swift
//  EmptyApp
//
//  Created by Krishna Vikas on 2/24/20.
//  Copyright © 2020 rab. All rights reserved.
//

import UIKit

class Schedules {
    var arrivalTime: String!;
    var departureTime: String!;
    var scheduleID: Int! = 0;
    var lineID: Int!;
    init() {
        self.scheduleID = Int.random(in: 0 ..< 1000);
    }
}
