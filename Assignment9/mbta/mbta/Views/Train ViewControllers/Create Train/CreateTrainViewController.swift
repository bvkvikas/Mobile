//
//  CreateTrainViewController.swift
//  mbta
//
//  Created by Krishna Vikas on 3/22/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class CreateTrainViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var selectedSource: String?
    var selectedDestination: String?
//    @IBOutlet weak var TrainNameTF: UITextField!
//    @IBOutlet weak var DestinationTF: UITextField!
//    @IBOutlet weak var SourceTF: UITextField!
//
//    @IBOutlet weak var ActionBtn: UIButton!
//    @IBOutlet weak var viewLabel: UILabel!
//    @IBOutlet weak var image: UIButton!
//
//    @IBOutlet weak var imageDisplay: UIImageView!
    
    @IBOutlet weak var SubmitButton: UIButton!
    @IBOutlet weak var imgBtn: UIButton!
    @IBOutlet weak var imgDisplay: UIImageView!
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var TrainName: UITextField!
    
    @IBOutlet weak var Source: UITextField!
    
    @IBOutlet weak var Destination: UITextField!
    
    var pickerData : [StopEntity] = [StopEntity]()
    var tr : TrainEntity?
    var tntf : String?
    var dtf : String?
    var stf : String?
    var btntitle: String?
    var action : String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerData = CoreDataManager.getAllStops();
        createPickerView()
        dismissPickerView()
        TrainName?.text = tr?.trainLineName ?? "1"
        Destination?.text = tr?.destination?.stopName
        Source?.text = tr?.source?.stopName
        Source.allowsEditingTextAttributes = false;
        if action == "search" {
            TrainName?.isUserInteractionEnabled = false
            Destination?.isUserInteractionEnabled = false
            Source?.isUserInteractionEnabled = false
            imgDisplay.image = tr?.pic
            imgBtn.isHidden = true
            label.text = "Train Details"
            btntitle = "Go to Train Options"
        }
        
        if action == "create" {
            imgDisplay.isHidden = true;
            
            label.text = "Create Train"
        }
        
        
        if action == "update" {
            TrainName?.isUserInteractionEnabled = false
            label.text = "Update Train"
            btntitle = "Update Train"
        }
        
        SubmitButton.setTitle(btntitle, for: .normal)        // Do any additional setup after loading the view.
    }
    
    @IBAction func createTrain(_ sender: Any) {
        
        if action == "search"{
            let _ = self.navigationController?.popToViewController((self.navigationController?.viewControllers[1]) as! TrainOptionsViewController, animated: true)
            
            return
        }
        
        guard let trainName = TrainName!.text, !trainName.isEmptyOrWhitespace() else{
            showAlert(title: "Enter correct name")
            return
        }
        
        guard let source = Source!.text, !source.isEmptyOrWhitespace() else{
            showAlert(title: "Enter correct source")
            return
        }
        
        guard let destination = Destination!.text, !destination.isEmptyOrWhitespace() else{
            showAlert(title: "Enter correct destination")
            return
        }
        
        print(isSourceAndDestSame(source: source, destination: destination));
        
        if isSourceAndDestSame(source: source, destination: destination) {
            showAlert(title: "Source and Destination should be different")
            return
        }
        
        
        let sr = CoreDataManager.getStopByName(stopName: source);
        let des =  CoreDataManager.getStopByName(stopName: destination);
        
        if action == "update"{
            tr?.source = sr
            tr?.destination = des
            tr?.trainLineName = trainName;
            tr?.pic = self.imgBtn.backgroundImage(for: .normal)
            
            sr?.addToSource(tr!)
            des?.addToDestination(tr!)
                      
                      CoreDataManager.saveContext()
                      
            showAlert(title: "Train Updated")
        }else if action == "create"{
            
            if let _ =  CoreDataManager.getTrainByName(trainName: trainName)  {
                showAlert(title: "Train exists already")
                return
            }
            
            let train : TrainEntity = CoreDataManager.createTrain()
            train.trainLineName = trainName;
            train.source = sr
            train.destination = des
            train.pic = self.imgBtn.backgroundImage(for: .normal)
            CoreDataManager.saveContext()
            
            sr?.addToSource(train)
            des?.addToDestination(train)
            
            CoreDataManager.saveContext()
            
            
            
            
            showAlert(title: "Train created")
            
        }
        
    }
    @IBAction func imageClicked(_ sender: UIButton) {
        self.imgClciked()
    }
    
    func imgClciked(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePickerobj = UIImagePickerController()
            imagePickerobj.delegate = self
            imagePickerobj.allowsEditing = true
            imagePickerobj.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePickerobj, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Caution", message: "Gallery access not permitted.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage], let imgBtn = originalImage as? UIImage   {
            self.imgBtn.setBackgroundImage(imgBtn, for: .normal)
            self.imgBtn.setImage(nil, for: .normal)
            self.imgBtn.isHidden = false
            
            self.imgBtn.backgroundColor = UIColor.clear
            self.imgBtn.setTitle("", for: .normal)
            
            picker.dismiss(animated: true, completion: nil)
        }
        else
        {
            self.imgDisplay.backgroundColor = UIColor.clear
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
            Source.text = selectedSource
        }
        if pickerView.tag == 2 {
            selectedDestination = pickerData[row].stopName
            Destination.text = selectedDestination
        }
        
    }
    
    func createPickerView() {
        let pickerView = UIPickerView()
        let pickerView2 = UIPickerView()
        pickerView.tag = 1
        pickerView2.tag = 2
        pickerView.delegate = self
        pickerView2.delegate = self
        Source.inputView = pickerView
        Destination.inputView = pickerView2
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.action2))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        Source.inputAccessoryView = toolBar
        Destination.inputAccessoryView = toolBar
    }
    
    @objc func action2() {
        view.endEditing(true)
    }
    
}
