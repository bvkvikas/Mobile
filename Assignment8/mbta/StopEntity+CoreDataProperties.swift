//
//  StopEntity+CoreDataProperties.swift
//  mbta
//
//  Created by Krishna Vikas on 3/29/20.
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
    @NSManaged public var train: NSSet?
    @NSManaged public var manySchedules: NSSet?

}

// MARK: Generated accessors for train
extension StopEntity {

    @objc(addTrainObject:)
    @NSManaged public func addToTrain(_ value: TrainEntity)

    @objc(removeTrainObject:)
    @NSManaged public func removeFromTrain(_ value: TrainEntity)

    @objc(addTrain:)
    @NSManaged public func addToTrain(_ values: NSSet)

    @objc(removeTrain:)
    @NSManaged public func removeFromTrain(_ values: NSSet)

}

// MARK: Generated accessors for manySchedules
extension StopEntity {

    @objc(addManySchedulesObject:)
    @NSManaged public func addToManySchedules(_ value: ScheduleEntity)

    @objc(removeManySchedulesObject:)
    @NSManaged public func removeFromManySchedules(_ value: ScheduleEntity)

    @objc(addManySchedules:)
    @NSManaged public func addToManySchedules(_ values: NSSet)

    @objc(removeManySchedules:)
    @NSManaged public func removeFromManySchedules(_ values: NSSet)

}
