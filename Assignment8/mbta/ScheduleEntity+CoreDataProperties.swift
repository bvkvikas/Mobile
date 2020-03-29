//
//  ScheduleEntity+CoreDataProperties.swift
//  mbta
//
//  Created by Krishna Vikas on 3/29/20.
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
    @NSManaged public var toTrain: TrainEntity?
    @NSManaged public var manyStops: NSSet?

}

// MARK: Generated accessors for manyStops
extension ScheduleEntity {

    @objc(addManyStopsObject:)
    @NSManaged public func addToManyStops(_ value: StopEntity)

    @objc(removeManyStopsObject:)
    @NSManaged public func removeFromManyStops(_ value: StopEntity)

    @objc(addManyStops:)
    @NSManaged public func addToManyStops(_ values: NSSet)

    @objc(removeManyStops:)
    @NSManaged public func removeFromManyStops(_ values: NSSet)

}
