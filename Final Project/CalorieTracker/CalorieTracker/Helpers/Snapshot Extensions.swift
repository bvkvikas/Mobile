//
//  Snapshot Extensions.swift
//  CalorieTracker
//
//  Created by Krishna Vikas on 4/16/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import Foundation
import FirebaseFirestore

extension DocumentSnapshot {
    
    func decode<T: Decodable>(as objectType: T.Type, includingItemID: Bool = true) throws  -> T {
        
        var documentJson = data()
        if includingItemID {
            documentJson!["itemID"] = documentID
        }
        
        let documentData = try JSONSerialization.data(withJSONObject: documentJson, options: [])
        let decodedObject = try JSONDecoder().decode(objectType, from: documentData)
        
        return decodedObject
    }
    
}
