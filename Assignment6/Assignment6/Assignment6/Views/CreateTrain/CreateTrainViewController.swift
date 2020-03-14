//
//  CreateTrainViewController.swift
//  Assignment6
//
//  Created by Krishna Vikas on 3/8/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class CreateTrainViewController: UIViewController {

    @IBOutlet weak var TrainNameTF: UITextField?
    @IBOutlet weak var DestinationTF: UITextField?
    @IBOutlet weak var SourceTF: UITextField?
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var viewTitle: UILabel!
    @IBOutlet weak var ActionBtn: UIButton!
    
    var tr : Train?
    var tntf : String?
    var dtf : String?
    var stf : String?
    var btntitle: String?
    var action : String = "";
    
     override func viewDidLoad() {
        super.viewDidLoad()
        TrainNameTF?.text = tr?.trainLineName ?? "1"
        DestinationTF?.text = tr?.destination ?? "3"
        SourceTF?.text = tr?.source ?? "2"
        
        if action == "search" {
            TrainNameTF?.isUserInteractionEnabled = false
            DestinationTF?.isUserInteractionEnabled = false
            SourceTF?.isUserInteractionEnabled = false
            viewTitle.text = "Train Details"
            btntitle = "Go to Train Options"
        }
        
        if action == "create" {
            viewTitle.text = "Create Train"
        }
        
        
        if action == "update" {
            TrainNameTF?.isUserInteractionEnabled = false
            viewTitle.text = "Update Train"
            btntitle = "Update Train"
        }
        
        ActionBtn.setTitle(btntitle, for: .normal)
        // Do any additional setup after loading the view.
    }
    @IBAction func createTrain(_ sender: Any) {
        
        if action == "search"{
            let _ = self.navigationController?.popToViewController((self.navigationController?.viewControllers[1]) as! TrainOptionsViewController, animated: true)
          
            return
        }
        
        guard let trainName = TrainNameTF!.text, !trainName.isEmptyOrWhitespace() else{
                 showAlert(title: "Enter correct name")
                 return
             }
             
        guard let source = SourceTF!.text, !source.isEmptyOrWhitespace() else{
                 showAlert(title: "Enter correct source")
                 return
             }
             
        guard let destination = DestinationTF!.text, !destination.isEmptyOrWhitespace() else{
                        showAlert(title: "Enter correct destination")
                        return
                    }
        if action == "update"{
            tr?.source = source;
            tr?.destination = destination;
            tr?.trainLineName = trainName;
            showAlert(title: "Train Updated")
        }else if action == "create"{

            if let _ = SingletonClass.shared.getTrain(trainName)  {
                       showAlert(title: "Train exists already")
                       return
                   }
            let train = SingletonClass.shared.addTrain()
                        train.source = source;
                        train.destination = destination;
                        train.trainLineName = trainName;
                        showAlert(title: "Train created")
        }
            
    }
   
    
    func showAlert(title: String)
      {
          let alert = UIAlertController(title:title, message:"", preferredStyle: .alert)
          alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
          self.present(alert, animated: true)
      }
}


