//
//  CreateScheduleViewController.swift
//  mbta
//
//  Created by Krishna Vikas on 3/23/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class CreateScheduleViewController: UIViewController {
    
    @IBOutlet weak var arrivalTime: UITextField!
    @IBOutlet weak var departureTime: UITextField!
    @IBOutlet weak var actionBtn: UIButton!
    @IBOutlet weak var trainName: UITextField!
    @IBOutlet weak var header: UILabel!
    @IBOutlet weak var listOfStops: UITextField!
    var sch : ScheduleEntity?
    var dep : String?
    var arr : String?
    var tn : TrainEntity?
    var btnTitle: String?
    var listOfStps: String?
    var action : String? = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        arrivalTime?.text = sch?.arrivalTime  ?? ""
        departureTime?.text = sch?.departureTime ?? ""
        trainName?.text = tn?.trainLineName ?? ""
        // listOfStops?.text = SingletonClass.shared.getListOfStopsInString(list: sch?.stops ?? []) ?? ""
        listOfStops?.text = listOfStps ?? ""
        if action == "create" {
            btnTitle = "Create Schedule"
            header.text = "Create Schedule"
        }
        if action == "search" {
            trainName?.isUserInteractionEnabled = false
            arrivalTime?.isUserInteractionEnabled = false
            departureTime?.isUserInteractionEnabled = false
            listOfStops?.isUserInteractionEnabled = false
            header.text = "Schedule Details"
            btnTitle = "Go to Schedule Options"
        }
        
        if action == "update"{
            btnTitle = "Update Schedule"
            trainName?.isUserInteractionEnabled = false
        }
        
        actionBtn.setTitle(btnTitle, for: .normal)
        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        
        if action == "search"{
            self.navigationController?.popToViewController((self.navigationController?.viewControllers[1]) as! ScheduleOptionsViewController, animated: true)
            return
        }
        
        var schedule : ScheduleEntity!
        guard let tr = trainName, let trName = tr.text ,!trName.isEmptyOrWhitespace()  else {
            
            showAlert(title: "Enter train name")
            return
        }
        
        
        guard let arr = arrivalTime, let at = arr.text ,at.isValidTime() else {
            showAlert(title: "Enter correct arrival time format in HH:mm")
            return
        }
        guard let dep = departureTime, let dt = dep.text ,dt.isValidTime() else {
            showAlert(title: "Enter correct departure time format in HH:mm")
            return
        }
        
        guard let stops = listOfStops, let st = stops.text ,!st.isEmptyOrWhitespace() else {
            showAlert(title: "Enter Stops")
            return
        }
        
        guard let stopsList = CoreDataManager.validateStopsList(listOfStops: st) else {
            showAlert(title: "One of the stops does not exist")
            return
        }
        
        
        if action == "update"{
            sch?.arrivalTime = at
            sch?.departureTime = dt
            sch?.listOfStops = stopsList as NSSet
            showAlert(title: "Schedule: \(sch?.scheduleID ?? -1000) succesfully updated ")
            return
        }
        
        if tn == nil {
            guard let train = CoreDataManager.getTrainByName(trainName: trName) else {
                showAlert(title: "Train not found")
                return
            }
            tn = train
        }
        
        
        
        //
        schedule = CoreDataManager.createSchedule(trainEntity: tn!)
        schedule.lineID = tn!.lineID
        schedule.arrivalTime = at
        schedule.departureTime = dt
        schedule.listOfStops = stopsList as NSSet
        
        
        CoreDataManager.saveContext()
        showAlert(title: "Schedule: \(schedule.scheduleID) succesfully added ")
    }
    
    //    func validateStopsList(listOfStops : String) -> [Stop]? {
    //        var result : [Stop]? = [];
    //        let list : [String] = listOfStops.split(separator: ",").map {String($0)}
    //        if list.count > 0 {
    //
    //            for s in list {
    //                if let st = doesStopExsit(stop: s) {
    //                    result?.append(st);
    //                }else{
    //                    return nil;
    //                }
    //            }
    //
    //        }
    //        return result;
    //    }
    //
    //    func doesStopExsit(stop : String) -> Stop? {
    //        if let res = SingletonClass.shared.getStopByName(stopName: stop){
    //            return res;
    //        }
    //        return nil;
    //    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    func showAlert(title: String)
    {
        let alert = UIAlertController(title:title, message:"", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: refreshData))
        self.present(alert, animated: true)
    }
    
    
    func refreshData(action: UIAlertAction) {
        NotificationCenter.default.post(name:  NSNotification.Name(rawValue: "refresh"), object: nil)
        // self.dismiss(animated: true, completion: nil)
        
    }
}
