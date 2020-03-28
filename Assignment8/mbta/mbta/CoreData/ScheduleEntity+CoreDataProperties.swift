//
//  ScheduleEntity+CoreDataProperties.swift
//  mbta
//
//  Created by Krishna Vikas on 3/27/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//
//

import Foundation
import CoreData


extension ScheduleEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ScheduleEntity> {
        return NSFetchRequest<ScheduleEntity>(entityName: "ScheduleEntity")
    }

    @NSManaged public var arrivalTime: String?
    @NSManaged public var departureTime: String?
    @NSManaged public var lineID: Int16
    @NSManaged public var scheduleID: Int16
    @NSManaged public var stops: NSObject?
    @NSManaged public var toTrain: TrainEntity?

}
