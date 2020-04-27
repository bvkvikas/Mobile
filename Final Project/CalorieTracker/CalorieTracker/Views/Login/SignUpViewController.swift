//
//  SignUpViewController.swift
//  CalorieTracker
//
//  Created by Krishna Vikas on 4/15/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var ageTF: UITextField!
    @IBOutlet weak var weightTF: UITextField!
    @IBOutlet weak var hegihtFeetTF: UITextField!
    @IBOutlet weak var genderPicker: UISegmentedControl!
    @IBOutlet weak var heightInches: UITextField!
    var gender: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        // Do any additional setup after loading the view.
    }
    
    func setupElements(){
        errorLabel.alpha = 0
        Utilities.styleFilledButton(signUpButton)
    }
    
    func validateFields() -> String? {
        
        if firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailAddress.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            ageTF.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            hegihtFeetTF.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            heightInches.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            weightTF.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            gender == "" {
            return "Please fill in all fields."
        }
        
        
        if  !ageTF.text!.isNumeric() ||
            !hegihtFeetTF.text!.isNumeric() ||
            !heightInches.text!.isNumeric() ||
            !weightTF.text!.isNumeric()  {
            return "Enter numeric values only."
        }
        
        if !emailAddress.text!.isValidEmail(){
            return "Enter a valid email address"
        }
        
        let modifiedPwd = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isPasswordValid(modifiedPwd) == false {
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        return nil
    }
    
    
    @IBAction func signUpClicked(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }
        else{
            let fn = firstName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let ln = lastName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailAddress.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let pwd = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let ag = ageTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let hf = hegihtFeetTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let hi = heightInches.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let we = weightTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            Auth.auth().createUser(withEmail: email, password: pwd) { (result, err) in
                
                if err != nil {
                    print(err!)
                    self.showError("Error creating user")
                }
                else {
                    let totHeight : Double = BMRCalculator.getTotalHeightInInches(heightInFeet: Int(hf)!, heightInInches: Int(hi)!)
                    let caloriesToConsume = BMRCalculator.getBMR(weight: we.toDouble(), height: totHeight, age: Int(ag)!, gender: self.gender)
                    let user : User = User(firstName: fn, lastName: ln, emailID: (result?.user.email)!, age: ag.toDouble(), gender: self.gender, heightFeet: Int(hf)!, heightInches: hi.toDouble(),totalCaloriesToConsume: caloriesToConsume, weight: we.toDouble())
                    FireStoreServices.shared.createUser(user: user, in: .users)
                    
                    self.goToHome()
                }
                
            }
        }
        
        
        
    }
    
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    @IBAction func genderPicked(_ sender: UISegmentedControl) {
        if (genderPicker.selectedSegmentIndex == 0){
            self.gender = "Male"
        }
        else{
            self.gender = "Female"
        }
    }
    
    func goToHome() {
        
        let sb = UIStoryboard(name: "HomePage", bundle: nil)
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = .red
        let initialViewController = sb.instantiateViewController(withIdentifier: "HomePageVC") as? HomeViewController
        
        self.navigationController?.pushViewController(initialViewController!, animated: true)
        
    }}
