//
//  DeleteTrainViewController.swift
//  mbta
//
//  Created by Krishna Vikas on 3/22/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class SearchUpdateDeleteViewController: UIViewController {
    var action : String = "";
    @IBOutlet weak var TrainNameTF: UITextField!
    @IBOutlet weak var navigationTitle: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func SearchForTrain(_ sender: Any) {
        guard let trainName = TrainNameTF!.text, !trainName.isEmptyOrWhitespace() else{
            showAlert(title: "Enter correct name")
            return
        }
        guard let train : TrainEntity = CoreDataManager.getTrainByName(trainName: trainName) else{
            showAlert(title: "No Train found")
            return
        }
        
        if action == "delete" {
            CoreDataManager.deleteTrain(entity: train)
            showAlert(title: "Deleted Train");
            return
        }
        
        let CTController = CreateTrainViewController();
        CTController.tr = train
        CTController.btntitle = "Update Train"
        if action == "search" {
            CTController.action = action
            self.navigationController?.pushViewController(CTController, animated: true)
        }
        else {
            CTController.action = "update"
            self.navigationController?.pushViewController(CTController, animated: true)
            
        }
        
    }
    func showAlert(title: String)
    {
        let alert = UIAlertController(title:title, message:"", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true)
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
