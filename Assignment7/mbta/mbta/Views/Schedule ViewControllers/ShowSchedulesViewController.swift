//
//  ShowSchedulesViewController.swift
//  mbta
//
//  Created by Krishna Vikas on 3/23/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class ShowSchedulesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource , UISearchResultsUpdating{
    
    @IBOutlet weak var tableObject: UITableView!
    var schedules : [Schedule] = SingletonClass.shared.getAllSchedules()
    
    var search = UISearchController()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return self.schedules.count
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCellViewController
           
           let scheduleOfTrain = SingletonClass.shared.getAllSchedules()[indexPath.row]
           var stopsList = "";
           for stop in scheduleOfTrain.stops ?? []{
               stopsList += "\(stop.stopName ?? "") ,"
           }
        cell.label.text = "ScheduleID : \(scheduleOfTrain.scheduleID ?? -100)\n Arrival time : \(scheduleOfTrain.arrivalTime ?? "Error")\n Departure Time: \(scheduleOfTrain.departureTime ?? "Error")\n Stops: \(stopsList)"
           
           return cell;
       }
    
       func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 120
       }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let sch = self.schedules[indexPath.row]
        let tr : Train = SingletonClass.shared.getTrainByID(sch.lineID)!
        let result =  CreateScheduleViewController()
        result.sch = sch
        result.tn = tr
        result.listOfStps = SingletonClass.shared.getListOfStopsInString(list: sch.stops)!
     result.action = "search"
        self.navigationController?.pushViewController(result, animated: true)
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
                   
           if let searchText = searchController.searchBar.text, !searchText.isEmpty {
               self.schedules = SingletonClass.shared.getAllSchedules().filter { sch in
                   return sch.scheduleID == Int(searchText) }
           } else {
               self.schedules  = SingletonClass.shared.getAllSchedules()
           }
           self.tableObject.reloadData()
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
               tableObject.delegate = self
               tableObject.dataSource = self
               let cell = UINib(nibName: "CustomCellViewController", bundle: nil)
               tableObject.register(cell, forCellReuseIdentifier: "cell")
               tableObject.reloadData()
               
               
               self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .done, target: self, action: #selector(addTapped))
               
               NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: NSNotification.Name(rawValue: "refresh"), object: nil)
               
//               search = ({
//                   let controller = UISearchController(searchResultsController: nil)
//                   controller.searchResultsUpdater = self
//                   controller.dimsBackgroundDuringPresentation = false
//                   controller.searchBar.sizeToFit()
//
//                   tableObject.tableHeaderView = controller.searchBar
//
//                   return controller
//               })()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
     }
     
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
     }
    
    @objc func addTapped() {
         
         let CSViewController = CreateScheduleViewController();
         CSViewController.action = "create"
         self.present(CSViewController, animated: true, completion: nil)
         
     }
    
    @objc func refresh() {
        
         schedules = SingletonClass.shared.getAllSchedules()
         tableObject.reloadData()
    }
    
}
