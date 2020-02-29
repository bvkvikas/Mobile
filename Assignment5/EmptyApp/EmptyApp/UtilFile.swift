//
//  UtilFile.swift
//  EmptyApp
//
//  Created by Krishna Vikas on 2/24/20.
//  Copyright © 2020 rab. All rights reserved.
//

import UIKit

class UtilFile: NSObject {
    
}

enum choice : Int {
    case addTrain
    case updateTrain
    case displayAllTrains
    case deleteTrain
    case addSchedule
    case deleteSchedule
    case updateSchedule
    case showAllSchedules
    case exit
    case ask
    case train
    case schedule
    case trainOptionsButton
    case scheduleOptionsButton
    case addTrainButton
    case updateTrainButton
    case displayAllTrainsButton
    case deleteTrainButton
    case addScheduleButton
    case deleteScheduleButton
    case updateScheduleButton
    case showAllSchedulesButton
    case showSchedulesOfTrain
    case showSchedulesOfTrainButton
    case showSchedulesView
}

enum TypeEnum
{
    case time
    case date
    case other
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


class SingletonCLass: NSObject {
    
    var trainsObj : [Train] = [];
    var scheduleObj : [Schedules] = [];
    
    static let shared = SingletonCLass()
    private override init(){
        
    }
    func addTrain() -> Train {
        let train = Train()
        train.schedule = []
        self.trainsObj.append(train);
        return train
    }
    
    func deleteTrain(_ trn: String) -> Bool
    {
        if let t = getTrain(trn) {
            trainsObj.removeAll(where: { $0.trainLineName == trn })
            scheduleObj.removeAll(where: { $0.lineID == t.lineID })
           return true
        }
        return false
    }

    func getTrain(_ trn: String) -> Train? {
        
        guard let train = trainsObj.first(where: { $0.trainLineName == trn }) else {
            return nil
        }
        return train
    }
    
    func getTrainByID(_ lineID: Int) -> Train? {
        
        guard let train = trainsObj.first(where: { $0.lineID == lineID }) else {
            return nil
        }
        return train
    }
    
    func showSchedulesForTrain(_ trainLineName: String) -> [Schedules] {
        guard let tr  = getTrain(trainLineName) else{
            return []
        }
        return tr.schedule
    }
    
    func getSchedule(_ scheduleID: Int) -> Schedules? {
        
        guard let schedule = scheduleObj.first(where: { $0.scheduleID == scheduleID }) else {
            return nil
        }
        return schedule
    }
    
    func displayTrains() -> [Train] {
            return trainsObj
    }
    
    func addSchedule(train: Train) -> Schedules {
            let schedule = Schedules()
            scheduleObj.append(schedule)
            train.schedule.append(schedule)
            return schedule
    }
    
    func viewAllSchedules() -> [Schedules] {
            return scheduleObj
    }
    
    func searchScheduleById(_ scheduleID: Int) -> Schedules? {
        
        guard let schedule = scheduleObj.first(where: { $0.scheduleID == scheduleID }) else {
            return nil
        }
        return schedule
    }
    
    func deleteSchedule(_ scheduleID : Int) -> Bool
    {
        if let s = getSchedule(scheduleID) {
            let t = getTrainByID(s.lineID);
            t?.schedule.removeAll(where:{ $0.scheduleID == scheduleID })
            scheduleObj.removeAll(where:{ $0.scheduleID == scheduleID })
            
           return true
        }
        return false
    }
}
