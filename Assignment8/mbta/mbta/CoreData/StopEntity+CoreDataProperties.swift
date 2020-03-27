//
//  StopEntity+CoreDataProperties.swift
//  mbta
//
//  Created by Krishna Vikas on 3/27/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//
//

import Foundation
import CoreData


extension StopEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StopEntity> {
        return NSFetchRequest<StopEntity>(entityName: "StopEntity")
    }

    @NSManaged public var address: String?
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var stopID: Int16
    @NSManaged public var stopName: String?

}
