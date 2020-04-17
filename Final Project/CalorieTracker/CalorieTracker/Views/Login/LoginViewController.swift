//
//  LoginViewController.swift
//  CalorieTracker
//
//  Created by Krishna Vikas on 4/15/20.
//  Copyright © 2020 Krishna Vikas. All rights reserved.
//

import UIKit
import SystemConfiguration
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupElements()
    }
    
    func setupElements(){
        errorLabel.alpha = 0
        Utilities.styleTextField(emailAddress)
        Utilities.styleTextField(password)
    }
    
    @IBAction func logginButtonTapped(_ sender: Any) {
        let email = emailAddress.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let pwd = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        Auth.auth().signIn(withEmail: email, password: pwd) { (result, error) in
            
            if error != nil {
                print(error)
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                print("logged in")
                
                
                var window: UIWindow?
                
                let sb = UIStoryboard(name: "HomePage", bundle: nil)
                UITabBar.appearance().backgroundColor = .white
                UITabBar.appearance().tintColor = .red
                
                      let initialViewController = sb.instantiateViewController(withIdentifier: "HomePageVC")
                       
                       window = UIWindow(frame: UIScreen.main.bounds)
                       
                       let navigationBarSecond = UINavigationController(rootViewController: initialViewController)
                       window?.rootViewController = navigationBarSecond
                       window?.makeKeyAndVisible()
                
            }
        }
    }
    
    
}
