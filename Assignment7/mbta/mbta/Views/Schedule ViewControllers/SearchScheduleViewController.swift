//
//  SearchScheduleViewController.swift
//  mbta
//
//  Created by Krishna Vikas on 3/23/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class SearchScheduleViewController: UIViewController {
    var action : String = "";
    @IBOutlet weak var searchScheduleAction: UIButton!
    @IBOutlet weak var scheduleIDTF: UITextField!
    @IBOutlet weak var header: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        switch action {
        case "search":
            header.title = "Search Schedule"
        case "delete":
            searchScheduleAction.setTitle("Delete Scheule", for: .normal)
            header.title = "Delete Schedule"
        case "update":
            header.title = "Update Schedule"
        default:
            header.title = "Schedule"
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchButtonClicked(_ sender: Any) {
        guard let sid = scheduleIDTF!.text, !sid.isEmptyOrWhitespace() else{
            showAlert(title: "Enter schedule ID")
            return
        }
        
        guard let sch : ScheduleEntity = CoreDataManager.getScheduleByID(sid: Int(sid)!) else{
            showAlert(title: "No Schedule found")
            return
        }
        
        if action == "delete" {
            CoreDataManager.deleteSchedule(entity: sch)
                showAlert(title: "Schedule deleted from train")
                return
           
        }
        
        let tr : TrainEntity = CoreDataManager.getTrainByID(lineID: sch.lineID)!
        
        let SVController = CreateScheduleViewController();
        SVController.sch = sch;
        SVController.arr = sch.arrivalTime
        SVController.dep = sch.departureTime
        SVController.tn =  tr
        SVController.action = action
        SVController.listOfStps = CoreDataManager.getListOfStopsInString(list: sch.manyStops as! Set<StopEntity>)
        self.navigationController?.pushViewController(SVController, animated: true)
        
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
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}
