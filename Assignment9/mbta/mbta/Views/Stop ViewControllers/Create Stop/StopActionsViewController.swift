//
//  StopActionsViewController.swift
//  mbta
//
//  Created by Krishna Vikas on 3/23/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class StopActionsViewController: UIViewController {

    @IBOutlet weak var stopName: UITextField!
    @IBOutlet weak var Btn: UIButton!
    @IBOutlet weak var Address: UITextField!
    @IBOutlet weak var Latitude: UITextField!
    @IBOutlet weak var Longitude: UITextField!
    
    @IBOutlet weak var randomName: UILabel!
    var stops: StopEntity?
    var sn  : String?
    var lat : String?
    var long : String?
    var add : String?
    var action : String? = ""
    var btnTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stopName?.text = sn ?? "s1"
        Latitude?.text = lat ?? "lat"
        Longitude?.text = long ?? "long"
        Address?.text = add ?? "Boston-02115"
        
        if action == "create" {
            btnTitle = "Add Stop"
            randomName.text = "Create Stop"
        }
        if action == "search" {
            stopName?.isUserInteractionEnabled = false
            Latitude?.isUserInteractionEnabled = false
            Longitude?.isUserInteractionEnabled = false
            Address?.isUserInteractionEnabled = false
            btnTitle = "Go to Stops Options"
        }
        
        if action == "update"{
            btnTitle = "Update Stop"
            randomName.text = "Update Stop"
            stopName?.isUserInteractionEnabled = false
        }
        
        if action == "delete" {
            btnTitle = "Delete Stop"
        }
        
        Btn.setTitle(btnTitle, for: .normal)
        
        // Do any additional setup after loading the view.
    }
    @IBAction func submitted(_ sender: Any) {

                
                if action == "search"{
                    self.navigationController?.popToViewController((self.navigationController?.viewControllers[1]) as! StopOptionsViewController, animated: true)
                    return
                }
                
                
                var stop : StopEntity!
                
        //        if action == "create"{
        //            let x : Int? = Int (sch)
        //            schedule = SingletonClass.shared.getScheduleByID(sid: x ?? -100)
        //            if schedule == nil {
        //                showAlert(title: "Schedule not found")
        //                return
        //            }
        //
        //
        //        }
                
                guard let st = stopName, let stName = st.text, !stName.isEmptyOrWhitespace() else {
                    showAlert(title: "Enter stop name")
                    return
                }
                
                guard let latt = Latitude, let lati = latt.text, !lati.isEmptyOrWhitespace() else {
                    showAlert(title: "Enter latitude")
                    return
                }
                
                guard let lont = Longitude, let longt = lont.text, !longt.isEmptyOrWhitespace() else {
                    showAlert(title: "Enter Longitude")
                    return
                }
                
                guard let ad = Address, let addd = ad.text, !addd.isEmptyOrWhitespace() else {
                    showAlert(title: "Enter Address")
                    return
                }
                
                if action == "update"{
                    stops?.latitude = lati
                    stops?.longitude = longt
                    stops?.address = addd
                    showAlert(title: "Stop: \(stops?.stopID ?? -1000) succesfully updated ")
                    return
                }

                if let _ = CoreDataManager.getStopByName(stopName: stName)  {
                           showAlert(title: "Stop exists already")
                           return
                       }
                stop = CoreDataManager.addStop();
                stop.stopName = stName
                stop.latitude = lati
                stop.longitude = longt
                stop.address = addd
                
                showAlert(title: "Stop: \(stop.stopID) succesfully added ")
                
            
    }
    
    
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
       //  self.dismiss(animated: true, completion: nil)

     }
}

