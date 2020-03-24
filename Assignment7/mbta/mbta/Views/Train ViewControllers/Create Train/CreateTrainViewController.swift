//
//  CreateTrainViewController.swift
//  mbta
//
//  Created by Krishna Vikas on 3/22/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class CreateTrainViewController: UIViewController {

    
    @IBOutlet weak var TrainNameTF: UITextField!
    @IBOutlet weak var DestinationTF: UITextField!
    @IBOutlet weak var SourceTF: UITextField!
    
    @IBOutlet weak var ActionBtn: UIButton!
    @IBOutlet weak var viewLabel: UILabel!
    
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
                  viewLabel.text = "Train Details"
                  btntitle = "Go to Train Options"
              }
              
              if action == "create" {
                  viewLabel.text = "Create Train"
              }
              
              
              if action == "update" {
                  TrainNameTF?.isUserInteractionEnabled = false
                  viewLabel.text = "Update Train"
                  btntitle = "Update Train"
              }
              
              ActionBtn.setTitle(btntitle, for: .normal)        // Do any additional setup after loading the view.
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
          

//                  self.dismiss(animated: true, completion: nil)
         }
             
     }
    
     
       func showAlert(title: String)
        {
            let alert = UIAlertController(title:title, message:"", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: refreshData))
            self.present(alert, animated: true)
        }
    
    func refreshData(action: UIAlertAction) {
      NotificationCenter.default.post(name:  NSNotification.Name(rawValue: "refresh"), object: nil)
        self.dismiss(animated: true, completion: nil)

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
