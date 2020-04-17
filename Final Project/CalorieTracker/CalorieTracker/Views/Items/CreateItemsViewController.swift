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
    
    var action : String?
    var item : Items?
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            itemNameTF?.text = item?.itemName ?? "error"
            carbsTF?.text = String(format : "%.2f", carbsDouble)
            totalCaloriesTF?.text = String(caloriesInt)
            proteinTF?.text = String(format : "%.2f", proteinDouble)
            fatsTF?.text = String(format : "%.2f", fatsDouble)
            fiberTF?.text = String(format : "%.2f", fibersDouble)
        }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clearClicked(_ sender: Any) {
    }
    @IBAction func submitClicked(_ sender: Any) {
        
        guard let it = itemNameTF, let itName = it.text, !itName.isEmptyOrWhitespace() else {
            showAlert(title: "Enter Item Name")
            return
        }
        
        guard let cb = carbsTF, let carb = cb.text, !carb.isEmptyOrWhitespace() else {
            showAlert(title: "Enter carbs in grams")
            return
        }
        
        guard let pt = proteinTF, let prot = pt.text, !prot.isEmptyOrWhitespace() else {
            showAlert(title: "Enter proteins in grams")
            return
        }
        
        guard let tc = totalCaloriesTF, let tot = tc.text, !tot.isEmptyOrWhitespace() else {
            showAlert(title: "Enter Total Calories")
            return
        }
        
        guard let ft = fatsTF, let fat = ft.text, !fat.isEmptyOrWhitespace() else {
            showAlert(title: "Enter Fat in grams")
            return
        }
        
        guard let fib = fiberTF, let fiber = fib.text, !fiber.isEmptyOrWhitespace() else {
            showAlert(title: "Enter Fiber in grams")
            return
        }
        
      
        
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
}
