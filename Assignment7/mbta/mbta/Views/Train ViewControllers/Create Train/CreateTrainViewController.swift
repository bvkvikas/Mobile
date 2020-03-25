//
//  CreateTrainViewController.swift
//  mbta
//
//  Created by Krishna Vikas on 3/22/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class CreateTrainViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    var selectedSource: String?
    var selectedDestination: String?
    @IBOutlet weak var TrainNameTF: UITextField!
    @IBOutlet weak var DestinationTF: UITextField!
    @IBOutlet weak var SourceTF: UITextField!
    
    @IBOutlet weak var ActionBtn: UIButton!
    @IBOutlet weak var viewLabel: UILabel!
    
    var pickerData : [Stop] = [Stop]()
    var tr : Train?
    var tntf : String?
    var dtf : String?
    var stf : String?
    var btntitle: String?
    var action : String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerData = SingletonClass.shared.stops;
        createPickerView()
        dismissPickerView()
        TrainNameTF?.text = tr?.trainLineName ?? ""
        DestinationTF?.text = tr?.destination.stopName ?? ""
        SourceTF?.text = tr?.source.stopName ?? ""
        SourceTF.allowsEditingTextAttributes = false;
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
        
        print(isSourceAndDestSame(source: source, destination: destination));
        
        if isSourceAndDestSame(source: source, destination: destination) {
            showAlert(title: "Source and Destination should be different")
            return
        }
        
        
        
        if action == "update"{
            tr?.source = SingletonClass.shared.getStopByName(stopName: source);
            tr?.destination = SingletonClass.shared.getStopByName(stopName: destination);
            tr?.trainLineName = trainName;
            showAlert(title: "Train Updated")
        }else if action == "create"{
            
            if let _ = SingletonClass.shared.getTrain(trainName)  {
                showAlert(title: "Train exists already")
                return
            }
            let train = SingletonClass.shared.addTrain()
            train.source = SingletonClass.shared.getStopByName(stopName: source);
            train.destination = SingletonClass.shared.getStopByName(stopName: destination);
            train.trainLineName = trainName;
            
            showAlert(title: "Train created")
        
        }
        
    }
    
    func isSourceAndDestSame(source: String, destination: String) -> Bool {
        return source.lowercased() == destination.lowercased();
    }
        
    func showAlert(title: String)
    {
        let alert = UIAlertController(title:title, message:"", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: refreshData))
        self.present(alert, animated: true)
    }
    
    func refreshData(action: UIAlertAction) {
        NotificationCenter.default.post(name:  NSNotification.Name(rawValue: "refresh"), object: nil)
    //    self.dismiss(animated: true, completion: nil)
        
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row].stopName
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if pickerView.tag == 1 {
            selectedSource = pickerData[row].stopName
            SourceTF.text = selectedSource
        }
         if pickerView.tag == 2 {
            selectedDestination = pickerData[row].stopName
             DestinationTF.text = selectedDestination
         }
        
    }
   
    func createPickerView() {
        let pickerView = UIPickerView()
        let pickerView2 = UIPickerView()
        pickerView.tag = 1
        pickerView2.tag = 2
        pickerView.delegate = self
        pickerView2.delegate = self
        SourceTF.inputView = pickerView
        DestinationTF.inputView = pickerView2
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action2))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        SourceTF.inputAccessoryView = toolBar
        DestinationTF.inputAccessoryView = toolBar
    }
    
    @objc func action2() {
        view.endEditing(true)
    }
    
}
