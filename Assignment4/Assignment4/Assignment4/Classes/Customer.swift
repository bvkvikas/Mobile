//
//  Customer.swift
//  Assignment4
//
//  Created by Krishna Vikas on 2/13/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import Cocoa

class Customer {
    var customerName, customerEmail :  String;
    var customerID: Int;
    init(customerName : String , customerEmail:String){
        self.customerEmail=customerEmail;
        self.customerName=customerName;
        self.customerID=Int.random(in: 0 ..< 100);
    }
}
