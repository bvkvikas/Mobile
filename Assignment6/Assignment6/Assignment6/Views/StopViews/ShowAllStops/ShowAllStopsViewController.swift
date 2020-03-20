//
//  ShowAllStopsViewController.swift
//  Assignment6
//
//  Created by Krishna Vikas on 3/11/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class ShowAllStopsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableObj: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
             tableObj.delegate = self
             tableObj.dataSource = self
              let cell = UINib(nibName: "CustomCellTVCell", bundle: nil)
              tableObj.register(cell, forCellReuseIdentifier: "cell")
                    tableObj.reloadData()
        // Do any additional setup after loading the view.
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCellTVCell
        
        let stopsList = SingletonClass.shared.showAllStops()[indexPath.row]
        
        cell.lbl.text = "Schedule ID: \(stopsList.scheduleID ?? -100)\n StopID : \(stopsList.stopID ?? -100)\n Address : \(stopsList.address ?? "Error")\n Latitude: \(stopsList.latitude ?? "Error")\n Longitude: \(stopsList.longitude ?? "Error")\n "
        
        return cell;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SingletonClass.shared.showAllStops().count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         return 120
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
