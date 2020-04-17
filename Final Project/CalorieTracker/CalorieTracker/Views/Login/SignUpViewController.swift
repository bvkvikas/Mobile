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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElements()
        // Do any additional setup after loading the view.
    }
    
    func setupElements(){
        errorLabel.alpha = 0
        Utilities.styleTextField(firstName)
        Utilities.styleTextField(lastName)
        Utilities.styleTextField(emailAddress)
        Utilities.styleTextField(password)
    }
    
    func validateFields() -> String? {
        
        if firstName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailAddress.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
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
            Auth.auth().createUser(withEmail: email, password: pwd) { (result, err) in
                
                if err != nil {
                    self.showError("Error creating user")
                }
                else {
                    
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()

                    db.collection("users").addDocument(data: ["first_name":fn, "last_name":ln, "uid": result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            // Show error message
                            self.showError("Error saving user data : \(error) " )
                        }
                    }
                    self.goToLogin()
                }
                
            }
        }
        
        
        
    }
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func goToLogin() {
        
        let loginViewController = storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController
        
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
        
    }}
