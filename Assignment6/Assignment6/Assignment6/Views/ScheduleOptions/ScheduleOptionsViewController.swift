//
//  ScheduleOptionsViewController.swift
//  Assignment6
//
//  Created by Krishna Vikas on 3/8/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class ScheduleOptionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func createSchedule(_ sender: UIButton) {
        let CreateScheduleViewController = ScheduleViewController();
        CreateScheduleViewController.action = "create"
       
        self.navigationController?.pushViewController(CreateScheduleViewController, animated: true)
    }
    @IBAction func updateSchedule(_ sender: UIButton) {
        let UpdateScheduleViewController = SearchScheduleViewController();
               UpdateScheduleViewController.action = "update"
       
               self.navigationController?.pushViewController(UpdateScheduleViewController, animated: true)
    }
    @IBAction func searchScheduleByID(_ sender: Any) {
        let SearcScheduleViewController = SearchScheduleViewController();
                SearcScheduleViewController.action = "search"
        
                self.navigationController?.pushViewController(SearcScheduleViewController, animated: true)
    }
    @IBAction func deleteSchedule(_ sender: UIButton) {
        let DeleteScheduleViewController = SearchScheduleViewController();
                DeleteScheduleViewController.action = "delete"
        
                self.navigationController?.pushViewController(DeleteScheduleViewController, animated: true)
    }
    @IBAction func showAllSchedules(_ sender: UIButton) {
        let showAllSchedulesVC = ShowSchedulesViewController(); self.navigationController?.pushViewController(showAllSchedulesVC, animated: true)
    }
//    @IBAction func showScheduleByTrain(_ sender: UIButton) {
//    }
}
