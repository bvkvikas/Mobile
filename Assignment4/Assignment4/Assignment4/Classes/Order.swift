//
//  Order.swift
//  Assignment4
//
//  Created by Krishna Vikas on 2/15/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import Cocoa

class Order {
    var music : Music!;
    var customer : Customer!;
    var orderDate: String!;
    var orderPrice: Double!;
    var orderID: Int;
    init(){
        self.orderID = Int.random(in: 0 ..< 1000);
        
    }
}
