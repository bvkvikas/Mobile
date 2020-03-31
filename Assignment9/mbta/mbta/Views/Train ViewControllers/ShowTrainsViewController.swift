//
//  ShowTrainsViewController.swift
//  mbta
//
//  Created by Krishna Vikas on 3/23/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class ShowTrainsViewController:
UIViewController, UITableViewDelegate, UITableViewDataSource , UISearchResultsUpdating{
    
    var search = UISearchController()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trains.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCellViewController
        let train = CoreDataManager.getTrainEntities()[indexPath.row]
        
        var scheduleString = ""
        for schedule in train.manySchedules!{
            scheduleString = scheduleString + "\((schedule as AnyObject).scheduleID ?? 0), "
        }
        
        cell.label.text = " Train ID: \(train.lineID ) \n Train Name : \(train.trainLineName ?? "Error") \n Source: \(train.source?.stopName ?? "Error")\n Destination: \(train.destination?.stopName ?? "Error") \n Schedules : \(scheduleString)"
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let train = self.trains[indexPath.row]
        let result =  CreateTrainViewController()
        result.tr = train
        result.action = "search"
        self.navigationController?.pushViewController(result, animated: true)
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchText = searchController.searchBar.text, !searchText.isEmpty {
            self.trains = CoreDataManager.getTrainEntities().filter { train in
                return train.trainLineName!.lowercased().contains(searchText.lowercased())
            }
        } else {
            self.trains  = CoreDataManager.getTrainEntities()
        }
        self.tableObject.reloadData()
    }
    
    
    
    @IBOutlet weak var tableObject: UITableView!
    
    var trains : [TrainEntity] = CoreDataManager.getTrainEntities()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @objc func addTapped() {
        
        let CTViewController = CreateTrainViewController();
        CTViewController.btntitle =  "Create Train"
        CTViewController.action = "create"
        self.present(CTViewController, animated: true, completion: nil)
        
    }
    
    @objc func refresh() {
        
        trains = CoreDataManager.getTrainEntities()
        tableObject.reloadData()
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
