//
//  TrainEntity+CoreDataProperties.swift
//  mbta
//
//  Created by Krishna Vikas on 3/27/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//
//

import Foundation
import CoreData


extension TrainEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TrainEntity> {
        return NSFetchRequest<TrainEntity>(entityName: "TrainEntity")
    }

    @NSManaged public var destination: NSObject?
    @NSManaged public var lineID: Int16
    @NSManaged public var schedule: NSObject?
    @NSManaged public var source: NSObject?
    @NSManaged public var trainLineName: String?
    @NSManaged public var manySchedules: ScheduleEntity?

}
