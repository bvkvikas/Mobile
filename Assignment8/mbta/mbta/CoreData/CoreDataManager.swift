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
                   stop.stopName = "Test" + "\(i)";
                   stop.address = "address" + "\(i)";
                   stop.latitude = "latitude" + "\(i)";
                   stop.longitude = "longitude" + "\(i)";
               }
        appdel.saveContext();
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
    
    static func saveContext()
    {
       _ = appdel.saveContext()
    }
}
