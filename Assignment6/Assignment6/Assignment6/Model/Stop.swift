//
//  Stop.swift
//  Assignment6
//
//  Created by Krishna Vikas on 3/8/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit
class Stop{

    var stopName: String!
    var location: String!
    var address: String!
    var stopID: Int!
    
init() {
       self.stopID = Int.random(in: 0 ..< 1000);
   }
}