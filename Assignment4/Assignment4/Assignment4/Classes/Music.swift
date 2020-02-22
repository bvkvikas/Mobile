//
//  Music.swift
//  Assignment4
//
//  Created by Krishna Vikas on 2/13/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//
import Foundation

import Cocoa

class Music {
    var musicName, musicArtist: String!;
    var ID: String!
    var price: Double!
    var availableQuantity: Int!;
    init() {
        self.ID = "\(Int.random(in: 0 ..< 100))"
    }
    
}
