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

    @NSManaged public var destination: StopEntity?
    @NSManaged public var lineID: Int16
    @NSManaged public var schedule: NSObject?
    @NSManaged public var source: StopEntity?
    @NSManaged public var trainLineName: String?
    @NSManaged public var manySchedules: NSSet?
    @NSManaged public var stop: StopEntity?

}

// MARK: Generated accessors for manySchedules
extension TrainEntity {

    @objc(addManySchedulesObject:)
    @NSManaged public func addToManySchedules(_ value: ScheduleEntity)

    @objc(removeManySchedulesObject:)
    @NSManaged public func removeFromManySchedules(_ value: ScheduleEntity)

    @objc(addManySchedules:)
    @NSManaged public func addToManySchedules(_ values: NSSet)

    @objc(removeManySchedules:)
    @NSManaged public func removeFromManySchedules(_ values: NSSet)

}
