//
//  CreateItemsViewController.swift
//  CalorieTracker
//
//  Created by Krishna Vikas on 4/16/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit

class CreateItemsViewController: UIViewController {
    
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var itemNameTF: UITextField!
    @IBOutlet weak var carbsTF: UITextField!
    @IBOutlet weak var totalCaloriesTF: UITextField!
    @IBOutlet weak var proteinTF: UITextField!
    @IBOutlet weak var fatsTF: UITextField!
    @IBOutlet weak var fiberTF: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    var action : String?
    var item : Items?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtonStyle()
        errorLabel.alpha = 0
        if action == "search"{
            itemNameTF?.isUserInteractionEnabled = false
            carbsTF?.isUserInteractionEnabled = false
            totalCaloriesTF?.isUserInteractionEnabled = false
            proteinTF?.isUserInteractionEnabled = false
            fatsTF?.isUserInteractionEnabled = false
            fiberTF?.isUserInteractionEnabled = false
            submitButton?.isHidden = true
            clearButton?.isHidden = true
            
        }
        if action == "update" || action ==  "search"{
            let proteinDouble: Double = item?.protein ?? 00
            let fatsDouble: Double = item?.fats ?? 0
            let fibersDouble: Double = item?.fiber ?? 0
            let carbsDouble: Double = item?.carbs ?? 0
            let caloriesInt : Int = item?.totalCalories ?? 0
            itemNameTF.isEnabled = false
            itemNameTF?.text = item?.itemName ?? "error"
            carbsTF?.text = String(format : "%.2f", carbsDouble)
            totalCaloriesTF?.text = String(caloriesInt)
            proteinTF?.text = String(format : "%.2f", proteinDouble)
            fatsTF?.text = String(format : "%.2f", fatsDouble)
            fiberTF?.text = String(format : "%.2f", fibersDouble)
            submitButton.setTitle("Update", for: .normal)
        }
    }
    
    func setupButtonStyle(){
        Utilities.styleFilledButton(submitButton)
        Utilities.styleHollowButton(clearButton)
    }
    
    @IBAction func clearClicked(_ sender: Any) {
        itemNameTF.text = ""
        carbsTF.text = ""
        totalCaloriesTF.text = ""
        proteinTF.text = ""
        fatsTF.text = ""
        fiberTF.text = ""
    }
    
    @IBAction func submitClicked(_ sender: Any) {
        
        let error = validateFields()
               
               if error != nil {
                   showError(error!)
               }else{
                
     
        
        
        let itName = itemNameTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let carb = carbsTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let prot = proteinTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let tot = totalCaloriesTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
         let fat = fatsTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
         let fiber = fiberTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        if action == "update"{
            item?.itemName = itName
            item?.carbs = carb.toDouble()
            item?.protein = prot.toDouble()
            item?.fats = fat.toDouble()
            item?.fiber = fiber.toDouble()
            item?.totalCalories = Int(tot)
            FireStoreServices.shared.update(for: item!, in: .items)
            showAlert(title: "Item: \(item!.itemName ?? "Nil") details updated ")

            return
        }
        
       
        let newItem: Items = Items(itemName: itName, carbs: carb.toDouble(), protein: prot.toDouble(), fats: fat.toDouble(), fiber: fiber.toDouble(), totalCalories: Int(tot) ?? 0)
        
        FireStoreServices.shared.create(for: newItem, in: .items)
        showAlert(title: "Item created")
           }
        
        
        
    }
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
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
    
    
    func validateFields() -> String? {
       
        if itemNameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            carbsTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            totalCaloriesTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            proteinTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            fatsTF.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            fiberTF.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields."
        }
        
        if  !carbsTF.text!.isNumeric() ||
            !totalCaloriesTF.text!.isNumeric() ||
            !proteinTF.text!.isNumeric() ||
            !fatsTF.text!.isNumeric() ||
            !fiberTF.text!.isNumeric()  {
            return "Enter numeric values only."
        }
        
        
        
        return nil
    }
}
