//
//  TrainOptionsViewController.swift
//  Assignment6
//
//  Created by Krishna Vikas on 3/8/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//


import UIKit

class TrainOptionsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func CreatTrainAction(_ sender: UIButton) {
        let CTViewController = CreateTrainViewController();
        CTViewController.btntitle =  "Create Train"
        CTViewController.action = "create"
        self.navigationController?.pushViewController(CTViewController, animated: true)
    }
    
    @IBAction func UpdateTrainAction(_ sender: UIButton) {
        let UpdateViewController = UpdateTrainViewController();
        UpdateViewController.action =
        "update";
        self.navigationController?.pushViewController(UpdateViewController, animated: true)
    }
    
    @IBAction func DeleteTrainAction(_ sender: Any) {
        let UpdateViewController = UpdateTrainViewController();
        UpdateViewController.action =
        "delete";
        self.navigationController?.pushViewController(UpdateViewController, animated: true)
    }
    
    @IBAction func ShowAllTrainsAction(_ sender: UIButton) {
        self.navigationController?.pushViewController(ShowTrainsTableViewController(), animated: true)
    }
    
    @IBAction func SearchForTrain(_ sender: Any) {
        let UpdateViewController = UpdateTrainViewController();
        UpdateViewController.action = "search"
        
        self.navigationController?.pushViewController(UpdateViewController, animated: true)
    }
}
