//
//  SingletonClass.swift
//  Assignment6
//
//  Created by Krishna Vikas on 3/8/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class SingletonClass : NSObject{
    var trains : [Train] = []
    var stops : [Stop] = []
    static let shared = SingletonClass()
    
    
    
    private override init() {
        for i in (1...10) {
            let stop = Stop()
            stop.stopName = "stop" + "\(i)";
            stop.address = "address" + "\(i)";
            stop.latitude = "latitude" + "\(i)";
            stop.longitude = "longitude" + "\(i)";
            stops.append(stop);
            
        }
    }
    
    func addTrain() -> Train {
        let train = Train()
        train.schedule = []
        self.trains.append(train);
        let sch = Schedule()
        sch.arrivalTime = "08:00"
        sch.departureTime = "08:02"
        sch.lineID = train.lineID
        sch.stops = []
        train.schedule.append(sch)
        return train
    }
    
    func deleteTrain(_ trn: String) -> Bool
    {
        if getTrain(trn) != nil {
            trains.removeAll(where: { $0.trainLineName == trn })
            return true
        }
        return false
    }
    
    func getTrain(_ trn: String) -> Train? {
        
        guard let train = trains.first(where: { $0.trainLineName == trn }) else {
            return nil
        }
        return train
    }
    
    func schedulesForTrain(_ trainLineName: String) -> [Schedule] {
        guard let tr  = getTrain(trainLineName) else{
            return []
        }
        return tr.schedule
    }
    
    func getTrainByID(_ lineID: Int) -> Train? {
        
        guard let train = trains.first(where: { $0.lineID == lineID }) else {
            return nil
        }
        return train
    }
    
    func displayTrains() -> [Train] {
        return trains
    }
    
    func addSchedule(train: Train) -> Schedule {
        let schedule = Schedule()
        schedule.stops = []
        train.schedule.append(schedule)
        return schedule
    }
    
    func getAllSchedules() -> [Schedule]{
        var schedulesList : [Schedule] = [Schedule]()
        for train in trains {
            
            schedulesList.append(contentsOf: train.schedule)
        }
        return schedulesList
    }
    
    func getScheduleByID(sid: Int) -> Schedule? {
        var schedule : Schedule? = nil
        for train in trains {
            schedule = train.schedule.first(where : { $0.scheduleID == sid})
            if schedule != nil {
                return schedule
            }
        }
        return schedule
    }
    
    func deleteSchedule(sid: Int) -> Bool {
        if getScheduleByID(sid: sid) != nil {
            for train in trains {
                train.schedule.removeAll(where : { $0.scheduleID == sid})
             }
        }
        guard (SingletonClass.shared.getScheduleByID(sid: Int(sid)) != nil) else{
                 return true;
             }
        return false;
    }
    
    func addStop() -> Stop {
        let stop = Stop();
        stops.append(stop);
        return stop;
    }
    
    func getStopByID(sid: Int) -> Stop? {
        
        guard let stop = stops.first(where: { $0.stopID == sid }) else {
              return nil
          }
          return stop
        
     
    }
    
    func getStopByName(stopName: String) -> Stop? {
        
        guard let stop = stops.first(where: { $0.stopName == stopName }) else {
              return nil
          }
          return stop
        
     
    }
    
    
    func deleteStop(stopName: String) -> Bool{
        
        
        if getStopByName(stopName: stopName) != nil {
                  stops.removeAll(where: { $0.stopName == stopName })
                  return true
              }
              return false
        
        
//        for train in trains {
//            for sch in train.schedule {
//                sch.stops.removeAll(where : { $0.stopID == sid })
//            }
//        }
//        guard (SingletonClass.shared.getStopByID(sid: Int(sid)) != nil) else{
//            return true;
//        }
//        return false;
    }
    
    func showAllStops() -> [Stop] {
        var stopsList: [Stop] = [];
        for train in trains {
            for sch in train.schedule {
                stopsList.append(contentsOf: sch.stops)
            }
        }
        return stopsList
    }
    
}

enum TypeEnum
{
    case time
    case date
    case other
    case email
}

extension String {
    
    func isValidTime() -> Bool {
        let dateRegex = "^([0-1][0-9]|[2][0-3]):([0-5][0-9])$"
        let dateTest = NSPredicate(format: "SELF MATCHES %@",dateRegex)
        return dateTest.evaluate(with: self)
    }
    func isEmptyOrWhitespace() -> Bool {
        if(self.isEmpty) {
            return true
        }
        return (self.trimmingCharacters(in: NSCharacterSet.whitespaces) == "")
    }
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
}

