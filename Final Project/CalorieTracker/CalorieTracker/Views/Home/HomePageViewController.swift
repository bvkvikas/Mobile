//
//  HomePageViewController.swift
//  CalorieTracker
//
//  Created by Krishna Vikas on 4/17/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import ProgressMeter
import DateTimePicker

class HomePageViewController: UIViewController, DateTimePickerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    var breakfastData =  [String]()
    var lunchData =  [String]()
    var dinnerData =  [String]()
    
    @IBOutlet weak var progressControl: ProgressMeter!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var breakfastTableView: UITableView!
    @IBOutlet weak var lunchTableView: UITableView!
    @IBOutlet weak var dinnerTableView: UITableView!
    
    @IBOutlet weak var dateButton: UIButton!
    var user : User?
    var selectedDate : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if breakfastData.count == 0 {
            breakfastTableView.isHidden = true
        }
        setupDateButton()
        getUserData()
    }
    
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date) {
        title = picker.selectedDateString
    }
    
    func getUserData() {
        FireStoreServices.shared.getUser(emailID: (Auth.auth().currentUser?.email)!, from: .users, returning: User.self, completion: {user in
            
            self.UserNameLabel.text = "Welcome \(user.firstName ?? "error")"
            FireStoreServices.shared.getRecordsForTheDate(date: self.selectedDate!, completion: {
                retrievedData in
                var currentIntake: Double = 0
                if retrievedData.capacity > 0 {
                    currentIntake = (retrievedData["totalCaloriesForTheDate"]!.toDouble())
                }
                let totalCalories: Double = Double(user.totalCaloriesToConsume)
                self.setupWithCustomData(totalCalories: totalCalories, currentIntake: currentIntake)
                self.caloriesLabel.text = "\(currentIntake) of \(totalCalories) Cal eaten"
                FireStoreServices.shared.getMealRecordForTheDate(date: self.selectedDate!, typeOfMeal: "breakfast", completion: {
                    breakfastResponse in
                    if breakfastResponse.capacity > 0 {
                        let items = breakfastResponse["items"]?.components(separatedBy: ",")
                        self.breakfastData = items ?? []
                        self.breakfastTableView.reloadData()
                        self.breakfastTableView.isHidden = false
                    }else{
                        
                        self.breakfastData.removeAll()
                        self.breakfastTableView.reloadData()
                    }
                })
                FireStoreServices.shared.getMealRecordForTheDate(date: self.selectedDate!, typeOfMeal: "lunch", completion: {
                    lunchResponse in
                    if lunchResponse.capacity > 0 {
                        let items = lunchResponse["items"]?.components(separatedBy: ",")
                        self.breakfastData = items ?? []
                        self.breakfastTableView.reloadData()
                        self.breakfastTableView.isHidden = false
                    }else{
                        
                        self.breakfastData.removeAll()
                        self.breakfastTableView.reloadData()
                    }
                })
                FireStoreServices.shared.getMealRecordForTheDate(date: self.selectedDate!, typeOfMeal: "dinner", completion: {
                    dinnerResponse in
                    if dinnerResponse.capacity > 0 {
                        let items = dinnerResponse["items"]?.components(separatedBy: ",")
                        self.breakfastData = items ?? []
                        self.breakfastTableView.reloadData()
                        self.breakfastTableView.isHidden = false
                    }else{
                        
                        self.breakfastData.removeAll()
                        self.breakfastTableView.reloadData()
                    }
                })
            })
        })
        
    }
    
    func showCalender(){
        let min = Date().addingTimeInterval(-240 * 120 * 24 * 4)
        let max = Date().addingTimeInterval(10 * 60 * 24 * 4)
        let picker = DateTimePicker.create(minimumDate: min, maximumDate: max)
        picker.dateFormat = "dd-MM-YYYY"
        picker.isDatePickerOnly = true
        picker.selectedDate = selectedDate!.toDate()
        picker.includesMonth = true
        picker.highlightColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.doneButtonTitle = "Select"
        picker.doneBackgroundColor = UIColor(red: 255.0/255.0, green: 138.0/255.0, blue: 138.0/255.0, alpha: 1)
        picker.customFontSetting = DateTimePicker.CustomFontSetting(selectedDateLabelFont: .boldSystemFont(ofSize: 20))
        picker.completionHandler = { date in
            let formatter = DateFormatter()
            formatter.dateFormat = "dd-MM-YYYY"
            self.title = formatter.string(from: date)
            self.selectedDate = picker.selectedDateString
            self.dateButton.setTitle(self.selectedDate, for: .normal)
            self.getUserData()
        }
        picker.delegate = self
        picker.show()
    }
    
    func setupDateButton(){
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-YYYY"
        let result = formatter.string(from: date)
        dateButton.setTitle(result, for: .normal)
        selectedDate = result
    }
    
    
    
    func setupWithCustomData(totalCalories: Double, currentIntake: Double) {
        progressControl.maxValue = totalCalories
        progressControl.numberOfDivisions = 0
        progressControl.progress = Float(currentIntake / totalCalories)
        progressControl.annotationTextColor = .white
        progressControl.annotationPositionOnTop = true
    }
    @IBAction func logOutClicked(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Tracker", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "FirstViewController") as? FirstViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return breakfastData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "breakfastCell",for: indexPath)
        FireStoreServices.shared.getItem(itemID: breakfastData[indexPath.row], from: .items, returning: Items.self, completion: {
            (item) in
            let data = item.itemName!
            cell.textLabel?.text = data
            cell.detailTextLabel?.text = String(item.totalCalories)
        })
        return cell
    }
    
    
    @IBAction func dateClicked(_ sender: Any) {
        showCalender()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let navController = segue.destination as! UINavigationController
        let detailController = navController.topViewController as! ItemsPickerViewController
        detailController.mealType = segue.identifier
        detailController.dateToAdd = selectedDate
        
    }
    
}
