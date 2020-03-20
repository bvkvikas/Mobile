//
//  FirstViewController.swift
//  Assignment6
//
//  Created by Krishna Vikas on 3/8/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
//
//    @IBAction func user(_ sender: UIButton) {
//        self.navigationController?.pushViewController(CreateViewController(), animated: true)
//    }
//    
//    @IBAction func action(_ sender: UIButton) {
//        self.navigationController?.pushViewController(CreateEventViewController(), animated: true)
//
//     }
     
    @IBAction func ScheduleAction(_ sender: UIButton) {
        self.navigationController?.pushViewController(ScheduleOptionsViewController(), animated: true)
    }
    
    @IBAction func TrainAction(_ sender: UIButton) {
        self.navigationController?.pushViewController(TrainOptionsViewController(), animated: true)
    }
    @IBAction func StopAction(_ sender: Any) {
        self.navigationController?.pushViewController(StopOptionsViewController(), animated: true)
    }
}
