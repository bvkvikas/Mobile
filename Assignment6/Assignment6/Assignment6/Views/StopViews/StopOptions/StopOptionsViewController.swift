//
//  StopOptionsViewController.swift
//  Assignment6
//
//  Created by Krishna Vikas on 3/10/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class StopOptionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func createStopButton(_ sender: Any) {
        let createStopVC = StopActionsViewController();
         createStopVC.action = "create"
        
         self.navigationController?.pushViewController(createStopVC, animated: true)
        
        
    }
    
    @IBAction func updateStop(_ sender: Any) {
        let updateStopVC = SearchStopViewController();
                updateStopVC.action = "update"
               
                self.navigationController?.pushViewController(updateStopVC, animated: true)
               
    }
    @IBAction func searchStopByID(_ sender: Any) {
        let searchVC = SearchStopViewController();
         searchVC.action = "search"
        
         self.navigationController?.pushViewController(searchVC, animated: true)
    }
    @IBAction func deleteStop(_ sender: Any) {
        let deleteVC = SearchStopViewController();
             deleteVC.action = "delete"
            
             self.navigationController?.pushViewController(deleteVC, animated: true)
    }
    @IBAction func showAllStops(_ sender: Any) {
             self.navigationController?.pushViewController(ShowAllStopsViewController(), animated: true)
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
