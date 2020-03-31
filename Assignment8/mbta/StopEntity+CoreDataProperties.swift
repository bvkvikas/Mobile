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

    @NSManaged public var stopID: Int16
    @NSManaged public var stopName: String?
    @NSManaged public var longitude: String?
    @NSManaged public var latitude: String?
    @NSManaged public var address: String?
    @NSManaged public var source: NSSet?
    @NSManaged public var destination: NSSet?
    @NSManaged public var schedule: NSSet?

}

// MARK: Generated accessors for source
extension StopEntity {

    @objc(addSourceObject:)
    @NSManaged public func addToSource(_ value: TrainEntity)

    @objc(removeSourceObject:)
    @NSManaged public func removeFromSource(_ value: TrainEntity)

    @objc(addSource:)
    @NSManaged public func addToSource(_ values: NSSet)

    @objc(removeSource:)
    @NSManaged public func removeFromSource(_ values: NSSet)

}

// MARK: Generated accessors for destination
extension StopEntity {

    @objc(addDestinationObject:)
    @NSManaged public func addToDestination(_ value: TrainEntity)

    @objc(removeDestinationObject:)
    @NSManaged public func removeFromDestination(_ value: TrainEntity)

    @objc(addDestination:)
    @NSManaged public func addToDestination(_ values: NSSet)

    @objc(removeDestination:)
    @NSManaged public func removeFromDestination(_ values: NSSet)

}

// MARK: Generated accessors for schedule
extension StopEntity {

    @objc(addScheduleObject:)
    @NSManaged public func addToSchedule(_ value: ScheduleEntity)

    @objc(removeScheduleObject:)
    @NSManaged public func removeFromSchedule(_ value: ScheduleEntity)

    @objc(addSchedule:)
    @NSManaged public func addToSchedule(_ values: NSSet)

    @objc(removeSchedule:)
    @NSManaged public func removeFromSchedule(_ values: NSSet)

}
