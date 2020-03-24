//
//  ScheduleViewController.swift
//  Assignment6
//
//  Created by Krishna Vikas on 3/9/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {
    
    @IBOutlet weak var trainName: UITextField!
    @IBOutlet weak var arrivalTime: UITextField!
    @IBOutlet weak var departureTime: UITextField!
    @IBOutlet weak var actionBtn: UIButton!
    
    @IBOutlet weak var header: UINavigationItem!
    var sch : Schedule?
    var dep : String?
    var arr : String?
    var tn : Train?
    var btnTitle: String?
    var action : String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arrivalTime?.text = sch?.arrivalTime  ?? "08:02"
        departureTime?.text = sch?.departureTime ?? "08:00"
        trainName?.text = tn?.trainLineName ?? "1"
        
        if action == "create" {
            btnTitle = "Create Schedule"
           // header.title = "Create Schedule"
        }
        if action == "search" {
            arrivalTime?.isUserInteractionEnabled = false
            departureTime?.isUserInteractionEnabled = false
            header.title = "Schedule Details"
            btnTitle = "Go to Schedule Options"
        }
        
        if action == "update"{
            btnTitle = "Update Schedule"
            trainName?.isUserInteractionEnabled = false
        }
     
        actionBtn.setTitle(btnTitle, for: .normal)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        
        if action == "search"{
             self.navigationController?.popToViewController((self.navigationController?.viewControllers[1]) as! ScheduleOptionsViewController, animated: true)
            return
        }
        var schedule : Schedule!
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
        
        
        if action == "update"{
            sch?.arrivalTime = at
            sch?.departureTime = dt
            
            showAlert(title: "Schedule: \(sch?.scheduleID! ?? -1000) succesfully updated ")
            return
        }
        
        if tn == nil {
            guard let train = SingletonClass.shared.getTrain(trName) else {
                showAlert(title: "Train not found")
                return
            }
            tn = train
        }
        
        schedule =  SingletonClass.shared.addSchedule(train: tn!)
        schedule.lineID = tn!.lineID
        schedule.arrivalTime = at
        schedule.departureTime = dt
        
        showAlert(title: "Schedule: \(schedule.scheduleID!) succesfully added ")
    }
    
    func showAlert(title: String)
    {
        let alert = UIAlertController(title:title, message:"", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
