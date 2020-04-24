//
//  StackTableViewController.swift
//  CalorieTracker
//
//  Created by Krishna Vikas on 4/23/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import ProgressMeter
import DateTimePicker

class StackTableViewController: UIViewController,
UITableViewDataSource, UITableViewDelegate, DateTimePickerDelegate{
    
    
    @IBOutlet weak var breakfastTable: UITableView!
    @IBOutlet weak var lunchTable: UITableView!
    @IBOutlet weak var dinnerTable: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var dinnerTableHeight: NSLayoutConstraint!
    @IBOutlet weak var lunchTableHeight: NSLayoutConstraint!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var progressMeter: ProgressMeter!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    var breakfastData =  [String]()
    var lunchData =  [String]()
    var dinnerData =  [String]()
    var user : User?
    var selectedDate : String?
    
    let breakfastCell = "breakfastCell"
    let lunchCell = "lunchCell"
    let dinnerCell = "dinnerCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.styleDateButton(dateButton)
        Utilities.styleLogoutButton(logoutButton)
        hideShowTable()
        setupDateButton()
        getUserData()
    }
    
    func hideShowTable(){
        if breakfastData.count == 0 {
            breakfastTable.isHidden = true
        }
        if lunchData.count == 0 {
            lunchTable.isHidden = true
        }
        if dinnerData.count == 0 {
            dinnerTable.isHidden = true
        }
    }
    
    func getUserData() {
        FireStoreServices.shared.getUser(emailID: (Auth.auth().currentUser?.email)!, from: .users, returning: User.self, completion: {user in
            
            self.userNameLabel.text = "Welcome \(user.firstName ?? "error")"
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
                        let items = breakfastResponse["items"]?.components(separatedBy: ":")
                        self.breakfastData = items ?? []
                        self.breakfastTable.reloadData()
                        self.breakfastTable.isHidden = false
                    }else{
                        
                        self.breakfastData.removeAll()
                        self.breakfastTable.reloadData()
                    }
                })
                FireStoreServices.shared.getMealRecordForTheDate(date: self.selectedDate!, typeOfMeal: "lunch", completion: {
                    lunchResponse in
                    if lunchResponse.capacity > 0 {
                        let items = lunchResponse["items"]?.components(separatedBy: ":")
                        self.lunchData = items ?? []
                        self.lunchTable.reloadData()
                        self.lunchTable.isHidden = false
                    }else{
                        
                        self.lunchData.removeAll()
                        self.lunchTable.reloadData()
                    }
                })
                FireStoreServices.shared.getMealRecordForTheDate(date: self.selectedDate!, typeOfMeal: "dinner", completion: {
                    dinnerResponse in
                    if dinnerResponse.capacity > 0 {
                        let items = dinnerResponse["items"]?.components(separatedBy: ":")
                        self.dinnerData = items ?? []
                        self.dinnerTable.reloadData()
                        self.dinnerTable.isHidden = false
                    }else{
                        
                        self.dinnerData.removeAll()
                        self.dinnerTable.reloadData()
                    }
                })
            })
        })
        
    }
    
    @IBAction func dateClicked(_ sender: Any) {
        showCalender()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView{
        case breakfastTable:
            return breakfastData.count
        case lunchTable:
            return lunchData.count
        case dinnerTable:
            return dinnerData.count
        default:
            print("error retrieving rows in table")
            return 0;
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch tableView{
        case breakfastTable:
            cell = breakfastTable.dequeueReusableCell(withIdentifier: breakfastCell, for: indexPath)
            let item = breakfastData[indexPath.row].components(separatedBy: ",")
            cell.textLabel?.text = item[0]
            let str = "Calories: \(item[1])"
            cell.detailTextLabel?.text = str
        case lunchTable:
            cell = lunchTable.dequeueReusableCell(withIdentifier: lunchCell, for: indexPath)
            let item = lunchData[indexPath.row].components(separatedBy: ",")
            cell.textLabel?.text = item[0]
            let str = "Calories: \(item[1])"
            cell.detailTextLabel?.text = str
        case dinnerTable:
            cell = dinnerTable.dequeueReusableCell(withIdentifier: dinnerCell, for: indexPath)
            let item = dinnerData[indexPath.row].components(separatedBy: ",")
            cell.textLabel?.text = item[0]
            let str = "Calories: \(item[1])"
            cell.detailTextLabel?.text = str
        default:
            print("error retrieving rows in table")
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
    func setupWithCustomData(totalCalories: Double, currentIntake: Double) {
        progressMeter.maxValue = totalCalories
        progressMeter.numberOfDivisions = 0
        progressMeter.progress = Float(currentIntake / totalCalories)
        progressMeter.annotationTextColor = .white
        progressMeter.annotationPositionOnTop = true
    }
    
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date) {
        title = picker.selectedDateString
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
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        
        self.tableViewHeightConstraint?.constant = self.breakfastTable.contentSize.height
        self.lunchTableHeight?.constant = self.lunchTable.contentSize.height
        self.dinnerTableHeight?.constant = self.dinnerTable.contentSize.height
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           
           let navController = segue.destination as! UINavigationController
           let detailController = navController.topViewController as! ItemsPickerViewController
           detailController.mealType = segue.identifier
           detailController.dateToAdd = selectedDate
           
       }
    
    @IBAction func logOutTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            let storyboard = UIStoryboard(name: "Tracker", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "FirstViewController") as? FirstViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
