//
//  CoreDataManager.swift
//  mbta
//
//  Created by Krishna Vikas on 3/27/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    
    static var appdel =  UIApplication.shared.delegate as! AppDelegate
    
    // MARK: - Stop Functions
    
    static func addStopTestData() {
        
        
        for i in 1...10{
            //let stop = NSManagedObject(entity: entity, insertInto: persistentContainer.viewContext)
            let stop = StopEntity(context: appdel.persistentContainer.viewContext);
            stop.stopID = Int16.random(in: 1 ..< 1000)
            stop.stopName = "Test" + "\(i)";
            stop.address = "address" + "\(i)";
            stop.latitude = "latitude" + "\(i)";
            stop.longitude = "longitude" + "\(i)";
        }
        
        appdel.saveContext();
//
//        let tr : TrainEntity = createTrain()
//        tr.lineID = Int16.random(in: 1 ..< 100)
//        tr.source = getStopByName(stopName: "Test1")
//        tr.destination = getStopByName(stopName: "Test2")
//        tr.trainLineName = "test"
//        
//        
//        appdel.saveContext();
        
    }
    
    static func getStopByName(stopName: String) -> StopEntity?
    {
        var res : StopEntity?
        let request: NSFetchRequest<StopEntity> = StopEntity.fetchRequest();
        request.predicate = NSPredicate(format: "stopName = %@", stopName)
        do{
            let result = try appdel.persistentContainer.viewContext.fetch(request);
            for data in result as [StopEntity]{
                res = data
                return data
            }
        }catch{
            print("Fetch failed");
        }
        return res
    }
    
    static func getAllStops() -> [StopEntity] {
        let request: NSFetchRequest<StopEntity> = StopEntity.fetchRequest()
        do {
            return try appdel.persistentContainer.viewContext.fetch(request)
            
        } catch {
            print("Fetch failed")
            return []
        }
    }
    
    static func getListOfStopsInString(list: Set<StopEntity>) -> String {
        
        var res : String = ""
        let arr = Array(list)
        for stop in arr {
            res += stop.stopName!
        }
        
        return res;
    }
    
    
    static func addStop() -> StopEntity
    {
        let stopEntity = StopEntity(context: appdel.persistentContainer.viewContext)
        stopEntity.stopID = Int16.random(in: 0 ..< 1000 )
        
        return stopEntity
    }
    
    static func deleteStop(entity: StopEntity)
    {
        appdel.persistentContainer.viewContext.delete(entity)
        saveContext()
    }
    
    static func validateStopsList(listOfStops : String) -> Set<StopEntity>? {
        var result : Set<StopEntity>? = [];
        let list : [String] = listOfStops.split(separator: ",").map {String($0)}
        if list.count > 0 {
            
            for s in list {
                if let st = doesStopExsit(stop: s) {
                    result?.insert(st);
                }else{
                    return nil;
                }
            }
            
        }
        return result;
    }
    
    static func doesStopExsit(stop : String) -> StopEntity? {
        if let res = getStopByName(stopName: stop){
            return res;
        }
        return nil;
    }
    
    
    // MARK: - Train Functions
    
    
    static func getTrainEntities() -> [TrainEntity]  {
        var trainsList = [TrainEntity]()
        
        let request: NSFetchRequest<TrainEntity> = TrainEntity.fetchRequest()
        do {
            trainsList = try appdel.persistentContainer.viewContext.fetch(request)
            return trainsList
        } catch {
            print("Fetch failed")
            return []
        }
    }
    
    static func getTrainByName(trainName: String) -> TrainEntity?
    {
        var res : TrainEntity?
        let request: NSFetchRequest<TrainEntity> = TrainEntity.fetchRequest();
        request.predicate = NSPredicate(format: "trainLineName = %@", trainName)
        do{
            let result = try appdel.persistentContainer.viewContext.fetch(request);
            for data in result as [TrainEntity]{
                res = data
                return data
            }
        }catch{
            print("Fetch failed");
            
        }
        return res
    }
    
    static func getTrainByID(lineID: Int16) -> TrainEntity?
    {
        var res : TrainEntity?
        let request: NSFetchRequest<TrainEntity> = TrainEntity.fetchRequest();
        request.predicate = NSPredicate(format: "lineID == %i", lineID)
        do{
            let result = try appdel.persistentContainer.viewContext.fetch(request);
            for data in result as [TrainEntity]{
                res = data
                return data
            }
        }catch{
            print("Fetch failed");
            
        }
        return res
    }
    
    
    
    static func createTrain() -> TrainEntity {
        let trainEntity = TrainEntity(context: appdel.persistentContainer.viewContext)
        trainEntity.lineID = Int16.random(in: 0 ..< 1000 )
        
        return trainEntity
    }
    
    static func deleteTrain(entity: TrainEntity)
    {
        appdel.persistentContainer.viewContext.delete(entity)
        saveContext()
    }
    
    // MARK: - Schedule functions
    
    static func createSchedule(trainEntity : TrainEntity) -> ScheduleEntity {
        let scheduleEntity = ScheduleEntity(context: appdel.persistentContainer.viewContext)
        scheduleEntity.scheduleID = Int16.random(in: 0 ..< 1000 )
        trainEntity.addToManySchedules(scheduleEntity);
        return scheduleEntity
    }
    
    static func getAllSchedules() -> [ScheduleEntity]{
        var result : [ScheduleEntity] = []
        
        for train in getTrainEntities() {
            for schedule in train.manySchedules! {
                result.append(schedule as! ScheduleEntity)
            }
        }
        
        return result
    }
    
    static func getScheduleByID(sid: Int) -> ScheduleEntity? {
        var res : ScheduleEntity?
        
        let request: NSFetchRequest<ScheduleEntity> = ScheduleEntity.fetchRequest();
        request.predicate = NSPredicate(format: "scheduleID == %i", sid)
        
        do{
            let result = try appdel.persistentContainer.viewContext.fetch(request);
            for data in result as [ScheduleEntity]{
                res = data
                return data
            }
        }catch{
            print("Fetch failed");
            
        }
        return res
    }
    
    static func deleteSchedule(entity: ScheduleEntity)
       {
        
           appdel.persistentContainer.viewContext.delete(entity)
            saveContext()
       }
    
    // MARK: - Save Context
    static func saveContext()
    {
        _ = appdel.saveContext()
    }
}
