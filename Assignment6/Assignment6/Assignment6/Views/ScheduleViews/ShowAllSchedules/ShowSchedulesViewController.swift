//
//  ShowSchedulesViewController.swift
//  Assignment6
//
//  Created by Krishna Vikas on 3/10/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class ShowSchedulesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SingletonClass.shared.getAllSchedules().count
    }
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCellTVCell
        
        let scheduleOfTrain = SingletonClass.shared.getAllSchedules()[indexPath.row]
        var stopsList = "";
        for stop in scheduleOfTrain.stops ?? []{
            stopsList += "\(stop.stopID ?? -100) \n"
        }
        cell.lbl.text = "ScheduleID : \(scheduleOfTrain.scheduleID ?? -100)\n Arrival time : \(scheduleOfTrain.arrivalTime ?? "Error")\n Departure Time: \(scheduleOfTrain.departureTime ?? "Error")\n Stops: \(stopsList)"
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    @IBOutlet weak var tabObject: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tabObject.delegate = self
        tabObject.dataSource = self
         let cell = UINib(nibName: "CustomCellTVCell", bundle: nil)
         tabObject.register(cell, forCellReuseIdentifier: "cell")
               tabObject.reloadData()
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
