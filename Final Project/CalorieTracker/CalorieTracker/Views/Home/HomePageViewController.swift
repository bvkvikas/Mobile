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

class HomePageViewController: UIViewController {
    
    @IBOutlet weak var progressControl: ProgressMeter!
    @IBOutlet weak var UserNameLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FireStoreServices.shared.getUser(emailID: (Auth.auth().currentUser?.email)!, from: .users, returning: User.self, completion: {user in
            self.UserNameLabel.text = "Welcome \(user.firstName ?? "error")"
            let currentIntake: Double = 1000
            let totalCalories: Double = Double(user.totalCaloriesToConsume)
            self.setupWithCustomData(totalCalories: totalCalories, currentIntake: currentIntake)
            self.caloriesLabel.text = "\(currentIntake) of \(totalCalories) Cal eaten"
        })
        
        
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
    @IBAction func breakfastButtonTapped(_ sender: Any) {
    }
    @IBAction func lunchButtonTapped(_ sender: Any) {
    }
    @IBAction func dinnerButtonTapped(_ sender: Any) {
    }
    
}
